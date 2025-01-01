---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- stone.lua
--      Set up stone
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Table of files loaded
local t = {}

---------------------------------------------------------------------------------------------------
-- Notes
---------------------------------------------------------------------------------------------------

-- For compatibility with underch and uchu, the following groups should be added to most stone nodes
--      already in the "stone" group:
--          smoothstone stoneblock stonebrick cobble/rubble mossycobble
--          compressedstone condensedstone
-- Note that sandstone nodes traditionally have non-standard groups

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.stone = {}

---------------------------------------------------------------------------------------------------
-- Wrapper functions to load files, as and when required
---------------------------------------------------------------------------------------------------

-- Base API functions for stone types
local base_file = unilib.core.path_mod .. "/lib/shared/stone/stone_base.lua"

function unilib.register_stone(...)

    if not t[base_file] then t[base_file] = true; dofile(base_file) end
    return unilib.stone._register_stone(...)

end

-- Registry functions for smooth stone
local smo_file = unilib.core.path_mod .. "/lib/shared/stone/stone_smooth.lua"

function unilib.register_stone_smooth(...)

    if not t[smo_file] then t[smo_file] = true; dofile(smo_file) end
    return unilib.stone._register_smooth(...)

end

function unilib.register_stone_smooth_compressed(...)

    if not t[smo_file] then t[smo_file] = true; dofile(smo_file) end
    return unilib.stone._register_smooth_compressed(...)

end

function unilib.register_stone_smooth_condensed(...)

    if not t[smo_file] then t[smo_file] = true; dofile(smo_file) end
    return unilib.stone._register_smooth_condensed(...)

end

function unilib.register_stone_smooth_cuttings(...)

    if not t[smo_file] then t[smo_file] = true; dofile(smo_file) end
    return unilib.stone._register_smooth_cuttings(...)

end

-- Registry functions for stone blocks
local blo_file = unilib.core.path_mod .. "/lib/shared/stone/stone_block.lua"

function unilib.register_stone_block(...)

    if not t[blo_file] then t[blo_file] = true; dofile(blo_file) end
    return unilib.stone._register_block(...)

end

function unilib.register_stone_block_cuttings(...)

    if not t[blo_file] then t[blo_file] = true; dofile(blo_file) end
    return unilib.stone._register_block_cuttings(...)

end

-- Registry functions for stone bricks
local bri_file = unilib.core.path_mod .. "/lib/shared/stone/stone_brick.lua"

function unilib.register_stone_brick(...)

    if not t[bri_file] then t[bri_file] = true; dofile(bri_file) end
    return unilib.stone._register_brick(...)

end

function unilib.register_stone_brick_cuttings(...)

    if not t[bri_file] then t[bri_file] = true; dofile(bri_file) end
    return unilib.stone._register_brick_cuttings(...)

end

-- Registry functions for cobblestone
local cob_file = unilib.core.path_mod .. "/lib/shared/stone/stone_cobble.lua"

function unilib.register_stone_cobble(...)

    if not t[cob_file] then t[cob_file] = true; dofile(cob_file) end
    return unilib.stone._register_cobble(...)

end

function unilib.register_stone_cobble_mossy(...)

    if not t[cob_file] then t[cob_file] = true; dofile(cob_file) end
    return unilib.stone._register_cobble_mossy(...)

end

function unilib.register_stone_cobble_compressed(...)

    if not t[cob_file] then t[cob_file] = true; dofile(cob_file) end
    return unilib.stone._register_cobble_compressed(...)

end

function unilib.register_stone_cobble_condensed(...)

    if not t[cob_file] then t[cob_file] = true; dofile(cob_file) end
    return unilib.stone._register_cobble_condensed(...)

end

function unilib.register_stone_cobble_cuttings(...)

    if not t[cob_file] then t[cob_file] = true; dofile(cob_file) end
    return unilib.stone._register_cobble_cuttings(...)

end

function unilib.register_stone_cobble_mossy_cuttings(...)

    if not t[cob_file] then t[cob_file] = true; dofile(cob_file) end
    return unilib.stone._register_cobble_mossy_cuttings(...)

end

-- Registry functions for rubble
local rub_file = unilib.core.path_mod .. "/lib/shared/stone/stone_rubble.lua"

function unilib.register_stone_rubble(...)

    if not t[rub_file] then t[rub_file] = true; dofile(rub_file) end
    return unilib.stone._register_rubble(...)

end

function unilib.register_stone_rubble_compressed(...)

    if not t[rub_file] then t[rub_file] = true; dofile(rub_file) end
    return unilib.stone._register_rubble_compressed(...)

end

function unilib.register_stone_rubble_condensed(...)

    if not t[rub_file] then t[rub_file] = true; dofile(rub_file) end
    return unilib.stone._register_rubble_condensed(...)

end

function unilib.register_stone_rubble_cuttings(...)

    if not t[rub_file] then t[rub_file] = true; dofile(rub_file) end
    return unilib.stone._register_rubble_cuttings(...)

end

-- Registry functions for mixed stone types
local mix_file = unilib.core.path_mod .. "/lib/shared/stone/stone_mixed.lua"

function unilib.register_stone_cobble_or_rubble_or_nothing(...)

    if not t[mix_file] then t[mix_file] = true; dofile(mix_file) end
    return unilib.stone._register_cobble_or_rubble_or_nothing(...)

end

-- Registry functions for matrix stones
local mat_file = unilib.core.path_mod .. "/lib/shared/stone/stone_matrix.lua"

function unilib.register_matrix_stone(...)

    if not t[mat_file] then t[mat_file] = true; dofile(mat_file) end
    return unilib.stone._register_matrix_stone(...)

end

-- Hardness adjustment functions
local hard_file = unilib.core.path_mod .. "/lib/shared/stone/stone_adjust.lua"

function unilib.stone.get_adjusted_cracky(...)

    if not t[hard_file] then t[hard_file] = true; dofile(hard_file) end
    return unilib.stone._get_adjusted_cracky(...)

end

function unilib.stone.get_actual_hardness(...)

    if not t[hard_file] then t[hard_file] = true; dofile(hard_file) end
    return unilib.stone._get_actual_hardness(...)

end
