---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.fruit_coconut_exotic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fruit_coconut_exotic.init()

    return {
        description = "Exotic coconut",
        notes = "Edible when cracked open, after being hit on a hard surface",
        optional = "dye_basic",
    }

end

function unilib.pkg.fruit_coconut_exotic.exec()

    unilib.register_craftitem("unilib:fruit_coconut_exotic", "fruit:coconut", mode, {
        -- From farlands, fruit:coconut
        description = S("Exotic Coconut"),
        inventory_image = "unilib_fruit_coconut_exotic.png",

        on_use = function(itemstack, placer, pointed_thing)

            if pointed_thing.under == nil then
                return
            end

            local item = minetest.get_node(pointed_thing.under).name
            if minetest.get_item_group(item, "cracky") ~= 0 then

                itemstack:take_item()
                minetest.add_item(pointed_thing.above, "unilib:fruit_coconut_exotic_open")

            end

            return itemstack

        end,
    })
    -- N.B. We don't add the other craftrecipe, because leaves with coconuts are now
    --      not_in_creative_inventory items
    unilib.register_craft({
        -- From farlands, mapgen/crafts.lua
        output = "unilib:fruit_coconut_exotic_open 2",
        recipe = {
            {"unilib:fruit_coconut_exotic"},
        }
    })

    unilib.register_craftitem("unilib:fruit_coconut_exotic_open", "fruit:coconut_open", mode, {
        -- From farlands, fruit:coconut_open
        description = S("Cracked Exotic Coconut"),
        inventory_image = "unilib_fruit_coconut_exotic_open.png",
        -- N.B. No groups in original code
        groups = {food_coconut = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:fruit_coconut_exotic_open", 2),
    })
    if unilib.dye_from_fruit_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_white",
            recipe = {
                {"unilib:fruit_coconut_exotic_open"},
            },
        })

    end

    -- N.B. No call to unilib.setup_regrowing_fruit(), as this fruit is implemented as an ore

end
