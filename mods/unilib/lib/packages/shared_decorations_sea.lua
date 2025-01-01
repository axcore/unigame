---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decorations_sea
-- Code:    GPLv3
-- Media:   CC BY 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_decorations_sea = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.decorations_sea.add_mode

local noise_table = {
    coral = {
        octaves = 5,
        offset = -0.0115,
        persist = 0.6,
        scale = 0.024,
        seed = 111,
        spread = {x = 100, y = 100, z = 100},
    },
    grass = {
        octaves = 5,
        offset = 0.025,
        persist = 0.6,
        scale = 0.024,
        seed = 1411,
        spread = {x = 100, y = 100, z = 100},
    },
    seagrass_spoon = {
        octaves = 5,
        offset = 0.005,
        persist = 0.6,
        scale = 0.024,
        seed = 111,
        spread = {x = 100, y = 100, z = 100},
    },
    short_grass = {
        octaves = 5,
        offset = 0.075,
        persist = 0.6,
        scale = 0.024,
        seed = 25225,
        spread = {x = 100, y = 100, z = 100},
    },
    single_coral = {
        octaves = 5,
        offset = 0.01,
        persist = 0.6,
        scale = 0.024,
        seed = 111,
        spread = {x = 100, y = 100, z = 100},
    },
    sparse_grass = {
        octaves = 5,
        offset = 0.015,
        persist = 0.6,
        scale = 0.024,
        seed = 1411,
        spread = {x = 100, y = 100, z = 100},
    },
}

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_decorations_sea.warm_biome_list = {
    "default_desert_ocean",             -- From package biome_default_desert
    "default_desert_sandstone_ocean",   -- biome_default_desert_sandstone
    "default_rainforest_ocean",         -- biome_default_rainforest
    "default_savanna_shore",            -- biome_default_savanna
    "default_savanna_ocean",            -- biome_default_savanna
}

unilib.pkg.shared_decorations_sea.temperate_biome_list = {
    "default_desert_cold_ocean",        -- biome_default_desert_cold
    "default_forest_coniferous_ocean",  -- biome_default_forest_coniferous
    "default_forest_deciduous",         -- biome_default_forest_deciduous
    "default_forest_deciduous_ocean",   -- biome_default_forest_deciduous
    "default_forest_deciduous_shore",   -- biome_default_forest_deciduous
    "default_grassland",                -- biome_default_grassland
    "default_grassland_ocean",          -- biome_default_grassland
}

unilib.pkg.shared_decorations_sea.frozen_biome_list = {
    "default_grassland_snowy_ocean",    -- biome_default_grassland_snowy
    "default_icesheet_ocean",           -- biome_default_icesheet
    "default_taiga_ocean",              -- biome_default_taiga
    "default_tundra_beach",             -- biome_default_tundra
    "default_tundra_ocean",             -- biome_default_tundra
}

---------------------------------------------------------------------------------------------------
-- Shared functions (register nodes/craftitems)
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_decorations_sea.register_sand_item(data_table)

    -- Adapted from decorations_sea/nodes.lua
    -- Register seashell and starfish nodes
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "seashell_spiral"
    --      sand_orig_name (str): e.g. "decorations_sea:seashell_01_node", a node
    --      shell_orig_name (str): e.g. "decorations_sea:seashell_01", a craftitem
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      sand_description (str): e.g. "Spiral Seashell"
    --      shell_description (str): e.g. "Spiral Seashell"
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local sand_orig_name = data_table.sand_orig_name
    local shell_orig_name = data_table.shell_orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local sand_description = data_table.sand_description or S("Seashell In Sand")
    local shell_description = data_table.shell_description or S("Seashell")

    local sand_full_name = "unilib:sand_with_" .. part_name
    local shell_full_name = "unilib:misc_" .. part_name

    unilib.register_node(sand_full_name, sand_orig_name, replace_mode, {
        description = sand_description,
        tiles = {
            "unilib_sand_ordinary.png^unilib_misc_" .. part_name .. "_overlay.png",
            "unilib_sand_ordinary.png",
        },
        groups = {crumbly = 3, falling_node = 1, not_in_creative_inventory = 1, sand = 1},
        sounds = unilib.global.sound_table.sand,

        drop = shell_full_name,
        node_dig_prediction = "unilib:sand_ordinary",
        node_placement_prediction = "",

        after_destruct = function(pos, oldnode)
            core.set_node(pos, {name = "unilib:sand_ordinary"})
        end,
    })

    unilib.register_craftitem(shell_full_name, shell_orig_name, replace_mode, {
        description = shell_description,
        inventory_image = "unilib_misc_" .. part_name .. ".png",

        on_place = function(itemstack, user, pointed_thing)

            if not user then
                return
            end

            if pointed_thing and pointed_thing.type == "node" then

                local pos = core.get_pointed_thing_position(pointed_thing)
                local node = core.get_node_or_nil(pos)
                if node and core.registered_nodes[node.name].name == "unilib:sand_ordinary" then

                    local name = user:get_player_name()
                    if not core.is_protected(pos, name) then

                        core.set_node(pos, {name = sand_full_name})
                        itemstack:take_item()
                        return itemstack

                    end

                end

            end

        end,
    })

end

