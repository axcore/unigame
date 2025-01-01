---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_cactus_purple = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_cactus_purple.init()

    return {
        description = "Purple cactus",
        notes = "As with an ordinary cactus, a single node placed as a decoration will grow" ..
                " additional nodes (in an upwards direction); but unlike an ordinary cactus," ..
                " this cactus has no seedling and is not placed in the world as a schematic" ..
                " with arms",
    }

end

function unilib.pkg.plant_cactus_purple.exec()

    unilib.register_node("unilib:plant_cactus_purple", "lib_ecology:plant_cactus_02", mode, {
        -- From GLEMr4, lib_ecology:plant_cactus_02
        description = S("Purple Cactus"),
        tiles = {
            "unilib_plant_cactus_purple_top.png",
            "unilib_plant_cactus_purple_top.png",
            "unilib_plant_cactus_purple_side.png",
        },
        -- N.B. groups changed to match those of unilib:plant_cactus_ordinary
--      groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1, tree = 1},
        groups = {cactus_grow = 1, choppy = 3},
        sounds = unilib.global.sound_table.wood,

        -- N.B. removed is_ground_content = false to match other plants
--      is_ground_content = false,
        paramtype = "light",
        paramtype2 = "facedir",
        use_texture_alpha = "clip",
        walkable = true,

        on_place = core.rotate_node,
    })
    unilib.register_craft({
        -- Original to unilib
        type = "fuel",
        recipe = "unilib:plant_cactus_purple",
        burntime = 15,
    })
    -- (not compatible with flowerpots)

    -- Enable cactus growth with fertilisers
    unilib.fertiliser.register_special("unilib:plant_cactus_purple", unilib.flora.grow_cactus)

    -- Cactus decoration placed as a single node; the ABM in the "abm_standard_cactus_grow" package
    --      causes it to grow upwards
    unilib.register_decoration_generic("glem_plant_cactus_purple", {
        -- Original to unilib
        deco_type = "simple",
        decoration = "unilib:plant_cactus_thorny",

        height = 1,
        height_max = 3,
        noise_params = {
            octaves = 3,
            offset = -0.0004,
            persist = 0.7,
            scale = 0.0008,
            seed = 232,
            spread = {x = 200, y = 200, z = 200},
        },
        sidelen = 16,
    })

end
