---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_pick_steel = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_pick_steel.init()

    return {
        description = "Steel pickaxe",
        depends = "metal_steel",
    }

end

function unilib.pkg.tool_pick_steel.exec()

    unilib.register_tool("unilib:tool_pick_steel", "default:pick_steel", mode, {
        -- From default:pick_steel
        description = S("Steel Pickaxe"),
        inventory_image = "unilib_tool_pick_steel.png",
        groups = {pickaxe = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 4},
            full_punch_interval = 1.0,
            groupcaps = {
                cracky = {times = {[1] = 4.00, [2] = 1.60, [3] = 0.80}, uses = 20, maxlevel = 2},
            },
            max_drop_level = 1,
        },

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft_pick({
        -- From default:pick_steel
        part_name = "steel",
        ingredient = "unilib:metal_steel_ingot",
    })
    unilib.tools.apply_toolranks("unilib:tool_pick_steel", "pickaxe")

end
