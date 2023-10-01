---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- abms.lua
--      Set up shared ABMs
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- unilib standard ABMs can be enabled, or not, depending on Minetest settings and any packages that
--      have been loaded
local enable_abm_flag = unilib.activate_standard_abm_lbm_flag
-- (The "disable" setting overrides everything else)
if unilib.disable_standard_abm_lbm_flag then
    enable_abm_flag = false
elseif unilib.enable_standard_abm_lbm_flag then
    enable_abm_flag = true
end

-- Fire can be disabled in Minetest settings; decide whether this applies or not
local fire_enabled_flag = minetest.settings:get_bool("enable_fire")
if fire_enabled_flag == nil then

    -- enable_fire setting not specified, check for disable_fire
    local fire_disabled_flag = minetest.settings:get_bool("disable_fire")
    if fire_disabled_flag == nil then

        -- Neither setting specified, check whether singleplayer
        fire_enabled_flag = minetest.is_singleplayer()

    else

        fire_enabled_flag = not fire_disabled_flag

    end

end

---------------------------------------------------------------------------------------------------
-- cactus_grow ABM
---------------------------------------------------------------------------------------------------

-- Adadpted from default/functions.lua
-- Handles growth of a cactus from a single block upwards

if unilib.abm_replace_table.cactus_grow ~= nil then

    -- Override the standard ABM with one specified by a package
    unilib.abm_replace_table.cactus_grow()

elseif enable_abm_flag then

    unilib.register_abm({
        label = "Cactus growth [unilib]",
        nodenames = {"group:cactus_grow"},
        neighbors = {"group:sand"},

        chance = 83,
        interval = 12,

        action = function(pos, node)
            unilib.grow_cactus_callback(pos, node)
        end,
    })

end

---------------------------------------------------------------------------------------------------
-- crop_grow ABM
---------------------------------------------------------------------------------------------------

-- Adapted from farming_redo/init.lua
-- Handles any growth stages that have been omitted, or any crops from other mods that have been
--      added to the map, that have since been converted to farming_redo crops
if unilib.abm_replace_table.crop_grow ~= nil then

    -- Override the standard ABM with one specified by a package
    unilib.abm_replace_table.crop_grow()

elseif enable_abm_flag then

    unilib.register_abm({
        label = "Crop growth [unilib]",
        nodenames = {"group:growing"},

        catch_up = false,
        chance = 1,
        interval = 300,

        action = function(pos, node)
            unilib.prepare_growth_callback(pos, node)
        end,
    })

end

---------------------------------------------------------------------------------------------------
-- flame_ignite, flame_remove ABMs
---------------------------------------------------------------------------------------------------

-- Adapted from fire/init.lua

if unilib.abm_replace_table.flame_ignite ~= nil then

    -- Override the standard ABM with one specified by a package
    unilib.abm_replace_table.flame_ignite(fire_enabled_flag)

elseif enable_abm_flag and
        fire_enabled_flag and
        unilib.pkg_executed_table["fire_ordinary"] ~= nil then

    -- Ignite neighboring nodes, add basic flames
    unilib.register_abm({
        label = "Ignite flame [unilib]",
        nodenames = {"group:flammable"},
        neighbors = {"group:igniter"},

        catch_up = false,
        chance = 12,
        interval = 7,

        action = function(pos)

            local p = minetest.find_node_near(pos, 1, {"air"})
            if p then
                minetest.set_node(p, {name = "unilib:fire_ordinary"})
            end

        end,
    })

end

if unilib.abm_replace_table.flame_remove ~= nil then

    -- Override the standard ABM with one specified by a package
    unilib.abm_replace_table.flame_remove(fire_enabled_flag)

elseif enable_abm_flag and
        fire_enabled_flag and
        unilib.pkg_executed_table["fire_ordinary"] ~= nil then

    -- Remove flammable nodes around basic flame
    unilib.register_abm({
        label = "Remove flammable nodes [unilib]",
        nodenames = {"unilib:fire_ordinary"},
        neighbors = "group:flammable",

        catch_up = false,
        chance = 18,
        interval = 5,

        action = function(pos)

            local p = minetest.find_node_near(pos, 1, {"group:flammable"})
            if not p then
                return
            end

            local flammable_node = minetest.get_node(p)
            local def = minetest.registered_nodes[flammable_node.name]

            if def.on_burn then

                def.on_burn(p)

            else

                minetest.remove_node(p)
                minetest.check_for_falling(p)

            end

        end,
    })

