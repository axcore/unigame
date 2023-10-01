---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_axe_mese = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_axe_mese.init()

    return {
        description = "Mese axe",
        depends = "mineral_mese",
    }

end

function unilib.pkg.tool_axe_mese.exec()

    unilib.register_tool("unilib:tool_axe_mese", "default:axe_mese", mode, {
        -- From default:axe_mese
        description = S("Mese Axe"),
        inventory_image = "unilib_tool_axe_mese.png",
        groups = {axe = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 6},
            full_punch_interval = 0.9,
            groupcaps = {
                choppy = {times = {[1] = 2.20, [2] = 1.00, [3] = 0.60}, uses = 20, maxlevel = 3},
            },
            max_drop_level = 1,
        },

        after_use = unilib.tool_after_use,
    })
    unilib.register_craft_axe({
        -- From default:axe_mese
        part_name = "mese",
        ingredient = "unilib:mineral_mese_crystal",
    })
    unilib.apply_toolranks("unilib:tool_axe_mese", "axe")

end
