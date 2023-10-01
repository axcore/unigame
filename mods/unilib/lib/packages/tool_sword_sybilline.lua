---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_sword_sybilline = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_sword_sybilline.init()

    return {
        description = "Sybilline sword",
        depends = "metal_sybilline",
    }

end

function unilib.pkg.tool_sword_sybilline.exec()

    unilib.register_tool("unilib:tool_sword_sybilline", "xtraores:sword_cobalt", mode, {
        -- From xtraores:sword_cobalt
        description = S("Sybilline Sword"),
        inventory_image = "unilib_tool_sword_sybilline.png",
        -- N.B. no groups in original code
        groups = {sword = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 10},
            full_punch_interval = 0.7,
            groupcaps = {
                snappy = {times = {[1] = 1.5, [2] = 0.7, [3] = 0.2}, uses = 70, maxlevel = 3},
            },
            max_drop_level = 1,
        },

        after_use = unilib.tool_after_use,
    })
    unilib.register_craft_sword({
        -- From xtraores:sword_cobalt
        part_name = "sybilline",
        ingredient = "unilib:metal_sybilline_ingot",
    })
    unilib.apply_toolranks("unilib:tool_sword_sybilline", "sword")

end
