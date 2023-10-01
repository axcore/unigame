---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_hoe_diamond = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_hoe_diamond.init()

    return {
        description = "Diamond hoe",
        depends = "mineral_diamond",
    }

end

function unilib.pkg.tool_hoe_diamond.exec()

    -- (This tool is marked as deprecated in minetest_game/farming)
    if unilib.mtgame_tweak_flag then

        unilib.register_hoe({
            -- From farming:hoe_diamond
            part_name = "diamond",
            full_name = "unilib:tool_hoe_diamond",
            orig_name = "farming:hoe_diamond",
            def_table = {
                description = S("Diamond Hoe"),
                inventory_image = "unilib_tool_hoe_diamond.png",
                groups = {hoe = 1},

                ingredient = "unilib:mineral_diamond_gem",
                max_uses = 500,
            },

            replace_mode = mode,
        })

    end

end
