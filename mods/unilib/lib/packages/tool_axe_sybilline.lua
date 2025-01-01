---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_axe_sybilline = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_axe_sybilline.init()

    return {
        description = "Sybilline axe",
        depends = "metal_sybilline",
    }

end

function unilib.pkg.tool_axe_sybilline.exec()

    unilib.register_tool("unilib:tool_axe_sybilline", "xtraores:axe_cobalt", mode, {
        -- From xtraores:axe_cobalt
        description = S("Sybilline Axe"),
        inventory_image = "unilib_tool_axe_sybilline.png",
        -- N.B. no groups in original code
        groups = {axe = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 9},
            full_punch_interval = 0.9,
            groupcaps = {
                choppy = {times = {[1] = 1.8, [2] = 0.7, [3] = 0.3}, uses = 60, maxlevel = 3},
                snappy = {times = {[1] = 1.5, [2] = 0.7, [3] = 0.2}, uses = 50, maxlevel = 3},
            },
            max_drop_level = 1,
        },

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft_axe({
        -- From xtraores:axe_cobalt
        part_name = "sybilline",
        ingredient = "unilib:metal_sybilline_ingot",
    })
    unilib.tools.apply_toolranks("unilib:tool_axe_sybilline", "axe")

end
