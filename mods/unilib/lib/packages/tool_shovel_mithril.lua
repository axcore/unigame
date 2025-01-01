---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreores
-- Code:    zlib
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_shovel_mithril = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moreores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_shovel_mithril.init()

    return {
        description = "Mithril shovel",
        depends = "metal_mithril",
    }

end

function unilib.pkg.tool_shovel_mithril.exec()

    unilib.register_tool("unilib:tool_shovel_mithril", "moreores:shovel_mithril", mode, {
        -- From moreores:shovel_mithril
        description = S("Mithril Shovel"),
        inventory_image = "unilib_tool_shovel_mithril.png",
        -- N.B. no groups in original code
        groups = {shovel = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 5},
            full_punch_interval = 0.45,
            groupcaps = {
                crumbly = {times = {[1] = 0.7, [2] = 0.35, [3] = 0.2}, uses = 200, maxlevel = 3},
            },
            max_drop_level = 3,
        },
        wield_image = "unilib_tool_shovel_mithril.png^[transformR90",

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft_shovel({
        -- From moreores:shovel_mithril
        part_name = "mithril",
        ingredient = "unilib:metal_mithril_ingot",
    })
    unilib.tools.apply_toolranks("unilib:tool_shovel_mithril", "shovel")

end
