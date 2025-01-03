---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plants
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_cotton_ancient_wild = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.plants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_cotton_ancient_wild.init()

    return {
        description = "Ancient wild cotton",
        notes = "Drops cotton seeds infrequently, but no cotton",
        depends = "crop_cotton",
    }

end

function unilib.pkg.plant_cotton_ancient_wild.exec()

    unilib.register_node("unilib:plant_cotton_ancient_wild", "plants:cotton_wild", mode, {
        -- From plants:cotton_wild
        description = unilib.utils.annotate(S("Ancient Wild Cotton"), "Gossypium"),
        tiles = {"unilib_plant_cotton_ancient_wild.png"},
        -- N.B. flora = 1, not_in_creative_inventory = 1 not in original code
        groups = {
            attached_node = 1, flammable = 2, flora = 1, not_in_creative_inventory = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        -- N.B. Modified from original code, so that cotton seeds are dropped much less frequently
        --      than for the plant in the "plant_cotton_wild" package
        drop = {
            items = {
                {items = {"unilib:crop_cotton_seed"}, rarity = 5},
            },
        },
        inventory_image = "unilib_plant_cotton_ancient_wild.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, -3/16, 0.25},
        },
        sunlight_propagates = true,
        visual_scale = 1.3,
        walkable = false,
    })
    -- (not compatible with flowerpots)

    unilib.register_decoration_generic("plants_plant_cotton_ancient_wild", {
        -- Original to unilib, based on decoration in "plant_cotton_wild" package
        deco_type = "simple",
        decoration = "unilib:plant_cotton_ancient_wild",

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 0.7,
            scale = 0.1,
            seed = 43518,      -- New random seed, generated for unilib
            spread = {x = 50, y = 50, z = 50},
        },
        sidelen = 16,
    })

end
