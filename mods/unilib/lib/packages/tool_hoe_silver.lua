---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreores
-- Code:    zlib
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_hoe_silver = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moreores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_hoe_silver.init()

    return {
        description = "Silver hoe",
        depends = "metal_silver",
    }

end

function unilib.pkg.tool_hoe_silver.exec()

    unilib.register_hoe({
        -- From moreores:hoe_silver (an earlier version, now deprecated)
        part_name = "silver",
        full_name = "unilib:tool_hoe_silver",
        orig_name = "moreores:hoe_silver",
        def_table = {
            description = S("Silver Hoe"),
            inventory_image = "unilib_tool_hoe_silver.png",
            -- N.B. no groups in original code
            groups = {hoe = 1},

            ingredient = "unilib:metal_silver_ingot",
            max_uses = 300,
        },

        replace_mode = mode,
        damage_group_table = {fleshy = 2},
    })
    unilib.tools.apply_toolranks("unilib:tool_hoe_silver", "hoe")

end
