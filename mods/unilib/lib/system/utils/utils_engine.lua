---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- utils_engine.lua
--      Engine utility functions
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- If creative is enabled for all players, then calls to unilib.utils.is_creative() don't have to
--      check on a per-player basis
local creative_mode_cache = core.settings:get_bool("creative_mode")

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.utils._get_pointed_node(player)

    -- Adapted from what_is_this_uwu.get_pointed_thing()
    -- Returns the node object, or nil when not pointing at a node
    -- For an example of some calling code, see ../lib/effects/identify/identify_base.lua

    -- Get player position
    local player_pos = player:get_pos()
    local eye_height = player:get_properties().eye_height
    local eye_offset = player:get_eye_offset()
    player_pos.y = player_pos.y + eye_height
    player_pos = vector.add(player_pos, eye_offset)

    -- Set vision in liquids
    local see_liquid = core.registered_nodes[core.get_node(player_pos).name].drawtype ~= "liquid"

    -- Get wielded item range 5; is the engine default
    -- order tool/item range >> hand_range >> fallback 5
    local tool_range = player:get_wielded_item():get_definition().range or nil
    local hand_range

    for key, val in pairs(core.registered_items) do

        if key == "" then
            hand_range = val.range or nil
        end
    end

    local wield_range = tool_range or hand_range or 5

    -- Determine ray end position
    local look_dir = player:get_look_dir()
    look_dir = vector.multiply(look_dir, wield_range)
    local end_pos = vector.add(look_dir, player_pos)

    -- Get pointed_thing
    local ray = core.raycast(player_pos, end_pos, false, see_liquid)
    local pointed_thing = ray:next()
    if pointed_thing then
        return core.get_node(pointed_thing.under)
    else
        return nil
    end

end

function unilib.utils._is_creative(player_name)

    -- Adapted from farming_redo/init.lua
    -- Checks creative mode on a per-player basis (if a player name is specified), or for all
    --      players otherwise (checking the Minetest "creative_mode" setting)
    --
    -- All unilib code should call this function, rather than core.is_creative_enabled()
    --
    -- Args:
    --      player_name (str or "" or nil): The optional player name, e.g. "singleplayer"

    if player_name == nil or player_name == "" then
        return creative_mode_cache
    else
        return creative_mode_cache or core.check_player_privs(player_name, {creative = true})
    end

end

function unilib.utils._settings_get_float(arg)

    -- Reads a floating-point value from settingtypes.txt, because apparently Minetest 5.7.0 is
    --      incapable of doing that, instead returning a string
    -- This functions returns a floating-point value if the setting exists, or nil if not

    local value = core.settings:get(arg)
    if value == nil then
        return value
    else
        return tonumber(value)
    end

end

function unilib.utils._settings_get_int(arg)

    -- Reads an integer from settingtypes.txt, because apparently Minetest 5.7.0 is incapable of
    --      doing that, instead returning a string
    -- This functions returns an integer if the setting exists, or nil if not

    local value = core.settings:get(arg)
    if value == nil then
        return value
    else
        return math.floor(tonumber(value))
    end

end
