---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_yarrow_pink = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_yarrow_pink.init()

    return {
        description = "Pink yarrow",
    }

end

function unilib.pkg.flower_yarrow_pink.exec()

    local full_name = "unilib:flower_yarrow_pink"
    local orig_name = "elysflowers:yarrow_pink"
    local img = "unilib_flower_yarrow_pink.png"

    unilib.register_node(full_name, orig_name, mode, {
        -- From elysflowers:yarrow_pink
        description = unilib.utils.annotate(S("Pink Yarrow"), "Achillea millefolium"),
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

    unilib.register_decoration_generic("elysflowers_flower_yarrow_pink", {
        -- From elysflowers/init.lua
        deco_type = "simple",
        decoration = full_name,

        noise_params = {
            octaves = 1,
            offset = 0.00021,
            persist = 0.4,
            scale = 0.000019,
            seed = math.random(),
            spread = {x = 8, y = 8, z = 8},
        },
        rotation = "random",
        sidelen = 16,
    })

end
