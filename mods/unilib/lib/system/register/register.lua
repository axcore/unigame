---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- register.lua
--      Set up registration functions, including replacements for several Minetest registration
--          functions
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Table of files loaded
local t = {}

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.register = {}

---------------------------------------------------------------------------------------------------
-- Load files providing replacements for Minetest registration/override functions
---------------------------------------------------------------------------------------------------

-- Register nodes
dofile(unilib.core.path_mod .. "/lib/system/register/register_node.lua")
-- Register craftitems
dofile(unilib.core.path_mod .. "/lib/system/register/register_craftitem.lua")
-- Register tools
dofile(unilib.core.path_mod .. "/lib/system/register/register_tool.lua")

-- Override items
dofile(unilib.core.path_mod .. "/lib/system/register/register_override.lua")

-- Register crafts
dofile(unilib.core.path_mod .. "/lib/system/register/register_craft.lua")

-- Register entities
dofile(unilib.core.path_mod .. "/lib/system/register/register_entity.lua")
-- Register ABMs
dofile(unilib.core.path_mod .. "/lib/system/register/register_abm.lua")
-- Register LBMs
dofile(unilib.core.path_mod .. "/lib/system/register/register_lbm.lua")
-- Register schematics
dofile(unilib.core.path_mod .. "/lib/system/register/register_schematic.lua")

---------------------------------------------------------------------------------------------------
-- Wrapper functions to load files, as and when required
---------------------------------------------------------------------------------------------------

-- N.B. For consistency, unilib.register_X() functions stay within the unilib.X namespace, not the
--      unilib.register.X namespace

-- Node/craftitem/tool upgrade functions
local upg_file = unilib.core.path_mod .. "/lib/system/register/register_upgrade.lua"

function unilib.register.upgrade_node(...)

    if not t[upg_file] then t[upg_file] = true; dofile(upg_file) end
    return unilib.register._upgrade_node(...)

end

function unilib.register.upgrade_craftitem(...)

    if not t[upg_file] then t[upg_file] = true; dofile(upg_file) end
    return unilib.register._upgrade_craftitem(...)

end

-- Extra craft recipe functions
local cre_file = unilib.core.path_mod .. "/lib/system/register/register_craft_extra.lua"

function unilib.register_craft_2x2(...)

    if not t[cre_file] then t[cre_file] = true; dofile(cre_file) end
    return unilib.register._register_craft_2x2(...)

end

function unilib.register_craft_2x2x4(...)

    if not t[cre_file] then t[cre_file] = true; dofile(cre_file) end
    return unilib.register._register_craft_2x2x4(...)

end

function unilib.register_craft_3x3(...)

    if not t[cre_file] then t[cre_file] = true; dofile(cre_file) end
    return unilib.register._register_craft_3x3(...)

end

function unilib.register_craft_3x3x9(...)

    if not t[cre_file] then t[cre_file] = true; dofile(cre_file) end
    return unilib.register._register_craft_3x3x9(...)

end

-- Craft recipe utility functions
local cru_file = unilib.core.path_mod .. "/lib/system/register/register_craft_util.lua"

function unilib.register_craft_metadata_copy(...)

    if not t[cru_file] then t[cru_file] = true; dofile(cru_file) end
    return unilib.register._register_craft_metadata_copy(...)

end

function unilib.register_external_ingredient(...)

    if not t[cru_file] then t[cru_file] = true; dofile(cru_file) end
    return unilib.register._register_external_ingredient(...)

end

function unilib.register_craft_conflicts(...)

    if not t[cru_file] then t[cru_file] = true; dofile(cru_file) end
    return unilib.register._register_craft_conflicts(...)

end

function unilib.register_craft_missing_ingredients(...)

    if not t[cru_file] then t[cru_file] = true; dofile(cru_file) end
    return unilib.register._register_craft_missing_ingredients(...)

end

-- Register biomes
local bio_file = unilib.core.path_mod .. "/lib/system/register/register_biome.lua"

function unilib.register_biome(...)

    if not t[bio_file] then t[bio_file] = true; dofile(bio_file) end
    return unilib.register._register_biome(...)

end

-- Regiser biomes from CSV
local cbio_file = unilib.core.path_mod .. "/lib/system/register/register_biome_csv.lua"

function unilib.register_biome_from_csv(...)

    if not t[cbio_file] then t[cbio_file] = true; dofile(cbio_file) end
    return unilib.register._register_biome_from_csv(...)

end

-- Register decorations
local dec_file = unilib.core.path_mod .. "/lib/system/register/register_deco.lua"

function unilib.register_decoration_generic(...)

    if not t[dec_file] then t[dec_file] = true; dofile(dec_file) end
    return unilib.register._register_decoration_generic(...)

end

function unilib.register_decoration_spare(...)

    if not t[dec_file] then t[dec_file] = true; dofile(dec_file) end
    return unilib.register._register_decoration_spare(...)

end

function unilib.register_decoration_complete(...)

    if not t[dec_file] then t[dec_file] = true; dofile(dec_file) end
    return unilib.register._register_decoration_complete(...)

end

-- Register simple decorations
local sdec_file = unilib.core.path_mod .. "/lib/system/register/register_deco_simple.lua"

function unilib.register_decoration_simple(...)

    if not t[sdec_file] then t[sdec_file] = true; dofile(sdec_file) end
    return unilib.register._register_decoration_simple(...)

end

-- Register convertable decorations
local vdec_file = unilib.core.path_mod .. "/lib/system/register/register_deco_convertable.lua"

function unilib.register_decoration_convertable(...)

    if not t[vdec_file] then t[vdec_file] = true; dofile(vdec_file) end
    return unilib.register._register_decoration_convertable(...)

end

-- Register decorations from CSV
local cdec_file = unilib.core.path_mod .. "/lib/system/register/register_deco_csv.lua"

function unilib.register_decoration_from_csv(...)

    if not t[cdec_file] then t[cdec_file] = true; dofile(cdec_file) end
    return unilib.register._register_decoration_from_csv(...)

end

-- Register ores
local ore_file = unilib.core.path_mod .. "/lib/system/register/register_ore.lua"

function unilib.register_ore(...)

    if not t[ore_file] then t[ore_file] = true; dofile(ore_file) end
    return unilib.register._register_ore(...)

end

-- Regiser ores from CSV
local core_file = unilib.core.path_mod .. "/lib/system/register/register_ore_csv.lua"

function unilib.register_ore_from_csv(...)

    if not t[core_file] then t[core_file] = true; dofile(core_file) end
    return unilib.register._register_ore_from_csv(...)

end

-- Support functions (decorations and ores)
local dsup_file = unilib.core.path_mod .. "/lib/system/register/register_support_deco_ore.lua"

function unilib.register.parse_flags(...)

    if not t[dsup_file] then t[dsup_file] = true; dofile(dsup_file) end
    return unilib.register._parse_flags(...)

end

function unilib.register.check_biomes_in_decoration(...)

    if not t[dsup_file] then t[dsup_file] = true; dofile(dsup_file) end
    return unilib.register._check_biomes_in_decoration(...)

end

-- Support functions (items)
local isup_file = unilib.core.path_mod .. "/lib/system/register/register_support_item.lua"

function unilib.register.hide_item(...)

    if not t[isup_file] then t[isup_file] = true; dofile(isup_file) end
    return unilib.register._hide_item(...)

end

function unilib.register.replace_item(...)

    if not t[isup_file] then t[isup_file] = true; dofile(isup_file) end
    return unilib.register._replace_item(...)

end