end

---------------------------------------------------------------------------------------------------
-- flora_spread ABM
---------------------------------------------------------------------------------------------------

-- Adapted from flowers/init.lua

if unilib.abm_replace_table.flora_spread ~= nil then

    -- Override the standard ABM with one specified by a package
    unilib.abm_replace_table.flora_spread()

elseif enable_abm_flag then

    unilib.register_abm({
        label = "Flora spread (for flowers and some grasses) [unilib]",
        nodenames = {"group:flora"},

        chance = 300,
        interval = 13 / unilib.abm_spread_factor,

        -- (Function in ..lib/shared/flora.lua)
        action = function(...)
            unilib.flora_spread(...)
        end,
    })

end

-- (Nullify the original minetest_game ABM, if present. This prevents marram grass from turning into
--      dry shrubs on unilib:sand_ordinary beaches)
if enable_abm_flag and minetest.get_modpath("flowers") and flowers.flower_spread ~= nil then
    function flowers.flower_spread() end
end

---------------------------------------------------------------------------------------------------
-- ice_snow_melt ABM
---------------------------------------------------------------------------------------------------

-- Adapted from snow/srcs/abms.lua
-- Any node with the "melts" group will melt when near warm nodes (lava, fire, torches etc)
-- The amount of water that replaces the node is defined by the group number:
--      1         - water source node
--      2         - deep flowing water
--      3 or more - shallow flowing water

local function ice_snow_melt(pos, node)

    -- Default water, in case no specific water is specified
    local c_source = "unilib:liquid_water_ordinary_source"
    local c_flowing = "unilib:liquid_water_ordinary_flowing"

    if unilib.ice_snow_melting_table[node.name] ~= nil then

        c_source = unilib.ice_snow_melting_table[node.name]["source"]
        c_flowing = unilib.ice_snow_melting_table[node.name]["flowing"]

    end

    local intensity = minetest.get_item_group(node.name, "melts")
    if intensity == 1 then

        minetest.set_node(pos, {name = c_source})

    elseif intensity == 2 then

        minetest.set_node(
            pos,
            {name = c_flowing, param2 = 7}
        )

    elseif intensity >= 3 then

        minetest.set_node(
            pos,
            {name = c_flowing, param2 = 3}
        )

    else

        return

    end

end

if unilib.abm_replace_table.ice_snow_melt ~= nil then

    -- Override the standard ABM with one specified by a package
    unilib.abm_replace_table.ice_snow_melt()

elseif enable_abm_flag then

    unilib.register_abm({
        label = "Ice/snow melting [unilib]",
        nodenames = {"group:melts"},
        neighbors = {
            "group:igniter",
            -- N.B. default:torch in original code
            "group:torch",
            "group:hot",
            -- N.B. Compatibility with earthen furnace (etc) not in original code
            "group:active_furnace",
        },

        chance = 2,
        interval = 10,

        action = function(...)
            ice_snow_melt(...)
        end,
    })

end

---------------------------------------------------------------------------------------------------
-- lava_cool ABM
---------------------------------------------------------------------------------------------------

-- Adapted from default/functions.lua
-- Any lava source/flowing nodes have already been registered in a call to unilib.register_lava()

local function cool_lava(pos, node)

    if unilib.lava_cooling_table[node.name] ~= nil then
        minetest.set_node(pos, {name = unilib.lava_cooling_table[node.name]})
    else
        minetest.set_node(pos, {name = "unilib:stone_ordinary"})
    end

    minetest.sound_play(
        "unilib_cool_lava",
        {pos = pos, max_hear_distance = 16, gain = 0.25},
        true
    )

end

local node_list = {}
for lava_name, cooled_name in pairs(unilib.lava_cooling_table) do

    -- Check that both the package that creates both the lava node and cooled node has actually
    --      been loaded; if not, the abm will cause a crash
    if minetest.registered_nodes[lava_name] ~= nil and
            minetest.registered_nodes[cooled_name] ~= nil then
        table.insert(node_list, lava_name)
    end

end

if unilib.abm_replace_table.lava_cool ~= nil then

    -- Override the standard ABM with one specified by a package
    unilib.abm_replace_table.lava_cool(node_list)

elseif enable_abm_flag and minetest.settings:get_bool("enable_lavacooling") ~= false then

    unilib.register_abm({
        label = "Lava cooling [unilib]",
        nodenames = node_list,
        neighbors = {"group:cools_lava", "group:water"},

        catch_up = false,
        chance = 2,
        interval = 2,

        action = function(...)
            cool_lava(...)
        end,
    })

