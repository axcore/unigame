---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/poisonivy
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_ivy_poison = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.poisonivy.add_mode

-- In original code, poison ivy grows only on a small selection of nodes...
local wall_name_table = {}
for _, wall_name in ipairs({
    "unilib:brick_ordinary_block",
    "unilib:dirt_ordinary",
    "unilib:dirt_ordinary_with_turf",
    "unilib:stone_ordinary",
    "unilib:stone_ordinary_cobble",
    "unilib:stone_ordinary_cobble_mossy",
    "unilib:stone_ordinary_with_coal",
    "unilib:stone_ordinary_with_iron",
    "unilib:tree_apple_trunk",
    "unilib:tree_jungle_trunk",
}) do
    wall_name_table[wall_name] = true
end

-- ...but if settings allow, they can grow on any suitable surface
local wall_group_list = {}
if unilib.plantlife_poison_ivy_unfussy_flag then
    wall_group_list = {"smoothstone", "cobble", "soil", "tree"}
end

-- Sproutlings next to walls spread as climbing ivy
local random_dir_list = {}
local dir_table = {}
for dir, facedir in pairs({north = 4, south = 5, west = 3, east = 2}) do

    table.insert(random_dir_list, dir)
    dir_table[dir] = facedir

end

-- Climbing ivy spreads to neighbouring wall nodes
local random_side_list = {"up", "down", "left", "right"}

-- The rate at which poison ivy grows/spreads (which is intended to happen slowly)
-- (We don't use unilib.sapling_grow_min, etc, because a low value would cause catastrophic
--      spreading)
local spread_delay = unilib.sapling_grow_default
local spread_chance = 30

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function can_grow(pos)

    local light = minetest.get_node_light(pos)

    if (not unilib.plantlife_poison_ivy_light_flag) or (light > 2 and light < 10) then
        return true
    else
        return false
    end

end

local function check_group(full_name)

    for _, group in pairs(wall_group_list) do

        if minetest.get_item_group(full_name , group) > 0 then
            return true
        end

    end

    return false

end

local function do_poison(player)

    if unilib.plantlife_poison_ivy_poison_flag then
        player:set_hp(player:get_hp() - unilib.nettle_damage_factor)
    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_ivy_poison.init()

    return {
        description = "Poison ivy",
        notes = "Poison ivy spreads (very slowly) on suitable surfaces. Depending on settings," ..
                " it can be poisonous (or not), and require certain light levels (or not)",
        optional = {
            "brick_ordinary",
            "dirt_ordinary",
            "stone_ordinary",
            "stone_ordinary_with_coal",
            "stone_ordinary_with_iron",
            "tree_apple",
            "tree_jungle",
        },
    }

end

