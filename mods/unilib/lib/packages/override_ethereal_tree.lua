---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.override_ethereal_tree = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.override_ethereal_tree.init()

    return {
        description = "Overrides trees from minetest_game with settings from ethereal-ng, giving" ..
                " pine nuts to pine trees and tweaking the texture for acacia leaves",
        at_least_one = {
            "food_nuts_pine",
            "tree_acacia",
            "tree_pine",
        },
    }

end

function unilib.pkg.override_ethereal_tree.exec()

    if unilib.mtgame_tweak_flag then

        if unilib.pkg_executed_table["tree_acacia"] ~= nil then

            unilib.override_item("unilib:tree_acacia_leaves", {
                inventory_image = "unilib_tree_acacia_leaves_inv.png",
                wield_image = "unilib_tree_acacia_leaves_inv.png",
            })

        end

        if unilib.pkg_executed_table["food_nuts_pine"] ~= nil and
                unilib.pkg_executed_table["tree_pine"] ~= nil then

            unilib.override_item("unilib:tree_pine_leaves", {
                drop = {
                    max_items = 1,
                    items = {
                        {items = {"unilib:tree_pine_sapling"}, rarity = 20},
                        {items = {"unilib:food_nuts_pine"}, rarity = 5},
                        {items = {"unilib:tree_pine_leaves"}}
                    }
                },
            })

        end

    end

end
