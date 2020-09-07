
class 'Globals'

function Globals:get(name, alternative)
    local response = api.get('/globalVariables/' .. name)
    if response then
        if (string.sub(response.value, 1, 1) == '{') then
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
        local response = api.post('/globalVariables', {
            name = name,
            value = json.encode(value)
        })
    end
end