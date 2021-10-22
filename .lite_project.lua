local git = require "plugins.git"

git.branch = "refactor"

local console = require "plugins.console"
local command = require "core.command"
local keymap  = require "core.keymap"
local core = require "core"

local autocomplete = require "plugins.autocomplete"

autocomplete.add { name = "defold", items = {
 ["go.get_position()"] = "get a gameobject's position",
 ["go.set_position()"] = "set a gameobject's position",
 ["msg.post()"] = "post a message",
 ["sound.play()"] = "play a sound",
 ["sound.stop()"] = "stop a sound",
 ["msg.url()"]    = "",

 ["init(self)"] = "",
 ["update(self, dt)"] = "",
 ["final(self)"] = "",
 ["on_message(self, message_id, message, sender)"] = "",
 ["on_input(self, action_id, action)"] = ""
}}

local config = require "core.config"

local function show_semver()
  local name = "log.txt"
  os.execute("git log --oneline > log.txt")

  local file = io.open(name, "r")
  local major, minor, patch = 0, 0, 0

  for line in file:lines() do
    if string.find(line, "! : ") then
      minor = 0; patch = 0
      major = major + 1
    elseif line:find("feat : ") then
      patch = 0
      minor = minor + 1
    elseif line:find("fix : ") then
      patch = patch + 1
    end
  end

  core.log(major .. "." .. minor .. "." .. patch)

  os.remove(name)

  file:close()
end

command.add(nil, {
  ["defold:build-project"] = function()
    console.run ({
      command = "./build.sh build && ./build.sh launch Linux"
    })
  end,
  ["defold:bundle-project"] = function()
    core.command_view:set_text("Linux", true)
    core.command_view:enter("Platform", function(platform)
      console.run ({ command = "./build.sh bundle " .. platform })
    end)
  end,
  ["semver:show-version"] = show_semver
})

keymap.add({
  ["ctrl+b"] = "defold:build-project",
  ["ctrl+shift+b"] = "defold:bundle-project"
})

config.ignore_files = {
  "^lite_xl$",
  "^bundle$",
  "^build$",
  "^%.",
}
