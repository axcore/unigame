---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bonemeal
-- Code:    MIT
-- Media:   CC0-1.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_fertiliser_compound = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bonemeal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_fertiliser_compound.init()

    return {
        description = "Compound fertiliser (high-grade fertiliser)",
        depends = {"item_fertiliser_bonemeal", "item_fertiliser_mulch"},
        optional = "dye_basic",
    }

end

function unilib.pkg.item_fertiliser_compound.exec()

    unilib.register_craftitem("unilib:item_fertiliser_compound", "bonemeal:fertiliser", mode, {
        -- From bonemeal:fertiliser
        description = S("Compound Fertiliser"),
        inventory_image = "unilib_item_fertiliser_compound.png",

        on_use = function(itemstack, user, pointed_thing)

            -- Are we pointing at a node?
            if pointed_thing.type ~= "node" then
                return
            end

            -- Is the area protected?
            if core.is_protected(pointed_thing.under, user:get_player_name()) then
                return
            end

            -- Call the global on_use function with strength of 3
            if unilib.fertiliser.callback_on_use(pointed_thing.under, "compound", 3) then

                -- Take item if not in creative
                if not unilib.utils.is_creative(user:get_player_name()) then
                    itemstack:take_item()
                end

            end

            return itemstack

        end
    })
    -- N.B. "shapeless" commented out here, and in original code, due to a Minetest error if it's
    --      included
    unilib.register_craft({
        -- From bonemeal:fertiliser
--      type = "shapeless",
        output = "unilib:item_fertiliser_compound 2",
        recipe = {
            {"unilib:item_fertiliser_bonemeal", "unilib:item_fertiliser_mulch"},
        },
    })
    if unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- From bonemeal:mulch
            output = "unilib:dye_green 4",
            recipe = {
                {"unilib:item_fertiliser_compound"},
            },
        })

    end

end
