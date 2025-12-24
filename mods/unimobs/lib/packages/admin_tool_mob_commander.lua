---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unimobs
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.admin_tool_mob_commander = {}

local S = unimobs.intllib
local F = core.formspec_escape
local FS = function(...) return F(S(...)) end
local mode = unilib.global.imported_mod_table.unimobs.add_mode

-- List of compatible behaviours
-- By default, this list contains (most) built-in behaviour packages. To support additional
--      behaviours, add the package names to this list, then modify the code in use_tool() below
local init_list = {
    -- High-level behaviours
    "hqb_approach_beehive",
    "hqb_aqua_attack",
    "hqb_aqua_jump",
    "hqb_aqua_roam",
    "hqb_aqua_turn",
    "hqb_attack",
    "hqb_climb_tree",
    "hqb_die",
    "hqb_evade",
    "hqb_evade_in_liquid_or_air",
    "hqb_find_beehive",
    "hqb_find_flower",
    "hqb_find_land",
    "hqb_find_liquid",
    "hqb_fly_alight",
    "hqb_fly_attack",
    "hqb_fly_hunt",
    "hqb_fly_liquid_recovery",
    "hqb_fly_take_off",
    "hqb_fly_wander",
    "hqb_follow",
    "hqb_follow_and_drop",
    "hqb_follow_in_liquid_or_air",
    "hqb_goto",
    "hqb_goto_liquid",
    "hqb_hunt",
    "hqb_look_at",
    "hqb_obey_driver",
    "hqb_roam",
    "hqb_sleep_until_wake_up",
    "hqb_swim_to",
    "hqb_terrestrial_jump",
    "hqb_warn",
    -- Low-level behaviours
    "lqb_approach_beehive",
    "lqb_climb_tree",
    "lqb_dumb_jump",
    "lqb_dumb_walk",
    "lqb_fall_over",
    "lqb_find_beehive",
    "lqb_find_flower",
    "lqb_fly_alight",
    "lqb_fly_attack",
    "lqb_fly_take_off",
    "lqb_fly_turn_to_yaw",
    "lqb_fly_wander",
    "lqb_follow_in_liquid_or_air",
    "lqb_free_jump",
    "lqb_idle",
    "lqb_jump_attack",
    "lqb_obey_driver",
    "lqb_short_jump",
    "lqb_turn_to_pos",
    -- Meta-behaviours
    "mtb_attack_player",
    "mtb_breed",
    "mtb_climb_tree",
    "mtb_create_anthill",
    "mtb_create_beehive",
    "mtb_dumb_step",
    "mtb_fall_asleep",
    "mtb_find_herd",
    "mtb_flee_player",
    "mtb_flee_predator",
    "mtb_fly_alight",
    "mtb_fly_to",
    "mtb_hunt_prey",
    "mtb_lay_ant_egg",
    "mtb_look_at",
    "mtb_move_head",
    "mtb_order_autonomy",
    "mtb_order_follow",
    "mtb_order_guard",
    "mtb_order_stand",
    "mtb_order_stand_here",
    "mtb_replace_node_or_lay_egg",
    "mtb_rescue_suffocating_mob",
    "mtb_restore_head",
    "mtb_set_forward_velocity",
    "mtb_show_fear",
    "mtb_start_following",
    "mtb_start_repelling",
    "mtb_stop_following",
    "mtb_stop_repelling",
    "mtb_straggle_parents",
    "mtb_teleport_behind_player",
    "mtb_turn_away_from_danger",
}
-- The code below will filter out unloaded packages, adding the rest to this list
local behaviour_list = {}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_behaviour_str()

    local str = ""
    for _, pkg_name in ipairs(behaviour_list) do

        if str ~= "" then
            str = str .. ","
        end

        str = str .. pkg_name

    end

    return str

end

local function get_formspec(itemstack)

    local meta = itemstack:get_meta()

    local formspec = "size[6,6]" ..
        "image[0,0;1,1;unilib_admin_tool_mob_commander.png;]" ..
        "label[1,0.25;" .. FS("Admin mob commander") .. "]" ..
        "label[0,1.25;" .. FS("Select a behaviour") .. ":]" ..
        "textlist[2,1.25;3.75,4.5;behaviour_list;" .. get_behaviour_str() .. ";" ..
            meta:get_int("behaviour_index") .. "]"

    return formspec

