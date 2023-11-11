--[[
OpenWeather SDK
@author ikubicki
]]

class 'SDK'

function SDK:new(app)
    self.app = app
    self.http = HTTPClient:new({
        baseUrl = 'https://api.openweathermap.org/data/2.5'
    })
    return self
end

function SDK:formatOneCallResponse(data)
    local collection = {
        source = 'onecall',
        type = 'current',
        temp = data.current['temp'],
        humidity = data.current['humidity'],
        wind_speed = data.current['wind_speed'] * 3.6,
        wind_gust = 0,
        pressure = data.current['pressure'],
        clouds = data.current['clouds'],
        rain = 0.0,
        uvi = data.current['uvi'],
        weather_id = data.current.weather[1]['id'],
        weather_main = data.current.weather[1]['main'],
        weather_icon = data.current.weather[1]['icon'],
        sunrise = data.daily[1]['sunrise'],
        sunset = data.daily[1]['sunset'],
    }

    if data.current['rain'] and data.current['rain']['1h'] then
        collection['rain'] = data.current['rain']['1h']
    end
    if data.wind and data.current['wind_gust'] then
        collection['wind_gust'] = data.current['wind_gust'] * 3.6
    end
    return collection
end

function SDK:OneCall(success, fail)
    local url = '/onecall' .. self:getUrlQueryString()
    local wrappedCallback = function(response)
        if response.status >= 299 then
            if fail then
                fail(response)
            end
            return
        end
        local data = json.decode(response.data)
        if success then
            success(SDK:formatOneCallResponse(data))
        end
        return
    end
    self.http:get(url, wrappedCallback, fail)
end

function SDK:formatWeatherResponse(data)
    local collection = {
        source = 'weather',
        type = 'current',
        temp = data.main['temp'],
        humidity = data.main['humidity'],
        wind_speed = data.wind['speed'] * 3.6,
        wind_gust = 0,
        pressure = data.main['pressure'],
        clouds = data.clouds['all'],
        rain = 0.0,
        uvi = data.uvi,
        weather_id = data.weather[1]['id'],
        weather_main = data.weather[1]['main'],
        weather_icon = data.weather[1]['icon'],
        sunrise = data.sys['sunrise'],
        sunset = data.sys['sunset'],
    }
    if data.rain and data.rain['1h'] then
        collection['rain'] = data.rain['1h']
    end
    if data.wind and data.wind['gust'] then
        collection['wind_gust'] = data.wind['gust'] * 3.6
    end
    return collection
end

function SDK:Weather(success, fail)
    local url = '/weather' .. self:getUrlQueryString()
    local uviCallback = function(uvi)
        local wrappedCallback = function(response)
            if response.status >= 299 then
                if fail then
                    fail(response)
                end
                return
            end
            local data = json.decode(response.data)
            if success then
                data['uvi'] = uvi
                success(SDK:formatWeatherResponse(data))
            end
            return
        end
        self.http:get(url, wrappedCallback, fail)
    end
    SDK:Uvi(uviCallback)
end

function SDK:Uvi(success) -- deprecated
    local url = '/uvi' .. self:getUrlQueryString()
    local wrappedCallback = function(response)
        if response.status ~= 200 then
            response.data = '{"value": 0}'
        end
        local data = json.decode(response.data)
        if success then
            success(data.value)
        end
        return
    end
    self.http:get(url, wrappedCallback, fail)
end

function SDK:Forecast(offset, success, fail)
    local url = '/forecast' .. self:getUrlQueryString()
    local uviCallback = function(uvi)
        local wrappedCallback = function(response)
            if response.status >= 299 then
                if fail then
                    fail(response)
                end
                return
            end
            local data = json.decode(response.data)
            if success then
                data.list[offset]['uvi'] = uvi
                success(SDK:formatWeatherResponse(data.list[offset]))
            end
            return
        end
        self.http:get(url, wrappedCallback, fail)
    end
    SDK:Uvi(uviCallback)
end

function SDK:getUrlQueryString()
    local string = '?appid=' .. self.app.apikey
    string = string .. '&lat=' .. self.app.latitude
    string = string .. '&lon=' .. self.app.longitude
    string = string .. '&units=metric'
    string = string .. '&lang=' .. self.app.lang
    string = string .. '&exclude=minutely,hourly'
    return string
end
