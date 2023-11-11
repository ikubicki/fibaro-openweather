--[[
OpenWeather weather station
@author ikubicki
@version 2.0.0
]]

function QuickApp:onInit()
    self:initializeProperties()
    self:initializeChildren()
    self:trace('')
    self:trace(self.i18n:get('name'))
    GUI:label2Render()
    GUI:button3Render()
    self:run()
    self:updateSlider()
    self.gui:button1Text('refresh')
    GUI:label1Text('name')
end

function QuickApp:run()
    self:pullOpenWeatherData()
    if (self.interval > 0) then
        fibaro.setTimeout(self.interval, function() self:run() end)
    end
end

function QuickApp:button1Event()
    self:run()
end

function QuickApp:handleSlider(param)
    self.mode = math.floor(param.values[1] / 5.88)
    self:updateSlider()
end

function QuickApp:updateSlider()
    if self.mode == 0 then
        self.gui:label3Text("current-weather")
    else
        self.gui:label3Text("forecast", (self.mode - 1) * 3)
    end
    self.gui:slider(math.floor(self.mode * 5.89))
end

function QuickApp:pullOpenWeatherData()
    if (string.len(self.apikey) < 4) then
        QuickApp:warning("APIKEY variable not specified")
        return false
    end
    self.gui:button1Text('please-wait')
    local sdkFail = function(response)
        self:error("Unable to pull OpenWeather data")
        self.gui:label1Text('OpenWeather API error')
        self.gui:button1Text('retry')
    end
    local sdkSuccess = function (data)
        QuickApp:debug(json.encode(data))
        self:updateProvider(data)
        self:updateDevices(data)
        self:updateSunInfo(data)
        self:updateViewElements()
    end
    if self.mode == 0 then
        if self.source == 'OneCall' then
            self.sdk:OneCall(sdkSuccess)
        else
            self.sdk:Weather(sdkSuccess)
        end
    else 
        self.sdk:Forecast(self.mode, sdkSuccess)
    end
    
end

function QuickApp:updateViewElements()
    self.gui:label1Text('last-update', os.date('%Y-%m-%d %H:%M:%S'))
    self.gui:button1Text('refresh')
end

function QuickApp:updateProvider(data)
    -- WEATHER PROVIDER
    self:updateProperty("WeatherCondition", string.lower(data.weather_main))
    self:updateProperty("ConditionCode", ConditionCodes:get(data.weather_id, data.weather_icon))
    self:updateProperty("Temperature", data.temp)
    self:updateProperty("Humidity", data.humidity)
    self:updateProperty("Wind", data.wind_speed)
    self:updateProperty("Pressure", data.pressure)
end

function QuickApp:updateDevices(data)
    -- TEMPERATURE
    OWTemperature:get('temperature'):update({value = data.temp})
    -- WIND
    OWWind:get('wind'):update({value = data.wind_speed, unit = 'km/h'})
    -- PRESSURE
    OWSensor:get('pressure'):update({value = data.pressure, unit = 'mbar'})
    -- HUMIDITY
    OWHumidity:get('humidity'):update({value = data.humidity, unit = '%'})
    -- CLOUDS
    OWSensor:get('clouds'):update({value = data.clouds, unit = '%'})
    -- RAIN
    local rain = OWRain:get('rain'):update({value = OWRain:extractValue(data.rain), unit = 'mm'})
    -- UVI
    OWSensor:get('uv'):update(data.uvi)
end

function QuickApp:updateSunInfo(data)
    -- SUNRISE
    OWSensor:get('sunrise'):update(tonumber(os.date('%H.%M', data.sunrise)))
    -- SUNSET
    OWSensor:get('sunset'):update(tonumber(os.date('%H.%M', data.sunset)))
end

function QuickApp:toggleMetric(e)
    if e.elementName == 'button3_1' then Toggles:toggle('temperature') end
    if e.elementName == 'button3_2' then Toggles:toggle('wind') end
    if e.elementName == 'button3_3' then Toggles:toggle('pressure') end
    if e.elementName == 'button3_4' then Toggles:toggle('humidity') end
    if e.elementName == 'button3_5' then Toggles:toggle('clouds') end
    if e.elementName == 'button3_6' then Toggles:toggle('rain') end
    if e.elementName == 'button3_7' then Toggles:toggle('uv') end
    if e.elementName == 'button3_8' then Toggles:toggle('sunrise') end
    if e.elementName == 'button3_9' then Toggles:toggle('sunset') end
    GUI:button3Render()
    GUI:button1Text('refresh-sensors')
end

function QuickApp:initializeProperties()
    local locationInfo = api.get('/settings/location')
    self.mode = 0
    self.latitude = locationInfo.latitude
    self.longitude = locationInfo.longitude
    self.apikey = self:getVariable("APIKEY")
    self.source = self:getVariable("Source")
    self.lang = api.get("/settings/info").defaultLanguage
    self.interval = 1

    QuickApp.toggles = Toggles:new()
    QuickApp.i18n = i18n:new(self.lang)
    QuickApp.sdk = SDK:new(self)
    QuickApp.gui = GUI:new(self, QuickApp.i18n)
    QuickApp.builder = DeviceBuilder:new(self)

    self:updateProperty('manufacturer', 'OpenWeather')
    self:updateProperty('model', 'Weather provider')

    -- hours to miliseconds conversion
    self.interval = self:hoursToMiliseconds(self.interval)
end

function QuickApp:hoursToMiliseconds(hours)
    return hours * 3600000
end

function QuickApp:initializeChildren()
    self.builder:initChildren({
        [OWSensor.class] = OWSensor,
        [OWTemperature.class] = OWTemperature,
        [OWWind.class] = OWWind,
        [OWHumidity.class] = OWHumidity,
        [OWRain.class] = OWRain,
    })
end