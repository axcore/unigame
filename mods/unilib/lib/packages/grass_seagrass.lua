---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.grass_seagrass = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.grass_seagrass.init()

    return {
        description = "Seagrass",
        notes = "Not related to other seagrass plant packages, which do not have growth stages",
    }

end

function unilib.pkg.grass_seagrass.exec()

    local full_name = "unilib:grass_seagrass_1"
    local drop = full_name
    if unilib.setting.disable_grass_drop_flag then
        drop = ""
    end

    -- First variant
    unilib.register_node(full_name, nil, mode, {
        -- Textures from farlands, mapgen:seagrass_1 etc. For consistency, code adapted from
        --      "grass_ordinary" package
        description = S("Seagrass"),
        tiles = {"unilib_grass_seagrass_1.png"},
        -- N.B. seagrass = 1 not in original code
        groups = {
            attached_node = 1, flammable = 1, flora = 1, grass = 1, sea = 1, seagrass = 1,
            snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        drop = drop,
        inventory_image = "unilib_grass_seagrass_1.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_grass_seagrass_1.png",

        on_place = function(itemstack, placer, pointed_thing)

            -- Place a random grass variant
            local stack = ItemStack("unilib:grass_seagrass_" .. math.random(1, 3))
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
    unilib.register_plant_in_pot(full_name, nil)

    for i = 2, 3 do

        unilib.register_node("unilib:grass_seagrass_" .. i, nil, mode, {
            -- Textures from farlands, mapgen:seagrass_2 etc. For consistency, code adapted from
            --      "grass_ordinary" package
            description = S("Seagrass"),
            tiles = {"unilib_grass_seagrass_" .. i .. ".png"},
            -- N.B. seagrass = 1 not in original code
            groups = {
                attached_node = 1, flammable = 1, flora = 1, grass = 1,
                not_in_creative_inventory = 1, sea = 1, seagrass = 1, snappy = 3,
            },
            sounds = unilib.global.sound_table.leaves,

            buildable_to = true,
            drawtype = "plantlike",
            drop = drop,
            inventory_image = "unilib_grass_seagrass_" .. i .. ".png",
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
            },
            sunlight_propagates = true,
            walkable = false,
            waving = 1,
            wield_image = "unilib_grass_seagrass_" .. i .. ".png",
        })
        -- (not compatible with flowerpots)

    end

    -- N.B. no decorations in original code; this generic definition is available for anyone who
    --      wants to write their own decoration package
    for i = 1, 3 do

        unilib.register_decoration_generic("farlands_grass_seagrass_" .. i, {
            -- Original to unilib
            deco_type = "simple",
            decoration = "unilib:grass_seagrass_" .. i,

            noise_params = {
                octaves = 3,
                offset = 0,
                persist = 0.6,
                scale = 0.05,
                seed = 789,
                spread = {x = 200, y = 200, z = 200},
            },
            sidelen = 16,
        })

    end

    -- Update global variables
    unilib.flora.register_growth_stages({
        base_name = "unilib:grass_seagrass",
        mode = "other",
        stage_max = 3,
    })

end
