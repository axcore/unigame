---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.ladder_wood_gold = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ladder_wood_gold.init()

    return {
        description = "Gold-enriched wood ladder",
        depends = "tree_gold",
    }

end

function unilib.pkg.ladder_wood_gold.exec()

    unilib.register_ladder({
        -- From mtg_plus:ladder_goldwood. Creates unilib:ladder_wood_gold
        part_name = "wood_gold",
        orig_name = "mtg_plus:ladder_goldwood",
        ingredient = "group:stick",

        replace_mode = mode,
        centre_ingredient = "unilib:tree_gold_wood",
        description = S("Gold-Enriched Wood Ladder"),
        group_table = {choppy = 2},
        multiple = 9,
        sound_name = "wood",
    })

end
