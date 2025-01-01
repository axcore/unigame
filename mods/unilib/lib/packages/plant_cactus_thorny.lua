---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_cactus_thorny = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_cactus_thorny.init()

    return {
        description = "Thorny cactus",
        notes = "As with an ordinary cactus, a single node placed as a decoration will grow" ..
                " additional nodes (in an upwards direction); but unlike an ordinary cactus," ..
                " this cactus has no seedling and is not placed in the world as a schematic" ..
                " with arms",
    }

end

function unilib.pkg.plant_cactus_thorny.exec()

    unilib.register_node("unilib:plant_cactus_thorny", "lib_ecology:plant_cactus_03", mode, {
        -- From GLEMr4, lib_ecology:plant_cactus_03
        description = S("Thorny Cactus"),
        tiles = {"unilib_plant_cactus_thorny.png"},
        -- N.B. groups changed to match those of unilib:plant_cactus_ordinary
--      groups = {choppy = 1, oddly_breakable_by_hand = 1},
        groups = {cactus_grow = 1, choppy = 3},
        sounds = unilib.global.sound_table.wood,

        collision_box = {
            type = "fixed",
            fixed = {-0.4, -0.5, -0.4, 0.4, 0.5, 0.4},
        },
        drawtype = "mesh",
        mesh = "unilib_plant_cactus_exotic.b3d",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.4, -0.5, -0.4, 0.4, 0.5, 0.4},
        },
        use_texture_alpha = "clip",
        visual_scale = 0.5,
    })
    unilib.register_craft({
        -- Original to unilib
        type = "fuel",
        recipe = "unilib:plant_cactus_thorny",
        burntime = 15,
    })
    -- (not compatible with flowerpots)

    -- Enable cactus growth with fertilisers
    unilib.fertiliser.register_special("unilib:plant_cactus_thorny", unilib.flora.grow_cactus)

    -- Cactus decoration placed as a single node; the ABM in the "abm_standard_cactus_grow" package
    --      causes it to grow upwards
    unilib.register_decoration_generic("glem_plant_cactus_thorny", {
        -- Original to unilib
        deco_type = "simple",
        decoration = "unilib:plant_cactus_thorny",

        height = 1,
        height_max = 4,
        noise_params = {
            octaves = 3,
            offset = -0.0005,
            persist = 0.5,
            scale = 0.0007,
            seed = 231,
            spread = {x = 200, y = 200, z = 200},
        },
        sidelen = 16,
    })

end
