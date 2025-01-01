---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.override_ethereal_tree_pine = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.override_ethereal_tree_pine.init()

    return {
        description = "Overrides pine trees from minetest_game, giving them pine nuts",
        depends = {"food_nuts_pine", "tree_pine"},
    }

end

function unilib.pkg.override_ethereal_tree_pine.exec()

    if unilib.setting.mtgame_tweak_flag then

        unilib.override_item("unilib:tree_pine_leaves", {
            drop = {
                max_items = 1,
                items = {
                    {items = {"unilib:tree_pine_sapling"}, rarity = 20},
                    {items = {"unilib:food_nuts_pine"}, rarity = 5},
                    {items = {"unilib:tree_pine_leaves"}},
                },
            },
        })

    end

end
