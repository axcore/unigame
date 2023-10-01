---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_pick_diamond = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_pick_diamond.init()

    return {
        description = "Diamond pickaxe",
        depends = "mineral_diamond",
    }

end

function unilib.pkg.tool_pick_diamond.exec()

    unilib.register_tool("unilib:tool_pick_diamond", "default:pick_diamond", mode, {
        -- From default:pick_diamond
        description = S("Diamond Pickaxe"),
        inventory_image = "unilib_tool_pick_diamond.png",
        groups = {pickaxe = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 5},
            full_punch_interval = 0.9,
            groupcaps = {
                cracky = {times = {[1] = 2.0, [2] = 1.0, [3] = 0.50}, uses = 30, maxlevel = 3},
            },
            max_drop_level = 3,
        },

        after_use = unilib.tool_after_use,
    })
    unilib.register_craft_pick({
        -- From default:pick_diamond
        part_name = "diamond",
        ingredient = "unilib:mineral_diamond_gem",
    })
    unilib.apply_toolranks("unilib:tool_pick_diamond", "pickaxe")

end
