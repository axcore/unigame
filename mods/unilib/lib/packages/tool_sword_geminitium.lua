---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_sword_geminitium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_sword_geminitium.init()

    return {
        description = "Geminitium sword",
        depends = "metal_geminitium",
    }

end

function unilib.pkg.tool_sword_geminitium.exec()

    unilib.register_tool("unilib:tool_sword_geminitium", "xtraores:sword_geminitinum", mode, {
        -- From xtraores:sword_geminitinum
        description = S("Geminitium Sword"),
        inventory_image = "unilib_tool_sword_geminitium.png",
        -- N.B. no groups in original code
        groups = {sword = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 20},
            full_punch_interval = 0.7,
            groupcaps = {
                snappy = {times = {[1] = 0.01, [2] = 0.03, [3] = 0.002}, uses = 1000, maxlevel = 3},
            },
            max_drop_level = 1,
        },

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft_sword({
        -- From xtraores:sword_geminitinum
        part_name = "geminitium",
        ingredient = "unilib:metal_geminitium_ingot",
    })
    unilib.tools.apply_toolranks("unilib:tool_sword_geminitium", "sword")

end
