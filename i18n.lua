
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
        ["openweather-provider"] = "Pogoda OpenWeather",
    },
    en = {
        ["openweather-provider"] = "OpenWeather weather provider",
    },
    de = {
        ["openweather-provider"] = "OpenWeather Wetteranbieter",
    }
}