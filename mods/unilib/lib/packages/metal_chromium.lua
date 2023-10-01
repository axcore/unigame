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

unilib.pkg.metal_chromium = {}

local S = unilib.intllib
local technic_add_mode = unilib.imported_mod_table.technic.add_mode
local worldgen_add_mode = unilib.imported_mod_table.technic_worldgen.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_chromium.init()

    return {
        description = "Chromium",
    }

end

function unilib.pkg.metal_chromium.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "chromium",
        description = S("Chromium"),

        hardness = 1,
    })

    unilib.register_craftitem(
        -- From technic:chromium_lump
        "unilib:metal_chromium_lump",
        "technic:chromium_lump",
        worldgen_add_mode,
        {
            description = S("Chromium Lump"),
            inventory_image = "unilib_metal_chromium_lump.png",
        }
    )

    unilib.register_metal_powder({
        -- From technic:chromium_dust. Creates unilib:metal_chromium_powder
        part_name = "chromium",
        orig_name = "technic:chromium_dust",

        replace_mode = technic_add_mode,
        description = S("Chromium Powder"),
    })

    unilib.register_craftitem(
        -- From unilib:metal_chromium_ingot
        "unilib:metal_chromium_ingot",
        "technic:chromium_ingot",
        worldgen_add_mode,
        {
            description = S("Chromium Ingot"),
            inventory_image = "unilib_metal_chromium_ingot.png",
            -- N.B. no groups in original code
            groups = {metal_ingot = 1},
        }
    )
    unilib.register_craft({
        -- From unilib:metal_chromium_ingot
        type = "cooking",
        output = "unilib:metal_chromium_ingot",
        recipe = "unilib:metal_chromium_lump",
    })
    unilib.register_craft({
        -- From unilib:metal_chromium_ingot
        output = "unilib:metal_chromium_ingot 9",
        recipe = {
            {"unilib:metal_chromium_block"},
        }
    })

    unilib.register_node(
        -- From technic:chromium_block
        "unilib:metal_chromium_block",
        "technic:chromium_block",
        worldgen_add_mode,
        {
            description = S("Chromium Block"),
            tiles = {"unilib_metal_chromium_block.png"},
            groups = {cracky = 1, level = 2},
            sounds = unilib.sound_table.stone,
        }
    )
    unilib.register_craft_3x3({
        -- From technic:chromium_block
        output = "unilib:metal_chromium_block",
        ingredient = "unilib:metal_chromium_ingot",
    })

end
