---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreores
-- Code:    zlib
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_axe_silver = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moreores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_axe_silver.init()

    return {
        description = "Silver axe",
        depends = "metal_silver",
    }

end

function unilib.pkg.tool_axe_silver.exec()

    unilib.register_tool("unilib:tool_axe_silver", "moreores:axe_silver", mode, {
        -- From moreores:axe_silver
        description = S("Silver Axe"),
        inventory_image = "unilib_tool_axe_silver.png",
        -- N.B. no groups in original code
        groups = {axe = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 5},
            full_punch_interval = 1,
            groupcaps = {
                choppy = {times = {[1] = 2.5, [2] = 0.8, [3] = 0.5}, uses = 100, maxlevel = 1},
                fleshy = {times = {[2] = 1.1, [3] = 0.6}, uses = 100, maxlevel = 1},
            },
            max_drop_level = 3,
        },

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft_axe({
        -- From moreores:axe_silver
        part_name = "silver",
        ingredient = "unilib:metal_silver_ingot",
    })
    unilib.tools.apply_toolranks("unilib:tool_axe_silver", "axe")

end
