local M = {}

local levels = {
  "Cutey always moves towards her target",
  "Cutey always sees what others don't",
  "Cutey can bend everything to her will",
  "Cutey wishes there was time for one more level"
}

function M.get(index)
  return levels[index]
end

return M
