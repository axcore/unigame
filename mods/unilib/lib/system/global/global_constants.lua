---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- global_constants.lua
--      Initialise global constants
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Global constants (unilib)
---------------------------------------------------------------------------------------------------

-- The standard separator for CSV files
unilib.constant.separator = "|"

-- Default values for detect/replace modes, in case some part of the code doesn't specify them
unilib.constant.default_detect_mode = "detect"
unilib.constant.default_replace_mode = "defer"

-- For compatibility with default, a maximum light setting
unilib.constant.light_max = 14
-- Standard minimum light for saplings (also used for grass, plants, etc)
unilib.constant.light_min_grow_sapling = 13
-- Standard minimum light crops/produce
unilib.constant.light_min_grow_crop = 12

-- Maximum tool wear (as specified by Minetest)
unilib.constant.max_tool_wear = 65535

-- World size limits (use these values instead of literal 31000 / -31000 values)
unilib.constant.x_max = 31000
unilib.constant.x_min = -31000
unilib.constant.y_max = 31000
unilib.constant.y_min = -31000
unilib.constant.z_max = 31000
unilib.constant.z_min = -31000

-- Standard error message for chat commands
unilib.constant.chat_offline_msg = S("This command is not available to offline players")

---------------------------------------------------------------------------------------------------
-- Global constants (mod-specific)
---------------------------------------------------------------------------------------------------

-- Maximum number of pseudo-biomes created by packages calling code in ../lib/shared/pbiomes/ or
--      ../lib/shared/jbiomes/
unilib.constant.underch_max_biomes = 62
-- Scale all damage caused by underch nodes by a given factor
unilib.constant.underch_damage_scaling_factor = 1
