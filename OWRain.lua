class 'OWRain' (OWSensor)

OWRain.class = 'com.fibaro.rainSensor'

function OWRain:__init(device)
    QuickAppChild.__init(self, device)
end

function OWRain:get(name)
    return OWSensor:get(name, self.class)
end

function OWRain:extractValue(data)
    if data == nil then
        data = {
            ['1h'] = 0
        }
    end
    return data
end