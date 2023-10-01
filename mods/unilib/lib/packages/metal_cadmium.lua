---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_cadmium = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_cadmium.init()

    return {
        description = "Cadmium",
    }

end

function unilib.pkg.metal_cadmium.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "cadmium",
        description = S("Cadmium"),

        hardness = 1,
    })

    unilib.register_metal_powder({
        -- Original to unilib. Creates unilib:metal_cadmium_powder
        part_name = "cadmium",
        orig_name = nil,

        replace_mode = mode,
        description = S("Cadmium Powder"),
        no_lump_flag = true,
    })

    unilib.register_craftitem("unilib:metal_cadmium_ingot", nil, mode, {
        -- Original to unilib
        description = S("Cadmium Ingot"),
        inventory_image = "unilib_metal_cadmium_ingot.png",
        groups = {metal_ingot = 1},
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:metal_cadmium_ingot 9",
        recipe = {
            {"unilib:metal_cadmium_block"},
        }
    })

    unilib.register_node("unilib:metal_cadmium_block", nil, mode, {
        -- Original to unilib
        description = S("Cadmium Block"),
        tiles = {"unilib_metal_cadmium_block.png"},
        groups = {cracky = 1, level = 2},
        sounds = unilib.sound_table.metal,

        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- Original to unilib
        output = "unilib:metal_cadmium_block",
        ingredient = "unilib:metal_cadmium_ingot",
    })

end
