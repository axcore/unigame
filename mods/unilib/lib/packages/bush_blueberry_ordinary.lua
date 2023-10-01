---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.bush_blueberry_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.bush_blueberry_ordinary.init()

    return {
        description = "Ordinary blueberry bush",
        notes = "Produces edible blueberries, which grow over time. Unlike other bushes from" ..
                " default, has no stem",
        depends = "fruit_blueberry_ordinary",
    }

end

function unilib.pkg.bush_blueberry_ordinary.exec()

    -- (no burnlevel)
    -- (no sci_name)

    local inv_img = unilib.filter_leaves_img("unilib_bush_blueberry_ordinary_leaves.png")
    unilib.register_node(
        -- From default:blueberry_bush_leaves
        "unilib:bush_blueberry_ordinary_leaves",
        "default:blueberry_bush_leaves",
        mode,
        {
            description = S("Ordinary Blueberry Bush Leaves"),
            tiles = {"unilib_bush_blueberry_ordinary_leaves.png"},
            groups = {flammable = 2, leaves = 1, snappy = 3},
            sounds = unilib.sound_table.leaves,

            drawtype = "allfaces_optional",
            drop = {
                max_items = 1,
                items = {
                    {items = {"unilib:bush_blueberry_ordinary_sapling"}, rarity = 5},
                    {items = {"unilib:bush_blueberry_ordinary_leaves"}}
                }
            },
            inventory_image = inv_img,
            paramtype = "light",
            wield_img = inv_img,

            after_place_node = unilib.after_place_leaves,

            on_timer = function(pos, elapsed)

                if minetest.get_node_light(pos) < 11 then

--                  minetest.get_node_timer(pos):start(200)
                    minetest.get_node_timer(pos):start(int(unilib.sapling_grow_min * 0.66))

                else

                    minetest.set_node(
                        pos, {name = "unilib:bush_blueberry_ordinary_leaves_with_berries"}
                    )

                end

            end,
        }
    )

    local main_img = "unilib_bush_blueberry_ordinary_leaves.png" ..
            "^unilib_bush_blueberry_ordinary_overlay.png"
    inv_img = unilib.filter_leaves_img(main_img)
    unilib.register_node(
        "unilib:bush_blueberry_ordinary_leaves_with_berries",
        "default:blueberry_bush_leaves_with_berries",
        mode,
        {
            -- From default:blueberry_bush_leaves_with_berries
            description = S("Ordinary Blueberry Bush Leaves with Berries"),
            tiles = {main_img},
            -- N.B. not_in_creative_inventory = 1 not in original code
            groups = {
                dig_immediate = 3, flammable = 2, leaves = 1, not_in_creative_inventory = 1,
                snappy = 3,
            },
            sounds = unilib.sound_table.leaves,

            drawtype = "allfaces_optional",
            drop = "unilib:fruit_blueberry_ordinary",
            inventory_image = inv_img,
            node_dig_prediction = "unilib:bush_blueberry_ordinary_leaves",
            paramtype = "light",
            wield_img = inv_img,

            after_dig_node = function(pos, oldnode, oldmetadata, digger)

                minetest.set_node(pos, {name = "unilib:bush_blueberry_ordinary_leaves"})
                minetest.get_node_timer(pos):start(
                    math.random(unilib.sapling_grow_min, unilib.sapling_grow_max)
                )

            end,
        }
    )

    unilib.register_bush_sapling({
        -- From default:blueberry_bush_sapling. Creates unilib:bush_blueberry_ordinary_sapling
        part_name = "blueberry_ordinary",
        orig_name = "default:blueberry_bush_sapling",

        replace_mode = mode,
        common_group = 2,
        description = S("Ordinary Blueberry Bush Sapling"),
        max_volume = 2,
        maxp_table = {x = 1, y = 1, z = 1},
        minp_table = {x = -1, y = 0, z = -1},
        offset_list = {1, 0, 1},
        select_Table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 2 / 16, 4 / 16},
    })

    unilib.register_decoration("default_bush_blueberry_ordinary", {
        -- From default/mapgen.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_bush_blueberry_ordinary.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 3,
            offset = -0.004,
            persist = 0.7,
            scale = 0.01,
            seed = 697,
            spread = {x = 100, y = 100, z = 100},
        },
        place_offset_y = 1,
        sidelen = 16,
    })

end
