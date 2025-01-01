---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_cactus_ordinary = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function grow_seed_func(pos)

    local node_under = core.get_node_or_nil({x = pos.x, y = pos.y - 1, z = pos.z})
    if not node_under then

        -- Node under not yet loaded, try later
        core.get_node_timer(pos):start(unilib.setting.sapling_grow_retry)
        return

    end

    if core.get_item_group(node_under.name, "sand") == 0 then

        -- Seedling dies
        core.remove_node(pos)
        return

    end

    local light_level = core.get_node_light(pos)
    if not light_level or light_level < unilib.constant.light_min_grow_sapling then

        -- Too dark for growth, try later in case it's night
        core.get_node_timer(pos):start(unilib.setting.sapling_grow_retry)
        return

    end

    unilib.utils.log(
        "action",
        "The ordinary cactus seedling grows into an ordinary cactus at " .. core.pos_to_string(pos)
    )

    core.place_schematic(
        {x = pos.x - 2, y = pos.y - 1, z = pos.z - 2},
        unilib.core.path_mod .. "/mts/unilib_plant_cactus_ordinary_large.mts",
        "random",
        nil,
        false
    )

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_cactus_ordinary.init()

    return {
        description = "Ordinary cactus",
        notes = "Decorations occur as single nodes, or as \"large\" plants. Single nodes will" ..
                " grow up to three additional nodes. Cactus seedlings are crafted directly from" ..
                " cactus nodes. Seedlings will grow into a cactus with \"arms\". Growth occurs" ..
                " on the sand group",
    }

end

function unilib.pkg.plant_cactus_ordinary.exec()

    local c_cactus = "unilib:plant_cactus_ordinary"

    unilib.register_node("unilib:plant_cactus_ordinary", "default:cactus", mode, {
        -- From default:cactus
        description = S("Ordinary Cactus"),
        tiles = {
            "unilib_plant_cactus_ordinary_top.png",
            "unilib_plant_cactus_ordinary_top.png",
            "unilib_plant_cactus_ordinary_side.png",
        },
        -- N.B. cactus_grow = 1 not in original code, used for ABM
        groups = {cactus_grow = 1, choppy = 3},
        sounds = unilib.global.sound_table.wood,

        paramtype2 = "facedir",

        on_place = core.rotate_node,
    })
    unilib.register_craft({
        -- From default:cactus
        type = "fuel",
        recipe = "unilib:plant_cactus_ordinary",
        burntime = 15,
    })
    unilib.register_juice({
        ingredient = "unilib:plant_cactus_ordinary",
        juice_description = S("Cactus"),
        juice_type = "cactus",
        rgb = "#96F97B",

        orig_flag = true,
    })
    -- (not compatible with flowerpots)

    unilib.register_node(
        -- From default:large_cactus_seedling
        "unilib:plant_cactus_ordinary_seed",
        "default:large_cactus_seedling",
        mode,
        {
            description = S("Ordinary Cactus Seedling"),
            tiles = {"unilib_plant_cactus_ordinary_seed.png"},
            groups = {attached_node = 1, choppy = 3, dig_immediate = 3},
            sounds = unilib.global.sound_table.wood,

            drawtype = "plantlike",
            inventory_image = "unilib_plant_cactus_ordinary_seed.png",
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 0.5, 5 / 16},
            },
            sunlight_propagates = true,
            walkable = false,
            wield_image = "unilib_plant_cactus_ordinary_seed.png",

            on_construct = function(pos)

                -- Notes from default:
                -- Normal cactus farming adds 1 cactus node by ABM, interval 12s, chance 83
                -- Consider starting with 5 cactus nodes. We make sure that growing a large cactus
                --      is not a faster way to produce new cactus nodes
                -- Confirmed by experiment, when farming 5 cacti, on average 1 new cactus node is
                --      added on average every 83 / 5 = 16.6 intervals = 16.6 * 12 = 199.2s
                -- Large cactus contains on average 14 cactus nodes
                -- 14 * 199.2 = 2788.8s
                -- Set random range to average to 2789s
                core.get_node_timer(pos):start(math.random(1859, 3719))

            end,

            on_place = function(itemstack, placer, pointed_thing)

                itemstack = unilib.flora.sapling_on_place(
                    itemstack,
                    placer,
                    pointed_thing,
                    "unilib:plant_cactus_ordinary_seed",
                    {x = -2, y = -1, z = -2},
                    {x = 2, y = 5, z = 2},
                    4
                )

                return itemstack

            end,

            on_timer = function(pos)
                grow_seed_func(pos)
            end,
        }
    )
    unilib.register_craft({
        -- From default:large_cactus_seedling
        output = "unilib:plant_cactus_ordinary_seed",
        recipe = {
            {"", c_cactus, ""},
            {c_cactus, c_cactus, c_cactus},
            {"", c_cactus, ""},
        },
    })
    unilib.register_craft({
        -- From default:large_cactus_seedling
        type = "fuel",
        recipe = "unilib:plant_cactus_ordinary_seed",
        burntime = 5,
    })

    -- Enable cactus growth with fertilisers
    unilib.fertiliser.register_special("unilib:plant_cactus_ordinary", unilib.flora.grow_cactus)
    unilib.fertiliser.register_special("unilib:plant_cactus_ordinary_seed", grow_seed_func)

    -- Cactus decoration placed as a single node; the ABM in the "abm_standard_cactus_grow" package
    --      causes it to grow upwards
    unilib.register_decoration_generic("default_plant_cactus_ordinary", {
        -- From default/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:plant_cactus_ordinary",

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

    -- Cactus decoration placed as a multi-node plant
    unilib.register_decoration_generic("default_plant_cactus_ordinary_large", {
        -- From default/mapgen.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_plant_cactus_ordinary_large.mts",

        flags = "place_center_x, place_center_z",
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
