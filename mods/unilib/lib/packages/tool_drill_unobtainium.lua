---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_drill_unobtainium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_drill_unobtainium.init()

    return {
        description = "Unobtainium drill",
        depends = {"metal_unobtainium", "mineral_diamond"},
    }

end

function unilib.pkg.tool_drill_unobtainium.exec()

    unilib.register_tool("unilib:tool_drill_unobtainium", "xtraores:drill_unobtainium", mode, {
        -- From xtraores:drill_unobtainium
        description = S("Unobtainium Drill"),
        inventory_image = "unilib_tool_drill_unobtainium.png",
        -- N.B. no groups in original code
        groups = {drill = 1, pickaxe = 1},
        -- N.B. no sounds in original code
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 12},
            full_punch_interval = 0.001,
            groupcaps = {
                cracky = {times = {[1] = 0.15, [2] = 0.06, [3] = 0.04}, uses = 500, maxlevel = 3},
                crumbly = {times = {[1] = 0.15, [2] = 0.06, [3] = 0.03}, uses = 500, maxlevel = 3},
                extrahard = {
                    times = {[0] = 1, [1] = 0.75, [2] = 0.5, [3] = 0.25},
                    uses = 500,
                    maxlevel = 3,
                },
            },
            max_drop_level = 3,
        },
    })
    unilib.register_craft_drill({
        -- From xtraores:drill_unobtainium
        part_name = "unobtainium",
        ingredient = "unilib:metal_unobtainium_ingot",
        minor_ingredient = "unilib:mineral_diamond_gem",
    })
    unilib.tools.apply_toolranks("unilib:tool_drill_unobtainium", "drill")

end
