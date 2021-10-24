local globals = {}

globals.level = 1
globals.score = 0
globals.over = false

globals.reset = function()
  globals.level = 1
  globals.score = 0
  globals.over = false
end

return globals
