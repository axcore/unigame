---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- flora.lua
--      Set up shared functions for various types of flora
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Table of files loaded
local t = {}

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.flora = {}

---------------------------------------------------------------------------------------------------
-- Wrapper functions to load files, as and when required
---------------------------------------------------------------------------------------------------

-- Cactus growth callbacks
local cac_file = unilib.core.path_mod .. "/lib/shared/flora/flora_cactus.lua"

function unilib.flora.grow_cactus(...)

    if not t[cac_file] then t[cac_file] = true; dofile(cac_file) end
    return unilib.flora._grow_cactus(...)

end

-- Register regrowing fruit
local fru_file = unilib.core.path_mod .. "/lib/shared/flora/flora_fruit.lua"

function unilib.register_regrowing_fruit(...)

    if not t[fru_file] then t[fru_file] = true; dofile(fru_file) end
    return unilib.flora._register_regrowing_fruit(...)

end

-- Register growth stages for various flora
local grow_file = unilib.core.path_mod .. "/lib/shared/flora/flora_grow.lua"

function unilib.flora.register_growth_stages(...)

    if not t[grow_file] then t[grow_file] = true; dofile(grow_file) end
    return unilib.flora._register_growth_stages(...)

end

-- Handle leaf decay
local dec_file = unilib.core.path_mod .. "/lib/shared/flora/flora_leafdecay.lua"

function unilib.register_leafdecay(...)

    if not t[dec_file] then t[dec_file] = true; dofile(dec_file) end
    return unilib.flora._register_leafdecay(...)

end

function unilib.register_quick_bush_leafdecay(...)

    if not t[dec_file] then t[dec_file] = true; dofile(dec_file) end
    return unilib.flora._register_quick_bush_leafdecay(...)

end

function unilib.register_quick_tree_leafdecay(...)

    if not t[dec_file] then t[dec_file] = true; dofile(dec_file) end
    return unilib.flora._register_quick_tree_leafdecay(...)

end

function unilib.flora.collapse_tree(...)

    if not t[dec_file] then t[dec_file] = true; dofile(dec_file) end
    return unilib.flora._collapse_tree(...)

end

function unilib.flora.collapse_slim_tree(...)

    if not t[dec_file] then t[dec_file] = true; dofile(dec_file) end
    return unilib.flora._collapse_slim_tree(...)

end

function unilib.flora.after_place_leaves(...)

    if not t[dec_file] then t[dec_file] = true; dofile(dec_file) end
    return unilib.flora._after_place_leaves(...)

end

-- Papyrus growth callbacks
local pap_file = unilib.core.path_mod .. "/lib/shared/flora/flora_papyrus.lua"

function unilib.flora.grow_papyrus(...)

    if not t[pap_file] then t[pap_file] = true; dofile(pap_file) end
    return unilib.flora._grow_papyrus(...)

end

-- Handle flowerpots (used with flowers, mushrooms, plants and saplings)
local pot_file = unilib.core.path_mod .. "/lib/shared/flora/flora_pot.lua"

function unilib.register_flower_in_pot(...)

    if not t[pot_file] then t[pot_file] = true; dofile(pot_file) end
    return unilib.flora._register_flower_in_pot(...)

end

function unilib.register_mushroom_in_pot(...)

    if not t[pot_file] then t[pot_file] = true; dofile(pot_file) end
    return unilib.flora._register_mushroom_in_pot(...)

end

function unilib.register_plant_in_pot(...)

    if not t[pot_file] then t[pot_file] = true; dofile(pot_file) end
    return unilib.flora._register_plant_in_pot(...)

end

function unilib.register_sapling_in_pot(...)

    if not t[pot_file] then t[pot_file] = true; dofile(pot_file) end
    return unilib.flora._register_sapling_in_pot(...)

end

-- Handle saplings
local sap_file = unilib.core.path_mod .. "/lib/shared/flora/flora_sapling.lua"

function unilib.flora.sapling_on_place(...)

    if not t[sap_file] then t[sap_file] = true; dofile(sap_file) end
    return unilib.flora._sapling_on_place(...)

end

function unilib.flora.can_grow_sapling(...)

    if not t[sap_file] then t[sap_file] = true; dofile(sap_file) end
    return unilib.flora._can_grow_sapling(...)

end

function unilib.flora.is_snow_nearby(...)

    if not t[sap_file] then t[sap_file] = true; dofile(sap_file) end
    return unilib.flora._is_snow_nearby(...)

end

function unilib.flora.get_sapling_hint(...)

    if not t[sap_file] then t[sap_file] = true; dofile(sap_file) end
    return unilib.flora._get_sapling_hint(...)

end

-- Flora support functions
local sup_file = unilib.core.path_mod .. "/lib/shared/flora/flora_support.lua"

function unilib.flora.filter_leaves_img(...)

    if not t[sup_file] then t[sup_file] = true; dofile(sup_file) end
    return unilib.flora._filter_leaves_img(...)

end

function unilib.flora.update_sapling_growth_requirements(...)

    if not t[sup_file] then t[sup_file] = true; dofile(sup_file) end
    return unilib.flora._update_sapling_growth_requirements(...)

end
