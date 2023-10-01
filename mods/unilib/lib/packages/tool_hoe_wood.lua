---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_hoe_wood = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_hoe_wood.init()

    return {
        description = "Wooden hoe",
    }

end

function unilib.pkg.tool_hoe_wood.exec()

    unilib.register_hoe({
        -- From farming:hoe_wood
        part_name = "wood",
        full_name = "unilib:tool_hoe_wood",
        orig_name = "farming:hoe_wood",
        def_table = {
            description = S("Wooden Hoe"),
            inventory_image = "unilib_tool_hoe_wood.png",
            groups = {flammable = 2, hoe = 1},

            ingredient = "group:wood",
            max_uses = 30,
        },

        replace_mode = mode,
    })
    unilib.register_craft({
        -- From farming:hoe_wood
        type = "fuel",
        recipe = "unilib:tool_hoe_wood",
        burntime = 5,
    })

end
