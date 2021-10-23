local button = {}
button.__index = button

local TOUCH = hash("touch")

local function animate(node, initial_scale, fn)
	gui.cancel_animation(node, "scale.x")
	gui.cancel_animation(node, "scale.y")
	gui.set_scale(node, initial_scale)
	local scale = gui.get_scale(node)
	gui.set_scale(node, scale * 1.2)
	gui.animate(node, "scale.x", scale.x, gui.EASING_OUTELASTIC, 0.8)
	gui.animate(node, "scale.y", scale.y, gui.EASING_OUTELASTIC, 0.8, 0.05, function()
		gui.set_scale(node, initial_scale)
		if fn ~= nil then pprint("here"); fn(node) end;
	end)
end

function button.create()
	local b = {}
	setmetatable(b, button)
	b.registered = {}
	return b
end

function button:register(id, animated)
	animated = animated or true
	local node = gui.get_node(id)
	self.registered[id] = {node = node}

	if animated then self.registered[id].scale = gui.get_scale(node) end
end

function button:unregistered(id)
	self.registered [id] = nil
end

function button:register_on_click(id, f)
	self.registered[id].on_click = f
end

function button:register_on_update(id, f)
	self.registered[id].on_update = f
end

function button:on_input(action_id, action)
	for _,v in pairs(self.registered) do
		local params = {}
		params.node = v.node
		params.hover = false
		params.clicked_now = false
		params.released_now = false
		params.clicked = false

		if not action_id then
			if gui.pick_node(v.node, action.x, action.y) then
				params.hover = true
			else
				params.hover = false
			end
		end

		if action_id == TOUCH then
			if gui.pick_node(v.node, action.x, action.y) then
				if action.pressed then
					params.clicked_now = true
					params.released_now = false
					if v.scale then animate(v.node, v.scale, v.on_click)
					else v.on_click (v.node)
					end
				elseif action.released then
					params.clicked_now = false
					params.released_now = true
				else
					params.clicked_now = false
					params.released_now = false
				end

				params.pressed = true
			end
		end

		if v.on_update ~= nil then v.on_update(params)end
		if params.pressed then return end
	end
end

return button