end

---------------------------------------------------------------------------------------------------
-- moss_grow ABM
---------------------------------------------------------------------------------------------------

-- Adapted from default/functions.lua and underch/init.lua
-- Moss grows on cobble (and some of its stair variants) when they are near water

local moss_table = {}
local moss_flag = false

-- Create a table of cobble nodes (including stairs and walls) that can be converted to mossy cobble
--      nodes
for part_name, data_table in pairs(unilib.stone_table) do

    if data_table.moss_flag then

        local cobble_name = "unilib:stone_" .. part_name .. "_cobble"
        local mossy_name = cobble_name .. "_mossy"

        moss_table[cobble_name] = mossy_name

        -- To keep things simple, only the four basic stair types from minetest_game/stairs can
        --      become mossy
        if unilib.add_stairs_any_flag then

            moss_table[unilib.convert_stairs_simple(cobble_name)] =
                    unilib.convert_stairs_simple(mossy_name)
            moss_table[unilib.convert_stairs_inner(cobble_name)] =
                    unilib.convert_stairs_inner(mossy_name)
            moss_table[unilib.convert_stairs_outer(cobble_name)] =
                    unilib.convert_stairs_outer(mossy_name)
            moss_table[unilib.convert_stairs_slab(cobble_name)] =
                    unilib.convert_stairs_slab(mossy_name)

        end

        if unilib.add_walls_flag then
            moss_table[cobble_name .. "_wall"] = cobble_name .. "_mossy_wall"
        end

        moss_flag = true

    end

end

if unilib.abm_replace_table.moss_grow ~= nil then

    -- Override the standard ABM with one specified by a package
    unilib.abm_replace_table.moss_grow(moss_flag, moss_table)

elseif enable_abm_flag and moss_flag then

    unilib.register_abm({
        label = "Moss growth on cobble [unilib]",
        nodenames = {"group:cobble", "group:wall"},
        neighbors = {"group:water"},

        catch_up = false,
        chance = 200,
        interval = 16,

        action = function(pos, node)

            node.name = moss_table[node.name]
            if node.name then
                minetest.set_node(pos, node)
            end

        end,
    })

end

---------------------------------------------------------------------------------------------------
-- moss_spread ABM
---------------------------------------------------------------------------------------------------

-- Adapted from snow/src/abms.lua
-- Moss grows on cobble (and some of its stair variants) when they are near moss

if unilib.abm_replace_table.moss_spread ~= nil then

    -- Override the standard ABM with one specified by a package
    unilib.abm_replace_table.moss_spread(moss_flag, moss_table)

elseif enable_abm_flag and moss_flag then

    unilib.register_abm({
        label = "Moss spread to cobble [unilib]",
        nodenames = {"group:cobble", "group:wall"},
        neighbors = {"group:moss"},

        catch_up = false,
        chance = 6,
        interval = 20,

        action = function(pos, node)

            node.name = moss_table[node.name]
            if node.name then
                minetest.set_node(pos, node)
            end

        end,
    })

end

---------------------------------------------------------------------------------------------------
-- mushroom_spread ABM
---------------------------------------------------------------------------------------------------

-- Adapted from flowers/init.lua
-- Mushrooms in group:mushroom only spread in low light, and strong light kills them

if unilib.abm_replace_table.mushroom_spread ~= nil then

    -- Override the standard ABM with one specified by a package
    unilib.abm_replace_table.mushroom_spread()

elseif enable_abm_flag then

    unilib.register_abm({
        label = "Mushroom spread [unilib]",
        nodenames = {"group:mushroom"},

        chance = 150,
        interval = 11 / unilib.abm_spread_factor,

        -- (Function in ..lib/shared/flowers.lua)
        action = function(...)
            unilib.mushroom_spread(...)
        end,
    })

end

---------------------------------------------------------------------------------------------------
-- oil_ignite ABM
---------------------------------------------------------------------------------------------------

-- Adapted from forest/oil.lua

if unilib.abm_replace_table.oil_ignite ~= nil then

    -- Override the standard ABM with one specified by a package
    unilib.abm_replace_table.oil_ignite(fire_enabled_flag)

