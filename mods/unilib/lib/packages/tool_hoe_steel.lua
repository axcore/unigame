---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_hoe_steel = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_hoe_steel.init()

    return {
        description = "Steel hoe",
        depends = "metal_steel",
    }

end

function unilib.pkg.tool_hoe_steel.exec()

    -- N.B. In 2018, bronze/mese/diamond hoes were deprecated, and steel hoes were buffed to
    --      compensate. Since unilib provides hoes from a number of mods, reverse the buff if
    --      allowed
    local max_uses = 500
    if unilib.setting.mtgame_tweak_flag then
        max_uses = 200
    end

    unilib.register_hoe({
        -- From farming:hoe_steel
        part_name = "steel",
        full_name = "unilib:tool_hoe_steel",
        orig_name = "farming:hoe_steel",
        def_table = {
            description = S("Steel Hoe"),
            inventory_image = "unilib_tool_hoe_steel.png",
            groups = {hoe = 1},

            ingredient = "unilib:metal_steel_ingot",
            max_uses = max_uses,
        },

        replace_mode = mode,
        damage_group_table = {fleshy = 2},
    })
    unilib.tools.apply_toolranks("unilib:tool_hoe_steel", "hoe")

end
