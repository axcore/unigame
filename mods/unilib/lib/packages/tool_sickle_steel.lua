---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    sickles
-- Code:    LGPL v3
-- Media:   CC BY-SA 3.0/4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_sickle_steel = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.sickles.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_sickle_steel.init()

    return {
        description = "Steel sickle",
        depends = "metal_steel",
    }

end

function unilib.pkg.tool_sickle_steel.exec()

    unilib.register_tool("unilib:tool_sickle_steel", "sickles:sickle_steel", mode, {
        -- From sickles:sickle_steel
        description = S("Steel Sickle"),
        inventory_image = "unilib_tool_sickle_steel.png",
        groups = {sickle = 1, sickle_uses = 300},
        sound = {breaks = "unilib_tool_breaks"},

        range = 6,
        tool_capabilities = {
            damage_groups = {fleshy = 3},
            full_punch_interval = 0.8,
            max_drop_level = 1,
            groupcaps = {
                snappy = {times = {[1] = 2.5, [2] = 1.20, [3] = 0.35}, uses = 150, maxlevel = 2},
            },
            punch_attack_uses = 150,
        },
    })
    unilib.register_craft_sickle({
        -- From sickles:sickle_steel
        part_name = "steel",
        ingredient = "unilib:metal_steel_ingot",
    })
    unilib.tools.apply_toolranks("unilib:tool_sickle_steel", "sickle")

end
