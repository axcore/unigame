---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- armour.lua
--      Set up armour
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.armour = {}

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

-- For convenience, set a flag when any armour function is called (the equivalent of checking
--      whether the 3darmor mod has been loaded, or not)
-- This shared variables replaces the "t" table (a local variable) used in other parts of
--      ../lib/shared
-- For example, code in ../lib/effects/stamina/stamina_base.lua wants to retrieve player physics
--      data, but only if it exists (the equivalent of checking whether the 3darmor mod has been
--      loaded or not, in the original mod code)
unilib.armour.active_flag = false

---------------------------------------------------------------------------------------------------
-- Wrapper functions to load files, as and when required
---------------------------------------------------------------------------------------------------

-- Base API functions for armour (all code is contained in a single file)
local base_file = unilib.core.path_mod .. "/lib/shared/armour/armour_base.lua"

function unilib.register_armour(...)

    if not unilib.armour.active_flag then unilib.armour.active_flag = true; dofile(base_file) end
    return unilib.armour._register_armour(...)

end

function unilib.armour.register_callback_on_damage(...)

    if not unilib.armour.active_flag then unilib.armour.active_flag = true; dofile(base_file) end
    return unilib.armour._register_callback_on_damage(...)

end

function unilib.armour.register_callback_on_destroy(...)

    if not unilib.armour.active_flag then unilib.armour.active_flag = true; dofile(base_file) end
    return unilib.armour._register_callback_on_destroy(...)

end

function unilib.armour.register_callback_on_equip(...)

    if not unilib.armour.active_flag then unilib.armour.active_flag = true; dofile(base_file) end
    return unilib.armour._register_callback_on_equip(...)

end

function unilib.armour.register_callback_on_unequip(...)

    if not unilib.armour.active_flag then unilib.armour.active_flag = true; dofile(base_file) end
    return unilib.armour._register_callback_on_unequip(...)

end

function unilib.armour.register_callback_on_update(...)

    if not unilib.armour.active_flag then unilib.armour.active_flag = true; dofile(base_file) end
    return unilib.armour._register_callback_on_update(...)

end

function unilib.register_craft_boots(...)

    if not unilib.armour.active_flag then unilib.armour.active_flag = true; dofile(base_file) end
    return unilib.armour._register_craft_boots(...)

end

function unilib.register_craft_chestplate(...)

    if not unilib.armour.active_flag then unilib.armour.active_flag = true; dofile(base_file) end
    return unilib.armour._register_craft_chestplate(...)

end

function unilib.register_craft_helmet(...)

    if not unilib.armour.active_flag then unilib.armour.active_flag = true; dofile(base_file) end
    return unilib.armour._register_craft_helmet(...)

end

function unilib.register_craft_leggings(...)

    if not unilib.armour.active_flag then unilib.armour.active_flag = true; dofile(base_file) end
    return unilib.armour._register_craft_leggings(...)

end

function unilib.register_craft_gauntlets(...)

    if not unilib.armour.active_flag then unilib.armour.active_flag = true; dofile(base_file) end
    return unilib.armour._register_craft_gauntlets(...)

end

function unilib.register_craft_shield(...)

    if not unilib.armour.active_flag then unilib.armour.active_flag = true; dofile(base_file) end
    return unilib.armour._register_craft_shield(...)

end

function unilib.armour.drop_armour(...)

    if not unilib.armour.active_flag then unilib.armour.active_flag = true; dofile(base_file) end
    return unilib.armour._drop_armour(...)

end

function unilib.armour.update_player_visuals(...)

    if not unilib.armour.active_flag then unilib.armour.active_flag = true; dofile(base_file) end
    return unilib.armour._update_player_visuals(...)

end

function unilib.armour.get_formspec(...)

    if not unilib.armour.active_flag then unilib.armour.active_flag = true; dofile(base_file) end
    return unilib.armour._get_formspec(...)

end

function unilib.armour.remove_all(...)

    if not unilib.armour.active_flag then unilib.armour.active_flag = true; dofile(base_file) end
    return unilib.armour._remove_all(...)

end

function unilib.armour.get_config(...)

    if not unilib.armour.active_flag then unilib.armour.active_flag = true; dofile(base_file) end
    return unilib.armour._get_config(...)

end

function unilib.armour.get_default_formspec(...)

    if not unilib.armour.active_flag then unilib.armour.active_flag = true; dofile(base_file) end
    return unilib.armour._get_default_formspec(...)

end

function unilib.armour.get_player_data(...)

    if not unilib.armour.active_flag then unilib.armour.active_flag = true; dofile(base_file) end
    return unilib.armour._get_player_data(...)

end

function unilib.armour.get_player_texture(...)

    if not unilib.armour.active_flag then unilib.armour.active_flag = true; dofile(base_file) end
    return unilib.armour._get_player_texture(...)

end

function unilib.armour.set_player_texture(...)

    if not unilib.armour.active_flag then unilib.armour.active_flag = true; dofile(base_file) end
    return unilib.armour._set_player_texture(...)

end

function unilib.armour.set_default_formspec(...)

    if not unilib.armour.active_flag then unilib.armour.active_flag = true; dofile(base_file) end
    return unilib.armour._set_default_formspec(...)

end
