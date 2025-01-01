---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_knife_flint = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.earthbuild.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_knife_flint.init()

    return {
        description = "Flint knife",
        depends = "mineral_flint",
    }

end

function unilib.pkg.tool_knife_flint.exec()

    unilib.register_tool("unilib:tool_knife_flint", "earthbuild:flint_knife", mode, {
        -- From earthbuild:flint_knife
        description = S("Flint Knife"),
        inventory_image = "unilib_tool_knife_flint.png",
        -- (no groups)
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 5},
            full_punch_interval = 1.2,
            groupcaps = {
                snappy = {times = {[1] = 2.75, [2] = 1.3, [3] = 0.38}, uses = 15, maxlevel = 2},
            },
            max_drop_level = 0,
        },
    })
    unilib.register_craft({
        -- From earthbuild:flint_knife
        output = "unilib:tool_knife_flint",
        recipe = {
            {"unilib:mineral_flint_lump"},
            {"group:stick"},
        },
    })

end
