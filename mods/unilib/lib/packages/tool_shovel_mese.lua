---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_shovel_mese = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_shovel_mese.init()

    return {
        description = "Mese shovel",
        depends = "mineral_mese",
    }

end

function unilib.pkg.tool_shovel_mese.exec()

    unilib.register_tool("unilib:tool_shovel_mese", "default:shovel_mese", mode, {
        -- From default:shovel_mese
        description = S("Mese Shovel"),
        inventory_image = "unilib_tool_shovel_mese.png",
        groups = {shovel = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 4},
            full_punch_interval = 1.0,
            groupcaps = {
                crumbly = {times = {[1] = 1.20, [2] = 0.60, [3] = 0.30}, uses = 20, maxlevel = 3},
            },
            max_drop_level = 3,
        },
        wield_image = "unilib_tool_shovel_mese.png^[transformR90",

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft_shovel({
        -- From default:shovel_mese
        part_name = "mese",
        ingredient = "unilib:mineral_mese_crystal",
    })
    unilib.tools.apply_toolranks("unilib:tool_shovel_mese", "shovel")

end
