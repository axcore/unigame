---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.grass_wild = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr11.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_decoration(offset, scale, length)

    unilib.register_decoration_generic("glem_grass_wild_" .. length, {
        -- Code adapted from "grass_ordinary" package
        deco_type = "simple",
        decoration = "unilib:grass_wild_" .. length,

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

function unilib.pkg.grass_wild.init()

    return {
        description = "Wild grass",
    }

end

function unilib.pkg.grass_wild.exec()

    local full_name = "unilib:grass_wild_1"
    local drop = full_name
    if unilib.setting.disable_grass_drop_flag then
        drop = ""
    end

    -- First variant
    unilib.register_node(full_name, "lib_ecology:grass_green_1", mode, {
        -- Textures from GLEMr11, lib_ecology:lib_ecology_grass_green_1 etc. For consistency, code
        --      adapted from "grass_ordinary" package
        description = S("Wild Grass"),
        tiles = {"unilib_grass_wild_1.png"},
        -- N.B. wild_grass = 1 not in original code
        groups = {
            attached_node = 1, flammable = 1, flora = 1, grass = 1, snappy = 3, wild_grass = 1,
        },
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        drop = drop,
        -- N.B. As in the "grass_ordinary" package, we use a different variant for the inventory
        --      image
        inventory_image = "unilib_grass_wild_2.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_grass_wild_2.png",

        on_place = function(itemstack, placer, pointed_thing)

            -- Place a random grass variant
            local stack = ItemStack("unilib:grass_wild_" .. math.random(1, 5))
            local ret = core.item_place(stack, placer, pointed_thing)
            return ItemStack(full_name .. " " .. itemstack:get_count() - (1 - ret:get_count()))

        end,
    })
    unilib.register_craft({
        -- Original to unilib
        type = "fuel",
        recipe = full_name,
        burntime = 2,
    })
    unilib.register_plant_in_pot(full_name, "lib_ecology:grass_green_1")

    for i = 2, 5 do

        unilib.register_node("unilib:grass_wild_" .. i, "lib_ecology:grass_green_" .. i, mode, {
            -- Textures from GLEMr11, lib_ecology:lib_ecology_grass_green_2 etc. For consistency,
            --      code adapted from "grass_ordinary" package
            description = S("Wild Grass"),
            tiles = {"unilib_grass_wild_" .. i .. ".png"},
            -- N.B. wild_grass = 1 not in original code
            groups = {
                attached_node = 1, flammable = 1, flora = 1, grass = 1,
                not_in_creative_inventory = 1, snappy = 3, wild_grass = 1,
            },
            sounds = unilib.global.sound_table.leaves,

            buildable_to = true,
            drawtype = "plantlike",
            drop = drop,
            inventory_image = "unilib_grass_wild_" .. i .. ".png",
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
            },
            sunlight_propagates = true,
            walkable = false,
            waving = 1,
            wield_image = "unilib_grass_wild_" .. i .. ".png",
        })
        -- (not compatible with flowerpots)

    end

    do_decoration(-0.03, 0.09, 5)
    do_decoration(-0.015, 0.075, 4)
    do_decoration(0, 0.06, 3)
    do_decoration(0.015, 0.045, 2)
    do_decoration(0.03, 0.03, 1)

    -- Update global variables
    unilib.flora.register_growth_stages({
        base_name = "unilib:grass_wild",
        mode = "other",
        stage_max = 5,
    })

end
