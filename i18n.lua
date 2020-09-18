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
        ['name'] = 'Stacja pogodowa OpenWeather',
        ['refresh'] = 'Odśwież',
        ['last-update'] = 'Ostatnia aktualizacja: %s',
        ['please-wait'] = 'Proszę czekać...',
        ['device-updated'] = 'Zaktualizowano %s',
        ["openweather-provider"] = "Stacja OpenWeather",
        ["openweather-temperature"] = "Temperatura",
        ["openweather-pressure"] = "Ciśnienie",
        ["openweather-humidity"] = "Wilgotność",
        ["openweather-wind"] = "Wiatr",
        ["openweather-rain"] = "Opady",
        ["openweather-clouds"] = "Zachmurzenie",
        ["openweather-sunrise"] = "Wschód słońca",
        ["openweather-sunset"] = "Zachód słońca",
        ["openweather-uv"] = "Indeks UV",
    },
    en = {
        ['name'] = 'OpenWeather weather station',
        ['refresh'] = 'Refresh',
        ['last-update'] = 'Last update at %s',
        ['please-wait'] = 'Please wait...',
        ['device-updated'] = '%s updated',
        ["openweather-provider"] = "OpenWeather station",
        ["openweather-temperature"] = "Temperature",
        ["openweather-pressure"] = "Pressure",
        ["openweather-humidity"] = "Humidity",
        ["openweather-wind"] = "Wind",
        ["openweather-rain"] = "Rain",
        ["openweather-clouds"] = "Clouds",
        ["openweather-sunrise"] = "Sunrise",
        ["openweather-sunset"] = "Sunset",
        ["openweather-uv"] = "UV Index",
    },
    de = {
        ['name'] = 'OpenWeather wetterstation',
        ['refresh'] = 'Aktualisieren',
        ['last-update'] = 'Letztes update: %s',
        ['please-wait'] = 'Ein moment bitte...',
        ['device-updated'] = '%s aktualisiert',
        ["openweather-provider"] = "OpenWeather station",
        ["openweather-temperature"] = "Temperatur",
        ["openweather-pressure"] = "Luftdruck",
        ["openweather-humidity"] = "Luftfeuchtigkeit",
        ["openweather-wind"] = "Windgeschwindigkeit",
        ["openweather-rain"] = "Regenfall",
        ["openweather-clouds"] = "Wolkig",
        ["openweather-sunrise"] = "Sonnenaufgang",
        ["openweather-sunset"] = "Sonnenuntergang",
        ["openweather-uv"] = "UV-Index",
    }
}