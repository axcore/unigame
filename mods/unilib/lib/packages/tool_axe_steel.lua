---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_axe_steel = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_axe_steel.init()

    return {
        description = "Steel axe",
        depends = "metal_steel",
    }

end

function unilib.pkg.tool_axe_steel.exec()

    unilib.register_tool("unilib:tool_axe_steel", "default:axe_steel", mode, {
        -- From default:axe_steel
        description = S("Steel Axe"),
        inventory_image = "unilib_tool_axe_steel.png",
        groups = {axe = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 4},
            full_punch_interval = 1.0,
            groupcaps = {
                choppy = {times = {[1] = 2.50, [2] = 1.40, [3] = 1.00}, uses = 20, maxlevel = 2},
            },
            max_drop_level = 1,
        },

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft_axe({
        -- From default:axe_steel
        part_name = "steel",
        ingredient = "unilib:metal_steel_ingot",
    })
    unilib.tools.apply_toolranks("unilib:tool_axe_steel", "axe")

end
