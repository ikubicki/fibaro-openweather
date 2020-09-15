--[[
Global variables handler
@author ikubicki
]]
class 'Globals'

function Globals:get(name, alternative)
    local response = api.get('/globalVariables/' .. name)
    if response then
        local char = string.sub(response.value, 1, 1)
        if char == '{' or char == '"' then
            return json.decode(response.value)
        end
        return response.value
    end
    return alternative
end

function Globals:set(name, value)
    local response = api.put('/globalVariables/' .. name, {
        name = name,
        value = json.encode(value)
    })
    if not response then
        response = api.post('/globalVariables', {
            name = name,
            value = json.encode(value)
        })
        
    end
    if response ~= nil then
        if response.type == 'ERROR' then
            QuickApp:error('GLOBALS ERROR[' .. response.reason .. ']:', response.message)
        end
    end
end