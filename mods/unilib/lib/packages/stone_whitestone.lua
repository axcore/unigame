---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    grailtest/material
-- Code:    LGPL v2.1
-- Media:   CC BY-SA
--
-- From:    grailtest/mineral
-- Code:    LGPL v2.1
-- Media:   CC BY-SA
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_whitestone = {}

local S = unilib.intllib
local material_add_mode = unilib.global.imported_mod_table.material.add_mode
local mineral_add_mode = unilib.global.imported_mod_table.mineral.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_whitestone.init()

    return {
        description = "Whitestone",
    }

end

function unilib.pkg.stone_whitestone.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "whitestone",
        description = S("Whitestone"),

        category = "other",
        colour = "#D1CBCA",
        fictional_flag = true,
        grinder_flag = false,
        hardness = 1,
    })

    -- N.B. These stone nodes have been standardised, omitting the eccentric groups in the original
    --      grailtest code
    unilib.register_stone_smooth({
        -- From grailtest, mineral:white_stone. Creates unilib:stone_whitestone
        part_name = "whitestone",
        orig_name = "mineral:white_stone",

        replace_mode = mineral_add_mode,
        cobble_mode = "cobble",
        description = S("White_stone"),
    })

    unilib.register_stone_block({
        -- Original to unilib. Creates unilib:stone_whitestone_block
        part_name = "whitestone",
        orig_name = nil,

        replace_mode = mineral_add_mode,
        description = S("Whitestone Block"),
        img_list = {"unilib_stone_whitestone.png^unilib_stone_block_overlay.png"},
    })

    -- N.B. Original brick/cobble textures are 32px, so use standard overlays instead
    unilib.register_stone_brick({
        -- From grailtest, material:whitestone_brick. Creates unilib:stone_whitestone_brick
        part_name = "whitestone",
        orig_name = "material:whitestone_brick",

        replace_mode = material_add_mode,
        description = S("Whitestone Bricks"),
        img_list = {"unilib_stone_whitestone.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_cobble({
        -- From grailtest, mineral:white_cobble. Creates unilib:stone_whitestone_cobble
        part_name = "whitestone",
        orig_name = "mineral:white_cobble",

        replace_mode = mineral_add_mode,
        description = S("Whitestone Cobble"),
        img_list = {"unilib_stone_whitestone.png^unilib_stone_cobble_overlay.png"},
    })

    unilib.register_stone_cobble_compressed({
        -- Original to unilib. Creates unilib:stone_whitestone_cobble_compressed
        part_name = "whitestone",
        orig_name = nil,

        replace_mode = mineral_add_mode,
        description = S("Compressed Whitestone Cobble"),
    })

    unilib.register_stone_cobble_condensed({
        -- Original to unilib. Creates unilib:stone_whitestone_cobble_condensed
        part_name = "whitestone",
        orig_name = nil,

        replace_mode = mineral_add_mode,
        description = S("Condensed Whitestone Cobble"),
    })

end
