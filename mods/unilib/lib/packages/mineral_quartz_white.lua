---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_quartz_white = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_quartz_white.init()

    return {
        description = "White quartz (as a mineral)",
    }

end

function unilib.pkg.mineral_quartz_white.exec()

    unilib.register_mineral({
        -- Original to unilib
        part_name = "quartz_white",
        description = S("White Quartz"),

        hardness = 3,
    })

    unilib.register_craftitem("unilib:mineral_quartz_white_crystal", "underch:quartz", mode, {
        -- From underch:quartz
        description = S("White Quartz Crystal"),
        inventory_image = "unilib_mineral_quartz_white_crystal.png",
    })
    unilib.register_craft({
        -- From underch:quartz
        type = "shapeless",
        output = "unilib:mineral_quartz_white_crystal 9",
        recipe = {"unilib:mineral_quartz_white_block"},
    })
    unilib.register_craft({
        -- From underch:quartz
        type = "shapeless",
        output = "unilib:mineral_quartz_white_crystal 2",
        recipe = {"unilib:mineral_quartz_white_crystal_large"},
    })

    unilib.register_node("unilib:mineral_quartz_white_block", "underch:quartz_block", mode, {
        -- From underch:quartz_block
        description = S("White Quartz Block"),
        tiles = {"unilib_mineral_quartz_white_block.png"},
        groups = {cracky = 3},
        sounds = unilib.global.sound_table.glass,

        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From underch:quartz_block
        output = "unilib:mineral_quartz_white_block",
        ingredient = "unilib:mineral_quartz_white_crystal",
    })
    unilib.register_stairs("unilib:mineral_quartz_white_block")
    unilib.register_carvings("unilib:mineral_quartz_white_block", {
        millwork_flag = true,
    })

    unilib.register_node(
        -- From underch:quartz_crystal
        "unilib:mineral_quartz_white_crystal_large",
        "underch:quartz_crystal",
        mode,
        {
            description = S("Large White Quartz Crystal"),
            tiles = {"unilib_mineral_quartz_white_crystal_large.png"},
            groups = {cracky = 2},
            sounds = unilib.global.sound_table.glass,

            drawtype = "mesh",
            is_ground_content = false,
            light_source = 4,
            mesh = "unilib_mineral_crystal_large.obj",
            paramtype = "light",
            paramtype2 = "facedir",
        }
    )

end
