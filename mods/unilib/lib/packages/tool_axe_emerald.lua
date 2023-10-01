---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    gemtools
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_axe_emerald = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.gemtools.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_axe_emerald.init()

    return {
        description = "Emerald axe",
        depends = "mineral_emerald",
    }

end

function unilib.pkg.tool_axe_emerald.exec()

    unilib.register_tool("unilib:tool_axe_emerald", "gemtools:axe_emerald", mode, {
        -- From gemtools:axe_emerald
        description = S("Emerald Axe"),
        inventory_image = "unilib_tool_axe_emerald.png",
        groups = {axe = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 4},
            full_punch_interval = 0.9,
            groupcaps = {
                choppy = {times = {[1] = 2.50, [2] = 1.40, [3] = 1.00}, uses = 25, maxlevel = 2},
            },
            max_drop_level = 1,
        },

        after_use = unilib.tool_after_use,
    })
    unilib.register_craft_axe({
        -- From gemtools:axe_emerald
        part_name = "emerald",
        ingredient = "unilib:mineral_emerald_gem",
    })
    unilib.apply_toolranks("unilib:tool_axe_emerald", "axe")

end
