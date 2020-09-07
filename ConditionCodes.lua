
--[[
Condition codes to translate OpenWeather weather info to Fibaro weather icon
Read more https://openweathermap.org/weather-conditions#How-to-get-icon-URL

@author ikubicki
]]
class 'ConditionCodes'

function ConditionCodes:get(id, icon)
    local key = id .. string.sub(icon, 3)
    return ConditionCodes.codes[key]
end

ConditionCodes.codes = {
    -- clear
    ["800d"] = 32,
    ["800n"] = 31,
    -- clouds
    ["801d"] = 28, ["802d"] = 28, ["803d"] = 26, ["804d"] = 26,
    ["801n"] = 27, ["802n"] = 27, ["803n"] = 26, ["804n"] = 26,
    -- atmosphere
    ["701d"] = 20, ["711d"] = 20, ["721d"] = 20, ["731d"] = 2, ["741d"] = 20,
    ["751d"] = 24, ["761d"] = 24, ["762d"] = 24, ["771d"] = 24, ["781d"] = 1,
    ["701n"] = 20, ["711n"] = 20, ["721n"] = 20, ["731n"] = 2, ["741n"] = 20,
    ["751n"] = 24, ["761n"] = 24, ["762n"] = 24, ["771n"] = 24, ["781n"] = 1,
    -- snow
    ["600d"] = 41,["601d"] = 16, ["602d"] = 13, ["611d"] = 7, ["612d"] = 7, ["613d"] = 7,
    ["615d"] = 7, ["616d"] = 7, ["620d"] = 7, ["621d"] = 7, ["622d"] = 7,
    ["600n"] = 41, ["601n"] = 16, ["602n"] = 13, ["611n"] = 7, ["612n"] = 7, ["613n"] = 7, 
    ["615n"] = 7, ["616n"] = 7, ["620n"] = 7, ["621n"] = 7, ["622n"] = 7,
    -- rain
    ["500d"] = 11, ["501d"] = 11, ["502d"] = 11, ["503d"] = 11, ["504d"] = 11,
    ["511d"] = 7, ["520d"] = 11, ["521d"] = 11, ["522d"] = 11, ["531d"] = 11,
    ["500n"] = 11, ["501n"] = 11, ["502n"] = 11, ["503n"] = 11, ["504n"] = 11,
    ["511n"] = 7, ["520n"] = 11, ["521n"] = 11, ["522n"] = 11, ["531n"] = 11,
    -- drizzle
    ["300d"] = 9, ["301d"] = 9, ["302d"] = 9, ["310d"] = 9, ["311d"] = 9,
    ["312d"] = 9, ["313d"] = 9, ["314d"] = 9, ["321d"] = 9,
    ["300n"] = 9, ["301n"] = 9, ["302n"] = 9, ["310n"] = 9, ["311n"] = 9,
    ["312n"] = 9, ["313n"] = 9, ["314n"] = 9, ["321n"] = 9,
    -- thunderstorm
    ["200d"] = 6, ["201d"] = 6, ["202d"] = 6, ["210d"] = 4, ["211d"] = 4,
    ["212d"] = 37, ["221d"] = 37, ["230d"] = 35, ["231d"] = 35, ["232d"] = 35,
    ["200n"] = 6, ["201n"] = 6, ["202n"] = 6, ["210n"] = 4, ["211n"] = 4, 
    ["212n"] = 37, ["221n"] = 37, ["230n"] = 35, ["231n"] = 35, ["232n"] = 35,
}
--[[
ConditionCodes.fibaro = {
    ["1"] = 'Tornado',
    ["2"] = 'Hurricane',
    ["3"] = 'Hurricane',
    ["4"] = 'CloudStorm',
    ["5"] = 'Storm',
    ["6"] = 'CloudRainStorm',
    ["7"] = 'CloudRainSnow',
    ["8"] = 'CloudSnow4',
    ["9"] = 'CloudHail',
    ["10"] = 'CloudHailRain',
    ["11"] = 'CloudRain',
    ["12"] = 'CloudRain',
    ["13"] = 'Snow10',
    ["14"] = 'CloudSnow3',
    ["15"] = 'Blizzard',
    ["16"] = 'Snow3',
    ["17"] = 'Snow3',
    ["18"] = 'CloudStorm',
    ["19"] = 'CloudRain',
    ["20"] = 'Fog',
    ["21"] = 'Fog',
    ["22"] = 'Fog',
    ["23"] = 'Wind',
    ["24"] = 'Wind2',
    ["25"] = 'Freeze',
    ["26"] = 'Clouds',
    ["27"] = 'CloudMoon',
    ["28"] = 'CloudSun',
    ["29"] = 'CloudMoon',
    ["30"] = 'CloudSun',
    ["31"] = 'Moon',
    ["32"] = 'Sun',
    ["33"] = 'MoonStars',
    ["34"] = 'SunFog',
    ["35"] = 'CloudSunStormRain',
    ["36"] = 'Heat',
    ["37"] = 'Storm',
    ["38"] = 'CloudMoonStorm1',
    ["39"] = 'CloudMoonStorm1',
    ["40"] = 'CloudRain',
    ["41"] = 'Snow',
    ["42"] = 'Snow',
    ["43"] = 'Snow',
    ["44"] = 'Clouds',
    ["45"] = 'CloudMoonStorm3',
    ["46"] = 'CloudMoonStorm1',
    ["47"] = 'CloudMoonStorm1',
}
]]