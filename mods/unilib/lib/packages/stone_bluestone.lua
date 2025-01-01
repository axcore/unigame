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

unilib.pkg.stone_bluestone = {}

local S = unilib.intllib
local material_add_mode = unilib.global.imported_mod_table.material.add_mode
local mineral_add_mode = unilib.global.imported_mod_table.mineral.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_bluestone.init()

    return {
        description = "Bluestone",
    }

end

function unilib.pkg.stone_bluestone.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "bluestone",
        description = S("Bluestone"),

        category = "other",
        colour = "#536167",
        grinder_flag = true,
        -- (N.B. This is not a fictional stone)
        hardness = 2,
    })

    -- N.B. These stone nodes have been standardised, omitting the eccentric groups in the original
    --      grailtest code
    unilib.register_stone_smooth({
        -- From grailtest, mineral:bluestone. Creates unilib:stone_bluestone
        part_name = "bluestone",
        orig_name = "mineral:bluestone",

        replace_mode = mineral_add_mode,
        description = S("Bluestone"),
    })

    unilib.register_stone_block({
        -- Original to unilib. Creates unilib:stone_bluestone_block
        part_name = "bluestone",
        orig_name = nil,

        replace_mode = mineral_add_mode,
        description = S("Bluestone Block"),
        img_list = {"unilib_stone_bluestone.png^unilib_stone_block_overlay.png"},
    })

    -- N.B. Original brick/cobble textures are 32px, so use standard overlays instead
    unilib.register_stone_brick({
        -- From grailtest, material:bluestone_brick. Creates unilib:stone_bluestone_brick
        part_name = "bluestone",
        orig_name = "material:bluestone_brick",

        replace_mode = material_add_mode,
        description = S("Bluestone Bricks"),
        img_list = {"unilib_stone_bluestone.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_cobble({
        -- From grailtest, mineral:bluestone_cobble. Creates unilib:stone_bluestone_cobble
        part_name = "bluestone",
        orig_name = "mineral:bluestone_cobble",

        replace_mode = mineral_add_mode,
        description = S("Bluestone Cobble"),
        img_list = {"unilib_stone_bluestone.png^unilib_stone_cobble_overlay.png"},
    })

    unilib.register_stone_cobble_compressed({
        -- Original to unilib. Creates unilib:stone_bluestone_cobble_compressed
        part_name = "bluestone",
        orig_name = nil,

        replace_mode = mineral_add_mode,
        description = S("Compressed Bluestone Cobble"),
    })

    unilib.register_stone_cobble_condensed({
        -- Original to unilib. Creates unilib:stone_bluestone_cobble_condensed
        part_name = "bluestone",
        orig_name = nil,

        replace_mode = mineral_add_mode,
        description = S("Condensed Bluestone Cobble"),
    })

end
