---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_pick_sybilline = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_pick_sybilline.init()

    return {
        description = "Sybilline pickaxe",
        depends = "metal_sybilline",
    }

end

function unilib.pkg.tool_pick_sybilline.exec()

    unilib.register_tool("unilib:tool_pick_sybilline", "xtraores:pick_cobalt", mode, {
        -- From xtraores:pick_cobalt
        description = S("Sybilline Pickaxe"),
        inventory_image = "unilib_tool_pick_sybilline.png",
        -- N.B. no groups in original code
        groups = {pickaxe = 1},
        -- N.B. no sounds in original code
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 8},
            full_punch_interval = 0.9,
            groupcaps = {
                cracky = {times = {[1] = 1.5, [2] = 0.85, [3] = 0.4}, uses = 60, maxlevel = 3},
                extrahard = {times = {[3] = 3}, uses = 60, maxlevel = 3},
            },
            max_drop_level = 3,
        },

        after_use = unilib.tool_after_use,
    })
    unilib.register_craft_pick({
        -- From xtraores:pick_cobalt
        part_name = "sybilline",
        ingredient = "unilib:metal_sybilline_ingot",
    })
    unilib.apply_toolranks("unilib:tool_pick_sybilline", "pickaxe")

end
