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

unilib.pkg.stone_basalt_brown = {}

local S = unilib.intllib
local material_add_mode = unilib.imported_mod_table.material.add_mode
local mineral_add_mode = unilib.imported_mod_table.mineral.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_basalt_brown.init()

    return {
        description = "Brown basalt",
    }

end

function unilib.pkg.stone_basalt_brown.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "basalt_brown",
        description = S("Brown Basalt"),

        category = "extrusive",
        grinder_flag = true,
        hardness = 3,
    })

    -- N.B. These stone nodes have been standardised, omitting the eccentric groups in the original
    --      grailtest code
    unilib.register_stone_smooth({
        -- From grailtest, mineral:basalt. Creates unilib:stone_basalt_brown
        part_name = "basalt_brown",
        orig_name = "mineral:basalt",

        replace_mode = mineral_add_mode,
        description = S("Brown Basalt"),
    })

    unilib.register_stone_block({
        -- Original to unilib. Creates unilib:stone_basalt_brown_block
        part_name = "basalt_brown",
        orig_name = nil,

        replace_mode = mineral_add_mode,
        description = S("Brown Basalt Block"),
        img_list = {"unilib_stone_basalt_brown.png^unilib_stone_block_overlay.png"},
    })

    -- N.B. Original brick/cobble textures are 32px, so use standard overlays instead
    unilib.register_stone_brick({
        -- From grailtest, material:basalt_brick. Creates unilib:stone_basalt_brown_brick
        part_name = "basalt_brown",
        orig_name = "material:basalt_brick",

        replace_mode = material_add_mode,
        description = S("Brown Basalt Bricks"),
        img_list = {"unilib_stone_basalt_brown.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_cobble({
        -- Original to unilib. Creates unilib:stone_basalt_brown_cobble
        part_name = "basalt_brown",
        orig_name = nil,

        replace_mode = mineral_add_mode,
        description = S("Brown Basalt Cobble"),
        img_list = {"unilib_stone_basalt_brown.png^unilib_stone_cobble_overlay.png"},
    })

end
