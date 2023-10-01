---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_spear_geminitinum = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_spear_geminitinum.init()

    return {
        description = "Geminitinum sword",
        depends = "metal_geminitinum",
    }

end

function unilib.pkg.tool_spear_geminitinum.exec()

    unilib.register_tool("unilib:tool_spear_geminitinum", "xtraores:spear_geminitinum", mode, {
        -- From xtraores:spear_geminitinum
        description = S("Geminitinum Spear"),
        inventory_image = "unilib_tool_spear_geminitinum.png",
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
        part_name = "geminitinum",
        ingredient = "unilib:metal_geminitinum_ingot",
    })

end
