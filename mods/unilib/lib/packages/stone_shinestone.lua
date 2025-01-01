---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_shinestone = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_shinestone.init()

    return {
        description = "Shinestone",
    }

end

function unilib.pkg.stone_shinestone.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "shinestone",
        description = S("Shinestone"),

        category = "other",
        colour = "#FF9D58",
        fictional_flag = true,
        grinder_flag = false,
        hardness = 1,
        not_super_flag = true,
    })

    unilib.register_node("unilib:stone_shinestone", "underch:shinestone", mode, {
        -- From underch:shinestone
        description = S("Shinestone"),
        tiles = {"unilib_stone_shinestone.png"},
        groups = {cracky = 3},
        sounds = unilib.global.sound_table.stone,

        light_source = unilib.constant.light_max,
    })
    unilib.register_stone_smooth_cuttings({
        part_name = "shinestone",

        drop_name = "unilib:stone_shinestone",
    })

    -- (no block/brick/cobble/rubble variants)

end