elseif enable_abm_flag and
        fire_enabled_flag and
        unilib.pkg_executed_table["fire_ordinary"] ~= nil then

    unilib.register_abm({
        label = "Oil ignition [unilib]",
        nodenames = {"group:oil"},
        neighbors = {"group:igniter"},

        chance = 10,
        interval = 2,

        action = function(pos)

            minetest.set_node(pos, {name = "unilib:fire_ordinary"})
            minetest.sound_play("unilib_cool_lava", {pos = pos,  gain = 0.25})

        end,
    })

end

---------------------------------------------------------------------------------------------------
-- soil_farm ABM
---------------------------------------------------------------------------------------------------

-- If water is near dry soil, then convert it to wet soil (and vice-versa)
if enable_abm_flag then

    if not unilib.mtgame_tweak_flag then

        -- Adapted from minetest_game/farming/nodes.lua
        unilib.register_abm({
            label = "Farming soil [unilib]",
            nodenames = {"group:field"},

            chance = 4,
            interval = 15,

            action = function(pos, node)

                local n_def = minetest.registered_nodes[node.name] or nil
                local wet = n_def.soil.wet or nil
                local base = n_def.soil.base or nil
                local dry = n_def.soil.dry or nil
                if not n_def or not n_def.soil or not wet or not base or not dry then
                    return
                end

                pos.y = pos.y + 1
                local nn = minetest.get_node_or_nil(pos)
                if not nn or not nn.name then
                    return
                end

                local nn_def = minetest.registered_nodes[nn.name] or nil
                pos.y = pos.y - 1

                if nn_def and
                        nn_def.walkable and
                        minetest.get_item_group(nn.name, "plant") == 0 then

                    minetest.set_node(pos, {name = base})
                    return

                end

                -- Check if there is water nearby
                local wet_lvl = minetest.get_item_group(node.name, "wet")
                if minetest.find_node_near(pos, 3, {"group:water"}) then

                    -- If it is dry soil and not base node, turn it into wet soil
                    if wet_lvl == 0 then
                        minetest.set_node(pos, {name = wet})
                    end

                else

                    -- Only turn back into dry soil if there are no unloaded blocks (and therefore
                    --      possible water sources) nearby
                    if not minetest.find_node_near(pos, 3, {"ignore"}) then

                        -- Turn it back into base if it is already dry
                        if wet_lvl == 0 then

                            -- Only turn it back if there is no plant/seed on top of it
                            if minetest.get_item_group(nn.name, "plant") == 0 and
                                    minetest.get_item_group(nn.name, "seed") == 0 then
                                minetest.set_node(pos, {name = base})
                            end

                        -- If it's wet, turn it back into dry soil
                        elseif wet_lvl == 1 then

                            minetest.set_node(pos, {name = dry})

                        end

                    end

                end

            end,
        })

    else

        -- Adapted from farming_redo/soil.lua
        unilib.register_abm({
            label = "Farming soil [unilib]",
            nodenames = {"group:field"},

            catch_up = false,
            chance = 4,
            interval = 15,

            action = function(pos, node)

                local ndef = minetest.registered_nodes[node.name]
                if not ndef or
                        not ndef.soil or
                        not ndef.soil.wet or
                        not ndef.soil.base or
                        not ndef.soil.dry then
                    return
                end

                pos.y = pos.y + 1
                local nn = minetest.get_node_or_nil(pos)
                pos.y = pos.y - 1

                if nn then
                    nn = nn.name
                else
                    return
                end

                -- Check what is on top of the soil. If solid/not plant, then change soil to dirt
                if minetest.registered_nodes[nn] and
                        minetest.registered_nodes[nn].walkable and
                        minetest.get_item_group(nn, "plant") == 0 then

                    minetest.set_node(pos, {name = ndef.soil.base})
                    return

                end

                -- If map around the soil is not loaded, then skip until loaded
                if minetest.find_node_near(pos, 3, {"ignore"}) then
                    return
                end

                -- Check if water is within 3 nodes horizontally and 1 below
                if #minetest.find_nodes_in_area(
                    {x = pos.x + 3, y = pos.y - 1, z = pos.z + 3},
                    {x = pos.x - 3, y = pos.y, z = pos.z - 3},
                    {"group:water"}
                ) > 0 then

                    minetest.set_node(pos, {name = ndef.soil.wet})

                elseif node.name == ndef.soil.wet then

                    minetest.set_node(pos, {name = ndef.soil.dry})

                elseif node.name == ndef.soil.dry and minetest.get_item_group(nn, "plant") == 0 then

                    minetest.set_node(pos, {name = ndef.soil.base})

                end

            end,
        })

    end

