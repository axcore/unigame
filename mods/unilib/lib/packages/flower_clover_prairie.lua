---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_clover_prairie = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_clover_prairie.init()

    return {
        description = "Prairie clover",
    }

end

function unilib.pkg.flower_clover_prairie.exec()

    local full_name = "unilib:flower_clover_prairie"
    local orig_name = "elysflowers:prairie_clover"
    local img = "unilib_flower_clover_prairie.png"

    unilib.register_node(full_name, orig_name, mode, {
        -- From elysflowers:prairie_clover
        description = unilib.utils.annotate(S("Prairie Clover"), "Dalea purpurea"),
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
        selection_box = {-0.35, -0.4, -0.35, 0.25, 0.40, 0.35},
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = img,
    })
    unilib.register_flower_in_pot(full_name, orig_name)

    unilib.register_decoration_generic("elysflowers_flower_clover_prairie", {
        -- From elysflowers/init.lua
        deco_type = "simple",
        decoration = full_name,

        noise_params = {
            lacunarity = 0.062,
            octaves = 4,
            offset = 0.000178129,
            persist = 0.7,
            scale = 0.00084902,
            seed = math.random(),
            spread = {x = 24, y = 12, z = 24},
        },
        rotation = "random",
        sidelen = 16,
    })

end
