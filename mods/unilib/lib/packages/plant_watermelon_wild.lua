---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_watermelon_wild = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_watermelon_wild.init()

    return {
        description = "Wild watermelon plant",
        notes = "For consistency with other packages, the unilib version of this plant does not" ..
                " use ABMs to spawn watermelons in adjacent nodes",
        depends = "crop_watermelon_tiny",
    }

end

function unilib.pkg.plant_watermelon_wild.exec()

    unilib.register_node(
        -- From cropocalypse:watermelon, cropocalypse:watermelon_wild
        "unilib:plant_watermelon_wild",
        {"cropocalypse:watermelon", "cropocalypse:watermelon_wild"},
        mode,
        {
            description = unilib.utils.annotate(S("Wild Watermelon Plant"), "Citrullus lanatus"),
            tiles = {
                "unilib_plant_watermelon_wild_top.png",
                "unilib_plant_watermelon_wild_top.png",
                "unilib_plant_watermelon_wild.png",
                "unilib_plant_watermelon_wild.png",
                "unilib_plant_watermelon_wild.png",
                "unilib_plant_watermelon_wild.png"
            },
            -- N.B. flora = 1 not in original code
            groups = {
                choppy = 2, flammable = 1, flora = 1, oddly_breakable_by_hand = 2, watermelon = 1,
            },
            sounds = unilib.global.sound_table.wood,

            is_ground_content = false,
            node_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
                },
            },
            paramtype2 = "facedir",
        }
    )
    -- (not compatible with flowerpots)

    unilib.register_decoration_generic("cropocalypse_plant_watermelon_wild", {
        -- From cropocalypse/plants.lua
        deco_type = "simple",
        decoration = "unilib:plant_watermelon_wild",

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 0.7,
            scale = 0.1,
            seed = 1374,
            spread = {x = 50, y = 50, z = 50},
        },
        sidelen = 16,
    })

    unilib.register_craftitem(
        -- From cropocalypse:watermelon_slice
        "unilib:plant_watermelon_wild_slice",
        "cropocalypse:watermelon_slice",
        mode,
        {
            description = S("Wild Watermelon Slice"),
            groups = {flammable = 4, food_watermelon = 1},
            inventory_image = "unilib_plant_watermelon_wild_slice.png",

            paramtype = "meshoptions",
            wield_image = "unilib_plant_watermelon_wild_slice.png",

            on_use = unilib.cuisine.eat_on_use("unilib:plant_watermelon_wild_slice", 1),
        }
    )

    -- Craft recipes converting the tiny watermelon into the (wild) watermelon, and vice-versa
    unilib.register_craft_3x3({
        -- From cropocalypse:watermelon
        output = "unilib:plant_watermelon_wild",
        ingredient = "unilib:crop_watermelon_tiny_harvest",
    })
    unilib.register_craft_3x3({
        -- From cropocalypse:watermelon
        output = "unilib:plant_watermelon_wild",
        ingredient = "unilib:plant_watermelon_wild_slice",
    })
    unilib.register_craft({
        -- From cropocalypse:watermelon_slice
        output = "unilib:plant_watermelon_wild_slice 9",
        recipe = {
            {"unilib:plant_watermelon_wild"},
        },
    })
    unilib.register_craft({
        -- From cropocalypse:seed_watermelon_plant
        output = "unilib:crop_watermelon_tiny_seed",
        recipe = {
            {"unilib:plant_watermelon_wild_slice"},
        },
    })

end
