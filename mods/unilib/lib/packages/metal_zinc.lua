---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic/technic_worldgen
-- Code:    LGPL 2.0
-- Media:   unknown
--
-- From:    technic
-- Code:    LGPL 2.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_zinc = {}

local S = unilib.intllib
local technic_add_mode = unilib.imported_mod_table.technic.add_mode
local worldgen_add_mode = unilib.imported_mod_table.technic_worldgen.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_zinc.init()

    return {
        description = "Zinc",
    }

end

function unilib.pkg.metal_zinc.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "zinc",
        description = S("Zinc"),

        hardness = 1,
    })

    unilib.register_craftitem("unilib:metal_zinc_lump", "technic:zinc_lump", worldgen_add_mode, {
        -- From technic:zinc_lump
        description = S("Zinc Lump"),
        inventory_image = "unilib_metal_zinc_lump.png",
    })

    unilib.register_metal_powder({
        -- From technic:zinc_dust. Creates unilib:metal_zinc_powder
        part_name = "zinc",
        orig_name = "technic:zinc_dust",

        replace_mode = technic_add_mode,
        description = S("Zinc Powder"),
    })

    unilib.register_craftitem("unilib:metal_zinc_ingot", "technic:zinc_ingot", worldgen_add_mode, {
        -- From unilib:metal_zinc_ingot
        description = S("Zinc Ingot"),
        inventory_image = "unilib_metal_zinc_ingot.png",
        -- N.B. no groups in original code
        groups = {metal_ingot = 1},
    })
    unilib.register_craft({
        -- From unilib:metal_zinc_ingot
        type = "cooking",
        output = "unilib:metal_zinc_ingot",
        recipe = "unilib:metal_zinc_lump",
    })
    unilib.register_craft({
        -- From unilib:metal_zinc_ingot
        output = "unilib:metal_zinc_ingot 9",
        recipe = {
            {"unilib:metal_zinc_block"},
        }
    })

    unilib.register_node("unilib:metal_zinc_block", "technic:zinc_block", worldgen_add_mode, {
        -- From technic:zinc_block
        description = S("Zinc Block"),
        tiles = {"unilib_metal_zinc_block.png"},
        groups = {cracky = 1, level = 2},
        sounds = unilib.sound_table.stone,
    })
    unilib.register_craft_3x3({
        -- From technic:zinc_block
        output = "unilib:metal_zinc_block",
        ingredient = "unilib:metal_zinc_ingot",
    })

end
