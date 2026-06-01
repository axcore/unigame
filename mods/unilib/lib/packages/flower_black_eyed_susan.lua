---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_black_eyed_susan = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_black_eyed_susan.init()

    return {
        description = "Black-Eyed Susan",
    }

end

function unilib.pkg.flower_black_eyed_susan.exec()

    local full_name = "unilib:flower_black_eyed_susan"
    local orig_name = "elysflowers:black_eyed_susan"
    local img = "unilib_flower_black_eyed_susan.png"

    unilib.register_node(full_name, orig_name, mode, {
        -- From elysflowers:black_eyed_susan
        description = unilib.utils.annotate(S("Black-Eyed Susan"), "Rudbeckia hirta"),
        tiles = {img},
        -- N.B. Used standard unilib flower groups, rather than the extended set in original code
        groups = {
            attached_node = 1, color_yellow = 1, colour_yellow = 1, flammable = 1, flora = 1,
            flower = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        floodable = true,
        inventory_image = img,
        paramtype = "light",
        selection_box = {-0.35, -0.5, -0.35, 0.35, 0.40, 0.35},
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = img,
    })
    unilib.register_flower_in_pot(full_name, orig_name)

    unilib.register_decoration_generic("elysflowers_flower_black_eyed_susan", {
        -- From elysflowers/init.lua
        deco_type = "simple",
        decoration = full_name,

        noise_params = {
            octaves = 3,
            offset = 0.00052,
            persist = 0.4,
            scale = 0.0019,
            seed = 91138,
            spread = {x = 32, y = 32, z = 32},
        },
        rotation = "random",
        sidelen = 16,
    })

end
