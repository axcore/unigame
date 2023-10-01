---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_cactus_exotic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function grow_seed_func(pos)

    local node_under = minetest.get_node_or_nil({x = pos.x, y = pos.y - 1, z = pos.z})
    if not node_under then

        -- Node under not yet loaded, try later
        minetest.get_node_timer(pos):start(unilib.sapling_grow_retry)
        return

    end

    if minetest.get_item_group(node_under.name, "sand") == 0 then

        -- Seedling dies
        minetest.remove_node(pos)
        return

    end

    local light_level = minetest.get_node_light(pos)
    if not light_level or light_level < unilib.light_min_grow_sapling then

        -- Too dark for growth, try later in case it's night
        minetest.get_node_timer(pos):start(unilib.sapling_grow_retry)
        return

    end

    unilib.log(
        "action",
        "The exotic cactus seedling grows into an exotic cactus at " ..
                minetest.pos_to_string(pos)
    )

    minetest.place_schematic(
        {x = pos.x - 2, y = pos.y - 1, z = pos.z - 2},
        unilib.path_mod .. "/mts/unilib_plant_cactus_exotic_large.mts",
        "random",
        nil,
        false
    )

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_cactus_exotic.init()

    return {
        description = "Exotic cactus",
        notes = "Behaves in the same way as an ordinary cactus, but can also bare fruit",
        optional = "fruit_cactus_exotic",
    }

end

function unilib.pkg.plant_cactus_exotic.exec()

    local c_cactus = "unilib:plant_cactus_exotic"

    unilib.register_node("unilib:plant_cactus_exotic", nil, mode, {
        -- From farlands, default:cactus. Code adapted from the "plant_cactus_ordinary" package,
        --      and updated to use the farlands mesh
        description = S("Exotic Cactus"),
        tiles = {"unilib_plant_cactus_exotic.png"},
        groups = {cactus_grow = 1, choppy = 3},
        sounds = unilib.sound_table.wood,

        collision_box = {
            type = "fixed",
            fixed = {-0.4, -0.5, -0.4, 0.4, 0.5, 0.4},
        },
        drawtype = "mesh",
        mesh = "unilib_plant_cactus_exotic.b3d",
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-0.4, -0.5, -0.4, 0.4, 0.5, 0.4},
        },
        use_texture_alpha = "clip",
        visual_scale = 0.5,

        on_place = minetest.rotate_node,
    })
    unilib.register_craft({
        -- Original to unilib
        type = "fuel",
        recipe = "unilib:plant_cactus_exotic",
        burntime = 15,
    })
    -- (not compatible with flowerpots)

    if unilib.pkg_executed_table["fruit_cactus_exotic"] ~= nil then

        unilib.register_abm({
            -- From farlands, fruit/init.lua
            label = "Cactus growth [plant_cactus_exotic]",
            nodenames = {"unilib:plant_cactus_exotic"},

            chance = 50,
            interval = 30,

            action = function(pos, node)

                if minetest.get_node({x = pos.x, y = pos.y + 1, z = pos.z}).name == "air" then

                    minetest.set_node(
                        {x = pos.x, y = pos.y + 1, z = pos.z},
                        {name = "unilib:fruit_cactus_exotic"}
                    )

                end

            end,
        })

    end

    unilib.register_node("unilib:plant_cactus_exotic_seed", nil, mode, {
        -- Original to unilib
        description = S("Exotic Cactus Seedling"),
        tiles = {"unilib_plant_cactus_exotic_seed.png"},
        groups = {attached_node = 1, choppy = 3, dig_immediate = 3},
        sounds = unilib.sound_table.wood,

        drawtype = "plantlike",
        inventory_image = "unilib_plant_cactus_exotic_seed.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 0.5, 5 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_plant_cactus_exotic_seed.png",

        on_construct = function(pos)
            minetest.get_node_timer(pos):start(math.random(1859, 3719))
        end,

        on_place = function(itemstack, placer, pointed_thing)

            itemstack = unilib.sapling_on_place(
                itemstack,
                placer,
                pointed_thing,
                "unilib:plant_cactus_exotic_seed",
                {x = -2, y = -1, z = -2},
                {x = 2, y = 5, z = 2},
                4
            )

            return itemstack

        end,

        on_timer = function(pos)
            grow_seed_func(pos)
        end,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:plant_cactus_exotic_seed",
        recipe = {
            {"", c_cactus, ""},
            {c_cactus, c_cactus, c_cactus},
            {"", c_cactus, ""},
        }
    })
    unilib.register_craft({
        -- Original to unilib
        type = "fuel",
        recipe = "unilib:plant_cactus_exotic_seed",
        burntime = 5,
    })

    -- Enable cactus growth with fertilisers
    unilib.register_special_fertilise("unilib:plant_cactus_exotic", unilib.grow_cactus_callback)
    unilib.register_special_fertilise("unilib:plant_cactus_exotic_seed", grow_seed_func)

    -- Cactus decoration placed as a single node; the ABM in ../shared/abms.lua causes it to grow
    --      upwards
    unilib.register_decoration("farlands_plant_cactus_exotic", {
        -- From farlands, mapgen/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:plant_cactus_exotic",

        height = 2,
        height_max = 5,
        noise_params = {
            octaves = 3,
            offset = -0.0003,
            persist = 0.6,
            scale = 0.0009,
            seed = 230,
            spread = {x = 200, y = 200, z = 200},
        },
        sidelen = 16,
    })

    -- N.B. This was commented out in original code, but we need it
    -- Cactus decoration placed as a multi-node plant
    unilib.register_decoration("farlands_plant_cactus_exotic_large", {
        -- From farlands, mapgen/mapgen.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_plant_cactus_exotic_large.mts",

        flags = "place_center_x",
        noise_params = {
            octaves = 3,
            offset = -0.0003,
            persist = 0.6,
            scale = 0.0009,
            seed = 230,
            spread = {x = 200, y = 200, z = 200},
        },
        rotation = "random",
        sidelen = 16,
    })

end
