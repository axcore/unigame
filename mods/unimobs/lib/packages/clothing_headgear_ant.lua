---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.clothing_headgear_ant = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clothing_headgear_ant.init()

    return {
        description = "Ant headgear",
        depends = {"organ_ant_misc", "shared_petz_clothing"},
    }

end

function unilib.pkg.clothing_headgear_ant.exec()

    unilib.register_armour("unilib:clothing_headgear_ant", "petz:ant_helmet", mode, {
        -- From petz:ant_helmet
        description = S("Ant Headgear"),
        inventory_image = "unilib_clothing_headgear_ant_inv.png",
        groups = {armour_head = 1, armour_use = 250, flammable = 0},

        armour_groups = {fleshy = 7, radiation = 10},
        damage_groups = {choppy = 3, cracky = 3, crumbly = 3, level = 1, snappy = 3},
        preview = "unilib_clothing_headgear_ant_preview.png",
        reciprocate_damage = true,
        texture = "unilib_clothing_headgear_ant.png",

        on_destroy = function(player, index, stack)
            unilib.pkg.shared_petz_clothing.destroy_callback(player)
        end,
    })
    unilib.register_craft({
        -- From petz:ant_helmet
        type = "shaped",
        output = "unilib:clothing_headgear_ant",
        recipe = {
            {"unilib:organ_ant_head", "unilib:organ_ant_head", "unilib:organ_ant_head"},
            {"unilib:organ_ant_head", "", "unilib:organ_ant_head"},
            {"", "", ""},
        },
    })

end
