---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_drill_geminitinum = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_drill_geminitinum.init()

    return {
        description = "Geminitinum drill",
        depends = {"metal_geminitinum", "mineral_diamond"},
    }

end

function unilib.pkg.tool_drill_geminitinum.exec()

    unilib.register_tool("unilib:tool_drill_geminitinum", "xtraores:drill_geminitinum", mode, {
        -- From xtraores:drill_geminitinum
        description = S("Geminitinum Drill"),
        inventory_image = "unilib_tool_drill_geminitinum.png",
        -- N.B. no groups in original code
        groups = {pickaxe = 1},
        -- N.B. no sounds in original code
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 20},
            full_punch_interval = 0.001,
            groupcaps = {
                cracky = {times = {[1] = 0.01, [2] = 0.01, [3] = 0.01}, uses = 1000, maxlevel = 3},
                crumbly = {times = {[1] = 0.01, [2] = 0.01, [3] = 0.01}, uses = 1000, maxlevel = 3},
                extrahard = {
                    times = {[0] = 0.01, [1] = 0.01, [2] = 0.01, [3] = 0.01},
                    uses = 1000,
                    maxlevel = 3,
                },
            },
            max_drop_level = 3,
        },
    })
    unilib.register_craft_drill({
        -- From xtraores:drill_geminitinum
        part_name = "geminitinum",
        ingredient = "unilib:metal_geminitinum_ingot",
        minor_ingredient = "unilib:mineral_diamond_gem",
    })

end
