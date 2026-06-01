---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_lily_glacier = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_lily_glacier.init()

    return {
        description = "Glacier lily",
    }

end

function unilib.pkg.flower_lily_glacier.exec()

    local full_name = "unilib:flower_lily_glacier"
    local orig_name = "elysflowers:glacier_lilly"
    local img = "unilib_flower_lily_glacier.png"

    unilib.register_node(full_name, orig_name, mode, {
        -- From elysflowers:glacier_lilly
        description = unilib.utils.annotate(S("Glacier Lily"), "Erythronium grandiflorum"),
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
        selection_box = {-0.35, -0.4, -0.35, 0.35, 0.40, 0.35},
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = img,
    })
    unilib.register_flower_in_pot(full_name, orig_name)

    unilib.register_decoration_generic("elysflowers_flower_lily_glacier", {
        -- From elysflowers/init.lua
        deco_type = "simple",
        decoration = full_name,

        noise_params = {
            flags = {"absvalue", "eased"},
            lacunarity = 1.0,
            octaves = 4,
            offset = 0.0081,
            persist = 0.9,
            scale = 0.062041,
            seed = math.random(),
            spread = {x = 8, y = 8, z = 8},
        },
        rotation = "random",
        sidelen = 16,
    })

end
