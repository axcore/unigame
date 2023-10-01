---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_shovel_stone = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_shovel_stone.init()

    return {
        description = "Stone shovel",
    }

end

function unilib.pkg.tool_shovel_stone.exec()

    unilib.register_tool("unilib:tool_shovel_stone", "default:shovel_stone", mode, {
        -- From default:shovel_stone
        description = S("Stone Shovel"),
        inventory_image = "unilib_tool_shovel_stone.png",
        groups = {shovel = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 2},
            full_punch_interval = 1.4,
            groupcaps = {
                crumbly = {times = {[1] = 1.80, [2] = 1.20, [3] = 0.50}, uses = 20, maxlevel = 1},
            },
            max_drop_level = 0,
        },
        wield_image = "unilib_tool_shovel_stone.png^[transformR90",

        after_use = unilib.tool_after_use,
    })
    unilib.register_craft_shovel({
        -- From default:shovel_stone
        part_name = "stone",
        ingredient = "group:stone",
    })
    unilib.apply_toolranks("unilib:tool_shovel_stone", "shovel")

end
