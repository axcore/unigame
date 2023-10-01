---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    fireextinguisher
-- Code:    LGPL 2.1
-- Media:   LGPL 2.1/WTFPL/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_extinguisher_automatic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.fireextinguisher.add_mode

local retardant_strength = 5
local retardant_purity = 10

local spray_lifespan = 10
local spray_target_list = {"air", "unilib:fire_ordinary", "ignore"}
local spray_disperse_list = {"unilib:misc_foam_fire_retardant_cleaner"}
local retardant_replacement_table = {
    node = "unilib:misc_foam_fire_retardant", param2 = retardant_purity,
}

local cleaner_lifespan = 35
local cleaner_target_list = {"unilib:misc_foam_fire_retardant", "ignore"}
local cleaner_disperse_list = {"unilib:misc_foam_fire_retardant_spray"}
local cleaner_replacement_table = {node = "air", param2 = 10}

---------------------------------------------------------------------------------------------------
-- Local functions (miscellaneous)
---------------------------------------------------------------------------------------------------

local function do_propagate(pos, node, replacementnodename, life)

    -- Was fireextinguisher.propagate()

    if target.name == "unilib:fire_ordinary" then

        minetest.remove_node(pos)
        minetest.sound_play(
            "unilib_extinguish_flame", {pos = pos, max_hear_distance = 16, gain = 0.15}
        )

    end

    minetest.set_node(pos, {name = replacementnodename, param1 = 14, param2 = life - 1})

end

local function do_replace(pos, node, repl)

    -- Was fireextinguisher.replace()

    minetest.set_node(pos, {name = repl.node, param1 = 0, param2 = repl.param2})
    if node ~= nil and node.name == "unilib:fire_ordinary" then

        minetest.sound_play(
            "unilib_extinguish_flame",
            {pos = pos, max_hear_distance = 16, gain = 0.15}
        )

    end

end

local function do_run(pos, node, targettypes, replacement, lifespan, poisontypes)

    -- Was fireextinguisher.run()

    local life = node.param2
    if life == 0 then

        do_replace(pos, nil, replacement)
        return

    end

    local poisoned_flag = false
    if poisontypes ~= nil then
        poisoned_flag = minetest.find_node_near(pos, 1, poisontypes) ~= nil
    end

    local ignore_adjacent_node_found_flag = false
    local propagated_flag = false

    if not poisoned_flag then

        local target_list = minetest.find_nodes_in_area(
            {x = pos.x - 1, y = pos.y - 1, z = pos.z - 1},
            {x = pos.x + 1, y = pos.y + 1, z = pos.z + 1},
            targettypes
        )

        for i = 1, #target_list do

            target = minetest.get_node(target_list[i])
            if target.name ~= "ignore" then

                do_propagate(target_list[i], target, node.name, life)
                propagated_flag = true

            else

                ignore_adjacent_node_found_flag = true

            end

        end

    end

    if ignore_adjacent_node_found_flag == false or poisoned_flag then

        if propagated_flag or life ~= lifespan then
            do_replace(pos, nil, replacement)
        else
            minetest.set_node(pos, {name = "air", param1 = 0, param2 = 0})
        end

    end

end

---------------------------------------------------------------------------------------------------
-- Local functions (callbacks)
---------------------------------------------------------------------------------------------------

local function cleaner_callback(pos, node, active_object_count, active_object_count_wider)

    -- Was fireextinguisher.retardantcleanercat_abm

    do_run(
        pos,
        node,
        cleaner_target_list,
        cleaner_replacement_table,
        cleaner_lifespan,
        cleaner_disperse_list
    )

end

local function spray_callback(pos, node, active_object_count, active_object_count_wider)

    -- Was fireextinguisher.retardantcat_abm()

    do_run(
        pos,
        node,
        spray_target_list,
        retardant_replacement_table,
        spray_lifespan,
        spray_disperse_list
    )

end

