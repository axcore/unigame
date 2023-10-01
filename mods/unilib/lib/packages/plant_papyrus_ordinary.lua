---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_papyrus_ordinary = {}

local S = unilib.intllib
local default_add_mode = unilib.imported_mod_table.default.add_mode
local mtg_plus_add_mode = unilib.imported_mod_table.mtg_plus.add_mode

local dirt_table = {}
dirt_table["unilib:dirt_ordinary"] = true
dirt_table["unilib:dirt_dry"] = true

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_papyrus_ordinary.register_papyrus_dirt(dirt_name, add_turf_nodes_flag)

    -- Original to unilib
    -- In the original minetest_game code, papyrus grows only on (the equivalents of) ordinary dirt
    --      and dry dirt, as well as any related dirt-with-turf nodes. Those dirts are the ones that
    --      occur in the minetest_game biomes, in which papyrus spawns
    -- unilib packages, during their execution phase (the .exec() function), can call this function
    --      to increase the number of dirts on which papyrus can grow
    --
    -- There is no need to call this function for ordinary and dry dirt; papyrus always grows on
    --      them and all associated dirt-with-turf nodes. If you like, your code can call this
    --      function with the arguments ( "unilib:dirt_ordinary", false ), which will remove the
    --      ability to grow on the associated dirt-with-turf nodes
    -- There is no need to call this function for any associated dirt-with-turf nodes; just make
    --      one call specifying the dirt node itself
    --
    -- Args:
    --      dirt_name (str): e.g. "unilib:dirt_silt_coarse"
    --      add_turf_nodes_flag (bool): If true, both the dirt and its dirt-with-turf nodes are
    --          added. If false (or nil), only the dirt node is added

    if add_turf_nodes_flag == nil then
        add_turf_nodes_flag = false
    end

    -- (Eliminate duplicates by using a table, rather than a list)
    dirt_table[dirt_name] = add_turf_nodes_flag

end

function unilib.pkg.plant_papyrus_ordinary.grow_func(pos, node)

    -- From default/functions.lua
    -- Wrapping the function in ABM action is necessary to make overriding them possible

    pos.y = pos.y - 1
    local full_name = minetest.get_node(pos).name
    if (
        full_name ~= "unilib:dirt_ordinary" and
        full_name ~= "unilib:dirt_ordinary_with_turf" and
        full_name ~= "unilib:dirt_ordinary_with_turf_dry" and
        full_name ~= "unilib:dirt_ordinary_with_litter_rainforest" and
        full_name ~= "unilib:dirt_dry" and
        full_name ~= "unilib:dirt_dry_with_turf_dry"
    ) then
        return
    end

    if not minetest.find_node_near(pos, 3, {"group:water"}) then
        return
    end

    pos.y = pos.y + 1
    local height = 0
    while node.name == "unilib:plant_papyrus_ordinary" and height < 4 do

        height = height + 1
        pos.y = pos.y + 1
        node = minetest.get_node(pos)

    end

    if height == 4 or node.name ~= "air" then
        return
    end

    if minetest.get_node_light(pos) < unilib.light_min_grow_sapling then
        return
    end

    minetest.set_node(pos, {name = "unilib:plant_papyrus_ordinary"})
    return true

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_papyrus_ordinary.init()

    return {
        description = "Ordinary papyrus",
        notes = "Papyrus grows steadily higher if planted on certain types of dirt from default" ..
                " (matching the biomes in which papyrus appears). No seed/sapling required",
        at_least_one = {"dirt_ordinary", "dirt_dry"},
    }

end

