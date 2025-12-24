---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.clothing_coat_wolf = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clothing_coat_wolf.init()

    return {
        description = "Wolf coat",
        depends = {"organ_fur_wolf", "shared_petz_clothing", "wool_basic"},
        suggested = {
            "organ_leather_normal",             -- group:leather
        },
    }

end

function unilib.pkg.clothing_coat_wolf.exec()

    unilib.register_armour("unilib:clothing_coat_wolf", "petz:prince_north_coat", mode, {
        -- From petz:prince_north_coat
        description = S("Wolf Coat"),
        inventory_image = "unilib_clothing_coat_wolf_inv.png",
        groups = {armour_torso = 1, armour_use = 350, flammable = 0},

        armour_groups = {fleshy = 10, radiation = 10},
        damage_groups = {choppy = 3, cracky = 3, crumbly = 3, level = 1, snappy = 3},
        preview = "unilib_clothing_coat_wolf_preview.png",
        reciprocate_damage = true,
        texture = "unilib_clothing_coat_wolf.png",

        on_destroy = function(player, index, stack)
            unilib.pkg.shared_petz_clothing.destroy_callback(player)
        end,
    })
    unilib.register_craft({
        -- From petz:prince_north_coat
        type = "shaped",
        output = "unilib:clothing_coat_wolf",
        recipe = {
            {"", "unilib:organ_fur_wolf", ""},
            {"", "unilib:wool_blue", ""},
            {"group:leather", "unilib:wool_blue", "group:leather"},
        },
    })

end
