---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_sword_geminitinum = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_sword_geminitinum.init()

    return {
        description = "Geminitinum sword",
        depends = "metal_geminitinum",
    }

end

function unilib.pkg.tool_sword_geminitinum.exec()

    unilib.register_tool("unilib:tool_sword_geminitinum", "xtraores:sword_geminitinum", mode, {
        -- From xtraores:sword_geminitinum
        description = S("Geminitinum Sword"),
        inventory_image = "unilib_tool_sword_geminitinum.png",
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

        after_use = unilib.tool_after_use,
    })
    unilib.register_craft_sword({
        -- From xtraores:sword_geminitinum
        part_name = "geminitinum",
        ingredient = "unilib:metal_geminitinum_ingot",
    })
    unilib.apply_toolranks("unilib:tool_sword_geminitinum", "sword")

end
