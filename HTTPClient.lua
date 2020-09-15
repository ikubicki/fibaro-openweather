
--[[
HTTPClient wrapper
@author ikubicki
]]
class 'HTTPClient'

function HTTPClient:new(options)
    if not options then
        options = {}
    end
    self.options = options
    return self
end

function HTTPClient:get(url, success, error)
    local client = net.HTTPClient({timeout=10000})
    client:request(self:url(url), self:requestOptions(success, error, 'GET')) 
end

function HTTPClient:post(url, data, success, error)
    local client = net.HTTPClient({timeout=10000})
    client:request(self:url(url), self:requestOptions(success, error, 'POST', data)) 
end

function HTTPClient:put(url, data, success, error)
    local client = net.HTTPClient({timeout=10000})
    client:request(self:url(url), self:requestOptions(success, error, 'PUT', data)) 
end

function HTTPClient:delete(url, success, error)
    local client = net.HTTPClient({timeout=10000})
    client:request(self:url(url), self:requestOptions(success, error, 'DELETE')) 
end

function HTTPClient:url(url)
    if (string.sub(url, 0, 4) == 'http') then
        return url
    end
    if not self.options.baseUrl then
        self.options.baseUrl = 'http://localhost'
    end
    return self.options.baseUrl .. tostring(url)
end

function HTTPClient:requestOptions(success, error, method, data)
    if (error == nil) then
        error = function (error)
            QuickApp:error(json.encode(error))
        end
    end
    if (method == nil) then
        method = 'GET'
    end
    local options = {
        checkCertificate = false,
        method = method
    }
    if (data ~= nil) then
        options.data = data
    end
    return {
        options = options,
        success = success,
        error = error
    }
end