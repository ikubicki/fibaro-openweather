
--[[
Internationalization tool
@author ikubicki
]]
class 'i18n'

function i18n:new(langCode)
    self.phrases = phrases[langCode]
    return self
end

function i18n:get(key)
    if self.phrases[key] then
        return self.phrases[key]
    end
    return key
end

phrases = {
    pl = {
        ['refresh'] = 'Odśwież',
        ['last-update'] = 'Ostatnia aktualizacja: %s',
        ['please-wait'] = 'Proszę czekać...',
        ["openweather-provider"] = "Stacja OpenWeather",
        ["openweather-temp"] = "Temperatura",
        ["openweather-pressure"] = "Ciśnienie",
        ["openweather-humidity"] = "Wilgotność",
        ["openweather-wind"] = "Wiatr",
        ["openweather-rain"] = "Opady",
        ["openweather-clouds"] = "Zachmurzenie",
        ["openweather-sunrise"] = "Wschód słońca",
        ["openweather-sunset"] = "Zachód słońca",
        ["openweather-uvi"] = "Indeks UV",
    },
    en = {
        ['refresh'] = 'Refresh',
        ['last-update'] = 'Last update at %s',
        ['please-wait'] = 'Please wait...',
        ["openweather-provider"] = "OpenWeather station",
        ["openweather-temp"] = "Temperature",
        ["openweather-pressure"] = "Pressure",
        ["openweather-humidity"] = "Humidity",
        ["openweather-wind"] = "Wind",
        ["openweather-rain"] = "Rain",
        ["openweather-clouds"] = "Clouds",
        ["openweather-sunrise"] = "Sunrise",
        ["openweather-sunset"] = "Sunset",
        ["openweather-uvi"] = "UV Index",
    },
    de = {
        ['refresh'] = 'Aktualisieren',
        ['last-update'] = 'Letztes update: %s',
        ['please-wait'] = 'Ein moment bitte...',
        ["openweather-provider"] = "OpenWeather station",
        ["openweather-temp"] = "Temperatur",
        ["openweather-pressure"] = "Luftdruck",
        ["openweather-humidity"] = "Luftfeuchtigkeit",
        ["openweather-wind"] = "Windgeschwindigkeit",
        ["openweather-rain"] = "Regenfall",
        ["openweather-clouds"] = "Wolkig",
        ["openweather-sunrise"] = "Sonnenaufgang",
        ["openweather-sunset"] = "Sonnenuntergang",
        ["openweather-uvi"] = "UV-Index",
    }
}