---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_crystallinum = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_crystallinum.init()

    return {
        description = "Crystallinum",
        notes = "Crystallinum spikes harm the player if touched",
        optional = "mineral_mese",
    }

end

function unilib.pkg.mineral_crystallinum.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "crystallinum",
        description = S("Crystallinum"),

        fictional_flag = true,
        hardness = 3,
        no_lump_flag = true,
    })

    unilib.register_node("unilib:mineral_crystallinum_spike", "ethereal:crystal_spike", mode, {
        -- From ethereal:crystal_spike
        description = S("Crystallinum Spike"),
        tiles = {"unilib_mineral_crystallinum_spike.png"},
        groups = {cools_lava = 1, cracky = 1, falling_node = 1, puts_out_fire = 1},
        sounds = unilib.sound_table.glass,

        damage_per_second = 1,
        drawtype = "plantlike",
        inventory_image = "unilib_mineral_crystallinum_spike.png",
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
        wield_image = "unilib_mineral_crystallinum_spike.png",
    })

    if unilib.pkg_executed_table["mineral_mese"] ~= nil then

        unilib.register_craftitem(
            -- From ethereal:crystal_ingot
            "unilib:mineral_crystallinum_ingot",
            "ethereal:crystal_ingot",
            mode,
            {
                description = S("Crystallinum Ingot"),
                inventory_image = "unilib_mineral_crystallinum_ingot.png",

                wield_image = "unilib_mineral_crystallinum_ingot.png",
            }
        )
        unilib.register_craft({
            -- From ethereal:crystal_ingot
            output = "unilib:mineral_crystallinum_ingot 9",
            recipe = {
                {"unilib:mineral_crystallinum_block"},
            },
        })

        unilib.register_node("unilib:mineral_crystallinum_block", "ethereal:crystal_block", mode, {
            -- From ethereal:crystal_block
            description = S("Crystallinum Block"),
            tiles = {"unilib_mineral_crystallinum_block.png"},
            groups = {cools_lava = 1, cracky = 1, level = 2, puts_out_fire = 1},
            sounds = unilib.sound_table.glass,

            is_ground_content = false,
            light_source = 9,
        })
        unilib.register_craft_3x3({
            -- From ethereal:crystal_block
            output = "unilib:mineral_crystallinum_block",
            ingredient = "unilib:mineral_crystallinum_ingot",
        })
        unilib.register_stairs("unilib:mineral_crystallinum_block")

    end

end

function unilib.pkg.mineral_crystallinum.post()

    if unilib.pkg_executed_table["mineral_mese"] ~= nil then

        unilib.register_craft({
            -- From ethereal:crystal_ingot
            type = "shapeless",
            output = "unilib:mineral_crystallinum_ingot",
            recipe = {
                "unilib:mineral_mese_crystal",
                "unilib:mineral_crystallinum_spike",
                "unilib:mineral_crystallinum_spike",
                "unilib:mineral_mese_crystal",
                "group:craftable_bucket",
            },
            replacements = unilib.craftable_bucket_list,
        })

    end

end
