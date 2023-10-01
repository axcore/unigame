---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_chalk_white = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_chalk_white.init()

    return {
        description = "White chalk",
        optional = "shared_darkage"
    }

end

function unilib.pkg.stone_chalk_white.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "chalk_white",
        description = S("White Chalk"),

        category = "sedimentary",
        grinder_flag = false,
        hardness = 2,
        not_super_flag = true,
    })

    unilib.register_node("unilib:stone_chalk_white", "darkage:chalk", mode, {
        -- From darkage:chalk
        description = S("White Chalk"),
        tiles = {"unilib_stone_chalk_white.png"},
        -- N.B. stone = 1 not in original code
        groups = {cracky = 2, crumbly = 2, smoothstone = 1, stone = 1},
        sounds = unilib.sound_table.stone,

        drop = "unilib:stone_chalk_white_powder 2",
    })
    --[[
    unilib.register_carvings("unilib:stone_chalk_white", {
        facade_flag = true,
    })
    ]]--
    unilib.register_stone_smooth_cuttings({
        part_name = "chalk_white",

        drop_name = "unilib:stone_chalk_white",
    })

    unilib.register_craftitem("unilib:stone_chalk_white_powder", "darkage:chalk_powder", mode, {
        -- From darkage:chalk_powder
        description = S("White Chalk Powder"),
        inventory_image = "unilib_stone_chalk_white_powder.png",
    })

    -- (no block/brick/cobble/rubble variants)

end
