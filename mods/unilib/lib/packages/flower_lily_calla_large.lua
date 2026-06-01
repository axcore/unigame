---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_lily_calla_large = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_lily_calla_large.init()

    return {
        description = "Large calla lily",
    }

end

function unilib.pkg.flower_lily_calla_large.exec()

    local full_name = "unilib:flower_lily_calla_large"
    local orig_name = "elysflowers:calla_lily"
    local img = "unilib_flower_lily_calla_large.png"

    unilib.register_node(full_name, orig_name, mode, {
        -- From elysflowers:calla_lily
        description = unilib.utils.annotate(S("Large Calla Lily"), "Calla palustris"),
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
        selection_box = {-0.35, -0.4, -0.35, 0.25, 0.40, 0.35},
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = img,
    })
    -- N.B. Not compatible with flowerpots, even in original code

    unilib.register_decoration_generic("elysflowers_flower_lily_calla_large", {
        -- From elysflowers/init.lua
        deco_type = "simple",
        decoration = full_name,

        noise_params = {
            lacunarity = 0.081,
            octaves = 6,
            offset = 0.00042071,
            persist = 0.491,
            scale = 0.00059122,
            seed = math.random(),
            spread = {x = 7, y = 12, z = 7},
        },
        rotation = "random",
        sidelen = 16,
    })

end
