---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.clothing_coat_silk = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clothing_coat_silk.init()

    return {
        description = "Silk dress coat",
        depends = {"component_bobbin_silk", "dye_basic", "shared_petz_clothing"},
    }

end

function unilib.pkg.clothing_coat_silk.exec()

    local c_bobbin = "unilib:component_bobbin_silk"

    unilib.register_armour("unilib:clothing_coat_silk", "petz:silk_dress_coat", mode, {
        -- From petz:silk_dress_coat
        description = S("Silk Dress Coat"),
        inventory_image = "unilib_clothing_coat_silk_inv.png",
        groups = {armour_torso = 1, armour_use = 500, flammable = 0},

        armour_groups = {fleshy = 10, radiation = 10},
        damage_groups = {choppy = 3, cracky = 3, crumbly = 3, level = 1, snappy = 3},
        preview = "unilib_clothing_coat_silk_preview.png",
        reciprocate_damage = true,
        texture = "unilib_clothing_coat_silk.png",

        on_destroy = function(player, index, stack)
            unilib.pkg.shared_petz_clothing.destroy_callback(player)
        end,
    })
    unilib.register_craft({
        -- From petz:silk_dress_coat
        type = "shaped",
        output = "unilib:clothing_coat_silk",
        recipe = {
            {c_bobbin, "unilib:dye_red", c_bobbin},
            {c_bobbin, c_bobbin, c_bobbin},
            {c_bobbin, c_bobbin, c_bobbin},
        },
    })

end
