---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreores
-- Code:    zlib
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_pick_silver = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moreores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_pick_silver.init()

    return {
        description = "Silver pickaxe",
        depends = "metal_silver",
    }

end

function unilib.pkg.tool_pick_silver.exec()

    unilib.register_tool("unilib:tool_pick_silver", "moreores:pick_silver", mode, {
        -- From moreores:pick_silver
        description = S("Silver Pickaxe"),
        inventory_image = "unilib_tool_pick_silver.png",
        -- N.B. no groups in original code
        groups = {pickaxe = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 4},
            full_punch_interval = 1,
            groupcaps = {
                cracky = {times = {[1] = 2.6, [2] = 1, [3] = 0.6}, uses = 100, maxlevel = 1},
            },
            max_drop_level = 3,
        },

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft_pick({
        -- From moreores:pick_silver
        part_name = "silver",
        ingredient = "unilib:metal_silver_ingot",
    })
    unilib.tools.apply_toolranks("unilib:tool_pick_silver", "pickaxe")

end
