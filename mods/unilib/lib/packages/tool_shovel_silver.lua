---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreores
-- Code:    zlib
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_shovel_silver = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_shovel_silver.init()

    return {
        description = "Silver shovel",
        depends = "metal_silver",
    }

end

function unilib.pkg.tool_shovel_silver.exec()

    unilib.register_tool("unilib:tool_shovel_silver", "moreores:shovel_silver", mode, {
        -- From moreores:shovel_silver
        description = S("Silver Shovel"),
        inventory_image = "unilib_tool_shovel_silver.png",
        -- N.B. no groups in original code
        groups = {shovel = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 3},
            full_punch_interval = 1,
            groupcaps = {
                crumbly = {times = {[1] = 1.1, [2] = 0.4, [3] = 0.25}, uses = 100, maxlevel = 1},
            },
            max_drop_level = 3,
        },
        wield_image = "unilib_tool_shovel_silver.png^[transformR90",

        after_use = unilib.tool_after_use,
    })
    unilib.register_craft_shovel({
        -- From moreores:shovel_silver
        part_name = "silver",
        ingredient = "unilib:metal_silver_ingot",
    })
    unilib.apply_toolranks("unilib:tool_shovel_silver", "shovel")

end
