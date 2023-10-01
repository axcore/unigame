---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_hoe_mese = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_hoe_mese.init()

    return {
        description = "Mese hoe",
        depends = "mineral_mese",
    }

end

function unilib.pkg.tool_hoe_mese.exec()

    -- (This tool is marked as deprecated in minetest_game/farming)
    if unilib.mtgame_tweak_flag then

        unilib.register_hoe({
            -- From farming:hoe_mese
            part_name = "mese",
            full_name = "unilib:tool_hoe_mese",
            orig_name = "farming:hoe_mese",
            def_table = {
                description = S("Mese Hoe"),
                inventory_image = "unilib_tool_hoe_mese.png",
                groups = {hoe = 1},

                ingredient = "unilib:mineral_mese_crystal",
                max_uses = 350,
            },

            replace_mode = mode,
        })

    end

end
