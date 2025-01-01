---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_shovel_steel = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_shovel_steel.init()

    return {
        description = "Steel shovel",
        depends = "metal_steel",
    }

end

function unilib.pkg.tool_shovel_steel.exec()

    unilib.register_tool("unilib:tool_shovel_steel", "default:shovel_steel", mode, {
        -- From default:shovel_steel
        description = S("Steel Shovel"),
        inventory_image = "unilib_tool_shovel_steel.png",
        groups = {shovel = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 3},
            full_punch_interval = 1.1,
            groupcaps = {
                crumbly = {times = {[1] = 1.50, [2] = 0.90, [3] = 0.40}, uses = 30, maxlevel = 2},
            },
            max_drop_level = 1,
        },
        wield_image = "unilib_tool_shovel_steel.png^[transformR90",

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft_shovel({
        -- From default:shovel_steel
        part_name = "steel",
        ingredient = "unilib:metal_steel_ingot",
    })
    unilib.tools.apply_toolranks("unilib:tool_shovel_steel", "shovel")

end
