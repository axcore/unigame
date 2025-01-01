---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_sword_wood = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_sword_wood.init()

    return {
        description = "Wooden sword",
    }

end

function unilib.pkg.tool_sword_wood.exec()

    unilib.register_tool("unilib:tool_sword_wood", "default:sword_wood", mode, {
        -- From default:sword_wood
        description = S("Wooden Sword"),
        inventory_image = "unilib_tool_sword_wood.png",
        groups = {flammable = 2, sword = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 2},
            full_punch_interval = 1,
            groupcaps = {
                snappy = {times = {[2] = 1.6, [3] = 0.40}, uses = 10, maxlevel = 1},
            },
            max_drop_level = 0,
        },

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft_sword({
        -- From default:sword_wood
        part_name = "wood",
        ingredient = "group:wood",
    })
    unilib.register_craft({
        -- From default:sword_wood
        type = "fuel",
        recipe = "unilib:tool_sword_wood",
        burntime = 5,
    })
    unilib.tools.apply_toolranks("unilib:tool_sword_wood", "sword")

end
