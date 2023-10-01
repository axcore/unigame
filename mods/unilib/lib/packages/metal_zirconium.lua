---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_zirconium = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_zirconium.init()

    return {
        description = "Zirconium",
    }

end

function unilib.pkg.metal_zirconium.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "zirconium",
        description = S("Zirconium"),

        hardness = 2,
        powder_flag = true,
    })

    unilib.register_metal_powder({
        -- Original to unilib. Creates unilib:metal_zirconium_powder
        part_name = "zirconium",
        orig_name = nil,

        replace_mode = mode,
        description = S("Zirconium Powder"),
        no_lump_flag = true,
    })

    unilib.register_craftitem("unilib:metal_zirconium_ingot", nil, mode, {
        -- Original to unilib
        description = S("Zirconium Ingot"),
        inventory_image = "unilib_metal_zirconium_ingot.png",
        groups = {metal_ingot = 1},
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:metal_zirconium_ingot 9",
        recipe = {
            {"unilib:metal_zirconium_block"},
        }
    })

    unilib.register_node("unilib:metal_zirconium_block", nil, mode, {
        -- Original to unilib
        description = S("Zirconium Block"),
        tiles = {"unilib_metal_zirconium_block.png"},
        groups = {cracky = 1, level = 2},
        sounds = unilib.sound_table.metal,

        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- Original to unilib
        output = "unilib:metal_zirconium_block",
        ingredient = "unilib:metal_zirconium_ingot",
    })

end