local function extinguisher_callback(pos, node, active_object_count, active_object_count_wider)

    -- Was fireextinguisher.fireextinguisher_abm()

    minetest.sound_play(
        "unilib_misc_foam_fire_retardant",
        {pos = pos, gain = 1.3, max_hear_distance = spray_lifespan * 3}
    )

    node = {
        name = "unilib:misc_foam_fire_retardant_spray",
        param1 = 14,
        param2 = spray_lifespan,
    }

    minetest.set_node(pos, node)
    spray_callback(pos, node, nil, nil)

end

local function retardant_callback(pos, node, active_object_count, active_object_count_wider)

    -- Was fireextinguisher.retardant_abm

    flame_list = minetest.find_nodes_in_area(
        {x = pos.x - 1, y = pos.y - 1, z = pos.z - 1},
        {x = pos.x + 1, y = pos.y + 1, z = pos.z + 1},
        {"unilib:fire_ordinary"}
    )

    for i = 1, #flame_list do

        if node.param2 > 0 then

            minetest.set_node(
                flame_list[i], {name = node.name, param1 = 14, param2 = node.param2 - 1}
            )

        else

            minetest.remove_node(flame_list[i])

        end

    end

    for i = 1, #flame_list do

        minetest.sound_play(
            "unilib_extinguish_flame",
            {pos = pos, max_hear_distance = 16, gain = 0.15}
        )

    end

end

local function retardant_evaporate_callback(
    pos, node, active_object_count, active_object_count_wider
)
    -- Was fireextinguisher.retardant_evaporate_abm()

    local retardant_or_air_list = minetest.find_nodes_in_area(
        {x = pos.x - 1, y = pos.y - 1, z = pos.z - 1},
        {x = pos.x + 1, y = pos.y + 1, z = pos.z + 1},
        {
            "air",
            "unilib:misc_foam_fire_retardant",
            "unilib:liquid_lava_ordinary_source",
            "unilib:liquid_lava_ordinary_flowing",
        }
    )

    if #retardant_or_air_list == 27 then

        local below = {x = pos.x, y = pos.y - 1, z = pos.z}
        if minetest.get_node(below).name == "air" and node.param2 > 0 then

            minetest.set_node(
                below, {name = node.name, param1 = node.param1, param2 = node.param2 - 1}
            )

        end

        minetest.set_node(pos, {name = "air", param1 = 0, param2 = 0})

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_extinguisher_automatic.init()

    return {
        description = "Automatic fire extinguisher",
        notes = "When the extinguisher detects fire, it releases a large cloud of foam. The" ..
                " foam settles on the ground and continues to fight fire, but can be removed" ..
                " completely by placing fire-retardant cleaner",
        depends = {"metal_steel", "mineral_mese", "torch_ordinary"},
    }

end

