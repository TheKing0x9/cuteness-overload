local printer = {}
printer.__index = printer

function printer.new(node)
  local p = {}
  setmetatable(p, printer)

  -- the default delay between words
  p.delay_between_words = 0.075
  -- the text node
  p.node = gui.get_node(node)

  p.timer = nil
  p.is_printing = false
  return p
end

function printer:print(text, cb)
  if self.is_printing then self:instant_appear() end

  gui.set_text(self.node, "")
	self.text = text
	local i = 1
	local printed_text = ""
	self.is_printing = true
	self.timer = timer.delay(self.delay_between_words, true, function()
		if i == string.len(text) then
			self.is_printing = false
			timer.cancel(self.timer)

			if cb then cb() end
		end

		local byte = string.byte(text, i)
		printed_text = printed_text..string.char(byte)

		gui.set_text(self.node, printed_text)
		i = i + 1
	end)
end

function printer:instant_appear()
	if self.timer ~= nil then
		timer.cancel(self.timer)
		self.is_printing = false
		gui.set_text(self.node, self.text)
	end
end

function printer:clear()
	gui.set_text(self.node, "")
end

return printer
