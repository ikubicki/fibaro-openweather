class 'Toggles'

function Toggles:new()
    self:load()
    return self
end

function Toggles:get(name)
    return self[name]
end

function Toggles:toggle(name)
    self[name] = not self[name]
    self:save()
end

function Toggles:load()
    local toggles = Globals:get('openweather_toggles', self.defaults)
    self.temperature = toggles.t
    self.wind = toggles.w
    self.pressure = toggles.p
    self.humidity = toggles.h
    self.clouds = toggles.c
    self.rain = toggles.r
    self.uv = toggles.u
    self.sunrise = toggles.sr
    self.sunset = toggles.ss
end

function Toggles:save()
    Globals:set('openweather_toggles', {
        t = self.temperature,
        w = self.wind,
        p = self.pressure,
        h = self.humidity,
        c = self.clouds,
        r = self.rain,
        u = self.uv,
        sr = self.sunrise,
        ss = self.sunset,
    })
end

Toggles.defaults = {
    t = false,
    w = false,
    p = false,
    h = false,
    c = false,
    r = false,
    u = false,
    sr = false,
    ss = false,
}