---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bonemeal
-- Code:    MIT
-- Media:   CC0-1.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_fertiliser_bonemeal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bonemeal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_fertiliser_bonemeal.init()

    return {
        description = "Bone meal (medium-grade fertiliser)",
        mod_optional = "bones",
        optional = {"coral_block_skeleton", "dye_basic"},
    }

end

function unilib.pkg.item_fertiliser_bonemeal.exec()

    unilib.register_craftitem("unilib:item_fertiliser_bonemeal", "bonemeal:bonemeal", mode, {
        -- From bonemeal:bonemeal
        description = S("Bone Meal"),
        inventory_image = "unilib_item_fertiliser_bonemeal.png",

        on_use = function(itemstack, user, pointed_thing)

            -- Are we pointing at a node?
            if pointed_thing.type ~= "node" then
                return
            end

            -- Is the area protected?
            if minetest.is_protected(pointed_thing.under, user:get_player_name()) then
                return
            end

            -- Call the global on_use function with strength of 2
            if unilib.use_fertiliser(pointed_thing.under, 2) then

                -- Take item if not in creative
                if not unilib.is_creative(user:get_player_name()) then
                    itemstack:take_item()
                end

            end

            return itemstack

        end
    })
    unilib.register_craft({
        -- From bonemeal:bonemeal
        output = "unilib:item_fertiliser_bonemeal 2",
        recipe = {
            {"group:bone"},
        },
    })
    unilib.register_craft({
        -- From bonemeal:bonemeal
        output = "unilib:item_fertiliser_bonemeal 4",
        recipe = {
            {"bones:bones"},
        },
    })
    if unilib.pkg_executed_table["coral_block_skeleton"] ~= nil then

        unilib.register_craft({
            -- From bonemeal:bonemeal
            output = "unilib:item_fertiliser_bonemeal 2",
            recipe = {
                {"unilib:coral_block_skeleton"},
            },
        })

    end
    if unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- From bonemeal:mulch
            output = "unilib:dye_white 4",
            recipe = {
                {"unilib:item_fertiliser_bonemeal"}
            },
        })

    end

end
