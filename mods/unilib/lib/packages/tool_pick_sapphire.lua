---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    gemtools
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_pick_sapphire = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.gemtools.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_pick_sapphire.init()

    return {
        description = "Sapphire pickaxe",
        depends = "mineral_sapphire",
    }

end

function unilib.pkg.tool_pick_sapphire.exec()

    unilib.register_tool("unilib:tool_pick_sapphire", "gemtools:pick_sapphire", mode, {
        -- From gemtools:pick_sapphire
        description = S("Sapphire Pickaxe"),
        inventory_image = "unilib_tool_pick_sapphire.png",
        groups = {pickaxe = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 4},
            full_punch_interval = 0.9,
            groupcaps = {
                cracky = {times = {[1] = 3.00, [2] = 1.40, [3] = 0.70}, uses = 20, maxlevel = 3},
            },
            max_drop_level = 3,
        },

        after_use = unilib.tool_after_use,
    })
    unilib.register_craft_pick({
        -- From gemtools:pick_sapphire
        part_name = "sapphire",
        ingredient = "unilib:mineral_sapphire_gem",
    })
    unilib.apply_toolranks("unilib:tool_pick_sapphire", "pickaxe")

end
