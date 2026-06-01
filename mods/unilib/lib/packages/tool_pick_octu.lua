---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    octu
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.tool_pick_octu = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.octu.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tool_pick_octu.init()

    return {
        description = "Octu pickaxe",
        depends = "mineral_octu",
    }

end

function unilib.pkg.tool_pick_octu.exec()

    unilib.register_tool("unilib:tool_pick_octu", "gemtools:pick_octu", mode, {
        -- From gemtools:pick_octu
        description = S("Octu Pickaxe"),
        inventory_image = "unilib_tool_pick_octu.png",
        groups = {pickaxe = 1},
        sound = {breaks = "unilib_tool_breaks"},

        tool_capabilities = {
            damage_groups = {fleshy = 5},
            full_punch_interval = 0.9,
            groupcaps = {
                cracky = {times = {[1] = 2.0, [2] = 1.0, [3] = 0.5}, uses = 60, maxlevel = 3},
            },
            max_drop_level = 3,
        },

        after_use = unilib.tools.after_use,
    })
    unilib.register_craft_pick({
        -- From gemtools:pick_octu
        part_name = "octu",
        ingredient = "unilib:mineral_octu_crystal",
    })
    unilib.tools.apply_toolranks("unilib:tool_pick_octu", "pickaxe")

end
