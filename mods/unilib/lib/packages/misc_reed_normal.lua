---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/dryplants
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_reed_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.dryplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_reed_normal.init()

    return {
        description = "Normal reed",
        optional = {"misc_patch_grass", "plant_papyrus_ordinary", "plant_bulrush"},
    }

end

function unilib.pkg.misc_reed_normal.exec()

    unilib.register_node("unilib:misc_reed_normal", "dryplants:reed", mode, {
        -- From dryplants:reed
        description = S("Pile of Reed"),
        tiles = {"unilib_misc_reed_normal.png"},
        -- ("hay" group from the cottages mod)
        groups = {flammable = 2, hay = 3, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        -- N.B. is_ground_content = false not in original code; added to match ordinary straw
        is_ground_content = false,
        paramtype = "light",
        paramtype2 = "facedir",
    })
    -- (A pile of reed should only be able to make basic stair shapes and optionally the roof
    --      corners from plantlife; as in the original code)
    unilib.register_stairs("unilib:misc_reed_normal", {
        basic_flag = true,
    })
    if unilib.global.pkg_executed_table["misc_patch_grass"] ~= nil then

        unilib.register_craft({
            -- From dryplants:reed
            output = "unilib:misc_reed_normal 2",
            recipe = {
                {"unilib:misc_patch_grass_dead", "unilib:misc_patch_grass_dead"},
                {"unilib:misc_patch_grass_dead", "unilib:misc_patch_grass_dead"},
            },
        })

    end
    unilib.register_craft({
        -- From dryplants:reed
        type = "cooking",
        output = "unilib:misc_reed_normal",
        recipe = "unilib:misc_reed_normal_wet",
        cooktime = 2,
    })
    unilib.register_craft({
        -- From dryplants:reed
        type = "fuel",
        recipe = "unilib:misc_reed_normal",
        burntime = 4,
    })

    unilib.register_node("unilib:misc_reed_normal_wet", "dryplants:wetreed", mode, {
        -- From dryplants:wetreed
        description = S("Pile of Wet Reed"),
        tiles = {"unilib_misc_reed_normal_wet.png"},
        groups = {flammable = 2, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        -- N.B. is_ground_content = false not in original code; added to match ordinary straw
        is_ground_content = false,
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_stairs("unilib:misc_reed_normal_wet", {
        basic_flag = true,
    })
    if unilib.global.pkg_executed_table["plant_papyrus_ordinary"] ~= nil then

        unilib.register_craft({
            -- From dryplants:wetreed
            output = "unilib:misc_reed_normal_wet 2",
            recipe = {
                {"unilib:plant_papyrus_ordinary", "unilib:plant_papyrus_ordinary"},
                {"unilib:plant_papyrus_ordinary", "unilib:plant_papyrus_ordinary"},
            },
        })

    end
    if unilib.global.pkg_executed_table["plant_reedmace"] ~= nil then

        unilib.register_craft({
            -- From dryplants:reedmace_sapling
            output = "unilib:misc_reed_normal_wet 2",
            recipe = {
                {"unilib:plant_reedmace_sapling", "unilib:plant_reedmace_sapling"},
                {"unilib:plant_reedmace_sapling", "unilib:plant_reedmace_sapling"},
            },
        })
        unilib.register_craft({
            -- From dryplants:reedmace_top
            output = "unilib:misc_reed_normal_wet 2",
            recipe = {
                {"unilib:plant_reedmace_small", "unilib:plant_reedmace_small"},
                {"unilib:plant_reedmace_small", "unilib:plant_reedmace_small"},
            },
        })

        unilib.register_craft({
            -- From dryplants:reedmace
            output = "unilib:misc_reed_normal_wet 2",
            recipe = {
                {"unilib:plant_bulrush_stem", "unilib:plant_bulrush_stem"},
                {"unilib:plant_bulrush_stem", "unilib:plant_bulrush_stem"},
            },
        })
        unilib.register_craft({
            -- From dryplants:reedmace_bottom
            output = "unilib:misc_reed_normal_wet 2",
            recipe = {
                {"unilib:plant_bulrush_bottom", "unilib:plant_bulrush_bottom"},
                {"unilib:plant_bulrush_bottom", "unilib:plant_bulrush_bottom"},
            },
        })

    end

    -- Wet weed becomes dry over time
    local wet_list = unilib.global.stair_convert_table["unilib:misc_reed_normal_wet"]
    if wet_list == nil then
        wet_list = {"unilib:misc_reed_normal_wet"}
    else
        table.insert(wet_list, "unilib:misc_reed_normal_wet")
    end

    unilib.register_abm({
        label = "Dry wettened reed [misc_reed_normal]",
        nodenames = wet_list,

        chance = 1,
        -- In original mod, was 1200 in code comments, but 3600 in settings.txt
        interval = 3600,

        action = function(pos)

            local node = core.get_node(pos)
            local full_name = string.gsub(node.name, "misc_reed_normal_wet", "misc_reed_normal")
            local direction = node.param2

            core.swap_node(pos, {name=full_name, param2=direction})

        end,
    })

end
