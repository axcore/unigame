---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_aquamarine = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_aquamarine.init()

    return {
        description = "Aquamarine (as a mineral)",
    }

end

function unilib.pkg.mineral_aquamarine.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "aquamarine",
        description = S("Aquamarine"),

        hardness = 3,
        no_lump_flag = true,
    })

    unilib.register_craftitem("unilib:mineral_aquamarine_crystal", "underch:aquamarine", mode, {
        -- From underch:aquamarine
        description = S("Aquamarine Crystal"),
        inventory_image = "unilib_mineral_aquamarine_crystal.png",
    })
    unilib.register_craft({
        -- From underch:aquamarine
        type = "shapeless",
        output = "unilib:mineral_aquamarine_crystal 9",
        recipe = {"unilib:mineral_aquamarine_block"}
    })
    unilib.register_craft({
        -- From underch:aquamarine
        type = "shapeless",
        output = "unilib:mineral_aquamarine_crystal 2",
        recipe = {"unilib:mineral_aquamarine_crystal_large"}
    })

    unilib.register_node("unilib:mineral_aquamarine_block", "underch:aquamarine_block", mode, {
        -- From underch:aquamarine_block
        description = S("Aquamarine Block"),
        tiles = {"unilib_mineral_aquamarine_block.png"},
        groups = {cracky = 3},
        sounds = unilib.sound_table.glass,

        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From underch:aquamarine_block
        output = "unilib:mineral_aquamarine_block",
        ingredient = "unilib:mineral_aquamarine_crystal",
    })
    unilib.register_stairs("unilib:mineral_aquamarine_block")

    unilib.register_node(
        -- From underch:aquamarine_crystal
        "unilib:mineral_aquamarine_crystal_large",
        "underch:aquamarine_crystal",
        mode,
        {
            description = S("Large Aquamarine Crystal"),
            tiles = {"unilib_mineral_aquamarine_crystal_large.png"},
            groups = {cracky = 2},
            sounds = unilib.sound_table.glass,

            drawtype = "mesh",
            is_ground_content = false,
            light_source = 4,
            mesh = "unilib_mineral_crystal_large.obj",
            paramtype = "light",
            paramtype2 = "facedir",
        }
    )

end
