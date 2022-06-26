class 'OWRain' (OWSensor)

OWRain.class = 'com.fibaro.rainSensor'

function OWRain:__init(device)
    QuickAppChild.__init(self, device)
end

function OWRain:get(name)
    return OWSensor:get(name, self.class)
end

function OWRain:extractValue(data)
    local result = 0.00
    if data ~= nil then
        result = data['1h']
    end
    return result
end
