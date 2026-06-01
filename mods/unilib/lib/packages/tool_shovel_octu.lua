---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    octu
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_shovel_octu = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.octu.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_shovel_octu.init()

    return {
        description = "Octu shovel",
        depends = "mineral_octu",
    }

end

function unilib.pkg.tool_shovel_octu.exec()

    unilib.register_tool("unilib:tool_shovel_octu", "gemtools:shovel_octu", mode, {
        -- From gemtools:shovel_octu
        description = S("Octu Shovel"),
        inventory_image = "unilib_tool_shovel_octu.png",
        groups = {shovel = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 4},
            full_punch_interval = 1.0,
            groupcaps = {
                crumbly = {times = {[1] = 1.0, [2] = 1.0, [3] = 1.0}, uses = 60, maxlevel = 2},
            },
            max_drop_level = 1,
        },
        -- N.B. no transform in original code
        wield_image = "unilib_tool_shovel_octu.png^[transformR90",

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft_shovel({
        -- From gemtools:shovel_octu
        part_name = "octu",
        ingredient = "unilib:mineral_octu_crystal",
    })
    unilib.tools.apply_toolranks("unilib:tool_shovel_octu", "shovel")

end
