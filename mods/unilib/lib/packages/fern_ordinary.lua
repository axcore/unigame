---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.fern_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_decoration(seed, length)

    unilib.register_decoration("default_fern_ordinary_" .. length, {
        -- From default/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:fern_ordinary_" .. length,

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.7,
            scale = 0.2,
            seed = seed,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fern_ordinary.init()

    return {
        description = "Ordinary fern",
        notes = "Three variants of ordinary fern, each with a different height. Digging any" ..
                " variant puts the first variant into your inventory. Placing the first variant" ..
                " places a random variant (including the first one). Provides fiddlehead and" ..
                " tubers, if other packages are loaded",
    }

end

function unilib.pkg.fern_ordinary.exec()

    -- First variant
    unilib.register_node("unilib:fern_ordinary_1", "default:fern_1", mode, {
        -- From default:fern_1
        description = S("Ordinary Fern"),
        tiles = {"unilib_fern_ordinary_1.png"},
        groups = {attached_node = 1, fern = 1, flammable = 3, flora = 1, grass = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        -- DON'T use texture of a taller fern variant in inventory
        inventory_image = "unilib_fern_ordinary_1.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.25, 6 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_fern_ordinary_1.png",

        on_place = function(itemstack, placer, pointed_thing)

            -- Place a random fern variant
            local stack = ItemStack("unilib:fern_ordinary_" .. math.random(1,3))
            local ret = minetest.item_place(stack, placer, pointed_thing)
            return ItemStack("unilib:fern_ordinary_1 " ..
                    itemstack:get_count() - (1 - ret:get_count()))

        end,
    })
    unilib.register_craft({
        -- From default:fern_1
        type = "fuel",
        recipe = "unilib:fern_ordinary_1",
        burntime = 2,
    })
    unilib.register_plant_in_pot("unilib:fern_ordinary_1", "default:fern_1")

    for i = 2, 3 do

        unilib.register_node("unilib:fern_ordinary_" .. i, "default:fern_" .. i, mode, {
            -- From default:fern_2, etc
            description = S("Ordinary Fern"),
            tiles = {"unilib_fern_ordinary_" .. i .. ".png"},
            groups = {
                attached_node = 1, fern = 1, flammable = 3, flora = 1, grass = 1,
                not_in_creative_inventory = 1, snappy = 3,
            },
            sounds = unilib.sound_table.leaves,

            buildable_to = true,
            drawtype = "plantlike",
            drop = "unilib:fern_ordinary_1",
            inventory_image = "unilib_fern_ordinary_" .. i .. ".png",
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.25, 6 / 16},
            },
            sunlight_propagates = true,
            visual_scale = 2,
            walkable = false,
            waving = 1,
            wield_image = "unilib_fern_ordinary_" .. i .. ".png",
        })
        -- (not compatible with flowerpots)

    end

    do_decoration(14936, 3)
    do_decoration(801, 2)
    do_decoration(5, 1)

end
