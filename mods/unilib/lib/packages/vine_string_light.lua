---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.vine_string_light = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.vine_string_light.init()

    return {
        description = "Light string vine",
        depends = {"flower_fire", "vine_normal"},
    }

end

function unilib.pkg.vine_string_light.exec()

    unilib.register_node("unilib:vine_string_light", "ethereal:lightstring", mode, {
        -- From ethereal:lightstring
        description = S("Light String Vine"),
        tiles = {"unilib_vine_string_light.png"},
        groups = {choppy = 3, flammable = 2, oddly_breakable_by_hand = 1},
        sounds = unilib.sound_table.leaves,

        climbable = true,
        drawtype = "signlike",
        inventory_image = "unilib_vine_string_light.png",
        is_ground_content = false,
        light_source = 10,
        paramtype = "light",
        paramtype2 = "wallmounted",
        selection_box = {
            type = "wallmounted"
        },
        walkable = false,
        wield_image = "unilib_vine_string_light.png",
    })
    unilib.register_craft({
        -- From ethereal:lightstring
        output = "unilib:vine_string_light 8",
        recipe = {
            {"unilib:vine_normal", "unilib:vine_normal", "unilib:vine_normal"},
            {"unilib:vine_normal", "unilib:flower_fire_dust", "unilib:vine_normal"},
            {"unilib:vine_normal", "unilib:vine_normal", "unilib:vine_normal"},
        }
    })

end