function unilib.pkg.plant_papyrus_ordinary.exec()

    unilib.register_node("unilib:plant_papyrus_ordinary", "default:papyrus", default_add_mode, {
        -- From default:papyrus
        description = unilib.annotate(S("Ordinary Papyrus"), "Cyperus papyrus"),
        tiles = {"unilib_plant_papyrus_ordinary.png"},
        groups = {flammable = 2, snappy = 3},
        sounds = unilib.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_plant_papyrus_ordinary.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
        },
        sunlight_propagates = true,
        walkable = unilib.blocking_papyrus_flag,
        wield_image = "unilib_plant_papyrus_ordinary.png",

        -- Digging the base node auto-digs papyrus nodes above it
        after_dig_node = function(pos, node, metadata, digger)
            unilib.dig_up(pos, node, digger)
        end,
    })
    unilib.register_craft({
        -- From default:papyrus
        type = "fuel",
        recipe = "unilib:plant_papyrus_ordinary",
        burntime = 3,
    })
    -- (not compatible with flowerpots)

    -- Enable papyrus growth with fertilisers
    unilib.register_special_fertilise(
        "unilib:plant_papyrus_ordinary", unilib.pkg.plant_papyrus_ordinary.grow_func
    )

    -- Dirt version for rainforest swamp
    unilib.register_decoration("default_plant_papyrus_ordinary_1", {
        -- From default/mapgen.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_plant_papyrus_ordinary_on_dirt_ordinary.mts",

        noise_params = {
            octaves = 3,
            offset = -0.3,
            persist = 0.7,
            scale = 0.7,
            seed = 354,
            spread = {x = 200, y = 200, z = 200},
        },
        sidelen = 16,
    })

    -- Dry dirt version for savanna shore
    unilib.register_decoration("default_plant_papyrus_ordinary_2", {
        -- From default/mapgen.lua
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_plant_papyrus_ordinary_on_dirt_dry.mts",

        noise_params = {
            octaves = 3,
            offset = -0.3,
            persist = 0.7,
            scale = 0.7,
            seed = 354,
            spread = {x = 200, y = 200, z = 200},
        },
        sidelen = 16,
    })

    if unilib.mtgame_tweak_flag then

        unilib.register_node(
            -- From mtg_plus:papyrus_block
            "unilib:plant_papyrus_ordinary_block",
            "mtg_plus:papyrus_block",
            mtg_plus_add_mode,
            {
                description = S("Ordinary Papyrus Block"),
                tiles = {
                    "unilib_plant_papyrus_ordinary_block_top.png",
                    "unilib_plant_papyrus_ordinary_block_top.png",
                    "unilib_plant_papyrus_ordinary_block_side2.png",
                    "unilib_plant_papyrus_ordinary_block_side2.png",
                    "unilib_plant_papyrus_ordinary_block_side.png",
                    "unilib_plant_papyrus_ordinary_block_side.png",
                },
                groups = {choppy = 2, flammable = 3, snappy = 2},
                sounds = unilib.sound_table.leaves,

                is_ground_content = false,
            }
        )
        unilib.register_craft_3x3({
            -- From mtg_plus:papyrus_block
            output = "unilib:plant_papyrus_ordinary_block",
            ingredient = "unilib:plant_papyrus_ordinary",
        })
        unilib.register_craft({
            -- From mtg_plus:papyrus_block
            output = "unilib:plant_papyrus_ordinary 9",
            recipe = {
                {"unilib:plant_papyrus_ordinary_block"},
            },
        })
        unilib.register_craft({
            -- From mtg_plus:papyrus_block
            type = "fuel",
            recipe = "unilib:plant_papyrus_ordinary_block",
            burntime = 9,
        })

    end

end

function unilib.pkg.plant_papyrus_ordinary.post()

    -- Compile a reverse lookup table, converting dirt nodes into dirt-with-turf nodes
    local reverse_table = {}

    for turf_name, data_table in pairs(unilib.dirt_with_turf_table) do

        local dirt_name = "unilib:" .. data_table.dirt_part_name
        if reverse_table[dirt_name] == nil then
            reverse_table[dirt_name] = {}
        end

        table.insert(reverse_table[dirt_name], turf_name)

    end

    -- Compile a list of dirt and dirt-with-turf nodes, on which the papyrus can grow
    local neighbour_list = {}
    for dirt_name, add_turf_nodes_flag in pairs(dirt_table) do

        table.insert(neighbour_list, dirt_name)
        if add_turf_nodes_flag and reverse_table[dirt_name] ~= nil then

            for _, turf_name in pairs(reverse_table[dirt_name]) do
                table.insert(neighbour_list, turf_name)
            end

        end

    end

    unilib.register_abm({
        label = "Ordinary papyrus growth [plant_papyrus_ordinary]",
        nodenames = {"unilib:plant_papyrus_ordinary"},
        neighbors = neighbour_list,

        chance = 71,
        interval = 14,

        action = function(...)
            unilib.pkg.plant_papyrus_ordinary.grow_func(...)
        end
    })

end