end

local function configure_tool(itemstack, user, pointed_thing)

    -- Called when the player right-clicks a node, while wielding this tool
    -- Open the formspec

    local meta = itemstack:get_meta()
    if meta:get_int("behaviour_index") == 0 then

        -- On first use, initialise metadata
        meta:set_int("behaviour_index", 1)
        user:set_wielded_item(itemstack)

    end

    core.show_formspec(
        user:get_player_name(),
        "unilib:formspec_admin_tool_mob_commander",
        get_formspec(itemstack)
    )

end

local function use_tool(itemstack, player, luaent)

    -- Called when the player left-clicks a mob (or near a mob) while wielding this tool
    -- After basic checks, empties both behaviour queues, then inserts the selected behaviour into
    --      the queue (with the highest priority, when applicable)

    -- Basic checks. This tool will work on any unimobs mob, not just those using the petz API
    if not luaent or not unimobs.mobkit_api.is_object_alive(luaent.object) then
        return
    end

    -- Retrieve data from meta
    local meta = itemstack:get_meta()
    local behaviour_index = meta:get_int("behaviour_index")
    local behaviour = behaviour_list[behaviour_index]
    if not behaviour then
        return
    end

    -- Empty the mob's queues
    unimobs.mobkit_api.clear_both_queues(luaent)

    -- Insert the new behaviour
    local priority = -1
    local player_pos = player:get_pos()
    local player_yaw = player:get_yaw()
    local force_flag = true

    -- High-level behaviours
    if behaviour == "hqb_approach_beehive" then
        unilib.pkg.hqb_approach_beehive.add_to_queue(luaent, priority)
    elseif behaviour == "hqb_aqua_attack" then
        unilib.pkg.hqb_aqua_attack.add_to_queue(luaent, priority, player, 6)
    elseif behaviour == "hqb_aqua_jump" then
        unilib.pkg.hqb_aqua_jump.add_to_queue(luaent, priority)
    elseif behaviour == "hqb_aqua_roam" then
        unilib.pkg.hqb_aqua_roam.add_to_queue(luaent, priority, speed)
    elseif behaviour == "hqb_aqua_turn" then
        unilib.pkg.hqb_aqua_turn.add_to_queue(luaent, priority, target_yaw, luaent.max_speed)
    elseif behaviour == "hqb_attack" then
        unilib.pkg.hqb_attack.add_to_queue(luaent, priority, player)
    elseif behaviour == "hqb_climb_tree" then
        unilib.pkg.hqb_climb_tree.add_to_queue(luaent, priority)
    elseif behaviour == "hqb_die" then
        unilib.pkg.hqb_die.add_to_queue(luaent, priority)
    elseif behaviour == "hqb_evade" then
        unilib.pkg.hqb_evade.add_to_queue(luaent, priority, player)
    elseif behaviour == "hqb_evade_in_liquid_or_air" then
        unilib.pkg.hqb_evade_in_liquid_or_air.add_to_queue(luaent, priority, player)
    elseif behaviour == "hqb_find_beehive" then
        unilib.pkg.hqb_find_beehive.add_to_queue(luaent, priority)
    elseif behaviour == "hqb_find_flower" then
        unilib.pkg.hqb_find_flower.add_to_queue(luaent, priority, player_pos)
    elseif behaviour == "hqb_find_land" then
        unilib.pkg.hqb_find_land.add_to_queue(luaent, priority)
    elseif behaviour == "hqb_find_liquid" then
        unilib.pkg.hqb_find_liquid.add_to_queue(luaent, priority)
    elseif behaviour == "hqb_fly_alight" then
        unilib.pkg.hqb_fly_alight.add_to_queue(luaent, priority, "stand")
    elseif behaviour == "hqb_fly_attack" then
        unilib.pkg.hqb_fly_attack.add_to_queue(luaent, priority, player)
    elseif behaviour == "hqb_fly_hunt" then
        unilib.pkg.hqb_fly_hunt.add_to_queue(luaent, priority, player)
    elseif behaviour == "hqb_fly_liquid_recovery" then
        unilib.pkg.hqb_fly_liquid_recovery.add_to_queue(luaent, priority)
    elseif behaviour == "hqb_fly_take_off" then
        unilib.pkg.hqb_fly_take_off.add_to_queue(luaent, priority)
    elseif behaviour == "hqb_fly_wander" then
        unilib.pkg.hqb_fly_wander.add_to_queue(luaent, priority)
    elseif behaviour == "hqb_follow" then
        unilib.pkg.hqb_follow.add_to_queue(luaent, priority, player)
    elseif behaviour == "hqb_follow_and_drop" then
        unilib.pkg.hqb_follow_and_drop.add_to_queue(luaent, priority, player)
    elseif behaviour == "hqb_follow_in_liquid_or_air" then
        unilib.pkg.hqb_follow_in_liquid_or_air.add_to_queue(luaent, priority, player)
    elseif behaviour == "hqb_goto" then
        unilib.pkg.hqb_goto.add_to_queue(luaent, priority, player_pos)
    elseif behaviour == "hqb_goto_liquid" then
        unilib.pkg.hqb_goto_liquid.add_to_queue(luaent, priority, player_pos)
    elseif behaviour == "hqb_hunt" then
        unilib.pkg.hqb_hunt.add_to_queue(luaent, priority, player)
    elseif behaviour == "hqb_look_at" then
        unilib.pkg.hqb_look_at.add_to_queue(luaent, priority, player_pos)
    elseif behaviour == "hqb_obey_driver" then
        unilib.pkg.hqb_obey_driver.add_to_queue(luaent, priority)
    elseif behaviour == "hqb_roam" then
        unilib.pkg.hqb_roam.add_to_queue(luaent, priority)
    elseif behaviour == "hqb_sleep_until_wake_up" then
        unilib.pkg.hqb_sleep_until_wake_up.add_to_queue(luaent, priority, force_flag)
    elseif behaviour == "hqb_swim_to" then
        unilib.pkg.hqb_swim_to.add_to_queue(luaent, priority, player_pos)
    elseif behaviour == "hqb_terrestrial_jump" then
        unilib.pkg.hqb_terrestrial_jump.add_to_queue(luaent, priority)
    elseif behaviour == "hqb_warn" then
        unilib.pkg.hqb_warn.add_to_queue(luaent, priority, player)
    -- Low-level behaviours
    elseif behaviour == "lqb_approach_beehive" then
        unilib.pkg.lqb_approach_beehive.add_to_queue(luaent)
    elseif behaviour == "lqb_climb_tree" then
        unilib.pkg.lqb_climb_tree.add_to_queue(luaent)
    elseif behaviour == "lqb_dumb_jump" then
        unilib.pkg.lqb_dumb_jump.add_to_queue(luaent, 1, nil)
    elseif behaviour == "lqb_dumb_walk" then
        unilib.pkg.lqb_dumb_walk.add_to_queue(luaent, player_pos, 1)
    elseif behaviour == "lqb_fall_over" then
        unilib.pkg.lqb_fall_over.add_to_queue(luaent)
    elseif behaviour == "lqb_find_beehive" then
        unilib.pkg.lqb_find_beehive.add_to_queue(luaent)
    elseif behaviour == "lqb_find_flower" then
        unilib.pkg.lqb_find_flower.add_to_queue(luaent, player_pos)
    elseif behaviour == "lqb_fly_alight" then
        unilib.pkg.lqb_fly_alight.add_to_queue(luaent)
    elseif behaviour == "lqb_fly_attack" then
        unilib.pkg.lqb_fly_attack.add_to_queue(luaent, player)
    elseif behaviour == "lqb_fly_take_off" then
        unilib.pkg.lqb_fly_take_off.add_to_queue(luaent)
    elseif behaviour == "lqb_fly_turn_to_yaw" then
        unilib.pkg.lqb_fly_turn_to_yaw.add_to_queue(luaent, player_yaw)
    elseif behaviour == "lqb_fly_wander" then
        unilib.pkg.lqb_fly_wander.add_to_queue(luaent, 1)
    elseif behaviour == "lqb_follow_in_liquid_or_air" then
        unilib.pkg.lqb_follow_in_liquid_or_air.add_to_queue(luaent, player)
    elseif behaviour == "lqb_free_jump" then
        unilib.pkg.lqb_free_jump.add_to_queue(luaent)
    elseif behaviour == "lqb_idle" then
        unilib.pkg.lqb_idle.add_to_queue(luaent, 10, nil)
    elseif behaviour == "lqb_jump_attack" then
        unilib.pkg.lqb_jump_attack.add_to_queue(luaent, player_pos.y, player)
    elseif behaviour == "lqb_obey_driver" then
        unilib.pkg.lqb_obey_driver.add_to_queue(luaent)
    elseif behaviour == "lqb_short_jump" then
        unilib.pkg.lqb_short_jump.add_to_queue(luaent)
    elseif behaviour == "lqb_turn_to_pos" then
        unilib.pkg.lqb_turn_to_pos.add_to_queue(luaent, player_pos)
    -- Meta-behaviours
    elseif behaviour == "mtb_attack_player" then
        unilib.pkg.mtb_attack_player.do_action(luaent, priority, player)
    elseif behaviour == "mtb_breed" then
        unilib.pkg.mtb_breed.do_action(luaent)
    elseif behaviour == "mtb_climb_tree" then
        unilib.pkg.mtb_climb_tree.do_action(luaent, priority)
    elseif behaviour == "mtb_create_anthill" then
        unilib.pkg.mtb_create_anthill.do_action(luaent)
    elseif behaviour == "mtb_create_beehive" then
        unilib.pkg.mtb_create_beehive.do_action(luaent)
    elseif behaviour == "mtb_dumb_step" then
        unilib.pkg.mtb_dumb_step.do_action(luaent, height, player_pos, 1, 3)
    elseif behaviour == "mtb_fall_asleep" then
        unilib.pkg.mtb_fall_asleep.do_action(luaent, priority)
    elseif behaviour == "mtb_find_herd" then
        unilib.pkg.mtb_find_herd.do_action(luaent, player)
    elseif behaviour == "mtb_flee_player" then
        unilib.pkg.mtb_flee_player.do_action(luaent, priority, player)
    elseif behaviour == "mtb_flee_predator" then
        unilib.pkg.mtb_flee_predator.do_action(luaent, priority)
    elseif behaviour == "mtb_fly_alight" then
        unilib.pkg.mtb_fly_alight.do_action(luaent, priority, "alight")
    elseif behaviour == "mtb_fly_to" then
        unilib.pkg.mtb_fly_to.do_action(luaent, player)
    elseif behaviour == "mtb_hunt_prey" then
        unilib.pkg.mtb_hunt_prey.do_action(luaent, priority, force_flag)
    elseif behaviour == "mtb_lay_ant_egg" then
        unilib.pkg.mtb_lay_ant_egg.do_action(luaent)
    elseif behaviour == "mtb_look_at" then
        unilib.pkg.mtb_look_at.do_action(luaent, priority, player_pos)
    elseif behaviour == "mtb_move_head" then
        unilib.pkg.mtb_move_head.do_action(luaent, player_pos)
    elseif behaviour == "mtb_order_autonomy" then
        unilib.pkg.mtb_order_autonomy.do_action(luaent)
    elseif behaviour == "mtb_order_follow" then
        unilib.pkg.mtb_order_follow.do_action(luaent, player)
    elseif behaviour == "mtb_order_guard" then
        unilib.pkg.mtb_order_guard.do_action(luaent)
    elseif behaviour == "mtb_order_stand" then
        unilib.pkg.mtb_order_stand.do_action(luaent)
    elseif behaviour == "mtb_order_stand_here" then
        unilib.pkg.mtb_order_stand_here.do_action(luaent)
    elseif behaviour == "mtb_replace_node_or_lay_egg" then
        unilib.pkg.mtb_replace_node_or_lay_egg.do_action(luaent)
    elseif behaviour == "mtb_rescue_suffocating_mob" then
        unilib.pkg.mtb_rescue_suffocating_mob.do_action(luaent)
    elseif behaviour == "mtb_restore_head" then
        unilib.pkg.mtb_restore_head.do_action(luaent)
    elseif behaviour == "mtb_set_forward_velocity" then
        unilib.pkg.mtb_set_forward_velocity.do_action(luaent, {x = 0, y = 3, z = 0})
    elseif behaviour == "mtb_show_fear" then
        unilib.pkg.mtb_show_fear.do_action(luaent, player_pos)
    elseif behaviour == "mtb_start_following" then
        unilib.pkg.mtb_start_following.do_action(luaent, priority, player)
    elseif behaviour == "mtb_start_repelling" then
        unilib.pkg.mtb_start_repelling.do_action(luaent, priority, player)
    elseif behaviour == "mtb_stop_following" then
        unilib.pkg.mtb_stop_following.do_action(luaent, player)
    elseif behaviour == "mtb_stop_repelling" then
        unilib.pkg.mtb_stop_repelling.do_action(luaent, player)
    elseif behaviour == "mtb_straggle_parents" then
        unilib.pkg.mtb_straggle_parents.do_action(luaent)
    elseif behaviour == "mtb_teleport_behind_player" then
        unilib.pkg.mtb_teleport_behind_player.do_action(luaent, player, "pumpkin")
    elseif behaviour == "mtb_turn_away_from_danger" then
        unilib.pkg.mtb_turn_away_from_danger.do_action(luaent, player_pos)
    else
        return      -- Unsupported behaviour
    end

    core.chat_send_player(
        player:get_player_name(),
        S("Inserted behaviour @1 into queue of @2", behaviour, luaent.name)
    )

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.admin_tool_mob_commander.init()

    return {
        description = "Admin mob commander tool",
        notes = "Empties the mob's behaviour queues, and then launches a new behaviour (for" ..
                " debugging purposes). Click a mob while wielding the tool; alternatively, click" ..
                " a nearby node or \"click\" the air. This tool works on all unimobs creatures," ..
                " not just those associated with the \"petz\" API; but note that only built-in" ..
                " behaviours can be launched. Note also that some behaviours will be launched" ..
                " regardless of whether doing so makes any logical sense, or whether the" ..
                " behaviours are compatible with that particular mob",
    }

