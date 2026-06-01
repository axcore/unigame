---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_foxglove = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_foxglove.init()

    return {
        description = "Foxglove",
    }

end

function unilib.pkg.flower_foxglove.exec()

    local full_name = "unilib:flower_foxglove"
    local orig_name = "elysflowers:foxglove"
    local img = "unilib_flower_foxglove.png"

    unilib.register_node(full_name, orig_name, mode, {
        -- From elysflowers:foxglove
        description = unilib.utils.annotate(S("Foxglove"), "Digitalis purpurea"),
        tiles = {img},
        -- N.B. Used standard unilib flower groups, rather than the extended set in original code
        groups = {
            attached_node = 1, color_grey = 1, colour_grey = 1, flammable = 1, flora = 1,
            flower = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        floodable = true,
        inventory_image = img,
        paramtype = "light",
        selection_box = {-0.25, -0.49, -0.25, 0.25, 0.50, 0.25},
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = img,
    })
    unilib.register_flower_in_pot(full_name, orig_name)

    unilib.register_decoration_generic("elysflowers_flower_foxglove", {
        -- From elysflowers/init.lua
        deco_type = "simple",
        decoration = full_name,

        noise_params = {
            octaves = 3,
            offset = -0.003123,
            persist = 0.4,
            scale = 0.00414,
            seed = 881933,
            spread = {x = 32, y = 32, z = 64},
        },
        rotation = "random",
        sidelen = 8,
    })

end
