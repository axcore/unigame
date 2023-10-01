---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_osmium = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_osmium.init()

    return {
        description = "Osmium",
    }

end

function unilib.pkg.metal_osmium.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "osmium",
        description = S("Osmium"),

        hardness = 3,
    })

    unilib.register_metal_powder({
        -- Original to unilib. Creates unilib:metal_osmium_powder
        part_name = "osmium",
        orig_name = nil,

        replace_mode = mode,
        description = S("Osmium Powder"),
        no_lump_flag = true,
    })

    unilib.register_craftitem("unilib:metal_osmium_ingot", nil, mode, {
        -- Original to unilib
        description = S("Osmium Ingot"),
        inventory_image = "unilib_metal_osmium_ingot.png",
        groups = {metal_ingot = 1},
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:metal_osmium_ingot 9",
        recipe = {
            {"unilib:metal_osmium_block"},
        }
    })

    unilib.register_node("unilib:metal_osmium_block", nil, mode, {
        -- Original to unilib
        description = S("Osmium Block"),
        tiles = {"unilib_metal_osmium_block.png"},
        groups = {cracky = 1, level = 2},
        sounds = unilib.sound_table.metal,

        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- Original to unilib
        output = "unilib:metal_osmium_block",
        ingredient = "unilib:metal_osmium_ingot",
    })

end
