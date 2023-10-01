---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decorations_sea
-- Code:    GPLv3
-- Media:   CC BY 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local coral_noise = {
    offset = -0.0115,
    scale = 0.024,
    spread = {x = 100, y = 100, z = 100},
    seed = 111,
    octaves = 5,
    persist = 0.6
}

local single_coral_noise = {
    offset = 0.01,
    scale = 0.024,
    spread = {x = 100, y = 100, z = 100},
    seed = 111,
    octaves = 5,
    persist = 0.6
}

local sea_pickle_noise = {
    offset = 0.005,
    scale = 0.024,
    spread = {x = 100, y = 100, z = 100},
    seed = 111,
    octaves = 5,
    persist = 0.6
}

local grass_noise = {
    offset = 0.025,
    scale = 0.024,
    spread = {x = 100, y = 100, z = 100},
    seed = 1411,
    octaves = 5,
    persist = 0.6
}

local sparce_grass_noise = {
    offset = 0.015,
    scale = 0.024,
    spread = {x = 100, y = 100, z = 100},
    seed = 1411,
    octaves = 5,
    persist = 0.6
}

local short_grass_noise = {
    offset = 0.075,
    scale = 0.024,
    spread = {x = 100, y = 100, z = 100},
    seed = 25225,
    octaves = 5,
    persist = 0.6
}

local warm_biomes = {
    "desert_ocean",
    "sandstone_desert_ocean",
    "savanna_shore",
    "savanna_ocean",
    "rainforest_ocean",
}

local temperate_biomes = {
    "grassland",
    "deciduous_forest",
    "grassland_ocean",
    "coniferous_forest_ocean",
    "deciduous_forest_shore",
    "decidious_forest_ocean",
    "cold_desert_ocean",
}

local frozen_biomes = {
    "icesheet_ocean",
    "tundra_beach",
    "tundra_ocean",
    "taiga_ocean",
    "snowy_grassland_ocean",
}

local function register_sand_decoration(def)
    minetest.register_node(def.id .. "_node", {
        description = "Sand With " .. def.description,
        tiles = {"default_sand.png^" .. def.overlay, "default_sand.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1, not_in_creative_inventory = 1},
        sounds = default.node_sound_sand_defaults(),
        node_dig_prediction = "default:sand",
        node_placement_prediction = "",
        drop = def.id,
        after_destruct = function(pos, oldnode)
            minetest.set_node(pos, {name = "default:sand"})
        end
    })

    minetest.register_craftitem(def.id, {
        description = def.description,
        inventory_image = def.texture,
        on_place = function(itemstack, user, pointed_thing)
            if not user then return end
            if pointed_thing and pointed_thing.type == "node" then
                local pos = minetest.get_pointed_thing_position(pointed_thing)
                local node = minetest.get_node_or_nil(pos)
                if node and minetest.registered_nodes[node.name].name == "default:sand" then
                    local name = user:get_player_name()
                    if not minetest.is_protected(pos, name) then
                        minetest.set_node(pos, {name = def.id .. "_node"})
                        itemstack:take_item()
                        return itemstack
                    end
                end
            end
        end
    })
end

local function register_seagrass(def)
    local max_height = def.max_height or 3
    minetest.register_node(def.id, {
        description = def.description,
        drawtype = "plantlike_rooted",
        waving = 1,
        tiles = {"default_sand.png"},
        light_source = def.light_source,
        special_tiles = {{name = def.texture, tileable_vertical = true}},
        inventory_image = def.texture,
        paramtype = "light",
        paramtype2 = "leveled",
        groups = {snappy = 3},
        node_dig_prediction = "default:sand",
        node_placement_prediction = "",
        sounds = default.node_sound_sand_defaults({
            dig = {name = "default_dig_snappy", gain = 0.2},
            dug = {name = "default_grass_footstep", gain = 0.25},
        }),

        on_place = function(itemstack, placer, pointed_thing)
            -- Call on_rightclick if the pointed node defines it
            if pointed_thing.type == "node" and placer and
                    not placer:get_player_control().sneak then
                local node_ptu = minetest.get_node(pointed_thing.under)
                local def_ptu = minetest.registered_nodes[node_ptu.name]
                if def_ptu and def_ptu.on_rightclick then
                    return def_ptu.on_rightclick(pointed_thing.under, node_ptu, placer,
                        itemstack, pointed_thing)
                end
            end

            local pos = pointed_thing.under
            if minetest.get_node(pos).name ~= "default:sand" then
                return itemstack
            end

            local height = math.random(1, max_height)
            local pos_top = {x = pos.x, y = pos.y + height, z = pos.z}
            local node_top = minetest.get_node(pos_top)
            local def_top = minetest.registered_nodes[node_top.name]
            local player_name = placer:get_player_name()

            if def_top and def_top.liquidtype == "source" and
                    minetest.get_item_group(node_top.name, "water") > 0 then
                if not minetest.is_protected(pos, player_name) and
                        not minetest.is_protected(pos_top, player_name) then
                    minetest.set_node(pos, {name = def.id,
                        param2 = height * 16})
                    if not (creative and creative.is_enabled_for
                            and creative.is_enabled_for(player_name)) then
                        itemstack:take_item()
                    end
                else
                    minetest.chat_send_player(player_name, "Node is protected")
                    minetest.record_protection_violation(pos, player_name)
                end
            end

            return itemstack
        end,

        after_destruct  = function(pos, oldnode)
            minetest.set_node(pos, {name = "default:sand"})
        end
    })
end

local function register_coral_decoration(schemname, noisedef, biomes)
    minetest.register_decoration( {
        deco_type = "schematic",
        place_on = "default:sand",
        sidelen = 16,
        noise_params = noisedef,
        biomes = biomes,
        y_min = -32,
        y_max = -6,
        spawn_by = "default:water_source",
        num_spawn_by = 1,
        flags = "force_placement, all_floors",
        schematic = schemname,
        rotation = "random",
        place_offset_y = 0,
    })
end

local function register_tall_grass_decoration(name, hmin, hmax, noisedef, biomes)
    minetest.register_decoration({
        deco_type = "simple",
        place_on = "default:sand",
        sidelen = 16,
        noise_params = noisedef,
        biomes = biomes,
        y_min = -32,
        y_max = -hmax,
        spawn_by = "default:water_source",
        num_spawn_by = 1,
        flags = "force_placement, all_floors",
        decoration = name,
        param2 = hmin*16,
        param2_max = hmax*16,
        place_offset_y = -1,
    })
end

local function register_simple_decoration(name, noisedef, biomes)
    minetest.register_decoration({
        deco_type = "simple",
        place_on = "default:sand",
        sidelen = 16,
        noise_params = noisedef,
        biomes = biomes,
        y_min = -32,
        y_max = -1,
        spawn_by = "default:water_source",
        num_spawn_by = 1,
        flags = "force_placement, all_floors",
        decoration = name,
        param2 = 16,
        place_offset_y = -1,
    })
end

local function register_sand_decoration(name, fill_ratio, ymax, biomes)
    minetest.register_decoration({
        deco_type = "simple",
        place_on = "default:sand",
        sidelen = 16,
        fill_ratio = fill_ratio,
        biomes = biomes,
        y_min = -32,
        y_max = ymax,
        spawn_by = "default:water_source",
        num_spawn_by = 1,
        flags = "force_placement, all_floors",
        decoration = name,
        place_offset_y = -1,
    })
end
]]--
