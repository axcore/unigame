---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.door_ice = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_ice.init()

    return {
        description = "Ice door",
        depends = "ice_ordinary",
    }

end

function unilib.pkg.door_ice.exec()

    unilib.register_door({
        -- From mtg_plus mod, doors:door_ice. Creates unilib:door_ice
        part_name = "ice",
        orig_name = {
            "doors:door_ice_a",
            "doors:door_ice_b",
            "doors:door_ice_c",
            "doors:door_ice_d",
        },
        def_table = {
            description = S("Ice Door"),
            tiles = {{name = "unilib_door_ice.png", backface_culling = true}},
            groups = {cracky = 3, slippery = 3},
            sounds = unilib.sound_table.glass,

            inventory_image = "unilib_door_ice_inv.png",
            recipe = {
                {"unilib:ice_ordinary", "unilib:ice_ordinary"},
                {"unilib:ice_ordinary", "unilib:ice_ordinary"},
                {"unilib:ice_ordinary", "unilib:ice_ordinary"},
            },
            sound_close = "unilib_ice_door_close",
            sound_open = "unilib_ice_door_open",
        },

        replace_mode = mode,
        orig_craftitem_name = "doors:door_wood_bar",
    })

end
