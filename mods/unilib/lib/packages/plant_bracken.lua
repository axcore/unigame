---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_bracken = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_bracken.init()

    return {
        description = "Bracken",
    }

end

function unilib.pkg.plant_bracken.exec()

    unilib.register_node("unilib:plant_bracken", "aotearoa:bracken", mode, {
        -- From aotearoa:bracken
        description = unilib.utils.annotate(S("Bracken"), "Pteridium esculentum"),
        tiles = {"unilib_plant_bracken.png"},
        groups = {attached_node = 1, dry_grass = 1, flammable = 1, flora = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "firelike",
        inventory_image = "unilib_plant_bracken.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.4, -0.5, -0.4, 0.4, -0.2, 0.4},
        },
        sunlight_propagates = true,
        visual_scale = 1,
        walkable = false,
        waving = 1,
        wield_image = "unilib_plant_bracken.png",
    })
    unilib.register_craft({
        -- From aotearoa:bracken
        type = "fuel",
        recipe = "unilib:plant_bracken",
        burntime = 1,
    })
    -- (not compatible with flowerpots)

    unilib.register_decoration_generic("aotearoa_plant_bracken_sparse", {
        -- From aotearoa/spawn_plants.lua
        deco_type = "simple",
        decoration = "unilib:plant_bracken",

        fill_ratio = 0.002,
        sidelen = 16,
    })
    unilib.register_decoration_generic("aotearoa_plant_bracken_clumped", {
        -- From aotearoa/spawn_plants.lua
        deco_type = "simple",
        decoration = "unilib:plant_bracken",

        noise_params = {
            octaves = 2,
            offset = 0,
            persist = 0.7,
            scale = 0.095,
            seed = 557864,
            spread = {x = 6, y = 6, z = 6},
        },
        sidelen = 16,
    })
    unilib.register_decoration_generic("aotearoa_plant_bracken_dense", {
        -- From aotearoa/spawn_plants.lua
        deco_type = "simple",
        decoration = "unilib:plant_bracken",

        fill_ratio = 0.1,
        sidelen = 16,
    })

end
