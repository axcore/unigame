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

unilib.pkg.stone_greenstone = {}

local S = unilib.intllib
local material_add_mode = unilib.global.imported_mod_table.material.add_mode
local mineral_add_mode = unilib.global.imported_mod_table.mineral.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_greenstone.init()

    return {
        description = "Greenstone",
    }

end

function unilib.pkg.stone_greenstone.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "greenstone",
        description = S("Greenstone"),

        category = "metamorphic",
        colour = "#60756B",
        grinder_flag = true,
        hardness = 3,
    })

    -- N.B. These stone nodes have been standardised, omitting the eccentric groups in the original
    --      grailtest code
    unilib.register_stone_smooth({
        -- From grailtest, mineral:greenstone. Creates unilib:stone_greenstone
        part_name = "greenstone",
        orig_name = "mineral:greenstone",

        replace_mode = mineral_add_mode,
        cobble_mode = "cobble",
        description = S("Greenstone"),
    })

    unilib.register_stone_block({
        -- Original to unilib. Creates unilib:stone_greenstone_block
        part_name = "greenstone",
        orig_name = nil,

        replace_mode = mineral_add_mode,
        description = S("Greenstone Block"),
        img_list = {"unilib_stone_greenstone.png^unilib_stone_block_overlay.png"},
    })

    -- N.B. Original brick/cobble textures are 32px, so use standard overlays instead
    unilib.register_stone_brick({
        -- From grailtest, material:greenstone_brick. Creates unilib:stone_greenstone_brick
        part_name = "greenstone",
        orig_name = "material:greenstone_brick",

        replace_mode = material_add_mode,
        description = S("Greenstone Bricks"),
        img_list = {"unilib_stone_greenstone.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_cobble({
        -- Texture from grailtest/mineral, mineral_greenstone_cobble.png. Code original to unilib.
        --      Creates unilib:stone_greenstone_cobble
        part_name = "greenstone",
        orig_name = nil,

        replace_mode = mineral_add_mode,
        description = S("Greenstone Cobble"),
        img_list = {"unilib_stone_greenstone.png^unilib_stone_cobble_overlay.png"},
    })

    unilib.register_stone_cobble_compressed({
        -- Original to unilib. Creates unilib:stone_greenstone_cobble_compressed
        part_name = "greenstone",
        orig_name = nil,

        replace_mode = mineral_add_mode,
        description = S("Compressed Greenstone Cobble"),
    })

    unilib.register_stone_cobble_condensed({
        -- Original to unilib. Creates unilib:stone_greenstone_cobble_condensed
        part_name = "greenstone",
        orig_name = nil,

        replace_mode = mineral_add_mode,
        description = S("Condensed Greenstone Cobble"),
    })

end
