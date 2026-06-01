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

function unilib.flora._register_flower_in_pot(full_name, orig_name, flower_img)

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
    --
    -- Optional arguments:
    --      flower_img (str): A texture to use for the flower in a pot. If not specified, the
    --          flower's normal texture is used

    if unilib.setting.flowerpot_add_flowers_flag then

        unilib.global.flowerpot_compat_table[full_name] = orig_name or ""
        if flower_img ~= nil and flower_img ~= "" then
            unilib.global.flowerpot_overlay_table[full_name] = flower_img
        end

    end

end

function unilib.flora._register_mushroom_in_pot(full_name, orig_name, mushroom_img)

    -- Modified version of unilib.register_flower_in_pot(), for mushrooms
    --
    -- Arguments:
    --      full_name (str): e.g. unilib:mushroom_brown
    --      orig_name (str): e.g. flowers:mushroom_brown
    --
    -- Optional arguments:
    --      mushroom_img (str): A texture to use for the mushroom in a pot. If not specified, the
    --          mushroom's normal texture is used

    if unilib.setting.flowerpot_add_mushrooms_flag then

        unilib.global.flowerpot_compat_table[full_name] = orig_name or ""
        if mushroom_img ~= nil and mushroom_img ~= "" then
            unilib.global.flowerpot_overlay_table[full_name] = mushroom_img
        end

    end

end

function unilib.flora._register_plant_in_pot(full_name, orig_name, plant_img)

    -- Modified version of unilib.register_flower_in_pot(), for ferns, grasses and plants
    --
    -- Arguments:
    --      full_name (str): e.g. unilib:plant_shrub_dry
    --      orig_name (str): e.g. default:dry_shrub
    --
    -- Optional arguments:
    --      plant_img (str): A texture to use for the plant in a pot. If not specified, the
    --          plant's normal texture is used

    if unilib.setting.flowerpot_add_plants_flag then

        unilib.global.flowerpot_compat_table[full_name] = orig_name or ""
        if plant_img ~= nil and plant_img ~= "" then
            unilib.global.flowerpot_overlay_table[full_name] = plant_img
        end

    end

end

function unilib.flora._register_sapling_in_pot(full_name, orig_name, sapling_img)

    -- Modified version of unilib.register_flower_in_pot(), for saplings
    --
    -- Arguments:
    --      full_name (str): e.g. unilib:tree_apple_sapling
    --      orig_name (str): e.g. default:sapling
    --
    -- Optional arguments:
    --      sapling_img (str): A texture to use for the sapling in a pot. If not specified, the
    --          sapling's normal texture is used

    if unilib.setting.flowerpot_add_saplings_flag then

        unilib.global.flowerpot_compat_table[full_name] = orig_name or ""
        if sapling_img ~= nil and sapling_img ~= "" then
            unilib.global.flowerpot_overlay_table[full_name] = sapling_img
        end

    end

end
