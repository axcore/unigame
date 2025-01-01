---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_axe_flint = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.earthbuild.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_axe_flint.init()

    return {
        description = "Flint axe",
        depends = "mineral_flint",
    }

end

function unilib.pkg.tool_axe_flint.exec()

    unilib.register_tool("unilib:tool_axe_flint", "earthbuild:flint_axe", mode, {
        -- From earthbuild:flint_axe
        description = S("Flint Axe"),
        inventory_image = "unilib_tool_axe_flint.png",
        -- (no groups)
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 4},
            full_punch_interval = 1.2,
            groupcaps={
                choppy = {times = {[1] = 2.75, [2] = 1.70, [3] = 1.15}, uses = 15, maxlevel = 2},
            },
            max_drop_level = 0,
        },
    })
    unilib.register_craft({
        -- From earthbuild:flint_axe
        output = "unilib:tool_axe_flint",
        recipe = {
            {"unilib:mineral_flint_lump", "group:stick"},
            {"", "group:stick"},
        },
    })

end
