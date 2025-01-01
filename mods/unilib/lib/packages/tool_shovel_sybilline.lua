---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_shovel_sybilline = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_shovel_sybilline.init()

    return {
        description = "Sybilline shovel",
        depends = "metal_sybilline",
    }

end

function unilib.pkg.tool_shovel_sybilline.exec()

    unilib.register_tool("unilib:tool_shovel_sybilline", "xtraores:shovel_cobalt", mode, {
        -- From xtraores:shovel_cobalt
        description = S("Sybilline Shovel"),
        inventory_image = "unilib_tool_shovel_sybilline.png",
        -- N.B. no groups in original code
        groups = {shovel = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 7},
            full_punch_interval = 1,
            groupcaps = {
                crumbly = {times = {[1] = 0.9, [2] = 0.4, [3] = 0.2}, uses = 60, maxlevel = 3},
            },
            max_drop_level = 3,
        },
        wield_image = "unilib_tool_shovel_sybilline.png^[transformR90",

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft_shovel({
        -- From xtraores:shovel_cobalt
        part_name = "sybilline",
        ingredient = "unilib:metal_sybilline_ingot",
    })
    unilib.tools.apply_toolranks("unilib:tool_shovel_sybilline", "shovel")

end
