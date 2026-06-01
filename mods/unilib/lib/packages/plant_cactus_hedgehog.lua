---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_cactus_hedgehog = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_cactus_hedgehog.init()

    return {
        description = "Hedgehog cactus",
    }

end

function unilib.pkg.plant_cactus_hedgehog.exec()

    local full_name = "unilib:plant_cactus_hedgehog"
    local orig_name = "elysflowers:hedgehog_cactus"
    local img = "unilib_plant_cactus_hedgehog.png"

    unilib.register_node(full_name, orig_name, mode, {
        -- From elysflowers:hedgehog_cactus
        description = unilib.utils.annotate(S("Hedgehog Cactus"), "Echinocereus englemannii"),
        tiles = {img},
        -- N.B. Used groups based on the "plant_shrub_dry" package, rather than the extended set in
        --      original code
        groups = {attached_node = 1, flammable = 3, flora = 1, snappy = 3},
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
    unilib.register_plant_in_pot(full_name, orig_name)

    unilib.register_decoration_generic("elysflowers_plant_cactus_hedgehog", {
        -- From elysflowers/init.lua
        deco_type = "simple",
        decoration = full_name,

        noise_params = {
            lacunarity = 1.33,
            octaves = 4,
            offset = 0.0008024291,
            persist = 0.209,
            scale = 0.00002210311,
            seed = math.random(),
            spread = {x = 16, y = 8, z = 16},
        },
        rotation = "random",
        sidelen = 16,
    })

end
