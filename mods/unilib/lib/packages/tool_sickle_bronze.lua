---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    sickles
-- Code:    LGPL v3
-- Media:   CC BY-SA 3.0/4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_sickle_bronze = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.sickles.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_sickle_bronze.init()

    return {
        description = "Bronze sickle",
        depends = "metal_bronze",
    }

end

function unilib.pkg.tool_sickle_bronze.exec()

    unilib.register_tool("unilib:tool_sickle_bronze", "sickles:sickle_bronze", mode, {
        -- From sickles:sickle_bronze
        description = S("Bronze Sickle"),
        inventory_image = "unilib_tool_sickle_bronze.png",
        groups = {sickle = 1, sickle_uses = 110},
        sound = {breaks = "unilib_tool_breaks"},

        range = 6,
        tool_capabilities = {
            damage_groups = {fleshy = 3},
            full_punch_interval = 0.8,
            groupcaps = {
                snappy = {times = {[1] = 2.75, [2] = 1.30, [3] = 0.375}, uses = 60, maxlevel = 2},
            },
            max_drop_level = 1,
            punch_attack_uses = 110
        },
    })
    unilib.register_craft_sickle({
        -- From sickles:sickle_bronze
        part_name = "bronze",
        ingredient = "unilib:metal_bronze_ingot",
    })

end
