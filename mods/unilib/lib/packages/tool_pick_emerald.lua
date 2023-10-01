---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    gemtools
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_pick_emerald = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.gemtools.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_pick_emerald.init()

    return {
        description = "Emerald pickaxe",
        depends = "mineral_emerald",
    }

end

function unilib.pkg.tool_pick_emerald.exec()

    unilib.register_tool("unilib:tool_pick_emerald", "gemtools:pick_emerald", mode, {
        -- From gemtools:pick_emerald
        description = S("Emerald Pickaxe"),
        inventory_image = "unilib_tool_pick_emerald.png",
        groups = {pickaxe = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 4},
            full_punch_interval = 0.9,
            groupcaps = {
                cracky = {times = {[1] = 4.00, [2] = 1.60, [3] = 0.80}, uses = 25, maxlevel = 2},
            },
            max_drop_level = 3,
        },

        after_use = unilib.tool_after_use,
    })
    unilib.register_craft_pick({
        -- From gemtools:pick_emerald
        part_name = "emerald",
        ingredient = "unilib:mineral_emerald_gem",
    })
    unilib.apply_toolranks("unilib:tool_pick_emerald", "pickaxe")

end
