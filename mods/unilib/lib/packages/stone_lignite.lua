---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    UGBC
-- Code:    GPLv2
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_lignite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ugbc.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_lignite.init()

    return {
        description = "Lignite stone",
    }

end

function unilib.pkg.stone_lignite.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "lignite",
        description = S("Lignite Stone"),

        category = "sedimentary",
        grinder_flag = true,
        hardness = 1,
        not_super_flag = true,
    })

    unilib.register_stone_smooth({
        -- Texture from UGBC, lignite.png. Original code. Creates unilib:stone_lignite
        part_name = "lignite",
        orig_name = nil,

        replace_mode = mode,
        cobble_mode = "smooth",
        description = S("Lignite Stone"),
    })

    -- (no block/brick/cobble/rubble variants)

end
