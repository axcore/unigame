---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreores
-- Code:    zlib
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_axe_mithril = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_axe_mithril.init()

    return {
        description = "Mithril axe",
        depends = "metal_mithril",
    }

end

function unilib.pkg.tool_axe_mithril.exec()

    unilib.register_tool("unilib:tool_axe_mithril", "moreores:axe_mithril", mode, {
        -- From moreores:axe_mithril
        description = S("Mithril Axe"),
        inventory_image = "unilib_tool_axe_mithril.png",
        -- N.B. no groups in original code
        groups = {axe = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 8},
            full_punch_interval = 0.45,
            groupcaps = {
                choppy = {times = {[1] = 1.75, [2] = 0.45, [3] = 0.45}, uses = 200, maxlevel = 3},
                fleshy = {times = {[2] = 0.95, [3] = 0.3}, uses = 200, maxlevel = 2},
            },
            max_drop_level = 3,
        },

        after_use = unilib.tool_after_use,
    })
    unilib.register_craft_axe({
        -- From moreores:axe_mithril
        part_name = "mithril",
        ingredient = "unilib:metal_mithril_ingot",
    })
    unilib.apply_toolranks("unilib:tool_axe_mithril", "axe")

end
