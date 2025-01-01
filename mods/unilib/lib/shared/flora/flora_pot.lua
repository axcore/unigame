---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- flora_pot.lua
--      Handle flowerpots (used with flowers, mushrooms, plants and saplings)
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Handle flowerpots (used with flowers, mushrooms, plants and saplings)
---------------------------------------------------------------------------------------------------

function unilib.flora._register_flower_in_pot(full_name, orig_name)

    -- Original to unilib
    -- Can be called by unilib.register_flower() and unilib.register_beautiflower(), or
    --      independently by packages which create flowers or any other plants which are compatible
    --      with flowerpots
    -- Flowerpot packages should create an empty flowerpot in their .exec() functions, and then use
    --      list to register flowers in that pot during their .post() functionss
    --
    -- Some items are not suitable for use in flowerpots, and should not be used in calls to this
    --      function (and the ones below):
    --
    --      - Craftitems (and tools!)
    --      - Nodes drawn using a mesh
    --      - Nodes drawn with the .drawtype "firelike" or "nodebox"
    --      - Nodes that drop something other than themselves, e.g. seeds from "wild" plants
    --      - Nodes that drop nothing, i.e. .drop = ""
    --      - Nodes that would not be compatible in real life (e.g. underwater plants)
    --      - Nodes which have the "not_in_creative_inventory" group set
    --
    -- Arguments:
    --      full_name (str): e.g. unilib:flower_rose_red
    --      orig_name (str): e.g. flowers:rose

    if unilib.setting.flowerpot_add_flowers_flag then
        unilib.global.flowerpot_compat_table[full_name] = orig_name or ""
    end

end

function unilib.flora._register_mushroom_in_pot(full_name, orig_name)

    -- Modified version of unilib.register_flower_in_pot(), for mushrooms
    --
    -- Arguments:
    --      full_name (str): e.g. unilib:flower_rose_red
    --      orig_name (str): e.g. flowers:rose

    if unilib.setting.flowerpot_add_mushrooms_flag then
        unilib.global.flowerpot_compat_table[full_name] = orig_name or ""
    end

end

function unilib.flora._register_plant_in_pot(full_name, orig_name)

    -- Modified version of unilib.register_flower_in_pot(), for ferns, grasses and plants
    --
    -- Arguments:
    --      full_name (str): e.g. unilib:flower_rose_red
    --      orig_name (str): e.g. flowers:rose

    if unilib.setting.flowerpot_add_plants_flag then
        unilib.global.flowerpot_compat_table[full_name] = orig_name or ""
    end

end

function unilib.flora._register_sapling_in_pot(full_name, orig_name)

    -- Modified version of unilib.register_flower_in_pot(), for saplings
    --
    -- Arguments:
    --      full_name (str): e.g. unilib:flower_rose_red
    --      orig_name (str): e.g. flowers:rose

    if unilib.setting.flowerpot_add_saplings_flag then
        unilib.global.flowerpot_compat_table[full_name] = orig_name or ""
    end

end
