---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_amethyst = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_amethyst.init()

    return {
        description = "Amethyst (as a mineral)",
    }

end

function unilib.pkg.mineral_amethyst.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "amethyst",
        description = S("Amethyst"),

        hardness = 3,
        no_lump_flag = true,
    })

    unilib.register_craftitem("unilib:mineral_amethyst_crystal", "underch:amethyst", mode, {
        -- From underch:amethyst
        description = S("Amethyst Crystal"),
        inventory_image = "unilib_mineral_amethyst_crystal.png",
    })
    unilib.register_craft({
        -- From underch:amethyst
        type = "shapeless",
        output = "unilib:mineral_amethyst_crystal 9",
        recipe = {"unilib:mineral_amethyst_block"}
    })
    unilib.register_craft({
        -- From underch:amethyst
        type = "shapeless",
        output = "unilib:mineral_amethyst_crystal 2",
        recipe = {"unilib:mineral_amethyst_crystal_large"}
    })

    unilib.register_node("unilib:mineral_amethyst_block", "underch:amethyst_block", mode, {
        -- From underch:amethyst_block
        description = S("Amethyst Block"),
        tiles = {"unilib_mineral_amethyst_block.png"},
        groups = {cracky = 3},
        sounds = unilib.sound_table.glass,

        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From underch:amethyst_block
        output = "unilib:mineral_amethyst_block",
        ingredient = "unilib:mineral_amethyst_crystal",
    })
    unilib.register_stairs("unilib:mineral_amethyst_block")

    unilib.register_node(
        -- From underch:amethyst_crystal
        "unilib:mineral_amethyst_crystal_large",
        "underch:amethyst_crystal",
        mode,
        {
            description = S("Large Amethyst Crystal"),
            tiles = {"unilib_mineral_amethyst_crystal_large.png"},
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
