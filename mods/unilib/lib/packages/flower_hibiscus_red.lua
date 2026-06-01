---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_hibiscus_red = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_hibiscus_red.init()

    return {
        description = "Red hibiscus",
    }

end

function unilib.pkg.flower_hibiscus_red.exec()

    local full_name = "unilib:flower_hibiscus_red"
    local orig_name = "elysflowers:hibiscus"
    local img = "unilib_flower_hibiscus_red.png"

    unilib.register_node(full_name, orig_name, mode, {
        -- From elysflowers:hibiscus
        description = unilib.utils.annotate(S("Red Hibiscus"), "Hibiscus aponeurus"),
        tiles = {img},
        -- N.B. Used standard unilib flower groups, rather than the extended set in original code
        groups = {
            attached_node = 1, color_pink = 1, colour_pink = 1, flammable = 1, flora = 1,
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

    unilib.register_decoration_generic("elysflowers_flower_hibiscus_red", {
        -- From elysflowers/init.lua
        deco_type = "simple",
        decoration = full_name,

        noise_params = {
            octaves = 2,
            offset = -0.00629,
            persist = 0.5,
            scale = 0.01412,
            seed = 2983671,
            spread = {x = 32, y = 32, z = 32},
        },
        rotation = "random",
        sidelen = 16,
    })

end
