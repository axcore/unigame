---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_poppy_california = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_poppy_california.init()

    return {
        description = "California poppy",
    }

end

function unilib.pkg.flower_poppy_california.exec()

    local full_name = "unilib:flower_poppy_california"
    local orig_name = "elysflowers:california_poppy"
    local img = "unilib_flower_poppy_california.png"

    unilib.register_node(full_name, orig_name, mode, {
        -- From elysflowers:california_poppy
        description = unilib.utils.annotate(S("California Poppy"), "Eschscholzia californica"),
        tiles = {img},
        -- N.B. Used standard unilib flower groups, rather than the extended set in original code
        groups = {
            attached_node = 1, color_white = 1, colour_white = 1, flammable = 1, flora = 1,
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

    unilib.register_decoration_generic("elysflowers_flower_poppy_california", {
        -- From elysflowers/init.lua
        deco_type = "simple",
        decoration = full_name,

        noise_params = {
            flags = {"absvalue, eased"},
            octaves = 1,
            offset = -0.7,
            persist = 0.0,
            scale = 0.9,
            seed = math.random(),
            spread = {x = 32, y = 64, z = 32},
        },
        rotation = "random",
        sidelen = 16,
    })

end
