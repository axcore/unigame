---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    snow
-- Code:    GPL 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_shrub_frozen = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.snow.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_shrub_frozen.init()

    return {
        description = "Frozen shrub",
    }

end

function unilib.pkg.plant_shrub_frozen.exec()

    unilib.register_node("unilib:plant_shrub_frozen", "snow:shrub", mode, {
        -- From snow:shrub
        description = S("Frozen Shrub"),
        tiles = {"unilib_plant_shrub_frozen.png"},
        groups = {attached_node = 1, flammable = 3, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        furnace_burntime = 5,
        inventory_image = "unilib_plant_shrub_frozen.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, -5/16, 0.3},
        },
        sunlight_propagates = true,
        waving = 1,
        walkable = false,
        wield_image = "unilib_plant_shrub_frozen.png",
    })
    unilib.register_plant_in_pot("unilib:plant_shrub_frozen", "snow:shrub")

    unilib.register_node("unilib:plant_shrub_frozen_covered", "snow:shrub_covered", mode, {
        -- From snow:shrub_covered
        description = S("Covered Frozen Shrub"),
        tiles = {"unilib_plant_shrub_frozen.png^unilib_plant_shrub_frozen_overlay.png"},
        groups = {attached_node = 1, flammable = 3, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        drop = "unilib:plant_shrub_frozen",
        furnace_burntime = 3,
        inventory_image = "unilib_plant_shrub_frozen.png^unilib_plant_shrub_frozen_overlay.png",
        paramtype = "light",
        paramtype2 = "degrotate",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, -5/16, 0.3},
        },
        sunlight_propagates = true,
        waving = 1,
        walkable = false,
        wield_image = "unilib_plant_shrub_frozen.png^unilib_plant_shrub_frozen_overlay.png",
    })
    -- (not compatible with flowerpots)

    -- N.B. Original code placed dry shrubs as decorations, rather than frozen shrubs, for no
    --      obvious reason
    unilib.register_decoration_generic("snow_plant_shrub_frozen", {
        -- From snow/mapgen_v7.lua
        deco_type = "simple",
        decoration = "unilib:plant_shrub_frozen",

        fill_ratio = 0.005,
        sidelen = 16,
    })

    unilib.register_decoration_generic("snow_plant_shrub_frozen_covered", {
        -- From snow/mapgen_v7.lua
        deco_type = "simple",
        decoration = "unilib:plant_shrub_frozen_covered",

        fill_ratio = 0.05,
        sidelen = 16,
    })

end
