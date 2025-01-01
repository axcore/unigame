---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_pick_mese = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_pick_mese.init()

    return {
        description = "Mese pickaxe",
        depends = "mineral_mese",
    }

end

function unilib.pkg.tool_pick_mese.exec()

    unilib.register_tool("unilib:tool_pick_mese", "default:pick_mese", mode, {
        -- From default:pick_mese
        description = S("Mese Pickaxe"),
        inventory_image = "unilib_tool_pick_mese.png",
        groups = {pickaxe = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 5},
            full_punch_interval = 0.9,
            groupcaps = {
                cracky = {times = {[1] = 2.4, [2] = 1.2, [3] = 0.60}, uses = 20, maxlevel = 3},
            },
            max_drop_level = 3,
        },

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft_pick({
        -- From default:pick_mese
        part_name = "mese",
        ingredient = "unilib:mineral_mese_crystal",
    })
    unilib.tools.apply_toolranks("unilib:tool_pick_mese", "pickaxe")

end
