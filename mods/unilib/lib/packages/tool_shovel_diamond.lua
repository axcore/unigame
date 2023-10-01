---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_shovel_diamond = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_shovel_diamond.init()

    return {
        description = "Diamond shovel",
        depends = "mineral_diamond",
    }

end

function unilib.pkg.tool_shovel_diamond.exec()

    unilib.register_tool("unilib:tool_shovel_diamond", "default:shovel_diamond", mode, {
        -- From default:shovel_diamond
        description = S("Diamond Shovel"),
        inventory_image = "unilib_tool_shovel_diamond.png",
        groups = {shovel = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 4},
            full_punch_interval = 1.0,
            groupcaps = {
                crumbly = {times = {[1] = 1.10, [2] = 0.50, [3] = 0.30}, uses = 30, maxlevel = 3},
            },
            max_drop_level = 1,
        },
        wield_image = "unilib_tool_shovel_diamond.png^[transformR90",

        after_use = unilib.tool_after_use,
    })
    unilib.register_craft_shovel({
        -- From default:shovel_diamond
        part_name = "diamond",
        ingredient = "unilib:mineral_diamond_gem",
    })
    unilib.apply_toolranks("unilib:tool_shovel_diamond", "shovel")

end
