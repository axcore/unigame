---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_goldstone = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_goldstone.init()

    return {
        description = "Goldstone",
        depends = "metal_gold",
    }

end

function unilib.pkg.stone_goldstone.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "goldstone",
        description = S("Goldstone"),

        category = "other",
        colour = "#F8D711",
        fictional_flag = true,
        grinder_flag = false,
        hardness = 1,
        not_super_flag = true,
    })

    unilib.register_node("unilib:stone_goldstone", "underch:goldstone", mode, {
        -- From underch:goldstone
        description = S("Goldstone"),
        tiles = {"unilib_stone_goldstone.png"},
        groups = {cracky = 3, stone = 1},
        sounds = unilib.global.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft({
        -- From underch:goldstone
        output = "unilib:stone_goldstone 8",
        recipe = {
            {"group:stone", "group:stone", "group:stone"},
            {"group:stone", "unilib:metal_gold_ingot", "group:stone"},
            {"group:stone", "group:stone", "group:stone"},
        },
    })
    --[[
    unilib.register_stairs("unilib:stone_goldstone", {
        group_type = "smooth",
    })
    ]]--
    unilib.register_stone_smooth_cuttings({
        part_name = "goldstone",

        drop_name = "unilib:stone_goldstone",
    })

    -- (no block/brick/cobble/rubble variants)

end
