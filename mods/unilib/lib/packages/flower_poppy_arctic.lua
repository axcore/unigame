---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_poppy_arctic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_poppy_arctic.init()

    return {
        description = "Arctic poppy",
    }

end

function unilib.pkg.flower_poppy_arctic.exec()

    local full_name = "unilib:flower_poppy_arctic"
    local orig_name = "elysflowers:arctic_poppy"
    local img = "unilib_flower_poppy_arctic.png"

    unilib.register_node(full_name, orig_name, mode, {
        -- From elysflowers:arctic_poppy
        -- N.B. Botanical name was Papaver radicatum before 2021
        description = unilib.utils.annotate(S("Arctic Poppy"), "Oreomecon radicata"),
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
        selection_box = {-0.45, -0.5, -0.35, 0.35, 0.45, 0.35},
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = img,
    })
    -- N.B. Not compatible with flowerpots, even in original code

    unilib.register_decoration_generic("elysflowers_flower_poppy_arctic", {
        -- From elysflowers/init.lua
        deco_type = "simple",
        decoration = full_name,

        noise_params = {
            octaves = 2,
            offset = 0.00021945,
            persist = 0.6,
            scale = 0.0000798134,
            seed = math.random(),
            spread = {x = 14, y = 32, z = 14},
        },
        rotation = "random",
        sidelen = 16,
    })

end
