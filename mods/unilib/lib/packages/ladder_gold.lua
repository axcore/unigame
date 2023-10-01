---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.ladder_gold = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ladder_gold.init()

    return {
        description = "Gold ladder",
        depends = "metal_gold",
    }

end

function unilib.pkg.ladder_gold.exec()

    unilib.register_ladder({
        -- From mtg_plus:ladder_gold. Creates unilib:ladder_gold
        part_name = "gold",
        orig_name = "mtg_plus:ladder_gold",
        ingredient = "unilib:metal_gold_ingot",

        replace_mode = mode,
        description = S("Gold Ladder"),
        group_table = {cracky = 3},
        multiple = 15,
        sound_name = "metal",
    })

end
