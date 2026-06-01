---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    octu
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_sword_octu = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.octu.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_sword_octu.init()

    return {
        description = "Octu sword",
        depends = "mineral_octu",
    }

end

function unilib.pkg.tool_sword_octu.exec()

    unilib.register_tool("unilib:tool_sword_octu", "gemtools:sword_octu", mode, {
        -- From gemtools:sword_octu
        description = S("Octu Sword"),
        inventory_image = "unilib_tool_sword_octu.png",
        groups = {sword = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 8},
            full_punch_interval = 0.7,
            groupcaps = {
                -- N.B. fleshy in the original code; this seems to be an error
                snappy = {times = {[1] = 2.00, [2] = 0.80, [3] = 0.40}, uses = 10, maxlevel = 2},
            },
            max_drop_level = 1,
        },

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft_sword({
        -- From gemtools:sword_octu
        part_name = "octu",
        ingredient = "unilib:mineral_octu_crystal",
    })
    unilib.tools.apply_toolranks("unilib:tool_sword_octu", "sword")

end
