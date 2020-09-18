class 'OWSensor' (QuickAppChild)

OWSensor.class = 'com.fibaro.multilevelSensor'

function OWSensor:__init(device)
    self.device = false
    QuickAppChild.__init(self, device)
end

function OWSensor:get(name, class)
    if Toggles:get(name) then
        if not class then
            class = self.class
        end
        local id = 'openweather-' .. name
        local label = QuickApp.i18n:get(id)
        local options = {
            manufacturer = 'OpenWeather',
            model = name:sub(1, 1):upper() .. name:sub(2) .. ' sensor'
        }
        self.device = QuickApp.builder:updateChild(id, label, class, options)
    else
        self:delete(name)
        self.device = false
    end
    return self
end

function OWSensor:delete(name)
    if not Toggles:get(name) then
        -- QuickApp:debug('Deleting ', name)
        QuickApp.builder:deleteChild('openweather-' .. name)
    end
end

function OWSensor:update(properties)
    
    if self.device == nil or not self.device then
        return false
    end
    if type(properties) ~= 'table' then
        properties = {
            value = properties
        }
    end
    for name, value in pairs(properties) do
        self.device:updateProperty(name, value)
    end
    QuickApp:trace(string.format(QuickApp.i18n:get('device-updated'), self.device.name))
    return true
end