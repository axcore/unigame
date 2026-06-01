---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_trillium_western = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_trillium_western.init()

    return {
        description = "Western trillium",
    }

end

function unilib.pkg.flower_trillium_western.exec()

    local full_name = "unilib:flower_trillium_western"
    local orig_name = "elysflowers:western_trilium"
    local img = "unilib_flower_trillium_western.png"

    unilib.register_node(full_name, orig_name, mode, {
        -- From elysflowers:western_trilium
        description = unilib.utils.annotate(S("Western Trillium"), "Trillium ovatum"),
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
        selection_box = {-0.35, -0.4, -0.35, 0.35, 0.40, 0.35},
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = img,
    })
    unilib.register_flower_in_pot(full_name, orig_name)

    unilib.register_decoration_generic("elysflowers_flower_trillium_western", {
        -- From elysflowers/init.lua
        deco_type = "simple",
        decoration = full_name,

        noise_params = {
            lacunarity = 1.4,
            octaves = 2,
            offset = 0.00052091,
            persist = 0.9,
            scale = 0.00091310,
            seed = math.random(),
            spread = {x = 16, y = 16, z = 16},
        },
        rotation = "random",
        sidelen = 16,
    })

end