function unilib.pkg.misc_extinguisher_automatic.exec()

    unilib.register_node(
        -- From fireextinguisher:fireextinguisher
        "unilib:misc_extinguisher_automatic",
        "fireextinguisher:fireextinguisher",
        mode,
        {
            description = S("Automatic Fire Extinguisher"),
            tiles = {"unilib_misc_extinguisher_automatic.png"},
            groups = {oddly_breakable_by_hand = 1},
            -- (no sounds)

            damage_per_second = 0,
            diggable = true,
            drawtype = "plantlike",
            paramtype = "light",
            paramtype2 = "none",
            pointable = true,
        }
    )

    unilib.register_node(
        -- From fireextinguisher:fireretardant
        "unilib:misc_foam_fire_retardant",
        "fireextinguisher:fireretardant",
        mode,
        {
            description = S("Fire-Retardant Foam"),
            tiles = {"unilib_misc_foam_fire_retardant.png"},
            -- N.B. not_in_creative_inventory not in original code
            groups = {
                dig_immediate = 3, not_in_creative_inventory = 1, oddly_breakable_by_hand = 3,
                puts_out_fire = 1
            },
            -- (no sounds)

            buildable_to = true,
            damage_per_second = 0,
            diggable = true,
            drawtype = "plantlike",
            paramtype = "light",
            paramtype2 = "none",
            pointable = true,
            sunlight_propagates = true,
            walkable = false,

            after_place_node = function(pos, placer)

                minetest.set_node(
                    pos,
                    {
                        name = "unilib:misc_foam_fire_retardant",
                        param1 = 14,
                        param2 = retardant_strength,
                    }
                )

            end
        }
    )

    unilib.register_node(
        "unilib:misc_foam_fire_retardant_spray",
        "fireextinguisher:retardantcat",
        mode,
        {
            description = S("Fire-Retardant Foam Spray"),
            tiles = {"unilib_misc_foam_fire_retardant_spray.png"},
            -- N.B. not_in_creative_inventory not in original code
            groups = {immortal = 1, not_in_creative_inventory = 1, puts_out_fire = 1},
            -- (no sounds)

            damage_per_second = 0,
            diggable = false,
            drawtype = "glasslike",
            paramtype = "light",
            paramtype2 = "none",
            pointable = false,
            sunlight_propagates = true,
            walkable = false,
        }
    )

    unilib.register_node(
        -- From fireextinguisher:retardantcleanercat
        "unilib:misc_foam_fire_retardant_cleaner",
        "fireextinguisher:retardantcleanercat",
        mode,
        {
            description = S("Fire-Retardant Foam Cleaner"),
            tiles = {"unilib_misc_foam_fire_retardant_cleaner.png"},
            groups = {immortal = 1},
            -- (no sounds)

            damage_per_second = 0,
            diggable = false,
            drawtype = "glasslike",
            paramtype = "light",
            paramtype2 = "none",
            pointable = false,
            sunlight_propagates = true,
            walkable = false,

            after_place_node = function(pos, node, active_object_count, active_object_count_wider)

                minetest.set_node(
                    pos,
                    {
                        name = "unilib:misc_foam_fire_retardant_cleaner",
                        param1 = 14,
                        param2 = spray_lifespan,
                    }
                )

            end
        }
    )
    unilib.register_craft({
        -- From fireextinguisher:retardantcleanercat
        output = "unilib:misc_foam_fire_retardant_cleaner",
        recipe = {
            {
                "unilib:misc_foam_fire_retardant",
                "unilib:misc_foam_fire_retardant",
                "unilib:misc_foam_fire_retardant",
            },
            {
                "unilib:torch_ordinary",
                "unilib:torch_ordinary",
                "unilib:torch_ordinary",
            },
            {"", "", ""},
        }
    })

    unilib.register_abm({
        label = "Fire extinguisher [misc_extinguisher_automatic]",
        nodenames = {"unilib:misc_extinguisher_automatic"},
        neighbors = {
            "unilib:liquid_lava_ordinary_source",
            "unilib:liquid_lava_ordinary_flowing",
            "unilib:fire_ordinary",
        },

        chance = 1,
        interval = 0.05,

        action = extinguisher_callback,
    })

    unilib.register_abm({
        label = "Fire retardant [misc_extinguisher_automatic]",
        nodenames = {"unilib:misc_foam_fire_retardant"},
        neighbors = {"unilib:fire_ordinary"},

        chance = 1,
        interval = 0.03,

        action = retardant_callback,
    })

    unilib.register_abm({
        label = "Fire retardant evaporation [misc_extinguisher_automatic]",
        nodenames = {"unilib:misc_foam_fire_retardant"},
        neighbors = {"air"},

        chance = 2,
        interval = 1,

        action = retardant_evaporate_callback,
    })

    unilib.register_abm({
        label = "Fire extinguisher spray [misc_extinguisher_automatic]",
        nodenames = {"unilib:misc_foam_fire_retardant_spray"},

        chance = 3,
        interval = 0.01,

        action = spray_callback,
    })

    unilib.register_abm({
        label = "Fire retardant cleaning [misc_extinguisher_automatic]",
        nodenames = {"unilib:misc_foam_fire_retardant_cleaner"},

        chance = 2,
        interval = 0.3,

        action = cleaner_callback,
    })

end

function unilib.pkg.misc_extinguisher_automatic.post()

    unilib.register_craft({
        -- From fireextinguisher:fireextinguisher
        output = "fireextinguisher:fireextinguisher",
        recipe = {
            {"group:craftable_bucket", "unilib:torch_ordinary", "unilib:mineral_mese_block"},
            {"", "unilib:metal_steel_ingot", ""},
            {"", "", ""},
        },
        replacements = unilib.craftable_bucket_list,
    })

end
