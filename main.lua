--[[
OpenWeather widget v 1.0.0
@author ikubicki
]]

function QuickApp:onInit()
    self:initializeProperties()
    self:initializeChildren()
    self:trace('')
    self:trace(self.i18n:get('name'))
    GUI:button3Render()
    self:run()
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

function QuickApp:pullOpenWeatherData()
    if (string.len(self.apikey) < 4) then
        return false
    end
    self.gui:button1Text('please-wait')
    local callback1 = function (response)
        local data = json.decode(response.data)
        -- self:debug('today forecast', json.encode(data.daily[1]))
        -- self:debug('tomorrow forecast', json.encode(data.daily[2]))
        self:updateProvider(data.current)
        self:updateDevices(data.current)
        self:updateSunInfo(data.daily[1])
        self:updateViewElements()
    end
    self.http:get('/onecall' .. self:getUrlQueryString(), callback1)
end

function QuickApp:updateViewElements()
    self.gui:label1Text('last-update', os.date('%Y-%m-%d %H:%M:%S'))
    self.gui:button1Text('refresh')
end

function QuickApp:updateProvider(data)
    local weatherInfo = data.weather[1]
    -- WEATHER PROVIDER
    self:updateProperty("WeatherCondition", string.lower(weatherInfo.main))
    self:updateProperty("ConditionCode", ConditionCodes:get(weatherInfo.id, weatherInfo.icon))
    self:updateProperty("Temperature", data.temp)
    self:updateProperty("Humidity", data.humidity)
    self:updateProperty("Wind", data.wind_speed * 3.6)
    self:updateProperty("Pressure", data.pressure)
end

function QuickApp:updateDevices(data)
    -- TEMPERATURE
    OWTemperature:get('temperature'):update({value = data.temp})
    -- WIND
    OWWind:get('wind'):update({value = data.wind_speed * 3.6, unit = 'km/h'})
    -- PRESSURE
    OWSensor:get('pressure'):update({value = data.pressure, unit = 'mbar'})
    -- HUMIDITY
    OWHumidity:get('humidity'):update({value = data.humidity, unit = '%'})
    -- CLOUDS
    OWSensor:get('clouds'):update({value = data.clouds, unit = '%'})
    -- RAIN
    OWRain:get('rain'):update({value = OWRain:extractValue(data.rain), unit = 'mm'})
    -- UVI
    if data.uvi ~= nil then
        OWSensor:get('uv'):update(data.uvi)
    elseif Toggles:get('uv') then
        local uviCallback = function (response)
            local data = json.decode(response.data)
            OWSensor:get('uv'):update(data.uvi)
        end
        self.http:get('/uvi' .. self:getUrlQueryString(), uviCallback)
    end
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
end

function QuickApp:getUrlQueryString()
    local string = '?appid=' .. self.apikey
    string = string .. '&lat=' .. self.latitude
    string = string .. '&lon=' .. self.longitude
    string = string .. '&units=metric'
    string = string .. '&lang=pl'
    string = string .. '&exclude=minutely,hourly'
    return string
end

function QuickApp:initializeProperties()
    local locationInfo = api.get('/settings/location')
    self.latitude = locationInfo.latitude
    self.longitude = locationInfo.longitude
    self.apikey = self:getVariable("APIKEY")
    self.interval = 1

    QuickApp.toggles = Toggles:new()
    QuickApp.i18n = i18n:new(api.get("/settings/info").defaultLanguage)
    QuickApp.gui = GUI:new(self, QuickApp.i18n)
    QuickApp.builder = DeviceBuilder:new(self)
    QuickApp.http = HTTPClient:new({
        baseUrl = 'https://api.openweathermap.org/data/2.5'
    })

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
