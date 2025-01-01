---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- tools.lua
--      Set up tools
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Table of files loaded
local t = {}

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.tools = {}

---------------------------------------------------------------------------------------------------
-- Wrapper functions to load files, as and when required
---------------------------------------------------------------------------------------------------

-- Register standard craft recipes
local cra_file = unilib.core.path_mod .. "/lib/shared/tools/tools_craft.lua"

function unilib.register_craft_axe(...)

    if not t[cra_file] then t[cra_file] = true; dofile(cra_file) end
    return unilib.tools._register_craft_axe(...)

end

function unilib.register_craft_chainsaw(...)

    if not t[cra_file] then t[cra_file] = true; dofile(cra_file) end
    return unilib.tools._register_craft_chainsaw(...)

end

function unilib.register_craft_drill(...)

    if not t[cra_file] then t[cra_file] = true; dofile(cra_file) end
    return unilib.tools._register_craft_drill(...)

end

function unilib.register_craft_pick(...)

    if not t[cra_file] then t[cra_file] = true; dofile(cra_file) end
    return unilib.tools._register_craft_pick(...)

end

function unilib.register_craft_scythe(...)

    if not t[cra_file] then t[cra_file] = true; dofile(cra_file) end
    return unilib.tools._register_craft_scythe(...)

end

function unilib.register_craft_shovel(...)

    if not t[cra_file] then t[cra_file] = true; dofile(cra_file) end
    return unilib.tools._register_craft_shovel(...)

end

function unilib.register_craft_sickle(...)

    if not t[cra_file] then t[cra_file] = true; dofile(cra_file) end
    return unilib.tools._register_craft_sickle(...)

end

function unilib.register_craft_sword(...)

    if not t[cra_file] then t[cra_file] = true; dofile(cra_file) end
    return unilib.tools._register_craft_sword(...)

end

function unilib.register_craft_spear(...)

    if not t[cra_file] then t[cra_file] = true; dofile(cra_file) end
    return unilib.tools._register_craft_spear(...)

end

-- Register hoes
local hoe_file = unilib.core.path_mod .. "/lib/shared/tools/tools_hoe.lua"

function unilib.register_hoe(...)

    if not t[hoe_file] then t[hoe_file] = true; dofile(hoe_file) end
    return unilib.tools._register_hoe(...)

end

-- Register tool negative properties
local prop_file = unilib.core.path_mod .. "/lib/shared/tools/tools_properties.lua"

function unilib.tools.register_no_repair(...)

    if not t[prop_file] then t[prop_file] = true; dofile(prop_file) end
    return unilib.tools._register_no_repair(...)

end

function unilib.tools.register_no_scythe(...)

    if not t[prop_file] then t[prop_file] = true; dofile(prop_file) end
    return unilib.tools._register_no_scythe(...)

end

-- Scythe support functions
local scy_file = unilib.core.path_mod .. "/lib/shared/tools/tools_scythe.lua"

function unilib.tools.use_scythe(...)

    if not t[scy_file] then t[scy_file] = true; dofile(scy_file) end
    return unilib.tools._use_scythe(...)

end

-- Sickle support functions
local sic_file = unilib.core.path_mod .. "/lib/shared/tools/tools_sickle.lua"

function unilib.tools.make_cuttable(...)

    if not t[sic_file] then t[sic_file] = true; dofile(sic_file) end
    return unilib.tools._make_cuttable(...)

end

function unilib.tools.make_trimmable(...)

    if not t[sic_file] then t[sic_file] = true; dofile(sic_file) end
    return unilib.tools._make_trimmable(...)

end

-- Register special shovels
local spec_file = unilib.core.path_mod .. "/lib/shared/tools/tools_special.lua"

function unilib.register_special_shovel(...)

    if not t[spec_file] then t[spec_file] = true; dofile(spec_file) end
    return unilib.tools._register_special_shovel(...)

end

-- Toolranks support functions
local trnk_file = unilib.core.path_mod .. "/lib/shared/tools/tools_toolranks.lua"

function unilib.tools.prepare_toolranks_description(...)

    if not t[trnk_file] then t[trnk_file] = true; dofile(trnk_file) end
    return unilib.tools._prepare_toolranks_description(...)

end

function unilib.tools.apply_toolranks(...)

    if not t[trnk_file] then t[trnk_file] = true; dofile(trnk_file) end
    return unilib.tools._apply_toolranks(...)

end

function unilib.tools.update_toolranks_description(...)

    if not t[trnk_file] then t[trnk_file] = true; dofile(trnk_file) end
    return unilib.tools._update_toolranks_description(...)

end

-- Handle tool wear
local wear_file = unilib.core.path_mod .. "/lib/shared/tools/tools_wear.lua"

function unilib.tools.after_use(...)

    if not t[wear_file] then t[wear_file] = true; dofile(wear_file) end
    return unilib.tools._after_use(...)

end
