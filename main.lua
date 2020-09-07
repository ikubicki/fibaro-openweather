--[[
OpenWeather widget
@author ikubicki
]]

function QuickApp:onInit()
    self:debug("QuickApp:onInit")
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
    if (string.len(self.apikey) < 3) then
        return false
    end
    local callback = function (response)
        local data = json.decode(response.data)
        -- self:debug('today forecast', json.encode(data.daily[1]))
        -- self:debug('tomorrow forecast', json.encode(data.daily[2]))

        -- Current weather
        local weatherInfo = data.current.weather[1]
        self.builder:updateChild('openweather-provider', self.i18n:get('openweather-provider'), 'com.fibaro.weather', {
            manufacturer = 'OpenWeather',
            model = 'Weather provider',
            Wind = data.current.wind_speed * 3.6,
            Humidity = data.current.humidity,
            Temperature = data.current.temp,
            WeatherCondition = string.lower(weatherInfo.main),
            Pressure = data.current.pressure,
            ConditionCode = ConditionCodes:get(weatherInfo.id, weatherInfo.icon)
        })
    end
    self.http:get(self:getUrlQueryString(), callback)
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
    
    self.builder = DeviceBuilder:new(self)
    self.http = HTTPClient:new({
        baseUrl = 'https://api.openweathermap.org/data/2.5/onecall'
    })
    self.i18n = i18n:new(api.get("/settings/info").defaultLanguage)

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

-- Humidity sensor
-- Temperature sensor
-- Wind sensor
-- Weather

class 'OpenWeatherDevice' (QuickAppChild)
class 'OpenWeatherSensor' (QuickAppChild)

function OpenWeatherDevice:__init(device)
    QuickAppChild.__init(self, device) 
    self:debug("OpenWeatherDevice init")   
end

function OpenWeatherSensor:__init(device)
    QuickAppChild.__init(self, device) 
    self:debug("OpenWeatherSensor init")   
end
