---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    sickles
-- Code:    LGPL v3
-- Media:   CC BY-SA 3.0/4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_scythe_bronze = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.sickles.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_scythe_bronze.init()

    return {
        description = "Bronze scythe",
        depends = "metal_bronze",
    }

end

function unilib.pkg.tool_scythe_bronze.exec()

    unilib.register_tool("unilib:tool_scythe_bronze", "sickles:scythe_bronze", mode, {
        -- From sickles:scythe_bronze
        description = S("Bronze Scythe"),
        inventory_image = "unilib_tool_scythe_bronze.png",
        -- N.B. scythe = 2 in original code (the replacement code below reduces the scythe's range
        --      to 1 block)
        groups = {scythe = 1, scythe_uses = 25},
        sound = {breaks = "unilib_tool_breaks"},

        range = 12,
        tool_capabilities = {
            damage_groups = {fleshy = 5},
            full_punch_interval = 1.2,
            -- N.B. 160 in original code
            punch_attack_uses = 150,
        },

        on_use = unilib.use_scythe,
    })
    unilib.register_craft_scythe({
        -- From sickles:scythe_bronze
        part_name = "bronze",
        ingredient = "unilib:metal_bronze_ingot",
    })

end
