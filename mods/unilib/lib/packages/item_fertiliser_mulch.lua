---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bonemeal
-- Code:    MIT
-- Media:   CC0-1.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_fertiliser_mulch = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bonemeal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_fertiliser_mulch.init()

    return {
        description = "Mulch (low-grade fertiliser)",
        optional = "dye_basic",
    }

end

function unilib.pkg.item_fertiliser_mulch.exec()

    unilib.register_craftitem("unilib:item_fertiliser_mulch", "bonemeal:mulch", mode, {
        -- From bonemeal:mulch
        description = S("Mulch"),
        inventory_image = "unilib_item_fertiliser_mulch.png",

        on_use = function(itemstack, user, pointed_thing)

            -- Are we pointing at a node?
            if pointed_thing.type ~= "node" then
                return
            end

            -- Is the area protected?
            if minetest.is_protected(pointed_thing.under, user:get_player_name()) then
                return
            end

            -- Call the global on_use function with strength of 1
            if unilib.use_fertiliser(pointed_thing.under, 1) then

                -- Take item if not in creative
                if not unilib.is_creative(user:get_player_name()) then
                    itemstack:take_item()
                end

            end

            return itemstack

        end
    })
    -- N.B. "shapeless" commented out here, and in original code, due to a Minetest error if it's
    --      included
    unilib.register_craft({
        -- From bonemeal:mulch
--      type = "shapeless",
        output = "unilib:item_fertiliser_mulch 4",
        recipe = {
            {"group:tree", "group:leaves", "group:leaves"},
            {"group:leaves", "group:leaves", "group:leaves"},
            {"group:leaves", "group:leaves", "group:leaves"}
        }
    })
    unilib.register_craft({
        -- From bonemeal:mulch
        output = "unilib:item_fertiliser_mulch",
        recipe = {
            {"group:seed", "group:seed", "group:seed"},
            {"group:seed", "group:seed", "group:seed"},
            {"group:seed", "group:seed", "group:seed"}
        }
    })
    if unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- From bonemeal:mulch
            output = "unilib:dye_brown 4",
            recipe = {
                {"unilib:item_fertiliser_mulch"}
            },
        })

    end

end
