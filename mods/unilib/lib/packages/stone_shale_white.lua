---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_shale_white = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_shale_white.init()

    return {
        description = "White shale",
    }

end

function unilib.pkg.stone_shale_white.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "shale_white",
        description = S("White Shale"),

        category = "sedimentary",
        colour = "#ACACAF",
        grinder_flag = true,
        hardness = 1,
        not_super_flag = true,
    })

    unilib.register_stone_smooth({
        -- Texture from UGBC, shale.png. Original code. Creates unilib:stone_shale_white
        part_name = "shale_white",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "smooth",
        description = S("White Shale"),
    })

    -- (no block/brick/cobble/rubble variants)

end
