---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreores
-- Code:    zlib
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_hoe_mithril = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_hoe_mithril.init()

    return {
        description = "Mithril hoe",
        depends = "metal_mithril",
    }

end

function unilib.pkg.tool_hoe_mithril.exec()

    unilib.register_hoe({
        -- From moreores:hoe_mithril (an earlier version, now deprecated)
        part_name = "mithril",
        full_name = "unilib:tool_hoe_mithril",
        orig_name = "moreores:hoe_mithril",
        def_table = {
            description = S("Mithril Hoe"),
            inventory_image = "unilib_tool_hoe_mithril.png",
            -- N.B. no groups in original code
            groups = {hoe = 1},

            ingredient = "unilib:metal_mithril_ingot",
            max_uses = 1000,
        },

        replace_mode = mode,
    })

end