end

---------------------------------------------------------------------------------------------------
-- tnt_ignite ABM
---------------------------------------------------------------------------------------------------

-- Adapted from tnt/init.lua

if unilib.abm_replace_table.tnt_ignite ~= nil then

    -- Override the standard ABM with one specified by a package
    unilib.abm_replace_table.tnt_ignite()

elseif enable_abm_flag and unilib.enable_tnt_flag then

    unilib.register_abm({
        label = "Ordinary TNT ignition [unilib]",
        nodenames = {"group:tnt", "unilib:tnt_gunpowder"},
        neighbors = {
            "unilib:fire_ordinary",
            "unilib:liquid_lava_ordinary_flowing",
            "unilib:liquid_lava_ordinary_source",
        },

        chance = 1,
        interval = 4,

        action = function(pos, node)
            unilib.tnt_burn(pos, node.name)
        end,
    })

end

---------------------------------------------------------------------------------------------------
-- turf_kill ABM
---------------------------------------------------------------------------------------------------

-- Adapted from default/functions.lua
-- Removes grass and dry grass in darkness

if unilib.abm_replace_table.turf_kill ~= nil then

    -- Override the standard ABM with one specified by a package
    unilib.abm_replace_table.turf_kill()

elseif enable_abm_flag and unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

    unilib.register_abm({
        label = "Grass killed in darkness [unilib]",
        nodenames = {"group:spreading_dirt_type", "unilib:dirt_dry_with_turf_dry"},

        catch_up = false,
        chance = 50,
        interval = 8,

        action = function(pos, node)

            local above = {x = pos.x, y = pos.y + 1, z = pos.z}
            local above_name = minetest.get_node(above).name
            local def_table = minetest.registered_nodes[above_name]
            if above_name ~= "ignore" and
                    def_table and not (
                        (def_table.sunlight_propagates or def_table.paramtype == "light") and
                        def_table.liquidtype == "none"
                    ) and unilib.dirt_with_turf_table[node.name] ~= nil then

                minetest.set_node(
                    pos,
                    {name = "unilib:" .. unilib.dirt_with_turf_table[node.name]["dirt_part_name"]}
                )

            end

        end,
    })

end

---------------------------------------------------------------------------------------------------
-- turf_spread ABM
---------------------------------------------------------------------------------------------------

-- Adapted from default/functions.lua
-- Converts dirt nodes into dirt-with-turf nodes, matching one of the surrounding nodes. Some
--      grasses can also convert the dirt beneath them to a dirt-with-turf node

local fertile_dirt_list = {}
for k, v in pairs(unilib.fertile_dirt_table) do
    table.insert(fertile_dirt_list, v)
end

if unilib.abm_replace_table.turf_spread ~= nil then

    -- Override the standard ABM with one specified by a package
    unilib.abm_replace_table.turf_spread(fertile_dirt_list)

elseif enable_abm_flag and #fertile_dirt_list > 0 then

    unilib.register_abm({
        label = "Grass/turf spread [unilib]",
        nodenames = fertile_dirt_list,
        neighbors = {
            "air",
            "group:grass",
            "group:dry_grass",
            "unilib:snow_ordinary",
        },

        catch_up = false,
        chance = 50,
        interval = 6 / unilib.abm_spread_factor,

        action = function(pos, node)

            -- Check for darkness: night, shadow or under a light-blocking node
            local above = {x = pos.x, y = pos.y + 1, z = pos.z}
            if (minetest.get_node_light(above) or 0) < unilib.light_min_grow_sapling then
                return
            end

            -- Look for spreading dirt-type neighbours
            local p2 = minetest.find_node_near(pos, 1, "group:spreading_dirt_type")
            if p2 then

                local n3 = minetest.get_node(p2)
                minetest.set_node(pos, {name = n3.name})
                return

            end

            -- Otherwise, is there a turf seeder (e.g. dry grass or ordinary snow) just above? If
            --      so, it seeds turf onto this dirt
            local seeder_name = minetest.get_node(above).name
            if unilib.turf_seeder_table[seeder_name] ~= nil and
                    unilib.turf_seeder_table[seeder_name][node.name] ~= nil then
                minetest.set_node(pos, {name = unilib.turf_seeder_table[seeder_name][node.name]})
            end

        end,
    })

end

---------------------------------------------------------------------------------------------------
-- dirt_soak ABM
---------------------------------------------------------------------------------------------------

