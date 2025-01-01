---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_sword_diamond = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_sword_diamond.init()

    return {
        description = "Diamond sword",
        depends = "mineral_diamond",
    }

end

function unilib.pkg.tool_sword_diamond.exec()

    unilib.register_tool("unilib:tool_sword_diamond", "default:sword_diamond", mode, {
        -- From default:sword_diamond
        description = S("Diamond Sword"),
        inventory_image = "unilib_tool_sword_diamond.png",
        groups = {sword = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 8},
            full_punch_interval = 0.7,
            groupcaps = {
                snappy = {times = {[1] = 1.90, [2] = 0.90, [3] = 0.30}, uses = 40, maxlevel = 3},
            },
            max_drop_level = 1,
        },

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft_sword({
        -- From default:sword_diamond
        part_name = "diamond",
        ingredient = "unilib:mineral_diamond_gem",
    })
    unilib.tools.apply_toolranks("unilib:tool_sword_diamond", "sword")

end
