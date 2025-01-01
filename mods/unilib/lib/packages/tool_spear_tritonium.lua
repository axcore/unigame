---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_spear_tritonium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_spear_tritonium.init()

    return {
        description = "Tritonium sword",
        depends = "metal_tritonium",
    }

end

function unilib.pkg.tool_spear_tritonium.exec()

    unilib.register_tool("unilib:tool_spear_tritonium", "xtraores:spear_titanium", mode, {
        -- From xtraores:spear_titanium
        description = S("Tritonium Spear"),
        inventory_image = "unilib_tool_spear_tritonium.png",
        -- N.B. no groups in original code
        groups = {spear = 1},
        sound = {breaks = "unilib_tool_breaks"},

        range = 12,
        tool_capabilities = {
            damage_groups = {fleshy = 40},
            full_punch_interval = 0.7,
            groupcaps = {
                snappy = {times = {[1] = 2, [2] = 1, [3] = 0.35}, uses = 23, maxlevel = 3},
            },
            max_drop_level = 1,
        },
    })
    unilib.register_craft_spear({
        -- From xtraores:spear_titanium
        part_name = "tritonium",
        ingredient = "unilib:metal_tritonium_ingot",
    })
    unilib.tools.apply_toolranks("unilib:tool_spear_tritonium", "spear")

end
