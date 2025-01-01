---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreores
-- Code:    zlib
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_sword_mithril = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moreores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_sword_mithril.init()

    return {
        description = "Mithril sword",
        depends = "metal_mithril",
    }

end

function unilib.pkg.tool_sword_mithril.exec()

    unilib.register_tool("unilib:tool_sword_mithril", "moreores:sword_mithril", mode, {
        -- From moreores:sword_mithril
        description = S("Mithril Sword"),
        inventory_image = "unilib_tool_sword_mithril.png",
        -- N.B. no groups in original code
        groups = {sword = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 10},
            full_punch_interval = 0.45,
            groupcaps = {
                choppy = {times = {[3] = 0.65}, uses = 200, maxlevel = 0},
                fleshy = {times = {[2] = 0.65, [3] = 0.25}, uses = 200, maxlevel = 2},
                snappy = {times = {[1] = 1.7, [2] = 0.7, [3] = 0.25}, uses = 200, maxlevel = 3},
            },
            max_drop_level = 3,
        },

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft_sword({
        -- From moreores:sword_mithril
        part_name = "mithril",
        ingredient = "unilib:metal_mithril_ingot",
    })
    unilib.tools.apply_toolranks("unilib:tool_sword_mithril", "sword")

end
