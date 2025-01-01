---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_kelp = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_kelp.init()

    return {
        description = "Ordinary stone with kelp",
        notes = "ABMs in the \"plant_kelp_spiny\" and \"plant_kelp_giant\" grow kelp on these" ..
                " stone nodes",
        depends = "stone_ordinary",
    }

end

function unilib.pkg.stone_ordinary_with_kelp.exec()

    local kelp_table = {
        spiny = "brown",
        giant = "giant_brown",
    }

    for part_name, orig_part_name in pairs(kelp_table) do

        unilib.register_node(
            -- From australia:stone_kelp_brown, etc. Creates
            --      unilib:stone_ordinary_with_kelp_spiny, etc
            "unilib:stone_ordinary_with_kelp_" .. part_name,
            "australia:stone_kelp_" .. orig_part_name,
            mode,
            {
                description = S("Ordinary Stone with Kelp"),
                tiles = {"unilib_stone_ordinary_with_coral.png"},
                groups = {cracky = 3, not_in_creative_inventory = 1, stone = 1},
                sounds = unilib.global.sound_table.stone,

                drop = "unilib:stone_ordinary",
            }
        )

    end

end
