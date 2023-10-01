---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_hoe_bronze = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_hoe_bronze.init()

    return {
        description = "Bronze hoe",
        depends = "metal_bronze",
    }

end

function unilib.pkg.tool_hoe_bronze.exec()

    -- (This tool is marked as deprecated in minetest_game/farming)
    if unilib.mtgame_tweak_flag then

        unilib.register_hoe({
            -- From farming:hoe_bronze
            part_name = "bronze",
            full_name = "unilib:tool_hoe_bronze",
            orig_name = "farming:hoe_bronze",
            def_table = {
                description = S("Bronze Hoe"),
                inventory_image = "unilib_tool_hoe_bronze.png",
                groups = {hoe = 1},

                ingredient = "unilib:metal_bronze_ingot",
                max_uses = 220,
            },

            replace_mode = mode,
        })

    end

end
