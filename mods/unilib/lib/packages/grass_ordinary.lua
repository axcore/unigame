---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    farming
-- Code:    MIT
-- Media:   CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.grass_ordinary = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_decoration(offset, scale, length)

    unilib.register_decoration_generic("default_grass_ordinary_" .. length, {
        -- From default/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:grass_ordinary_" .. length,

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

function unilib.pkg.grass_ordinary.init()

    return {
        description = "Ordinary grass",
        notes = "Five variants of ordinary grass, each with a different height. Digging any" ..
                " variant puts the first variant into your inventory. Placing the first variant" ..
                " places at random variant (including perhaps the first one). Occasionally drops" ..
                " wheat seeds",
        -- Occasionally drop oat and/or wheat seeds
        optional = {"crop_oat", "crop_wheat"},
    }

end

function unilib.pkg.grass_ordinary.exec()

    local insert = ""
    if unilib.setting.mtgame_tweak_flag and unilib.setting.plantlife_long_grass_flag then

        -- Textures from plantlife/dryplants, e.g. unilib_grass_ordinary_1_alt.png
        insert = "_alt"

    end

    local full_name = "unilib:grass_ordinary_1"
    local drop = full_name
    if unilib.setting.disable_grass_drop_flag then
        drop = ""
    end

    -- First variant
    unilib.register_node(full_name, "default:grass_1", mode, {
        -- From default:grass_1
        description = S("Ordinary Grass"),
        tiles = {"unilib_grass_ordinary_1" .. insert .. ".png"},
        -- N.B. ordinary_grass = 1 not in original code; normal_grass = 1 retained for
        --      compatibility
        groups = {
            attached_node = 1, flammable = 1, flora = 1, grass = 1, normal_grass = 1,
            ordinary_grass = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        drop = drop,
        -- Notes from default:
        -- Use texture of a taller grass variant in inventory
        inventory_image = "unilib_grass_ordinary_3" .. insert .. ".png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -5 / 16, 6 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_grass_ordinary_3" .. insert .. ".png",

        on_place = function(itemstack, placer, pointed_thing)

            -- Place a random grass variant
            local stack = ItemStack("unilib:grass_ordinary_" .. math.random(1, 5))
            local ret = core.item_place(stack, placer, pointed_thing)
            return ItemStack(full_name .. " " .. itemstack:get_count() - (1 - ret:get_count()))

        end,
    })
    unilib.register_craft({
        -- From default:grass_1
        type = "fuel",
        recipe = full_name,
        burntime = 2,
    })
    unilib.register_plant_in_pot(full_name, "default:grass_1")

    for i = 2, 5 do

        unilib.register_node("unilib:grass_ordinary_" .. i, "default:grass_" .. i, mode, {
            -- From default:grass_2, etc
            description = S("Ordinary Grass"),
            tiles = {"unilib_grass_ordinary_" .. i .. insert .. ".png"},
            -- N.B. ordinary_grass = 1 not in original code; normal_grass = 1 retained for
            --      compatibility
            groups = {
                attached_node = 1, flammable = 1, flora = 1, grass = 1, normal_grass = 1,
                not_in_creative_inventory = 1, ordinary_grass = 1, snappy = 3,
            },
            sounds = unilib.global.sound_table.leaves,

            buildable_to = true,
            drawtype = "plantlike",
            drop = drop,
            inventory_image = "unilib_grass_ordinary_" .. i .. insert .. ".png",
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -3 / 16, 6 / 16},
            },
            sunlight_propagates = true,
            walkable = false,
            waving = 1,
            wield_image = "unilib_grass_ordinary_" .. i .. insert .. ".png",
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
        base_name = "unilib:grass_ordinary",
        mode = "other",
        stage_max = 5,
    })

end

function unilib.pkg.grass_ordinary.post()

    -- Occasionally drop oat and/or wheat seeds
    if not unilib.setting.disable_grass_drop_flag then

        if unilib.global.pkg_executed_table["crop_oat"] ~= nil and
                unilib.global.pkg_executed_table["crop_wheat"] ~= nil then

            -- Adapted from farming_redo
            for i = 1, 3 do

                unilib.override_item("unilib:grass_ordinary_" .. i, {
                    drop = {
                        max_items = 1,
                        items = {
                            {items = {"unilib:crop_wheat_seed"}, rarity = 5},
                            {items = {"unilib:grass_ordinary_1"}},
                        },
                    },
                })

            end

            for i = 4, 5 do

                unilib.override_item("unilib:grass_ordinary_" .. i, {
                    drop = {
                        max_items = 1,
                        items = {
                            {items = {"unilib:crop_oat_seed"}, rarity = 5},
                            {items = {"unilib:crop_wheat_seed"}, rarity = 5},
                            {items = {"unilib:grass_ordinary_1"}},
                        },
                    },
                })

            end

        elseif unilib.global.pkg_executed_table["crop_oat"] ~= nil then

            -- Original to unilib
            for i = 4, 5 do

                unilib.override_item("unilib:grass_ordinary_" .. i, {
                    drop = {
                        max_items = 1,
                        items = {
                            {items = {"unilib:crop_oat_seed"}, rarity = 5},
                            {items = {"unilib:grass_ordinary_1"}},
                        },
                    },
                })

            end

        elseif unilib.global.pkg_executed_table["crop_wheat"] ~= nil then

            -- Adapted from minetest_game/farming
            for i = 1, 5 do

                unilib.override_item("unilib:grass_ordinary_" .. i, {
                    drop = {
                        max_items = 1,
                        items = {
                            {items = {"unilib:crop_wheat_seed"}, rarity = 5},
                            {items = {"unilib:grass_ordinary_1"}},
                        },
                    },
                })

            end

        end

    else

        if unilib.global.pkg_executed_table["crop_oat"] ~= nil and
                unilib.global.pkg_executed_table["crop_wheat"] ~= nil then

            -- Adapted from farming_redo
            for i = 1, 3 do

                unilib.override_item("unilib:grass_ordinary_" .. i, {
                    drop = {
                        max_items = 1,
                        items = {
                            {items = {"unilib:crop_wheat_seed"}, rarity = 5},
--                          {items = {"unilib:grass_ordinary_1"}},
                        },
                    },
                })

            end

            for i = 4, 5 do

                unilib.override_item("unilib:grass_ordinary_" .. i, {
                    drop = {
                        max_items = 1,
                        items = {
                            {items = {"unilib:crop_oat_seed"}, rarity = 5},
                            {items = {"unilib:crop_wheat_seed"}, rarity = 5},
--                          {items = {"unilib:grass_ordinary_1"}},
                        },
                    },
                })

            end

        elseif unilib.global.pkg_executed_table["crop_oat"] ~= nil then

            -- Original to unilib
            for i = 4, 5 do

                unilib.override_item("unilib:grass_ordinary_" .. i, {
                    drop = {
                        max_items = 1,
                        items = {
                            {items = {"unilib:crop_oat_seed"}, rarity = 5},
--                          {items = {"unilib:grass_ordinary_1"}},
                        },
                    },
                })

            end

        elseif unilib.global.pkg_executed_table["crop_wheat"] ~= nil then

            -- Adapted from minetest_game/farming
            for i = 1, 5 do

                unilib.override_item("unilib:grass_ordinary_" .. i, {
                    drop = {
                        max_items = 1,
                        items = {
                            {items = {"unilib:crop_wheat_seed"}, rarity = 5},
--                          {items = {"unilib:grass_ordinary_1"}},
                        },
                    },
                })

            end

        end

    end

end