end

function unilib.pkg.admin_tool_mob_commander.exec()

    unilib.register_tool("unilib:admin_tool_mob_commander", nil, mode, {
        -- Original to unimobs
        description = S("Admin Mob Commander"),
        inventory_image = "unilib_admin_tool_mob_commander.png",
        groups = {not_in_creative_inventory = unilib.globalshow_admin_item_group},
        -- (no sounds)

        -- It's not OK to interact with water
        liquids_pointable = false,
        -- In common with other admin tools, forbid stacks
        stack_max = 1,
        wield_image = "",
        wield_scale = {x = 1, y = 1, z = 1},

        on_place = function(itemstack, placer, pointed_thing)

            if placer ~= nil and pointed_thing ~= nil then
                configure_tool(itemstack, placer, pointed_thing)
            end

            return itemstack

        end,

        on_use = function(itemstack, user, pointed_thing)

            if user ~= nil and pointed_thing ~= nil then

                if pointed_thing.type == "object" then

                    use_tool(itemstack, user, pointed_thing.ref:get_luaentity())

                elseif pointed_thing.type == "node" then

                    local closest_obj =
                            unimobs.mobkit_api.get_closest_entity_to_pos(pointed_thing.above)
                    if closest_obj then
                        use_tool(itemstack, user, closest_obj:get_luaentity())
                    end

                elseif pointed_thing.type == "nothing" then

                    local closest_obj =
                            unimobs.mobkit_api.get_closest_entity_to_pos(user:get_pos())
                    if closest_obj then
                        use_tool(itemstack, user, closest_obj:get_luaentity())
                    end

                end

            end

        end,
    })

    core.register_on_player_receive_fields(function(player, formname, fields)

        -- The player has interacted with our formspec
        if not formname or
                formname ~= "unilib:formspec_admin_tool_mob_commander" or
                not fields then
            return false
        end

        local itemstack = player:get_wielded_item()
        local meta = itemstack:get_meta()

        if fields.behaviour_list then

            local event = core.explode_textlist_event(fields.behaviour_list)
            if event.type == "CHG" then
                meta:set_int("behaviour_index", event.index)
            end

        else

            return true

        end

        -- (Because it's a tool, metadata is lost without this line)
        player:set_wielded_item(itemstack)

        return true

    end)

end

function unilib.pkg.admin_tool_mob_commander.post()

    -- Filter out unloaded packages
    for _, pkg_name in ipairs(init_list) do

        if unilib.global.pkg_executed_table[pkg_name] ~= nil then
            table.insert(behaviour_list, pkg_name)
        end

    end

end
