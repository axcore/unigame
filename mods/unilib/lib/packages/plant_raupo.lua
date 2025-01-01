---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_raupo = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_raupo.init()

    return {
        description = "Raupo",
        optional = "item_paper_ordinary",
    }

end

function unilib.pkg.plant_raupo.exec()

    unilib.register_node("unilib:plant_raupo", "aotearoa:raupo", mode, {
        -- From aotearoa:raupo
        description = unilib.utils.annotate(S("Raupo"), "Typha orientalis"),
        tiles = {"unilib_plant_raupo.png"},
        -- N.B. flora = 1 not in original code
        groups = {dry_grass = 1, flammable = 1, flora = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_raupo.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.1, -0.5, -0.1, 0.1, 0.5, 0.1},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_plant_raupo.png",

        after_dig_node = function(pos, node, metadata, digger)

            unilib.misc.dig_up_multiple(
                pos,
                {"unilib:plant_raupo", "unilib:plant_raupo_flower"},
                digger
            )

        end,
    })
    unilib.register_craft({
        -- From aotearoa:raupo
        type = "fuel",
        recipe = "unilib:plant_raupo",
        burntime = 1,
    })
    if unilib.global.pkg_executed_table["item_paper_ordinary"] ~= nil then

        unilib.register_craft({
            -- From aotearoa:raupo
            output = "unilib:item_paper_ordinary",
            recipe = {
                {"unilib:plant_raupo", "unilib:plant_raupo", "unilib:plant_raupo"},
            },
        })

    end
    unilib.register_plant_in_pot("unilib:plant_raupo", "aotearoa:raupo")

    unilib.register_node("unilib:plant_raupo_flower", "aotearoa:raupo_flower", mode, {
        -- From aotearoa:raupo_flower
        description = unilib.utils.annotate(S("Raupo with Flowers"), "Typha orientalis"),
        tiles = {"unilib_plant_raupo_flower.png"},
        groups = {dry_grass = 1, flammable = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_raupo_flower.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.1, -0.5, -0.1, 0.1, 0.5, 0.1},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_plant_raupo_flower.png",
    })
    unilib.register_craft({
        -- From aotearoa:raupo_flower
        type = "fuel",
        recipe = "unilib:plant_raupo_flower",
        burntime = 1,
    })
    unilib.register_plant_in_pot("unilib:plant_raupo_flower", "aotearoa:raupo_flower")

    for i = 1, 2 do

        unilib.register_decoration_generic("aotearoa_plant_raupo_normal_" .. i, {
            -- From aotearoa/spawn_trees.lua
            deco_type = "schematic",
            schematic = unilib.core.path_mod .. "/mts/unilib_plant_raupo_" .. i .. ".mts",

            fill_ratio = 0.7,
            flags = "place_center_x, place_center_z",
            rotation = "random",
            sidelen = 8,
        })

    end

end
