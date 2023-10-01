---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_tellurium = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_tellurium.init()

    return {
        description = "Tellurium",
    }

end

function unilib.pkg.metal_tellurium.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "tellurium",
        description = S("Tellurium"),

        hardness = 1,
    })

    unilib.register_metal_powder({
        -- Original to unilib. Creates unilib:metal_tellurium_powder
        part_name = "tellurium",
        orig_name = nil,

        replace_mode = mode,
        description = S("Tellurium Powder"),
        no_lump_flag = true,
    })

    unilib.register_craftitem("unilib:metal_tellurium_ingot", nil, mode, {
        -- Original to unilib
        description = S("Tellurium Ingot"),
        inventory_image = "unilib_metal_tellurium_ingot.png",
        groups = {metal_ingot = 1},
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:metal_tellurium_ingot 9",
        recipe = {
            {"unilib:metal_tellurium_block"},
        }
    })

    unilib.register_node("unilib:metal_tellurium_block", nil, mode, {
        -- Original to unilib
        description = S("Tellurium Block"),
        tiles = {"unilib_metal_tellurium_block.png"},
        groups = {cracky = 1, level = 2},
        sounds = unilib.sound_table.metal,

        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- Original to unilib
        output = "unilib:metal_tellurium_block",
        ingredient = "unilib:metal_tellurium_ingot",
    })

end

