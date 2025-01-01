---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.ladder_stone = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ladder_stone.init()

    return {
        description = "Stone ladder",
    }

end

function unilib.pkg.ladder_stone.exec()

    unilib.register_ladder({
        -- From ethereal:stone_ladder. Creates unilib:ladder_stone
        part_name = "stone",
        orig_name = "ethereal:stone_ladder",
        ingredient = "group:stone",

        replace_mode = mode,
        description = S("Stone Ladder"),
        group_table = {cracky = 3, oddly_breakable_by_hand = 1},
        multiple = 4,
        sound_name = "stone",
    })

end
