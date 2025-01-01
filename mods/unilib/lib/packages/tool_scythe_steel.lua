---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    sickles
-- Code:    LGPL v3
-- Media:   CC BY-SA 3.0/4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_scythe_steel = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.sickles.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_scythe_steel.init()

    return {
        description = "Steel scythe",
        depends = "metal_steel",
    }

end

function unilib.pkg.tool_scythe_steel.exec()

    unilib.register_tool("unilib:tool_scythe_steel", "sickles:scythe_steel", mode, {
        -- From sickles:scythe_steel
        description = S("Steel Scythe"),
        inventory_image = "unilib_tool_scythe_steel.png",
        groups = {scythe = 2, scythe_uses = 150},
        sound = {breaks = "unilib_tool_breaks"},

        range = 12,
        tool_capabilities = {
            damage_groups = {fleshy = 5},
            full_punch_interval = 1.2,
            punch_attack_uses = 300,
        },

        on_use = unilib.tools.use_scythe,
    })
    unilib.register_craft_scythe({
        -- From sickles:scythe_steel
        part_name = "steel",
        ingredient = "unilib:metal_steel_ingot",
    })
    unilib.tools.apply_toolranks("unilib:tool_scythe_steel", "scythe")

end
