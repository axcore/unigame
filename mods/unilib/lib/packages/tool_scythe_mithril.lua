---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_scythe_mithril = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_scythe_mithril.init()

    return {
        description = "Mithril scythe",
        depends = "metal_mithril",
    }

end

function unilib.pkg.tool_scythe_mithril.exec()

    unilib.register_tool("unilib:tool_scythe_mithril", "farming:scythe_mithril", mode, {
        -- From farming:scythe_mithril
        description = S("Mithril Scythe"),
        inventory_image = "unilib_tool_scythe_mithril.png",
        -- N.B. no groups in original code (the new code below increases the scythe's range to 3
        --      blocks)
        groups = {scythe = 3, scythe_uses = 50},
        sound = {breaks = "unilib_tool_breaks"},

        -- N.B. no range or tool_capabilities in original code
        range = 12,
        tool_capabilities = {
            damage_groups = {fleshy = 5},
            full_punch_interval = 1.2,
            punch_attack_uses = 300,
        },

        on_use = unilib.tools.use_scythe,
    })
    unilib.register_craft_scythe({
        -- From farming:scythe_mithril
        part_name = "mithril",
        ingredient = "unilib:metal_mithril_ingot",
    })
    unilib.tools.apply_toolranks("unilib:tool_scythe_mithril", "scythe")

end
