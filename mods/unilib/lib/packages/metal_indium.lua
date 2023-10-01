---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_indium = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_indium.init()

    return {
        description = "Indium",
    }

end

function unilib.pkg.metal_indium.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "indium",
        description = S("Indium"),

        hardness = 1,
    })

    unilib.register_metal_powder({
        -- Original to unilib. Creates unilib:metal_indium_powder
        part_name = "indium",
        orig_name = nil,

        replace_mode = mode,
        description = S("Indium Powder"),
        no_lump_flag = true,
    })

    unilib.register_craftitem("unilib:metal_indium_ingot", nil, mode, {
        -- Original to unilib
        description = S("Indium Ingot"),
        inventory_image = "unilib_metal_indium_ingot.png",
        groups = {metal_ingot = 1},
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:metal_indium_ingot 9",
        recipe = {
            {"unilib:metal_indium_block"},
        }
    })

    unilib.register_node("unilib:metal_indium_block", nil, mode, {
        -- Original to unilib
        description = S("Indium Block"),
        tiles = {"unilib_metal_indium_block.png"},
        groups = {cracky = 1, level = 2},
        sounds = unilib.sound_table.metal,

        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- Original to unilib
        output = "unilib:metal_indium_block",
        ingredient = "unilib:metal_indium_ingot",
    })

end
