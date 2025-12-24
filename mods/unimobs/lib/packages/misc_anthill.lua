---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_anthill = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

-- Localise math functions (for speed)
local random = math.random

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_anthill.init()

    return {
        description = "Anthill",
        notes = "Anthills are created by queen ants in favourable locations (generally near" ..
                " water, and away from mountains and frozen dirt). Players can construct" ..
                " artificial anthills, if they want (for example, inside a glass building for" ..
                " easy viewing). Granary blocks are one reason for players to risk looting an" ..
                " anthill; they sometimes drop valuable items",
        depends = {"crop_cotton", "crop_wheat", "mob_ant_misc"},
        optional = {
            "fruit_apple",
            "fruit_blueberry_ordinary",
            "metal_gold",
            "metal_iron",
            "mineral_diamond",
            "mob_ant_misc",
        },
    }

end

function unilib.pkg.misc_anthill.exec()

    local c_wheat_seed = "unilib:crop_wheat_seed"

    unilib.register_node("unilib:misc_anthill_bed", "petz:antbed", mode, {
        -- From petz:antbed
        description = S("Anthill Bed"),
        tiles = {"unilib_misc_anthill_bed.png"},
        groups = {crumbly = 3},
        sounds = unilib.global.sound_table.leaves,

        is_ground_content = false,
    })
    unilib.register_craft({
        -- From petz:antbed
        type = "shaped",
        output = "unilib:misc_anthill_bed",
        recipe = {
            {"unilib:crop_wheat_harvest", "group:leaves", "unilib:crop_wheat_harvest"},
            {"unilib:crop_cotton_harvest", c_wheat_seed, "unilib:crop_cotton_harvest"},
            {"unilib:crop_wheat_harvest", "group:leaves", "unilib:crop_wheat_harvest"},
        },
    })

    unilib.register_node("unilib:misc_anthill_entrance", "petz:anthill_entrance", mode, {
        -- From petz:anthill_entrance
        description = S("Anthill Entrance"),
        tiles = {
            "unilib_misc_anthill_entrance.png",
            "unilib_misc_anthill_entrance.png",
            "unilib_misc_anthill_bed.png",
        },
        groups = {crumbly = 3},
        sounds = unilib.global.sound_table.leaves,

        is_ground_content = false,

        on_construct = function(pos)

            -- Check the anthill entrance every 5 seconds to decide whether more ants should spawn
            local timer = core.get_node_timer(pos)
            timer:start(5)

        end,

        on_timer = function(pos)

            local pos_top = {x = pos.x, y = pos.y + 0.5, z = pos.z}
            local node = core.get_node_or_nil(pos_top)
            if node and core.registered_nodes[node.name] and node.name == "air" then

                -- A worker ant emerges once a day
                local chance_worker = random(1, 240)
                if chance_worker == 1 then

                    if not core.registered_entities["unilib:mob_ant_worker"] then
                        return true
                    else
                        core.add_entity(pos_top, "unilib:mob_ant_worker")
                    end

                end

                -- If a player is within 7 blocks, spawn a warrior ant to defend the anthill
                local player_near_flag = false

                local obj_list = core.get_objects_inside_radius(pos, 7)
                for _, obj in ipairs(obj_list) do

                    if obj:is_player() and unimobs.mobkit_api.is_object_alive(obj) then

                        player_near_flag = true
                        break

                    end

                end

                if player_near_flag then

                    if not core.registered_entities["unilib:mob_ant_warrior"] then
                        return true
                    else
                        core.add_entity(pos_top, "unilib:mob_ant_warrior")
                    end

                end

            end

            -- (The timer runs indefinitely)
            return true

        end,
    })

    -- The anthill granary drops items, but only those which are available
    local item_list = {
        {items = {c_wheat_seed .. " 5"}},
        {items = {"unilib:crop_cotton_seed"}, rarity = 5},
    }

    if unilib.global.pkg_executed_table["fruit_apple"] ~= nil then

        table.insert(
            item_list,
            {items = {"unilib:fruit_apple"}, rarity = 15}
        )

    end

    if unilib.global.pkg_executed_table["fruit_blueberry_ordinary"] ~= nil then

        table.insert(
            item_list,
            {items = {"unilib:fruit_blueberry_ordinary"}, rarity = 20}
        )

    end

    if unilib.global.pkg_executed_table["metal_iron"] ~= nil then

        table.insert(
            item_list,
            {items = {"unilib:metal_iron_lump"}, rarity = 25}
        )

    end

    if unilib.global.pkg_executed_table["metal_gold"] ~= nil then

        table.insert(
            item_list,
            {items = {"unilib:metal_gold_lump"}, rarity = 40}
        )

    end

    if unilib.global.pkg_executed_table["mineral_diamond"] ~= nil then

        table.insert(
            item_list,
            {items = {"unilib:mineral_diamond_gem"}, rarity = 80}
        )

    end

    unilib.register_node("unilib:misc_anthill_granary", "petz:grain_packet", mode, {
        -- From petz:grain_packet
        description = S("Anthill Granary"),
        tiles = {"unilib_misc_anthill_granary.png"},
        groups = {flammable = 2, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drop = {
            max_items = 15,
            items = item_list,
        },
        is_ground_content = false,
    })
    unilib.register_craft({
        -- From petz:grain_packet
        output = "unilib:misc_anthill_granary",
        recipe = {
            {c_wheat_seed, c_wheat_seed, c_wheat_seed},
            {c_wheat_seed, "", c_wheat_seed},
            {c_wheat_seed, c_wheat_seed, c_wheat_seed},
        },
    })

end
