--[[
Device building utility
@author ikubicki
]]

class 'DeviceBuilder'

function DeviceBuilder:new(parentDevice)
    self.parentDevice = parentDevice
    self.parentRoomId = api.get('/devices/' .. parentDevice.id).roomID
    self.classMap = {}
    self.devicesMap = {}
    return self
end

function DeviceBuilder:initChildren(classMap)
    self.classMap = classMap
    self.parentDevice:initChildDevices(classMap)
    for id, device in pairs(self.parentDevice.childDevices) do
        local vars = {}
        for _, var in pairs(device.properties.quickAppVariables) do
            vars[var.name] = var.value
        end
        if vars.name then
            self.devicesMap[vars.name] = device.id
        end
    end
end

function DeviceBuilder:updateChild(name, displayName, type, properties)
    local child = self:getChildByName(name)
    if not child then
        child = self:createChild(name, displayName, type, properties)
    end
    
    if properties ~= nil then
        api.put('/devices/' .. child.id, {name = displayName, properties = properties})
        -- QuickApp:trace('Device updated: ' .. child.name .. ' [' .. child.id .. ']')
    end
    return child
end

function DeviceBuilder:getChildByName(name)
--    QuickApp:debug(json.encode(self.devicesMap))
    local id = self.devicesMap[name]
    if id then
        return self:getChild(id)
    end
    return nil
end

function DeviceBuilder:getChild(id)
    return self.parentDevice.childDevices[id]
end

function DeviceBuilder:createChild(name, displayName, type, properties)
    local options = {
        name = displayName,
        type = type
    }
    local child = self.parentDevice:createChildDevice(options, self.classMap[type])
    if properties == nil then
        properties = {}
    end
    properties.quickAppVariables = {{
        name = 'name',
        value = name
    }}
    QuickApp:trace('New device added: ' .. child.name .. ' [' .. child.id .. ']')
    api.put('/devices/' .. child.id, {roomID = self.parentRoomId, properties = properties})
    self.devicesMap[name] = child.id
    return self:getChild(child.id)
end

function DeviceBuilder:deleteChild(name)
    local child = self:getChildByName(name)
    if child ~= nil then
        api.delete('/devices/' .. child.id)
        QuickApp:trace('Device removed: ' .. child.name .. ' [' .. child.id .. ']')
    end
end