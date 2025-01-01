---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    gemtools
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_sword_sapphire = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.gemtools.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_sword_sapphire.init()

    return {
        description = "Sapphire sword",
        depends = "mineral_sapphire",
    }

end

function unilib.pkg.tool_sword_sapphire.exec()

    unilib.register_tool("unilib:tool_sword_sapphire", "gemtools:sword_sapphire", mode, {
        -- From gemtools:sword_sapphire
        description = S("Sapphire Sword"),
        inventory_image = "unilib_tool_sword_sapphire.png",
        groups = {sword = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 6},
            full_punch_interval = 0.7,
            groupcaps = {
                snappy = {times = {[1] = 2.2, [2] = 1.10, [3] = 0.35}, uses = 30, maxlevel = 3},
            },
            max_drop_level = 1,
        },

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft_sword({
        -- From gemtools:sword_sapphire
        part_name = "sapphire",
        ingredient = "unilib:mineral_sapphire_gem",
    })
    unilib.tools.apply_toolranks("unilib:tool_sword_sapphire", "sword")

end
