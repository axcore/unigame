---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- misc.lua
--      Set up miscellaneous functions
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Table of files loaded
local t = {}

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.misc = {}

---------------------------------------------------------------------------------------------------
-- Wrapper functions to load files, as and when required
---------------------------------------------------------------------------------------------------

-- Clear registered biomes, decorations and ores on demand
local cle_file = unilib.core.path_mod .. "/lib/shared/misc/misc_clear.lua"

function unilib.misc.clear_registered_biomes(...)

    if not t[cle_file] then t[cle_file] = true; dofile(cle_file) end
    return unilib.misc._clear_registered_biomes(...)

end

function unilib.misc.clear_registered_decorations(...)

    if not t[cle_file] then t[cle_file] = true; dofile(cle_file) end
    return unilib.misc._clear_registered_decorations(...)

end

function unilib.misc.clear_registered_ores(...)

    if not t[cle_file] then t[cle_file] = true; dofile(cle_file) end
    return unilib.misc._clear_registered_ores(...)

end

-- Miscellaneous functions inherited from minetest_game/default
local def_file = unilib.core.path_mod .. "/lib/shared/misc/misc_default.lua"

function unilib.misc.can_interact_with_node(...)

    if not t[def_file] then t[def_file] = true; dofile(def_file) end
    return unilib.misc._can_interact_with_node(...)

end

function unilib.misc.dig_up(...)

    if not t[def_file] then t[def_file] = true; dofile(def_file) end
    return unilib.misc._dig_up(...)

end

function unilib.misc.dig_up_multiple(...)

    if not t[def_file] then t[def_file] = true; dofile(def_file) end
    return unilib.misc._dig_up_multiple(...)

end

function unilib.misc.get_hotbar_bg(...)

    if not t[def_file] then t[def_file] = true; dofile(def_file) end
    return unilib.misc._get_hotbar_bg(...)

end

function unilib.misc.get_inventory_drops(...)

    if not t[def_file] then t[def_file] = true; dofile(def_file) end
    return unilib.misc._get_inventory_drops(...)

end

-- Callbacks for nodes placed in a medium
local med_file = unilib.core.path_mod .. "/lib/shared/misc/misc_medium.lua"

function unilib.misc.place_in_medium(...)

    if not t[med_file] then t[med_file] = true; dofile(med_file) end
    return unilib.misc._place_in_medium(...)

end

-- Miscellaneous functions inherited from other mods
local oth_file = unilib.core.path_mod .. "/lib/shared/misc/misc_other.lua"

function unilib.misc.rotate_and_place(...)

    if not t[oth_file] then t[oth_file] = true; dofile(oth_file) end
    return unilib.misc._rotate_and_place(...)

end

function unilib.misc.pointed_has_rightclick(...)

    if not t[oth_file] then t[oth_file] = true; dofile(oth_file) end
    return unilib.misc._pointed_has_rightclick(...)

end

function unilib.misc.pointed_use_rightclick(...)

    if not t[oth_file] then t[oth_file] = true; dofile(oth_file) end
    return unilib.misc._pointed_use_rightclick(...)

end

-- Set craft recipes for "squeezed" items (compressed/condensed stone, compressed dirt, compacted
--      leaves, etc)
local sq_file = unilib.core.path_mod .. "/lib/shared/misc/misc_squeezed.lua"

function unilib.misc.set_squeezed_recipes(...)

    if not t[sq_file] then t[sq_file] = true; dofile(sq_file) end
    return unilib.misc._set_squeezed_recipes(...)

end

function unilib.misc.set_compressed_metal_recipes(...)

    if not t[sq_file] then t[sq_file] = true; dofile(sq_file) end
    return unilib.misc._set_compressed_metal_recipes(...)

end
