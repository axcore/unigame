---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreores
-- Code:    zlib
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_pick_mithril = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moreores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_pick_mithril.init()

    return {
        description = "Mithril pickaxe",
        depends = "metal_mithril",
    }

end

function unilib.pkg.tool_pick_mithril.exec()

    unilib.register_tool("unilib:tool_pick_mithril", "moreores:pick_mithril", mode, {
        -- From moreores:pick_mithril
        description = S("Mithril Pickaxe"),
        inventory_image = "unilib_tool_pick_mithril.png",
        -- N.B. no groups in original code
        groups = {pickaxe = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 6},
            full_punch_interval = 0.45,
            groupcaps = {
                cracky = {times = {[1] = 2.25, [2] = 0.55, [3] = 0.35}, uses = 200, maxlevel = 3},
            },
            max_drop_level = 3,
        },

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft_pick({
        -- From moreores:pick_mithril
        part_name = "mithril",
        ingredient = "unilib:metal_mithril_ingot",
    })
    unilib.tools.apply_toolranks("unilib:tool_pick_mithril", "pickaxe")

end
