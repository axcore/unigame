---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_drill_rarium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_drill_rarium.init()

    return {
        description = "Rarium drill",
        depends = {"metal_rarium", "mineral_diamond"},
    }

end

function unilib.pkg.tool_drill_rarium.exec()

    unilib.register_tool("unilib:tool_drill_rarium", "xtraores:drill_rarium", mode, {
        -- From xtraores:drill_rarium
        description = S("Rarium Drill"),
        inventory_image = "unilib_tool_drill_rarium.png",
        -- N.B. no groups in original code
        groups = {drill = 1, pickaxe = 1},
        -- N.B. no sounds in original code
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 8},
            full_punch_interval = 0.001,
            groupcaps = {
                cracky = {times = {[1] = 0.3, [2] = 0.125, [3] = 0.075}, uses = 350, maxlevel = 3},
                crumbly = {times = {[1] = 0.15, [2] = 0.06, [3] = 0.03}, uses = 350, maxlevel = 3},
                extrahard = {
                    times = {[0] = 2, [1] = 1.5, [2] = 1, [3] = 0.5},
                    uses = 350,
                    maxlevel = 3,
                },
            },
            max_drop_level = 3,
        },
    })
    unilib.register_craft_drill({
        -- From xtraores:drill_rarium
        part_name = "rarium",
        ingredient = "unilib:metal_rarium_ingot",
        minor_ingredient = "unilib:mineral_diamond_gem",
    })
    unilib.tools.apply_toolranks("unilib:tool_drill_rarium", "drill")

end
