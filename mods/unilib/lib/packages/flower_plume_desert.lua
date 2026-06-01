---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_plume_desert = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_plume_desert.init()

    return {
        description = "Desert plume",
    }

end

function unilib.pkg.flower_plume_desert.exec()

    local full_name = "unilib:flower_plume_desert"
    local orig_name = "elysflowers:desert_plume"
    local img = "unilib_flower_plume_desert.png"

    unilib.register_node(full_name, orig_name, mode, {
        -- From elysflowers:desert_plume
        description = unilib.utils.annotate(S("Desert Plume"), "Stanleya pinnata"),
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
        selection_box = {-0.35, -0.4, -0.35, 0.25, 0.40, 0.35},
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = img,
    })
    unilib.register_flower_in_pot(full_name, orig_name)

    unilib.register_decoration_generic("elysflowers_flower_plume_desert", {
        -- From elysflowers/init.lua
        deco_type = "simple",
        decoration = full_name,

        noise_params = {
            lacunarity = 0.056,
            octaves = 8,
            offset = 0.000097812,
            persist = 0.92,
            scale = 0.000244716,
            seed = math.random(),
            spread = {x = 32, y = 4, z = 32},
        },
        rotation = "random",
        sidelen = 16,
    })

end
