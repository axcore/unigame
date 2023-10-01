---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_hoe_stone = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_hoe_stone.init()

    return {
        description = "Stone hoe",
    }

end

function unilib.pkg.tool_hoe_stone.exec()

    unilib.register_hoe({
        -- From farming:hoe_stone
        part_name = "stone",
        full_name = "unilib:tool_hoe_stone",
        orig_name = "farming:hoe_stone",
        def_table = {
            description = S("Stone Hoe"),
            inventory_image = "unilib_tool_hoe_stone.png",
            groups = {hoe = 1},

            ingredient = "group:stone",
            max_uses = 90,
        },

        replace_mode = mode,
    })

end
