---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreores
-- Code:    zlib
-- Media:   CC BY-SA 3.0
--
-- From:    technic
-- Code:    LGPL 2.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_mithril = {}

local S = unilib.intllib
local moreores_add_mode = unilib.imported_mod_table.moreores.add_mode
local technic_add_mode = unilib.imported_mod_table.technic.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_mithril.init()

    return {
        description = "Mithril",
    }

end

function unilib.pkg.metal_mithril.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "mithril",
        description = S("Mithril"),

        fictional_flag = true,
        hardness = 2,
    })

    unilib.register_craftitem(
        -- From moreores:mithril_lump
        "unilib:metal_mithril_lump",
        "moreores:mithril_lump",
        moreores_add_mode,
        {
            description = S("Mithril Lump"),
            inventory_image = "unilib_metal_mithril_lump.png"
        }
    )

    unilib.register_metal_powder({
        -- From technic:mithril_dust. Creates unilib:metal_mithril_powder
        part_name = "mithril",
        orig_name = "technic:mithril_dust",

        replace_mode = technic_add_mode,
        description = S("Mithril Powder"),
    })

    unilib.register_craftitem(
        -- From moreores:mithril_ingot
        "unilib:metal_mithril_ingot",
        "moreores:mithril_ingot",
        moreores_add_mode,
        {
            description = S("Mithril Ingot"),
            inventory_image = "unilib_metal_mithril_ingot.png",
            -- N.B. no groups in original code
            groups = {metal_ingot = 1},
        }
    )
    unilib.register_craft({
        -- From moreores:mithril_ingot
        type = "cooking",
        output = "unilib:metal_mithril_ingot",
        recipe = "unilib:metal_mithril_lump",
    })
    unilib.register_craft({
        -- From moreores:mithril_ingot
        output = "unilib:metal_mithril_ingot 9",
        recipe = {
            {"unilib:metal_mithril_block"},
        }
    })

    unilib.register_node(
        -- From moreores:mithril_block
        "unilib:metal_mithril_block",
        "moreores:mithril_block",
        moreores_add_mode,
        {
            description = S("Mithril Block"),
            tiles = {"unilib_metal_mithril_block.png"},
            groups = {bendy = 2, cracky = 1, level = 2, melty = 2, snappy = 1},
            sounds = unilib.sound_table.metal,

            -- N.B. Not in original code
            is_ground_content = false,
        }
    )
    unilib.register_craft_3x3({
        -- From moreores:mithril_block
        output = "unilib:metal_mithril_block",
        ingredient = "unilib:metal_mithril_ingot",
    })
    unilib.register_stairs("unilib:metal_mithril_block")

end
