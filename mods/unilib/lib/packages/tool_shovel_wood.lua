---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_shovel_wood = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_shovel_wood.init()

    return {
        description = "Wooden shovel",
    }

end

function unilib.pkg.tool_shovel_wood.exec()

    unilib.register_tool("unilib:tool_shovel_wood", "default:shovel_wood", mode, {
        -- From default:shovel_wood
        description = S("Wooden Shovel"),
        inventory_image = "unilib_tool_shovel_wood.png",
        groups = {flammable = 2, shovel = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 2},
            full_punch_interval = 1.2,
            groupcaps = {
                crumbly = {times = {[1] = 3.00, [2] = 1.60, [3] = 0.60}, uses = 10, maxlevel = 1},
            },
            max_drop_level = 0,
        },
        wield_image = "unilib_tool_shovel_wood.png^[transformR90",

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft_shovel({
        -- From default:shovel_wood
        part_name = "wood",
        ingredient = "group:wood",
    })
    unilib.register_craft({
        -- From default:shovel_wood
        type = "fuel",
        recipe = "unilib:tool_shovel_wood",
        burntime = 4,
    })
    unilib.tools.apply_toolranks("unilib:tool_shovel_wood", "shovel")

end
