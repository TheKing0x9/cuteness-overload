-- This module stores all the constants that will be used in this game

local M = {}

-- #region input related constants

M.KEY_UP = hash("key_up")
M.KEY_DOWN = hash("key_down")
M.KEY_LEFT = hash("key_left")
M.KEY_RIGHT = hash("key_right")

M.KEY_W = hash("key_w")
M.KEY_A = hash("key_a")
M.KEY_S = hash("key_s")
M.KEY_D = hash("key_d")

M.KEY_E = hash("key_e")

M.KEY_SPACE = hash("key_space")

-- #endregion

-- #region camera related constants

function M.get_camera_id()
	return hash("/camera")
end

-- #endregion

-- #region weapon related constants

M.BULLET_FACTORY = "/factories#bullet"

-- #endregion

-- #region mathematical constants

M.NORTH = vmath.vector3(0, 1, 0)
M.SMALL_Z = vmath.vector3(0, 0, 0.01)

-- #endregion

-- #region collision constants

M.COLLISION_RESPONSE = hash("collision_response")
M.CONTACT_POINT_RESPONSE = hash("contact_point_response")

M.GROUND = hash("ground")
M.ENEMY = hash("enemy")

-- #endregion

-- #region inbuilt constants

M.ENABLE = hash("enable")
M.DISABLE = hash("disable")
M.LOAD_SCENE = hash("load_scene")
M.ANIMATION_DONE = hash("animation_done")
M.PROXY_LOADED = hash("proxy_loaded")
M.PROXY_UNLOADED = hash("proxy_unloaded")

-- #endregion

-- #region hud constants

M.UPDATE_HEALTH = hash("update_health")
M.HUD_ID = "/hud#hud"

-- #endregion

-- #region project constants

M.WIDTH = 640
M.HEIGHT = 480
-- window.get_size() can also be used

-- #endregion

-- #region custom messages

-- #endregion

-- #region state message

-- #endregion

-- #region misc

M.EMPTY_FUNCTION = function() end

-- #endregion

return M
