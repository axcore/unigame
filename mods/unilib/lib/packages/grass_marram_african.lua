---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.grass_marram_african = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.grass_marram_african.init()

    return {
        description = "African marram grass",
        notes = "Three variants of African marram grass, each with a different height. Digging" ..
                " any variant puts the first variant into your inventory. Placing the first" ..
                " variant places a random variant (including perhaps the first one)",
    }

end

function unilib.pkg.grass_marram_african.exec()

    local full_name = "unilib:grass_marram_african_1"
    local drop = full_name
    if unilib.setting.disable_grass_drop_flag then
        drop = ""
    end

    -- First variant
    unilib.register_node(full_name, nil, mode, {
        -- Original to unilib, based on ordinary marram grass from minetest_game
        description = S("African Marram Grass"),
        tiles = {"unilib_grass_marram_african_1.png"},
        groups = {
            attached_node = 1, flammable = 3, flora = 1, grass = 1, marram_grass = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        drop = drop,
        -- Unlike other grasses, don't use texture of a taller grass variant in inventory
        inventory_image = "unilib_grass_marram_african_1.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.25, 6 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_grass_marram_african_1.png",

        on_place = function(itemstack, placer, pointed_thing)

            -- Place a random grass variant
            local stack = ItemStack("unilib:grass_marram_african_" .. math.random(1, 3))
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
    unilib.register_plant_in_pot(full_name, "default:marram_grass_1")

    for i = 2, 3 do

        unilib.register_node("unilib:grass_marram_african_" .. i, nil, mode, {
            -- Original to unilib
            description = S("African Marram Grass"),
            tiles = {"unilib_grass_marram_african_" .. i .. ".png"},
            groups = {
                attached_node = 1, flammable = 3, flora = 1, grass = 1, marram_grass = 1,
                not_in_creative_inventory = 1, snappy = 3,
            },
            sounds = unilib.global.sound_table.leaves,

            buildable_to = true,
            drawtype = "plantlike",
            drop = drop,
            inventory_image = "unilib_grass_marram_african_" .. i .. ".png",
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.25, 6 / 16},
            },
            sunlight_propagates = true,
            walkable = false,
            waving = 1,
            wield_image = "unilib_grass_marram_african_" .. i .. ".png",
        })
        -- (not compatible with flowerpots)

    end

    -- Update global variables
    unilib.flora.register_growth_stages({
        base_name = "unilib:grass_marram_african",
        mode = "other",
        stage_max = 3,
    })

    unilib.register_decoration_generic("default_grass_marram_african", {
        -- Original to unilib, based on the decoration from "grass_marram_ordinary" package from
        --      default/mapgen.lua
        deco_type = "simple",
        decoration = {
            "unilib:grass_marram_african_1",
            "unilib:grass_marram_african_2",
            "unilib:grass_marram_african_3",
        },

        noise_params = {
            flags = "absvalue, eased",
            octaves = 1,
            offset = -0.7,
            persist = 0.0,
            scale = 4.0,
            seed = 513333,
            spread = {x = 16, y = 16, z = 16},
        },
        sidelen = 4,
    })

end
