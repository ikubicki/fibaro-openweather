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
        ['refresh-sensors'] = 'Odśwież sensory',
        ['retry'] = 'Ponów',
        ['last-update'] = 'Ostatnia aktualizacja: %s',
        ['please-wait'] = 'Proszę czekać...',
        ['device-updated'] = 'Zaktualizowano %s',
        ['select-sensors'] = 'Kliknij w przyciski aby wybrać sensory:',
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
        ['refresh-sensors'] = 'Refresh sensors',
        ['retry'] = 'Retry',
        ['last-update'] = 'Last update at %s',
        ['please-wait'] = 'Please wait...',
        ['device-updated'] = '%s updated',
        ['select-sensors'] = 'Click on buttons to select sensors:',
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
        ['refresh-sensors'] = 'Sensoren aktualisieren',
        ['retry'] = 'Wiederholen',
        ['last-update'] = 'Letztes update: %s',
        ['please-wait'] = 'Ein moment bitte...',
        ['device-updated'] = '%s aktualisiert',
        ['select-sensors'] = 'Klicken Sie auf die Schaltflächen, um Sensoren auszuwählen:',
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
    },
    se = {
        ['name'] = 'OpenWeather väderstation',
        ['refresh'] = 'Uppdatera',
        ['refresh-sensors'] = 'Uppdatera sensorer',
        ['retry'] = 'Försök igen',
        ['last-update'] = 'Senaste uppdatering %s',
        ['please-wait'] = 'Vänligen vänta...',
        ['device-updated'] = '%s uppdaterad',
        ['select-sensors'] = 'Klicka på knapparna för att välja sensorer:',
        ["openweather-provider"] = "OpenWeather station",
        ["openweather-temperature"] = "Temperatur",
        ["openweather-pressure"] = "Lufttryck",
        ["openweather-humidity"] = "Fuktighet",
        ["openweather-wind"] = "Vind",
        ["openweather-rain"] = "Regn",
        ["openweather-clouds"] = "Moln",
        ["openweather-sunrise"] = "Soluppgång",
        ["openweather-sunset"] = "Solnedgång",
        ["openweather-uv"] = "UV-Index",
    }
}