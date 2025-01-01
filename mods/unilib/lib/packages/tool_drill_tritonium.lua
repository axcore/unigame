---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_drill_tritonium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_drill_tritonium.init()

    return {
        description = "Tritonium drill",
        depends = {"metal_tritonium", "mineral_diamond"},
    }

end

function unilib.pkg.tool_drill_tritonium.exec()

    unilib.register_tool("unilib:tool_drill_tritonium", "xtraores:drill_titanium", mode, {
        -- From xtraores:drill_titanium
        description = S("Tritonium Drill"),
        inventory_image = "unilib_tool_drill_tritonium.png",
        -- N.B. no groups in original code
        groups = {drill = 1, pickaxe = 1},
        -- N.B. no sounds in original code
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 15},
            full_punch_interval = 0.001,
            groupcaps = {
                cracky = {times = {[1] = 0.1, [2] = 0.04, [3] = 0.02}, uses = 650, maxlevel = 3},
                crumbly = {times = {[1] = 0.1, [2] = 0.04, [3] = 0.02}, uses = 650, maxlevel = 3},
                extrahard = {
                    times = {[0] = 0.8, [1] = 0.6, [2] = 0.2, [3] = 0.1},
                    uses = 650,
                    maxlevel = 3,
                },
            },
            max_drop_level = 3,
        },
    })
    unilib.register_craft_drill({
        -- From xtraores:drill_titanium
        part_name = "tritonium",
        ingredient = "unilib:metal_tritonium_ingot",
        minor_ingredient = "unilib:mineral_diamond_gem",
    })
    unilib.tools.apply_toolranks("unilib:tool_drill_tritonium", "drill")

end
