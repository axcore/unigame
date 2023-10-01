---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.grass_dry = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_decoration(offset, scale, length)

    unilib.register_decoration("default_grass_dry_" .. length, {
        -- From default/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:grass_dry_" .. length,

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

function unilib.pkg.grass_dry.init()

    return {
        description = "Dry grass",
        notes = "Five variants of dry grass, each with a different height. Digging any variant" ..
                " puts the first variant into your inventory. Placing the first variant places a" ..
                " random variant (including perhaps the first one)",
        -- Occasionally drop barley and rye seeds
        optional = {"crop_barley", "crop_rye"},
    }

end

function unilib.pkg.grass_dry.exec()

    -- First variant
    unilib.register_node("unilib:grass_dry_1", "default:dry_grass_1", mode, {
        -- From default:dry_grass_1
        description = S("Savanna Grass"),
        tiles = {"unilib_grass_dry_1.png"},
        groups = {
            attached_node = 1, dry_grass = 1, flammable = 3, flora = 1, grass = 1, snappy = 3,
        },
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        -- Notes from default:
        -- Use texture of a taller grass variant in inventory
        inventory_image = "unilib_grass_dry_3.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -3 / 16, 6 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_grass_dry_3.png",

        on_place = function(itemstack, placer, pointed_thing)

            -- Place a random grass variant
            local stack = ItemStack("unilib:grass_dry_" .. math.random(1,5))
            local ret = minetest.item_place(stack, placer, pointed_thing)
            return ItemStack("unilib:grass_dry_1 " ..
                    itemstack:get_count() - (1 - ret:get_count()))

        end,
    })
    unilib.register_craft({
        -- From default:dry_grass_1
        type = "fuel",
        recipe = "unilib:grass_dry_1",
        burntime = 2,
    })
    unilib.register_plant_in_pot("unilib:grass_dry_1", "default:dry_grass_1")

    for i = 2, 5 do

        unilib.register_node("unilib:grass_dry_" .. i, "default:dry_grass_" .. i, mode, {
            -- From default:dry_grass_2, etc
            description = S("Savanna Grass"),
            tiles = {"unilib_grass_dry_" .. i .. ".png"},
            groups = {
                attached_node = 1, dry_grass = 1, flammable = 3, flora = 1, grass = 1,
                not_in_creative_inventory = 1, snappy = 3,
            },
            sounds = unilib.sound_table.leaves,

            buildable_to = true,
            drawtype = "plantlike",
            drop = "unilib:grass_dry_1",
            inventory_image = "unilib_grass_dry_" .. i .. ".png",
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -1 / 16, 6 / 16},
            },
            sunlight_propagates = true,
            walkable = false,
            waving = 1,
            wield_image = "unilib_grass_dry_" .. i .. ".png",
        })
        -- (not compatible with flowerpots)

    end

    do_decoration(0.01, 0.05, 5)
    do_decoration(0.03, 0.03, 4)
    do_decoration(0.05, 0.01, 3)
    do_decoration(0.07, -0.01, 2)
    do_decoration(0.09, -0.03, 1)

    -- Update global variables
    unilib.register_growing({
        base_name = "unilib:grass_dry",
        mode = "other",
        stage_max = 5,
    })

end

function unilib.pkg.grass_dry.post()

    -- Occasionally drop barley and rye seeds
    if unilib.pkg_executed_table["crop_barley"] ~= nil and
            unilib.pkg_executed_table["crop_rye"] ~= nil then

        -- Adapted from farming_redo
        for i = 1, 5 do

            unilib.override_item("unilib:grass_dry_" .. i, {
                drop = {
                    max_items = 1,
                    items = {
                        {items = {"unilib:crop_barley_seed"}, rarity = 5},
                        {items = {"unilib:crop_rye_seed"}, rarity = 5},
                        {items = {"unilib:grass_dry_1"}},
                    }
                }
            })

        end

    end

end
