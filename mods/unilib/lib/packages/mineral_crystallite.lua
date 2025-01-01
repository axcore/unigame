---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_crystallite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_crystallite.init()

    return {
        description = "Crystallite",
        notes = "Crystallite spikes harm the player if touched",
        optional = "mineral_mese",
    }

end

function unilib.pkg.mineral_crystallite.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "crystallite",
        description = S("Crystallite"),

        fictional_flag = true,
        hardness = 3,
        no_lump_flag = true,
    })

    unilib.register_node("unilib:mineral_crystallite_spike", "ethereal:crystal_spike", mode, {
        -- From ethereal:crystal_spike
        description = S("Crystallite Spike"),
        tiles = {"unilib_mineral_crystallite_spike.png"},
        groups = {cools_lava = 1, cracky = 1, falling_node = 1, puts_out_fire = 1},
        sounds = unilib.global.sound_table.glass,

        damage_per_second = 1,
        drawtype = "plantlike",
        inventory_image = "unilib_mineral_crystallite_spike.png",
        light_source = 7,
        node_box = {
            type = "fixed",
            fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 0, 5 / 16},
        },
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 0, 5 / 16},
        },
        sunlight_propagates = true,
        walkable = true,
        wield_image = "unilib_mineral_crystallite_spike.png",
    })

    if unilib.global.pkg_executed_table["mineral_mese"] ~= nil then

        unilib.register_craftitem(
            -- From ethereal:crystal_ingot
            "unilib:mineral_crystallite_ingot",
            "ethereal:crystal_ingot",
            mode,
            {
                description = S("Crystallite Ingot"),
                inventory_image = "unilib_mineral_crystallite_ingot.png",

                wield_image = "unilib_mineral_crystallite_ingot.png",
            }
        )
        unilib.register_craft({
            -- From ethereal:crystal_ingot
            output = "unilib:mineral_crystallite_ingot 9",
            recipe = {
                {"unilib:mineral_crystallite_block"},
            },
        })

        unilib.register_node("unilib:mineral_crystallite_block", "ethereal:crystal_block", mode, {
            -- From ethereal:crystal_block
            description = S("Crystallite Block"),
            tiles = {"unilib_mineral_crystallite_block.png"},
            groups = {cools_lava = 1, cracky = 1, level = 2, puts_out_fire = 1},
            sounds = unilib.global.sound_table.glass,

            is_ground_content = false,
            light_source = 9,
        })
        unilib.register_craft_3x3({
            -- From ethereal:crystal_block
            output = "unilib:mineral_crystallite_block",
            ingredient = "unilib:mineral_crystallite_ingot",
        })
        unilib.register_stairs("unilib:mineral_crystallite_block")
        unilib.register_carvings("unilib:mineral_crystallite_block", {
            millwork_flag = true,
        })

    end

end

function unilib.pkg.mineral_crystallite.post()

    if unilib.global.pkg_executed_table["mineral_mese"] ~= nil then

        unilib.register_craft({
            -- From ethereal:crystal_ingot
            output = "unilib:mineral_crystallite_ingot",
            recipe = {
                {"unilib:mineral_mese_crystal", "unilib:mineral_crystallite_spike"},
                {"unilib:mineral_crystallite_spike", "unilib:mineral_mese_crystal"},
                {"group:craftable_bucket", ""},
            },
            replacements = unilib.global.craftable_bucket_list,
        })

    end

end
