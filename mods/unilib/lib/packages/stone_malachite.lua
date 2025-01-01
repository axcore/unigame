---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_malachite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_malachite.init()

    return {
        description = "Malachite",
        notes = "In real life, this is a mineral; but the original mod uses it as a stone",
    }

end

function unilib.pkg.stone_malachite.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "malachite",
        description = S("Malachite"),

        category = "other",
        colour = "#57A438",
        fictional_flag = true,
        grinder_flag = false,
        -- (N.B. In-game hardness adjusted to match cracky groups below, should be 2)
        hardness = 1,
        hardness_real = 2,
        not_super_flag = true,
    })

    -- (preserve original cracky values for smoothstone)

    unilib.register_node("unilib:stone_malachite", "underch:malachite", mode, {
        -- From underch:malachite
        description = S("Malachite"),
        tiles = {"unilib_stone_malachite.png"},
        groups = {cracky = 3},
        sounds = unilib.global.sound_table.stone,
    })
    --[[
    unilib.register_stairs("unilib:stone_malachite", {
        group_type = "smooth",
    })
    ]]--
    unilib.register_stone_smooth_cuttings({
        part_name = "malachite",

        drop_name = "unilib:stone_malachite",
    })

    -- (no block/brick/cobble/rubble variants)

end
