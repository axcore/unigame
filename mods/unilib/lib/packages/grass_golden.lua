---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.grass_golden = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr11.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_decoration(offset, scale, length)

    unilib.register_decoration("glemr11_grass_golden_" .. length, {
        -- Code adapted from "grass_ordinary" package
        deco_type = "simple",
        decoration = "unilib:grass_golden_" .. length,

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

function unilib.pkg.grass_golden.init()

    return {
        description = "Golden grass",
    }

end

function unilib.pkg.grass_golden.exec()

    -- First variant
    unilib.register_node("unilib:grass_golden_1", "lib_ecology:grass_golden_1", mode, {
        -- Textures from GLEMr11, lib_ecology:lib_ecology_grass_golden_1 etc. For consistency, code
        --      adapted from "grass_ordinary" package
        description = S("Golden Grass"),
        tiles = {"unilib_grass_golden_1.png"},
        -- N.B. golden_grass = 1 not in original code
        groups = {
            attached_node = 1, flammable = 1, flora = 1, golden_grass = 1, grass = 1, snappy = 3,
        },
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        -- (As in the "grass_ordinary" package, we use a different variant for the inventory image)
        inventory_image = "unilib_grass_golden_2.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_grass_golden_2.png",

        on_place = function(itemstack, placer, pointed_thing)

            -- Place a random grass variant
            local stack = ItemStack("unilib:grass_golden_" .. math.random(1, 5))
            local ret = minetest.item_place(stack, placer, pointed_thing)
            return ItemStack("unilib:grass_golden_1 " ..
                    itemstack:get_count() - (1 - ret:get_count()))

        end,
    })
    unilib.register_craft({
        -- Original to unilib
        type = "fuel",
        recipe = "unilib:grass_golden_1",
        burntime = 2,
    })
    unilib.register_plant_in_pot("unilib:grass_golden_1", "lib_ecology:grass_golden_1")

    for i = 2, 5 do

        unilib.register_node("unilib:grass_golden_" .. i, "lib_ecology:grass_golden_" .. i, mode, {
            -- Textures from GLEMr11, lib_ecology:lib_ecology_grass_golden_2 etc. For consistency,
            --      code adapted from "grass_ordinary" package
            description = S("Golden Grass"),
            tiles = {"unilib_grass_golden_" .. i .. ".png"},
            -- N.B. golden_grass = 1 not in original code
            groups = {
                attached_node = 1, flammable = 1, flora = 1, golden_grass = 1, grass = 1,
                not_in_creative_inventory = 1, snappy = 3,
            },
            sounds = unilib.sound_table.leaves,

            buildable_to = true,
            drawtype = "plantlike",
            drop = "unilib:grass_golden_1",
            inventory_image = "unilib_grass_golden_" .. i .. ".png",
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
            },
            sunlight_propagates = true,
            walkable = false,
            waving = 1,
            wield_image = "unilib_grass_golden_" .. i .. ".png",
        })
        -- (not compatible with flowerpots)

    end

    do_decoration(-0.03, 0.09, 5)
    do_decoration(-0.015, 0.075, 4)
    do_decoration(0, 0.06, 3)
    do_decoration(0.015, 0.045, 2)
    do_decoration(0.03, 0.03, 1)

    -- Update global variables
    unilib.register_growing({
        base_name = "unilib:grass_golden",
        mode = "other",
        stage_max = 5,
    })

end