-- Adapted from ethereal_ng
-- Converts dry dirts to ordinary dirts when water is nearby

local function dirt_soak(pos, node)

    if unilib.dirt_with_turf_table[node.name] ~= nil then

        -- A dirt-with-turf node. Convert the dry-dirt-with-turf into the wettened
        --      equivalent, if it exists (we don't try to convert the turf as well)
        local wet_name = "unilib:dirt_ordinary_with_" ..
                unilib.dirt_with_turf_table[node.name]["turf_part_name"]

        if minetest.registered_nodes[wet_name] ~= nil then
            minetest.swap_node(pos, {name = wet_name})
        else
            minetest.swap_node(pos, {name = "unilib:dirt_ordinary"})
        end

    else

        -- A dirt node without turf
        minetest.swap_node(pos, {name = "unilib:dirt_ordinary"})

    end

end

if unilib.abm_replace_table.dirt_soak ~= nil then

    -- Override the standard ABM with one specified by a package
    unilib.abm_replace_table.dirt_soak(node_list)

elseif enable_abm_flag and unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

    unilib.register_abm({
        label = "Soak dry dirt [unilib]",
        nodenames = {"group:dry_dirt"},
        neighbors = {"group:water"},

        catch_up = false,
        chance = 2,
        interval = 15,

        action = function(...)
            dirt_soak(...)
        end,
    })

end

---------------------------------------------------------------------------------------------------
-- torch_extinguish ABM
---------------------------------------------------------------------------------------------------

-- Adapted from ethereal_ng
-- Drops ordinary torches that touch water

local function torch_extinguish(pos, node)

    local num = #minetest.find_nodes_in_area(
        {x = pos.x - 1, y = pos.y, z = pos.z},
        {x = pos.x + 1, y = pos.y, z = pos.z},
        {"group:water"}
    )

    if num == 0 then

        num = num + #minetest.find_nodes_in_area(
            {x = pos.x, y = pos.y, z = pos.z - 1},
            {x = pos.x, y = pos.y, z = pos.z + 1},
            {"group:water"}
        )

    end

    if num == 0 then

        num = num + #minetest.find_nodes_in_area(
            {x = pos.x, y = pos.y + 1, z = pos.z},
            {x = pos.x, y = pos.y + 1, z = pos.z},
            {"group:water"}
        )

    end

    if num > 0 then

        minetest.set_node(pos, {name = "air"})

        minetest.sound_play(
            "unilib_extinguish_flame",
            {pos = pos, gain = 0.2, max_hear_distance = 10}
        )

        minetest.add_item(pos, {name = "unilib:torch_ordinary"})

    end

end

if unilib.abm_replace_table.torch_extinguish ~= nil then

    -- Override the standard ABM with one specified by a package
    unilib.abm_replace_table.torch_extinguish(node_list)

elseif enable_abm_flag and unilib.pkg_executed_table["torch_ordinary"] ~= nil then

    unilib.register_abm({
        label = "Extinguish torches [unilib]",
        nodenames = {
            "unilib:torch_ordinary",
            "unilib:torch_ordinary_wall",
            "unilib:torch_ordinary_ceiling",
        },
        neighbors = {"group:water"},

        catch_up = false,
        chance = 1,
        interval = 5,

        action = function(...)
            torch_extinguish(...)
        end,
    })

end

---------------------------------------------------------------------------------------------------
-- water_freeze ABM
---------------------------------------------------------------------------------------------------

-- Adapted from ethereal_ng
-- Freezes ordinary/river water near snow

local function water_freeze(pos, node)

    local near = minetest.find_node_near(
        pos,
        1,
        {"unilib:liquid_water_ordinary_source", "unilib:liquid_water_river_source"}
    )

    if near then
        minetest.swap_node(near, {name = "unilib:ice_ordinary"})
    end

end

if unilib.abm_replace_table.water_freeze ~= nil then

    -- Override the standard ABM with one specified by a package
    unilib.abm_replace_table.water_freeze(node_list)

elseif enable_abm_flag and unilib.pkg_executed_table["ice_ordinary"] ~= nil then

    unilib.register_abm({
        label = "Freeze water near snow [unilib]",
        nodenames = {"group:snowy"},
        neighbors = {"unilib:liquid_water_ordinary_source", "unilib:liquid_water_river_source"},

        catch_up = false,
        chance = 4,
        interval = 15,

        action = function(...)
            water_freeze(...)
        end,
    })

end
