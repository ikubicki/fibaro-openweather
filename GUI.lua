
--[[
GUI utility
@author ikubicki
]]

class 'GUI'

function GUI:new(app, i18n)
    self.app = app
    self.i18n = i18n
    QuickApp:debug(i18n)
    return self
end

function GUI:button1Text(text)
    self.app:updateView("button1", "text", self.i18n:get(text))
end

function GUI:label1Text(text, value1)
    if value1 == nil then value1 = 'N/A' end
    self.app:updateView("label1", "text", string.format(self.i18n:get(text), value1))
end