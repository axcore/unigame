---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bakedclay
-- Code:    MIT
-- Media:   CC
---------------------------------------------------------------------------------------------------

unilib.pkg.grass_reed_mannagrass = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bakedclay.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.grass_reed_mannagrass.init()

    return {
        description = "Reed mannagrass",
    }

end

function unilib.pkg.grass_reed_mannagrass.exec()

    local img = "unilib_grass_reed_mannagrass.png"

    unilib.register_node("unilib:grass_reed_mannagrass", "bakedclay:mannagrass", mode, {
        -- From bakedclay:mannagrass
        description = unilib.utils.annotate(S("Reed Mannagrass"), "Glyceria maxima"),
        tiles = {img},
        -- N.B. Replaced flower = 1 from original code with grass = 1
        groups = {
            attached_node = 1, color_green_dark = 1, colour_green_dark = 1, flora = 1, grass = 1,
            snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = img,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.15, -0.5, -0.15, 0.15, 0.2, 0.15},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = img,
    })

    unilib.register_decoration_generic("bakedclay_grass_reed_mannagrass", {
        -- From bakedclay:mannagrass
        deco_type = "simple",
        decoration = "unilib:grass_reed_mannagrass",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.009,
            seed = 7136,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

end
