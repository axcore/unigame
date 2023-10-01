---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.grass_rainforest = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_decoration(offset, scale, length)

    unilib.register_decoration("farlands_grass_rainforest_" .. length, {
        -- From farlands, mapgen/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:grass_rainforest_" .. length,

        noise_params = {
            octaves = 3,
            offset = offset,
            persist = 0.6,
            scale = scale,
            seed = 329,
            spread = {x = 200, y = 200, z = 200},
        },
        sidelen = 16,
    })

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.grass_rainforest.init()

    return {
        description = "Rainforest grass",
    }

end

function unilib.pkg.grass_rainforest.exec()

    -- First variant
    unilib.register_node("unilib:grass_rainforest_1", nil, mode, {
        -- Textures from farlands, mapgen:jungle_grass_1 etc. For consistency, code adapted from
        --      "grass_ordinary" package
        -- Renamed from "jungle grass" to avoid the name clash with jungle grass from default
        description = S("Rainforest Grass"),
        tiles = {"unilib_grass_rainforest_1.png"},
        -- N.B. rainforest_grass = 1 not in original code
        groups = {
            attached_node = 1, flammable = 1, flora = 1, grass = 1, rainforest_grass = 1,
            snappy = 3,
        },
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        -- (As in the "grass_ordinary" package, we use a different variant for the inventory image)
        inventory_image = "unilib_grass_rainforest_2.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_grass_rainforest_2.png",

        on_place = function(itemstack, placer, pointed_thing)

            -- Place a random grass variant
            local stack = ItemStack("unilib:grass_rainforest_" .. math.random(1, 5))
            local ret = minetest.item_place(stack, placer, pointed_thing)
            return ItemStack("unilib:grass_rainforest_1 " ..
                    itemstack:get_count() - (1 - ret:get_count()))

        end,
    })
    unilib.register_craft({
        -- Original to unilib
        type = "fuel",
        recipe = "unilib:grass_rainforest_1",
        burntime = 2,
    })
    unilib.register_plant_in_pot("unilib:grass_rainforest_1", nil)

    for i = 2, 5 do

        unilib.register_node("unilib:grass_rainforest_" .. i, nil, mode, {
            -- Textures from farlands, mapgen:jungle_grass_2 etc. For consistency, code adapted from
            --      "grass_ordinary" package
            description = S("Rainforest Grass"),
            tiles = {"unilib_grass_rainforest_" .. i .. ".png"},
            -- N.B. rainforest_grass = 1 not in original code
            groups = {
                attached_node = 1, flammable = 1, flora = 1, grass = 1,
                not_in_creative_inventory = 1, rainforest_grass = 1, snappy = 3,
            },
            sounds = unilib.sound_table.leaves,

            buildable_to = true,
            drawtype = "plantlike",
            drop = "unilib:grass_rainforest_1",
            inventory_image = "unilib_grass_rainforest_" .. i .. ".png",
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
            },
            sunlight_propagates = true,
            walkable = false,
            waving = 1,
            wield_image = "unilib_grass_rainforest_" .. i .. ".png",
        })
        -- (not compatible with flowerpots)

    end

    do_decoration(-0.03,  0.09, 5)
    do_decoration(-0.015, 0.075, 4)
    do_decoration(0, 0.06, 3)
    do_decoration(0.015,  0.045, 2)
    do_decoration(0.03, 0.03, 1)

    -- Update global variables
    unilib.register_growing({
        base_name = "unilib:grass_rainforest",
        mode = "other",
        stage_max = 5,
    })

end
