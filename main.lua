--[[
OpenWeather widget v 0.2.0
@author ikubicki
]]

function QuickApp:onInit()
    self:trace('')
    self:trace('OpenWeather Weather Provider')
    self:initializeProperties()
    self:initializeChildren()
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

function QuickApp:updateSunInfo(data)
    
    -- SUNRISE
    if self:isEnabled('sunrise') then
        self.builder:updateChild('openweather-sunrise', self.i18n:get('openweather-sunrise'), 'com.fibaro.multilevelSensor', {
            manufacturer = 'OpenWeather',
            model = 'Sunrise',
            value = tonumber(os.date('%H.%M', data.sunrise))
        })
    else
        self.builder:deleteChild('openweather-sunrise')
    end
    -- SUNSET
    if self:isEnabled('sunset') then
        self.builder:updateChild('openweather-sunset', self.i18n:get('openweather-sunset'), 'com.fibaro.multilevelSensor', {
            manufacturer = 'OpenWeather',
            model = 'Sunset',
            value = tonumber(os.date('%H.%M', data.sunset))
        })
    else
        self.builder:deleteChild('openweather-sunset')
    end
end

function QuickApp:updateProvider(data)
    local weatherInfo = data.weather[1]
    -- WEATHER PROVIDER
    self.builder:updateChild('openweather-provider', self.i18n:get('openweather-provider'), 'com.fibaro.weather', {
        manufacturer = 'OpenWeather',
        model = 'Weather provider',
        Wind = data.wind_speed * 3.6,
        Humidity = data.humidity,
        Temperature = data.temp,
        WeatherCondition = string.lower(weatherInfo.main),
        Pressure = data.pressure,
        ConditionCode = ConditionCodes:get(weatherInfo.id, weatherInfo.icon)
    })
end

function QuickApp:updateDevices(data)
    -- TEMPERATURE
    if self:isEnabled('temperature') then
        self.builder:updateChild('openweather-temp', self.i18n:get('openweather-temp'), 'com.fibaro.multilevelSensor', {
            manufacturer = 'OpenWeather',
            model = 'Temperature',
            value = data.temp
        })
    else
        self.builder:deleteChild('openweather-temp')
    end
    -- WIND
    if self:isEnabled('wind') then
        self.builder:updateChild('openweather-wind', self.i18n:get('openweather-wind'), 'com.fibaro.multilevelSensor', {
            manufacturer = 'OpenWeather',
            model = 'Wind',
            value = data.wind_speed * 3.6,
            unit = 'km/h'
        })
    else
        self.builder:deleteChild('openweather-wind')
    end
    -- PRESSURE
    if self:isEnabled('pressure') then
        self.builder:updateChild('openweather-pressure', self.i18n:get('openweather-pressure'), 'com.fibaro.multilevelSensor', {
            manufacturer = 'OpenWeather',
            model = 'Pressure',
            value = data.pressure,
            unit = 'mbar'
        })
    else
        self.builder:deleteChild('openweather-pressure')
    end
    -- HUMIDITY
    if self:isEnabled('humidity') then
        self.builder:updateChild('openweather-humidity', self.i18n:get('openweather-humidity'), 'com.fibaro.multilevelSensor', {
            manufacturer = 'OpenWeather',
            model = 'Humidity',
            value = data.humidity,
            unit = '%'
        })
    else
        self.builder:deleteChild('openweather-humidity')
    end
    -- CLOUDS
    if self:isEnabled('clouds') then
        self.builder:updateChild('openweather-clouds', self.i18n:get('openweather-clouds'), 'com.fibaro.multilevelSensor', {
            manufacturer = 'OpenWeather',
            model = 'Clouds',
            value = data.clouds,
            unit = '%'
        })
    else
        self.builder:deleteChild('openweather-clouds')
    end
    -- RAIN
    if self:isEnabled('rain') then
        if data.rain == nil then
            data.rain = {
                ['1h'] = 0
            }
        end
        self.builder:updateChild('openweather-rain', self.i18n:get('openweather-rain'), 'com.fibaro.multilevelSensor', {
            manufacturer = 'OpenWeather',
            model = 'Rain',
            value = data.rain['1h'],
            unit = 'mm'
        })
    else
        self.builder:deleteChild('openweather-rain')
    end
    -- UVI
    if self:isEnabled('uv') then
        if data.uvi ~= nil then
            self.builder:updateChild('openweather-uvi', self.i18n:get('openweather-uvi'), 'com.fibaro.multilevelSensor', {
                manufacturer = 'OpenWeather',
                model = 'UVI',
                value = data.uvi
            })
        else
            local uviCallback = function (response)
                local data = json.decode(response.data)
                self.builder:updateChild('openweather-uvi', self.i18n:get('openweather-uvi'), 'com.fibaro.multilevelSensor', {
                    manufacturer = 'OpenWeather',
                    model = 'UVI',
                    value = data.value
                })
            end
            self.http:get('/uvi' .. self:getUrlQueryString(), uviCallback)
        end
    else
        self.builder:deleteChild('openweather-uvi')
    end
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
    
    self.i18n = i18n:new(api.get("/settings/info").defaultLanguage)
    self.gui = GUI:new(self, self.i18n)
    self.builder = DeviceBuilder:new(self)
    self.http = HTTPClient:new({
        baseUrl = 'https://api.openweathermap.org/data/2.5'
    })

    -- hours to miliseconds conversion
    self.interval = self:hoursToMiliseconds(self.interval)
end

function QuickApp:hoursToMiliseconds(hours)
    return hours * 3600000
end

function QuickApp:initializeChildren()
    self.builder:initChildren({
        ["com.fibaro.weather"] = OpenWeatherDevice,
        ["com.fibaro.multilevelSensor"] = OpenWeatherSensor,
    })
end

function QuickApp:isEnabled(item)
    local result = string.find(',' .. self:getVariable("Devices") .. ',', ',' .. item .. ',')
    return result ~= nil and result > 0
end

class 'OpenWeatherDevice' (QuickAppChild)
class 'OpenWeatherSensor' (QuickAppChild)

function OpenWeatherDevice:__init(device)
    QuickAppChild.__init(self, device) 
end

function OpenWeatherSensor:__init(device)
    QuickAppChild.__init(self, device)
end
