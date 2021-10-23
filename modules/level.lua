local M = {}

local levels = {
  "Cutey always moves towards her target",
  "Cutey always sees what others don't"
}

function M.get(index)
  return levels[index]
end

return M
