---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_pick_stone = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_pick_stone.init()

    return {
        description = "Stone pickaxe",
    }

end

function unilib.pkg.tool_pick_stone.exec()

    unilib.register_tool("unilib:tool_pick_stone", "default:pick_stone", mode, {
        -- From default:pick_stone
        description = S("Stone Pickaxe"),
        inventory_image = "unilib_tool_pick_stone.png",
        groups = {pickaxe = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 3},
            full_punch_interval = 1.3,
            groupcaps = {
                cracky = {times = {[2] = 2.0, [3] = 1.00}, uses = 20, maxlevel = 1},
            },
            max_drop_level = 0,
        },

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft_pick({
        -- From default:pick_stone
        part_name = "stone",
        ingredient = "group:stone",
    })
    unilib.tools.apply_toolranks("unilib:tool_pick_stone", "pickaxe")

end