function unilib.pkg.shared_decorations_sea.register_seagrass(data_table)

    -- Adapted from decorations_sea/nodes.lua
    -- Register seagrass nodes
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "tape_blue"
    --      orig_name (str): e.g. "decorations_sea:seagrass_01"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Blue Tape Seagrass"
    --      light_source (int): e.g. 8 (or nil for non-glowing plants)
    --      max_height (int): e.g. 5
    --      sci_name (str): e.g. "Enhalus acoroides"
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Seagrass")
    local light_source = data_table.light_source or nil
    local max_height = data_table.max_height or 3
    local sci_name = data_table.sci_name or nil

    local full_name = "unilib:plant_seagrass_" .. part_name

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = unilib.utils.annotate(description, sci_name),
        tiles = {"unilib_sand_ordinary.png"},
        groups = {snappy = 3},
        sounds = unilib.sound.generate_sand({
            dig = {name = "unilib_dig_snappy", gain = 0.2},
            dug = {name = "unilib_grass_footstep", gain = 0.25},
        }),

        drawtype = "plantlike_rooted",
        inventory_image = "unilib_plant_seagrass_" .. part_name .. ".png",
        light_source = light_source,
        node_dig_prediction = "unilib:sand_ordinary",
        node_placement_prediction = "",
        paramtype = "light",
        paramtype2 = "leveled",
        special_tiles = {
            {name = "unilib_plant_seagrass_" .. part_name .. ".png", tileable_vertical = true},
        },
        waving = 1,

        after_destruct = function(pos, oldnode)
            core.set_node(pos, {name = "unilib:sand_ordinary"})
        end,

        --[[
        on_place = function(itemstack, placer, pointed_thing)

            -- Call on_rightclick if the pointed node defines it
            if pointed_thing.type == "node" and
                    placer and
                    not placer:get_player_control().sneak then

                local node_ptu = core.get_node(pointed_thing.under)
                local def_ptu = core.registered_nodes[node_ptu.name]
                if def_ptu and def_ptu.on_rightclick then

                    return def_ptu.on_rightclick(
                        pointed_thing.under, node_ptu, placer, itemstack, pointed_thing
                    )

                end

            end

            local pos = pointed_thing.under
            if core.get_node(pos).name ~= "unilib:sand_ordinary" then
                return itemstack
            end

            local height = math.random(1, max_height)
            local pos_top = {x = pos.x, y = pos.y + height, z = pos.z}
            local node_top = core.get_node(pos_top)
            local def_top = core.registered_nodes[node_top.name]
            local player_name = placer:get_player_name()

            if def_top and def_top.liquidtype == "source" and
                    core.get_item_group(node_top.name, "water") > 0 then

                if not core.is_protected(pos, player_name) and
                        not core.is_protected(pos_top, player_name) then

                    core.set_node(pos, {name = full_name, param2 = height * 16})
                    if not unilib.utils.is_creative(player_name) then
                        itemstack:take_item()
                    end

                else

                    core.chat_send_player(player_name, S("Node is protected"))
                    core.record_protection_violation(pos, player_name)

                end

            end

            return itemstack

        end,
        ]]--

        on_place = function(itemstack, placer, pointed_thing)

            return unilib.misc.place_in_medium(
                itemstack, placer, pointed_thing,
                {
                    need_under = "unilib:sand_ordinary",
                    displace_flag = true,
                    height = math.random(1, max_height),
                }
            )

        end,
    })

end

---------------------------------------------------------------------------------------------------
-- Shared functions (register decorations)
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_decorations_sea.register_coral_decoration(part_name, noise_type)

    -- Was register_coral_decoration()

    unilib.register_decoration_generic("decoration_sea_coral_block_" .. part_name, {
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_coral_block_" .. part_name .. ".mts",

        flags = "force_placement, all_floors",
        noise_params = noise_table[noise_type],
--      place_offset_y = 0,
        rotation = "random",
        sidelen = 16,
    })

end

function unilib.pkg.shared_decorations_sea.register_sand_decoration(part_name, count, fill_ratio)

    -- Was register_sand_decoration()

    unilib.register_decoration_generic("decoration_sea_" .. part_name .. "_" .. count, {
        deco_type = "simple",
        decoration = "unilib:" .. part_name,

        fill_ratio = fill_ratio,
        flags = "force_placement, all_floors",
        place_offset_y = -1,
        sidelen = 16,
    })

end

function unilib.pkg.shared_decorations_sea.register_simple_decoration(part_name, count, noise_type)

    -- Was register_simple_decoration()

    unilib.register_decoration_generic("decoration_sea_" .. part_name .. "_" .. count, {
        deco_type = "simple",
        decoration = "unilib:" .. part_name,

        flags = "force_placement, all_floors",
        noise_params = noise_table[noise_type],
        param2 = 16,
        place_offset_y = -1,
        sidelen = 16,
    })

end

function unilib.pkg.shared_decorations_sea.register_tall_grass_decoration(
    part_name, count, noise_type, mini_list
)
    -- Was register_tall_grass_decoration()

    unilib.register_decoration_generic("decoration_sea_" .. part_name .. "_tall_" .. count, {
        deco_type = "simple",
        decoration = "unilib:" .. part_name,

        flags = "force_placement, all_floors",
        noise_params = noise_table[noise_type],
        param2 = mini_list[2] * 16,
        param2_max = mini_list[1] * 16,
        place_offset_y = -1,
        sidelen = 16,
    })

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_decorations_sea.init()

    return {
        description = "Shared functions for corals and seagrasses (from decorations_sea)",
        depends = "sand_ordinary",
    }

end
