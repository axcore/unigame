---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    gemtools
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_sword_emerald = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.gemtools.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_sword_emerald.init()

    return {
        description = "Emerald sword",
        depends = "mineral_emerald",
    }

end

function unilib.pkg.tool_sword_emerald.exec()

    unilib.register_tool("unilib:tool_sword_emerald", "gemtools:sword_emerald", mode, {
        -- From gemtools:sword_emerald
        description = S("Emerald Sword"),
        inventory_image = "unilib_tool_sword_emerald.png",
        groups = {sword = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 6},
            full_punch_interval = 0.7,
            groupcaps = {
                snappy = {times = {[1] = 2.5, [2] = 1.20, [3] = 0.35}, uses = 40, maxlevel = 2},
            },
            max_drop_level = 1,
        },

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft_sword({
        -- From gemtools:sword_emerald
        part_name = "emerald",
        ingredient = "unilib:mineral_emerald_gem",
    })
    unilib.tools.apply_toolranks("unilib:tool_sword_emerald", "sword")

end
