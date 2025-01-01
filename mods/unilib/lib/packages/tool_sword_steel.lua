---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_sword_steel = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_sword_steel.init()

    return {
        description = "Steel sword",
        depends = "metal_steel",
    }

end

function unilib.pkg.tool_sword_steel.exec()

    unilib.register_tool("unilib:tool_sword_steel", "default:sword_steel", mode, {
        -- From default:sword_steel
        description = S("Steel Sword"),
        inventory_image = "unilib_tool_sword_steel.png",
        groups = {sword = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 6},
            full_punch_interval = 0.8,
            groupcaps = {
                snappy = {times = {[1] = 2.5, [2] = 1.20, [3] = 0.35}, uses = 30, maxlevel = 2},
            },
            max_drop_level = 1,
        },

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft_sword({
        -- From default:sword_steel
        part_name = "steel",
        ingredient = "unilib:metal_steel_ingot",
    })
    unilib.tools.apply_toolranks("unilib:tool_sword_steel", "sword")

end
