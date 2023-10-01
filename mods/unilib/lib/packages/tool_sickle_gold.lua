---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    sickles
-- Code:    LGPL v3
-- Media:   CC BY-SA 3.0/4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_sickle_gold = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.sickles.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_sickle_gold.init()

    return {
        description = "Gold sickle",
        depends = "metal_gold",
    }

end

function unilib.pkg.tool_sickle_gold.exec()

    unilib.register_tool("unilib:tool_sickle_gold", "sickles:sickle_gold", mode, {
        -- From sickles:sickle_gold
        description = S("Golden Sickle"),
        inventory_image = "unilib_tool_sickle_gold.png",
        groups = {sickle = 1, sickle_uses = 90},
        sound = {breaks = "unilib_tool_breaks"},

        range = 6,
        tool_capabilities = {
            damage_groups = {fleshy = 2},
            full_punch_interval = 0.8,
            groupcaps = {
                snappy = {times = {[1] = 2.0, [2] = 1.00, [3] = 0.35}, uses = 45, maxlevel = 3},
            },
            max_drop_level = 1,
            punch_attack_uses = 90,
        },
    })
    unilib.register_craft_sickle({
        -- From sickles:sickle_gold
        part_name = "gold",
        ingredient = "unilib:metal_gold_ingot",
    })

end
