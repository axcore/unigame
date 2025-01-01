---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_pumpkin_red_wild = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_pumpkin_red_wild.init()

    return {
        description = "Wild red pumpkin plant",
        notes = "Can be used to craft seeds which grow into the tiny pumpkin crop",
        depends = "crop_pumpkin_tiny",
    }

end

function unilib.pkg.plant_pumpkin_red_wild.exec()

    unilib.register_node(
        -- From cropocalypse:pumpkin, cropocalypse:pumpkin_wild
        "unilib:plant_pumpkin_red_wild",
        {"cropocalypse:pumpkin", "cropocalypse:pumpkin_wild"},
        mode,
        {
            description = unilib.utils.annotate(S("Wild Red Pumpkin Plant"), "Cucurbita"),
            tiles = {
                "unilib_plant_pumpkin_red_wild_top.png",
                "unilib_plant_pumpkin_red_wild_bottom.png",
                "unilib_plant_pumpkin_red_wild.png",
                "unilib_plant_pumpkin_red_wild.png",
                "unilib_plant_pumpkin_red_wild.png",
                "unilib_plant_pumpkin_red_wild.png"
            },
            -- N.B. flora = 1 not in original code
            groups = {
                choppy = 2, flammable = 1, flora = 1, oddly_breakable_by_hand = 2, pumpkin = 1,
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

    unilib.register_decoration_generic("cropocalypse_plant_pumpkin_red_wild", {
        -- From cropocalypse/plants.lua
        deco_type = "simple",
        decoration = "unilib:plant_pumpkin_red_wild",

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 0.7,
            scale = 0.1,
            seed = 6588,
            spread = {x = 50, y = 50, z = 50},
        },
        sidelen = 16,
    })

    unilib.register_craftitem(
        -- From cropocalypse:pumpkin_chunk
        "unilib:plant_pumpkin_red_wild_chunk",
        "cropocalypse:pumpkin_chunk",
        mode,
        {
            description = S("Wild Red Pumpkin Chunk"),
            inventory_image = "unilib_plant_pumpkin_red_wild_chunk.png",
            groups = {flammable = 4, food_pumpkin = 1},

            paramtype = "meshoptions",
            wield_image = "unilib_plant_pumpkin_red_wild_chunk.png",

            on_use = unilib.cuisine.eat_on_use("unilib:plant_pumpkin_red_chunk", 1),
        }
    )

    -- Craft recipes converting the tiny pumpkin into the red pumpkin, and vice-versa
    unilib.register_craft_3x3({
        -- From cropocalypse:pumpkin
        output = "unilib:plant_pumpkin_red_wild",
        ingredient = "unilib:crop_pumpkin_tiny_harvest",
    })
    unilib.register_craft_3x3({
        -- From cropocalypse:pumpkin
        output = "unilib:plant_pumpkin_red_wild",
        ingredient = "unilib:plant_pumpkin_red_wild_chunk",
    })
    unilib.register_craft({
        -- From cropocalypse:pumpkin_chunk
        output = "unilib:plant_pumpkin_red_wild_chunk 9",
        recipe = {
            {"unilib:plant_pumpkin_red_wild"},
        },
    })
    unilib.register_craft({
        -- From cropocalypse:seed_pumpkin_plant
        output = "unilib:crop_pumpkin_tiny_seed",
        recipe = {
            {"unilib:plant_pumpkin_red_wild_chunk"},
        },
    })

end
