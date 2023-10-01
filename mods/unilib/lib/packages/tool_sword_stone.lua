---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_sword_stone = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_sword_stone.init()

    return {
        description = "Stone sword",
    }

end

function unilib.pkg.tool_sword_stone.exec()

    unilib.register_tool("unilib:tool_sword_stone", "default:sword_stone", mode, {
        -- From default:sword_stone
        description = S("Stone Sword"),
        inventory_image = "unilib_tool_sword_stone.png",
        groups = {sword = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 4},
            full_punch_interval = 1.2,
            groupcaps = {
                snappy = {times = {[2] = 1.4, [3] = 0.40}, uses = 20, maxlevel = 1},
            },
            max_drop_level = 0,
        },

        after_use = unilib.tool_after_use,
    })
    unilib.register_craft_sword({
        -- From default:sword_stone
        part_name = "stone",
        ingredient = "group:stone",
    })
    unilib.apply_toolranks("unilib:tool_sword_stone", "sword")

end
