---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    gemtools
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_axe_sapphire = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.gemtools.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_axe_sapphire.init()

    return {
        description = "Sapphire axe",
        depends = "mineral_sapphire",
    }

end

function unilib.pkg.tool_axe_sapphire.exec()

    unilib.register_tool("unilib:tool_axe_sapphire", "gemtools:axe_sapphire", mode, {
        -- From gemtools:axe_sapphire
        description = S("Sapphire Axe"),
        inventory_image = "unilib_tool_axe_sapphire.png",
        groups = {axe = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 4},
            full_punch_interval = 0.9,
            groupcaps = {
                choppy = {times = {[1] = 2.30, [2] = 1.20, [3] = 0.80}, uses = 20, maxlevel = 3},
            },
            max_drop_level = 1,
        },

        after_use = unilib.tool_after_use,
    })
    unilib.register_craft_axe({
        -- From gemtools:axe_sapphire
        part_name = "sapphire",
        ingredient = "unilib:mineral_sapphire_gem",
    })
    unilib.apply_toolranks("unilib:tool_axe_sapphire", "axe")

end
