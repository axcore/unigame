---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreores
-- Code:    zlib
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_sword_silver = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_sword_silver.init()

    return {
        description = "Silver sword",
        depends = "metal_silver",
    }

end

function unilib.pkg.tool_sword_silver.exec()

    unilib.register_tool("unilib:tool_sword_silver", "moreores:sword_silver", mode, {
        -- From moreores:sword_silver
        description = S("Silver Sword"),
        inventory_image = "unilib_tool_sword_silver.png",
        -- N.B. no groups in original code
        groups = {sword = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 6},
            full_punch_interval = 1,
            groupcaps = {
                choppy = {times = {[3] = 0.8}, uses = 100, maxlevel = 0},
                fleshy = {times = {[2] = 0.7, [3] = 0.3}, uses = 100, maxlevel = 1},
                snappy = {times = {[1] = 1.7, [2] = 0.7, [3] = 0.3}, uses = 100, maxlevel = 1},
            },
            max_drop_level = 3,
        },

        after_use = unilib.tool_after_use,
    })
    unilib.register_craft_sword({
        -- From moreores:sword_silver
        part_name = "silver",
        ingredient = "unilib:metal_silver_ingot",
    })
    unilib.apply_toolranks("unilib:tool_sword_silver", "sword")

end
