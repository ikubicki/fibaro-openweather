--[[
GUI utility
@author ikubicki
]]

class 'GUI'

function GUI:new(app, i18n)
    self.app = app
    self.i18n = i18n
    return self
end

function GUI:button1Text(text)
    self.app:updateView("button1", "text", self.i18n:get(text))
end

function GUI:label1Text(text, value1)
    if value1 == nil then value1 = 'N/A' end
    self.app:updateView("label1", "text", string.format(self.i18n:get(text), value1))
end

function GUI:label2Render()
    self.app:updateView("label2", "text", self.i18n:get('select-sensors'))
end

function GUI:button3Render()
    self.app:updateView('button3_1', 'text', string.format('[%s] ' .. self.i18n:get('openweather-temperature'), self:check(Toggles:get('temperature'))))
    self.app:updateView('button3_2', 'text', string.format('[%s] ' .. self.i18n:get('openweather-wind'), self:check(Toggles:get('wind'))))
    self.app:updateView('button3_3', 'text', string.format('[%s] ' .. self.i18n:get('openweather-pressure'), self:check(Toggles:get('pressure'))))
    self.app:updateView('button3_4', 'text', string.format('[%s] ' .. self.i18n:get('openweather-humidity'), self:check(Toggles:get('humidity'))))
    self.app:updateView('button3_5', 'text', string.format('[%s] ' .. self.i18n:get('openweather-clouds'), self:check(Toggles:get('clouds'))))
    self.app:updateView('button3_6', 'text', string.format('[%s] ' .. self.i18n:get('openweather-rain'), self:check(Toggles:get('rain'))))
    self.app:updateView('button3_7', 'text', string.format('[%s] ' .. self.i18n:get('openweather-uv'), self:check(Toggles:get('uv'))))
    self.app:updateView('button3_8', 'text', string.format('[%s] ' .. self.i18n:get('openweather-sunrise'), self:check(Toggles:get('sunrise'))))
    self.app:updateView('button3_9', 'text', string.format('[%s] ' .. self.i18n:get('openweather-sunset'), self:check(Toggles:get('sunset'))))

end

function GUI:check(checked)
    if checked then return 'x' else return ' ' end
end