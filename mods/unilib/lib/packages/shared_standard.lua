---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    fire
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    flowers
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_standard = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.flowers.add_mode

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

-- Create a table of cobble nodes (including stairs and walls) that can be converted to mossy cobble
--      nodes
unilib.pkg.shared_standard.moss_table = {}
-- Flag set to true if the moss table is not empty
unilib.pkg.shared_standard.moss_flag = false

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_standard.flora_spread(pos, node)

    -- Adapted from flowers/init.lua
    -- Called by the "abm_standard_flora_spread" package
    -- The original code was a public function to enable overeride by mods
    --
    -- N.B. Because the original function is nullified by code in "abm_standard_flora_spread"
    --      package, this function handles both unilib sands and their minetest_game equivalents
    --
    -- Args:
    --      pos (table): e.g. {x = 1, y = 1, z = 1}
    --      node (table): e.g. {name = "foobar", param1 = 15, param2 = 0}

    pos.y = pos.y - 1
    local under = core.get_node(pos)
    pos.y = pos.y + 1

    -- Notes from flowers:
    -- Replace flora with dry shrub in desert sand and silver sand, as this is the only way to
    --      generate them. However, preserve grasses in sand dune biomes
    -- (In case the original sand node exists in the game, check for that, too)
    if core.get_item_group(under.name, "sand") == 1 and
            under.name ~= "unilib:sand_ordinary" and
            under.name ~= "default:sand" then

        if unilib.global.pkg_executed_table["plant_shrub_dry"] ~= nil then

            core.set_node(pos, {name = "unilib:plant_shrub_dry"})
            return

        elseif core.registered_nodes["default:sand"] ~= nil then

            core.set_node(pos, {name = "default:dry_shrub"})
            return

        end

    end

    if core.get_item_group(under.name, "soil") == 0 then
        return
    end

    local light = core.get_node_light(pos)
    if not light or light < unilib.constant.light_min_grow_sapling then
        return
    end

    local pos0 = vector.subtract(pos, 4)
    local pos1 = vector.add(pos, 4)
    -- Notes from flowers:
    -- Testing shows that a threshold of 3 results in an appropriate maximum density of
    --      approximately 7 flora per 9x9 area.
    if #core.find_nodes_in_area(pos0, pos1, "group:flora") > 3 then
        return
    end

    local soils = core.find_nodes_in_area_under_air(pos0, pos1, "group:soil")
    local num_soils = #soils
    if num_soils >= 1 then

        for si = 1, math.min(3, num_soils) do

            local soil = soils[math.random(num_soils)]
            local soil_name = core.get_node(soil).name
            local soil_above = {x = soil.x, y = soil.y + 1, z = soil.z}
            light = core.get_node_light(soil_above)
            if light and light >= unilib.constant.light_min_grow_sapling and
                    -- Only spread to same surface node
                    soil_name == under.name and
                    -- Desert sand is in the soil group
                    soil_name ~= "unilib:sand_desert" and
                    soil_name ~= "default:desert_sand" then

                core.set_node(soil_above, {name = node.name})

            end

        end

    end

end

function unilib.pkg.shared_standard.mushroom_spread(pos, node)

    -- Adapted from flowers/init.lua
    -- Called by the ABM code in "abm_standard_mushroom_spread" package, etc
    -- The original code was a public function to enable overeride by mods
    --
    -- Args:
    --      pos (table): e.g. {x = 1, y = 1, z = 1}
    --      node (table): e.g. {name = "unilib:foobar", param1 = 15, param2 = 0}

    if core.get_node_light(pos, 0.5) > 3 then

        if core.get_node_light(pos, nil) == 15 then
            core.remove_node(pos)
        end

        return

    end

    local positions = core.find_nodes_in_area_under_air(
        {x = pos.x - 1, y = pos.y - 2, z = pos.z - 1},
        {x = pos.x + 1, y = pos.y + 1, z = pos.z + 1},
        {"group:soil", "group:tree"}
    )
    if #positions == 0 then
        return
    end

    local pos2 = positions[math.random(#positions)]
    pos2.y = pos2.y + 1
    if core.get_node_light(pos2, 0.5) <= 3 then
        core.set_node(pos2, {name = node.name})
    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_standard.init()

    return {
        description = "Shared functions/variables for standard ABMs/LBMs (original to unilib)",
    }

end

function unilib.pkg.shared_standard.exec()

    -- Create the table of convertable cobble nodes
    for part_name, data_table in pairs(unilib.global.stone_table) do

        if data_table.moss_flag then

            local cobble_name = "unilib:stone_" .. part_name .. "_cobble"
            local mossy_name = cobble_name .. "_mossy"

            unilib.pkg.shared_standard.moss_table[cobble_name] = mossy_name

            -- To keep things simple, only the four basic stair types from minetest_game/stairs can
            --      become mossy
            if unilib.global.add_stairs_any_flag then

                unilib.pkg.shared_standard.moss_table[unilib.stairs.convert_simple(cobble_name)] =
                        unilib.stairs.convert_simple(mossy_name)
                unilib.pkg.shared_standard.moss_table[unilib.stairs.convert_inner(cobble_name)] =
                        unilib.stairs.convert_inner(mossy_name)
                unilib.pkg.shared_standard.moss_table[unilib.stairs.convert_outer(cobble_name)] =
                        unilib.stairs.convert_outer(mossy_name)
                unilib.pkg.shared_standard.moss_table[unilib.stairs.convert_slab(cobble_name)] =
                        unilib.stairs.convert_slab(mossy_name)

            end

            if unilib.setting.add_walls_flag then

                unilib.pkg.shared_standard.moss_table[cobble_name .. "_wall"] =
                        cobble_name .. "_mossy_wall"

            end

            unilib.pkg.shared_standard.moss_flag = true

        end

    end

end
