---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_albata = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_albata.init()

    return {
        description = "Albata",
        depends = {"metal_copper_real", "metal_nickel", "metal_zinc_real"},
    }

end

function unilib.pkg.metal_albata.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "albata",
        description = S("Albata"),

        alloy_flag = true,
        hardness = 2,
    })

    unilib.register_metal_powder({
        -- Original to unilib. Creates unilib:metal_albata_powder
        part_name = "albata",
        orig_name = nil,

        replace_mode = mode,
        description = S("Albata Powder"),
        no_lump_flag = true,
    })

    unilib.register_craftitem("unilib:metal_albata_ingot", "real_minerals:albata_ingot", mode, {
        -- From real_minerals:albata_ingot
        description = S("Albata Ingot"),
        inventory_image = "unilib_metal_albata_ingot.png",
        -- N.B. alloy = 1 not in original code
        groups = {alloy = 1, metal_ingot = 1},
    })
    unilib.register_craft({
        -- From real_minerals:albata_ingot
        type = "shapeless",
        output = "unilib:metal_albata_ingot 4",
        recipe = {
            "unilib:metal_copper_real_ingot",
            "unilib:metal_nickel_ingot",
            "unilib:metal_zinc_real_ingot",
            "unilib:metal_zinc_real_ingot",
        },
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:metal_albata_ingot 9",
        recipe = {
            {"unilib:metal_albata_block"},
        }
    })

    unilib.register_node("unilib:metal_albata_block", "real_minerals:albata_block", mode, {
        -- From real_minerals:albata_block
        description = S("Albata Block"),
        tiles = {"unilib_metal_albata_block.png"},
        groups = {bendy = 2, cracky = 2, level = 4, melty = 2, snappy = 1},
        sounds = unilib.sound_table.metal,

        -- N.B. true in original code
        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From real_minerals:albata_block
        output = "unilib:metal_albata_block",
        ingredient = "unilib:metal_albata_ingot",
    })
    unilib.register_stairs("unilib:metal_albata_block")

end
