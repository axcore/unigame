---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_spear_geminitium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_spear_geminitium.init()

    return {
        description = "Geminitium sword",
        depends = "metal_geminitium",
    }

end

function unilib.pkg.tool_spear_geminitium.exec()

    unilib.register_tool("unilib:tool_spear_geminitium", "xtraores:spear_geminitinum", mode, {
        -- From xtraores:spear_geminitinum
        description = S("Geminitium Spear"),
        inventory_image = "unilib_tool_spear_geminitium.png",
        -- N.B. no groups in original code
        groups = {spear = 1},
        sound = {breaks = "unilib_tool_breaks"},

        range = 12,
        tool_capabilities = {
            damage_groups = {fleshy = 50},
            full_punch_interval = 0.7,
            groupcaps = {
                snappy = {times = {[1] = 2, [2] = 1, [3] = 0.35}, uses = 23, maxlevel = 3},
            },
            max_drop_level = 1,
        },
    })
    unilib.register_craft_spear({
        -- From xtraores:spear_geminitinum
        part_name = "geminitium",
        ingredient = "unilib:metal_geminitium_ingot",
    })
    unilib.tools.apply_toolranks("unilib:tool_spear_geminitium", "spear")

end
