---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_axe_planexium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_axe_planexium.init()

    return {
        description = "Planexium axe",
        depends = "metal_planexium",
    }

end

function unilib.pkg.tool_axe_planexium.exec()

    unilib.register_tool("unilib:tool_axe_planexium", "xtraores:axe_platinum", mode, {
        -- From xtraores:axe_platinum
        description = S("Planexium Axe"),
        inventory_image = "unilib_tool_axe_planexium.png",
        -- N.B. no groups in original code
        groups = {axe = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 6},
            full_punch_interval = 0.9,
            groupcaps = {
                choppy = {times = {[1] = 2.2, [2] = 1, [3] = 0.6}, uses = 15, maxlevel = 3},
                snappy = {times = {[1] = 2, [2] = 1, [3] = 0.35}, uses = 15, maxlevel = 3},
            },
            max_drop_level = 1,
        },

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft_axe({
        -- From xtraores:axe_platinum
        part_name = "planexium",
        ingredient = "unilib:metal_planexium_ingot",
    })
    unilib.tools.apply_toolranks("unilib:tool_axe_planexium", "axe")

end