function unilib.pkg.plant_ivy_poison.exec()

    local damage = nil
    if unilib.plantlife_poison_ivy_poison_flag then
        damage = 1 * unilib.nettle_damage_factor
    end

    unilib.register_node("unilib:plant_ivy_poison_seedling", "poisonivy:seedling", mode, {
        -- From poisonivy:seedling
        description = unilib.annotate(S("Poison Ivy Seedling"), "Toxicodendron radicans"),
        tiles = {"unilib_plant_ivy_poison_seedling.png"},
        groups = {flora_block = 1, poisonivy = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        damage_per_second = damage,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_ivy_poison_seedling.png",
        paramtype = "light",
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_plant_ivy_poison_seedling.png",

        -- (A timer to replace the biome_lib.update_plant() calls in the original code; code
        --      original to unilib)
        on_construct = function(pos)
            minetest.get_node_timer(pos):start(spread_delay)
        end,

        on_punch = function(pos, node, player, pointed_thing)
            do_poison(player)
        end,

        on_timer = function(pos)

            if can_grow(pos) then

                -- N.B. The timer is not restarted by calls to .swap_node()
                --minetest.swap_node(pos, {name = "unilib:plant_ivy_poison_sproutling"})
                minetest.remove_node(pos)
                minetest.set_node(pos, {name = "unilib:plant_ivy_poison_sproutling"})

            else

                -- Continue the timer
                return true

            end

        end,
    })
    unilib.register_plant_in_pot("unilib:plant_ivy_poison_seedling", "poisonivy:seedling")

    unilib.register_node("unilib:plant_ivy_poison_sproutling", "poisonivy:sproutling", mode, {
        -- From poisonivy:sproutling
        description = unilib.annotate(S("Poison Ivy Sproutling"), "Toxicodendron radicans"),
        tiles = {"unilib_plant_ivy_poison_sproutling.png"},
        -- N.B. not_in_creative_inventory = 1 not in original code
        groups = {flora_block = 1, not_in_creative_inventory = 1, poisonivy = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        damage_per_second = damage,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_ivy_poison_sproutling.png",
        paramtype = "light",
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_plant_ivy_poison_sproutling.png",

        -- (A timer to replace the biome_lib.update_plant() calls in the original code; code
        --      original to unilib)
        on_construct = function(pos)
            minetest.get_node_timer(pos):start(spread_delay)
        end,

        on_punch = function(pos, node, player, pointed_thing)
            do_poison(player)
        end,

        on_timer = function(pos)

            -- Spread to any nearby walls at random intervals
            if math.random(spread_chance) > 1 then
                return true
            end

            local above_pos = {x = pos.x, y = pos.y + 1, z = pos.z}
            local above_node = minetest.get_node(above_pos)
            if above_node.name == "air" and can_grow(above_pos) then

                -- Fisher-Yates shuffle so the direction of growth is random
                for i = #random_dir_list, 2, -1 do

                    local j = math.random(i)
                    random_dir_list[i], random_dir_list[j] = random_dir_list[j], random_dir_list[i]

                end

                -- Add a climber on the first suitable wall
                local current_table = {
                    north = minetest.get_node({x = pos.x, y = pos.y + 1, z = pos.z + 1}),
                    south = minetest.get_node({x = pos.x, y = pos.y + 1, z = pos.z - 1}),
                    west = minetest.get_node({x = pos.x - 1, y = pos.y + 1, z = pos.z}),
                    east = minetest.get_node({x = pos.x + 1, y = pos.y + 1, z = pos.z}),
                }

                for _, dir in ipairs(random_dir_list) do

                    local wall_node = current_table[dir]
                    if wall_name_table[wall_node.name] ~= nil or check_group(wall_node.name) then

                        -- N.B. The timer is not restarted by calls to .swap_node()
                        --[[
                        minetest.swap_node(
                            above_pos,
                            {name = "unilib:plant_ivy_poison_climbing", param2 = dir_table[dir]}
                        )
                        ]]--
                        minetest.remove_node(above_pos)
                        minetest.set_node(
                            above_pos,
                            {name = "unilib:plant_ivy_poison_climbing", param2 = dir_table[dir]}
                        )

                        -- If growth in one direction is not possible, try the others
                        break

                    end

                end

            end

            --  Keep the timer going, so that if the player removes the climber, a new climber can
            --      be placed (perhaps an a different adjoining wall)
            return true

        end,
    })
    -- (not compatible with flowerpots)

    unilib.register_node("unilib:plant_ivy_poison_climbing", "poisonivy:climbing", mode, {
        -- From poisonivy:climbing
        description = unilib.annotate(S("Climbing Poison Ivy"), "Toxicodendron radicans"),
        tiles = {"unilib_plant_ivy_poison_climbing.png"},
        -- N.B. not_in_creative_inventory = 1 not in original code
        groups = {flora_block = 1, not_in_creative_inventory = 1, poisonivy = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        damage_per_second = damage,
        drawtype = "signlike",
        inventory_image = "unilib_plant_ivy_poison_climbing.png",
        paramtype = "light",
        paramtype2 = "wallmounted",
        selection_box = {
            type = "wallmounted",
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_plant_ivy_poison_climbing.png",

        -- (A timer to replace the biome_lib.update_plant() calls in the original code; code
        --      original to unilib)
        on_construct = function(pos)
            minetest.get_node_timer(pos):start(spread_delay)
        end,

        on_punch = function(pos, node, player, pointed_thing)
            do_poison(player)
        end,

        on_timer = function(pos)

            -- Spread to adjoining walls at random intervals
            if math.random(spread_chance) > 1 then
                return true
            end

            local climbing_node = minetest.get_node(pos)
            local side_pos_table = {
                up = {x = pos.x, y = pos.y + 1, z = pos.z},
                down = {x = pos.x, y = pos.y - 1, z = pos.z},
            }

            if climbing_node.param2 == 4 or climbing_node.param2 == 5 then

                -- North/south-facing node
                side_pos_table["left"] = {x = pos.x + 1, y = pos.y, z = pos.z}
                side_pos_table["right"] = {x = pos.x - 1, y = pos.y, z = pos.z}

            elseif climbing_node.param2 == 2 or climbing_node.param2 == 3 then

                -- West/east-facing node
                side_pos_table["left"] = {x = pos.x, y = pos.y, z = pos.z + 1}
                side_pos_table["right"] = {x = pos.x, y = pos.y, z = pos.z - 1}

            end

            -- Fisher-Yates shuffle so the direction of growth is random
            for i = #random_side_list, 2, -1 do

                local j = math.random(i)
                random_side_list[i], random_side_list[j] = random_side_list[j], random_side_list[i]

            end

            for _, side in ipairs(random_side_list) do

                local side_pos = side_pos_table[side]
                local side_node = minetest.get_node(side_pos)

                local wall_pos, wall_node
                if climbing_node.param2 == 2 then
                    wall_pos = {x = side_pos.x + 1, y = side_pos.y, z = side_pos.z}
                elseif climbing_node.param2 == 3 then
                    wall_pos = {x = side_pos.x - 1, y = side_pos.y, z = side_pos.z}
                elseif climbing_node.param2 == 4 then
                    wall_pos = {x = side_pos.x, y = side_pos.y, z = side_pos.z + 1}
                elseif climbing_node.param2 == 5 then
                    wall_pos = {x = side_pos.x, y = side_pos.y, z = side_pos.z - 1}
                end

                wall_node = minetest.get_node(wall_pos)
                if side_node.name == "air" and can_grow(side_pos) and (
                    wall_name_table[wall_node.name] ~= nil or
                    check_group(wall_node.name)
                ) then

                    -- N.B. The timer is not restarted by calls to .swap_node()
                    --[[
                    minetest.swap_node(
                        side_pos,
                        {name = "unilib:plant_ivy_poison_climbing", param2 = climbing_node.param2}
                    )
                    ]]--
                    minetest.remove_node(side_pos)
                    minetest.set_node(
                        side_pos,
                        {name = "unilib:plant_ivy_poison_climbing", param2 = climbing_node.param2}
                    )

                    -- If growth in one direction is not possible, try the others
                    break

                end

            end

            --  Keep the timer going, so that if the player removes the climber, a new climber can
            --      be placed (perhaps an a different adjoining wall)
            return true

        end,
    })
    -- (not compatible with flowerpots)

    unilib.register_decoration("plant_ivy_poison", {
        deco_type = "simple",
        decoration = "unilib:plant_ivy_poison_seedling",

        fill_ratio = unilib.biome_lib_fill_ratio,
    })

end
