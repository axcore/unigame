---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    screwdriver
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_screwdriver_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.screwdriver.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_screwdriver_ordinary.init()

    return {
        description = "Ordinary screwdriver",
        notes = "Left-click rotates a node face, right-click rotates a node on its axis",
        depends = {"metal_steel", "shared_screwdriver"},
    }

end

function unilib.pkg.item_screwdriver_ordinary.exec()

    -- Register the screwdriver
    unilib.register_tool("unilib:item_screwdriver_ordinary", "screwdriver:screwdriver", mode, {
        -- From screwdriver:screwdriver
        description = unilib.hint(
            S("Ordinary Screwdriver"), S("left-click rotates face, right-click rotates axis")
        ),
        inventory_image = "unilib_item_screwdriver_ordinary.png",
        groups = {tool = 1},

        on_place = function(itemstack, user, pointed_thing)

            unilib.pkg.shared_screwdriver.handler(
                itemstack, user, pointed_thing, unilib.pkg.shared_screwdriver.rotate_axis, 200
            )

            return itemstack

        end,

        on_use = function(itemstack, user, pointed_thing)

            unilib.pkg.shared_screwdriver.handler(
                itemstack, user, pointed_thing, unilib.pkg.shared_screwdriver.rotate_face, 200
            )

            return itemstack

        end,
    })
    unilib.register_craft({
        -- From screwdriver:screwdriver
        output = "unilib:item_screwdriver_ordinary",
        recipe = {
            {"unilib:metal_steel_ingot"},
            {"group:stick"}
        }
    })

end
