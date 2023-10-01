---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_axe_diamond = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_axe_diamond.init()

    return {
        description = "Diamond axe",
        depends = "mineral_diamond",
    }

end

function unilib.pkg.tool_axe_diamond.exec()

    unilib.register_tool("unilib:tool_axe_diamond", "default:axe_diamond", mode, {
        -- From default:axe_diamond
        description = S("Diamond Axe"),
        inventory_image = "unilib_tool_axe_diamond.png",
        groups = {axe = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 7},
            full_punch_interval = 0.9,
            groupcaps = {
                choppy = {times = {[1] = 2.10, [2] = 0.90, [3] = 0.50}, uses = 30, maxlevel = 3},
            },
            max_drop_level = 1,
        },

        after_use = unilib.tool_after_use,
    })
    unilib.register_craft_axe({
        -- From default:axe_diamond
        part_name = "diamond",
        ingredient = "unilib:mineral_diamond_gem",
    })
    unilib.apply_toolranks("unilib:tool_axe_diamond", "axe")

end
