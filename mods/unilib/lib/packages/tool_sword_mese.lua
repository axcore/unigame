---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_sword_mese = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_sword_mese.init()

    return {
        description = "Mese sword",
        depends = "mineral_mese",
    }

end

function unilib.pkg.tool_sword_mese.exec()

    unilib.register_tool("unilib:tool_sword_mese", "default:sword_mese", mode, {
        -- From default:sword_mese
        description = S("Mese Sword"),
        inventory_image = "unilib_tool_sword_mese.png",
        groups = {sword = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 7},
            full_punch_interval = 0.7,
            groupcaps = {
                snappy = {times = {[1] = 2.0, [2] = 1.00, [3] = 0.35}, uses = 30, maxlevel = 3},
            },
            max_drop_level = 1,
        },

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft_sword({
        -- From default:sword_mese
        part_name = "mese",
        ingredient = "unilib:mineral_mese_crystal",
    })
    unilib.tools.apply_toolranks("unilib:tool_sword_mese", "sword")

end
