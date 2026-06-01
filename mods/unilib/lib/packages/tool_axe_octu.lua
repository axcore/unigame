---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    octu
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_axe_octu = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.octu.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_axe_octu.init()

    return {
        description = "Octu axe",
        depends = "mineral_octu",
    }

end

function unilib.pkg.tool_axe_octu.exec()

    unilib.register_tool("unilib:tool_axe_octu", "gemtools:axe_octu", mode, {
        -- From gemtools:axe_octu
        description = S("Octu Axe"),
        inventory_image = "unilib_tool_axe_octu.png",
        groups = {axe = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 7},
            full_punch_interval = 0.9,
            groupcaps = {
                choppy = {times = {[1] = 3.00, [2] = 1.60, [3] = 1.00}, uses = 60, maxlevel = 2},
            },
            max_drop_level = 1,
        },

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft_axe({
        -- From gemtools:axe_octu
        part_name = "octu",
        ingredient = "unilib:mineral_octu_crystal",
    })
    unilib.tools.apply_toolranks("unilib:tool_axe_octu", "axe")

end
