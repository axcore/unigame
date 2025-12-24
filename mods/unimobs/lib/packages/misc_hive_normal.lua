---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_hive_normal = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

-- Localise math functions (for speed)
local random = math.random

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_bee_spawn_pos(pos)

    -- From petz.spawn_bee_pos()
    -- Returns a position close the hive located at the specified "pos", at which the calling code
    --      can spawn a worker bee

    if not pos then
        return
    end

    local pos_1 = {x = pos.x - 1, y = pos.y - 1, z = pos.z - 1}
    local pos_2 = {x = pos.x + 1, y = pos.y + 1, z = pos.z + 1}

    local spawn_pos_list = core.find_nodes_in_area(pos_1, pos_2, {"air"})
    if #spawn_pos_list > 0 then
        return spawn_pos_list[random(1, #spawn_pos_list)]
    else
        return nil
    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_hive_normal.set_infotext(meta, honey_count, bee_count)

    -- From petz.set_infotext_beehive()
    -- Updates the hive's infotext. Note that the "pollen_count" property is not visible to players,
    --      so is not passed to this function as an argument

    local total_bees = meta:get_int("total_bees") or unimobs.petz_setting.beehive_max_bees
    local infotext = S("Honey") .. ": " .. tostring(honey_count) .. " | " ..
            S("Bees inside") .. ": " .. tostring(bee_count) .. " | " ..
            S("Total bees") .. ": " .. tostring(total_bees)

    if unimobs.petz_setting.beehive_protected_flag then

        local owner_name = meta:get_string("owner")
        if owner_name == "" then
            owner_name = S("Unknown")
        end

        infotext = infotext .. " | " .. S("Owner") .. ": ".. owner_name

    end

    meta:set_string("infotext", infotext)

end

function unilib.pkg.misc_hive_normal.decrease_total_bee_count(pos)

    -- From petz.decrease_total_bee_count()
    -- Decrease the number of bees in the hive located at the specified "pos"

    if not pos then
        return
    end

    local meta = core.get_meta(pos)
    local total_bees = meta:get_int("total_bees") or unimobs.petz_setting.beehive_max_bees
    total_bees = total_bees - 1
    meta:set_int("total_bees", total_bees)

end

function unilib.pkg.misc_hive_normal.get_stats(pos)

    -- From petz.get_beehive_stats()
    -- Get a list of values for the hive located at the specified "pos"

    if not pos then
        return
    end

    local meta = core.get_meta(pos)
    local pollen_count = meta:get_int("pollen_count")
    local honey_count = meta:get_int("honey_count")
    local bee_count = meta:get_int("bee_count")
    local owner = meta:get_string("owner")

    return meta, pollen_count, honey_count, bee_count, owner

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_hive_normal.init()

    return {
        description = "Normal beehive",
        notes = "This hive can only be used with bees from the \"mob_bee_misc\" package." ..
                " Compare the \"misc_hive_artificial\" package provided by unilib",
        depends = {"food_honey_normal", "misc_honeycomb_normal"},
    }

end

function unilib.pkg.misc_hive_normal.exec()

    local c_honeycomb = "unilib:misc_honeycomb_normal"

    unilib.register_node("unilib:misc_hive_normal", "petz:beehive", mode, {
        -- From petz:beehive
        description = S("Normal Beehive"),
        tiles = {"unilib_misc_hive_normal.png"},
        groups = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 3, snappy = 2, wool = 1},
        sounds = unilib.global.sound_table.node,

        drop = "",
        is_ground_content = false,

        after_place_node = function(pos, placer, itemstack, pointed_thing)

            local meta = core.get_meta(pos)
            local honey_count, bee_count

            if placer:is_player() then

                honey_count = 0
                bee_count = 0
                if unimobs.petz_setting.beehive_protected_flag then
                    meta:set_string("owner", placer:get_player_name())
                end

                core.after(unimobs.petz_setting.beehive_create_first_worker_delay, function()

                    local node = core.get_node_or_nil(pos)
                    if not (node and node.name == "unilib:misc_hive_normal") then
                        return
                    end

                    local meta = core.get_meta(pos)
                    local total_bees =
                            meta:get_int("total_bees") or unimobs.petz_setting.beehive_max_bees
                    if total_bees < unimobs.petz_setting.beehive_max_bees then

                        bee_count = meta:get_int("bee_count")
                        bee_count = bee_count + 1
                        total_bees = total_bees + 1
                        meta:set_int("bee_count", bee_count)
                        meta:set_int("total_bees", total_bees)
                        honey_count = meta:get_int("honey_count")
                        unilib.pkg.misc_hive_normal.set_infotext(meta, honey_count, bee_count)

                    end

                end, pos)

            else

                honey_count = unimobs.petz_setting.beehive_initial_honey
                bee_count = unimobs.petz_setting.beehive_max_bees

            end

            meta:set_int("pollen_count", 0)
            meta:set_int("honey_count", honey_count)
            meta:set_int("bee_count", bee_count)
            meta:set_int("total_bees", bee_count)
            unilib.pkg.misc_hive_normal.set_infotext(meta, honey_count, bee_count)

        end,

        can_dig = function(pos, player)

            -- Original to unimobs. If hives are ownable, then don't allow digging them either
            --      (original code already prevents other players from right-clicking the hive)

            local meta = core.get_meta(pos)
            local owner = meta:get_string("owner")

            local pname = ""
            if player then
                pname = player:get_player_name()
            end

            if not unimobs.petz_setting.beehive_protected_flag or
                    owner == "" or
                    owner == pname then
                return true
            else
                return false
            end

        end,

        on_construct = function(pos)

            local meta = core.get_meta(pos)
            local drop_list = {
                {name = c_honeycomb, chance = 1, min = 1, max = 6},
            }
            meta:set_string("drop_list", core.serialize(drop_list))

            local timer = core.get_node_timer(pos)
            timer:start(2.0)

            meta:set_int("pollen_count", 0)
            local honey_count = unimobs.petz_setting.beehive_initial_honey
            meta:set_int("honey_count", honey_count)

            local bee_count = unimobs.petz_setting.beehive_max_bees
            meta:set_int("total_bees", bee_count)
            meta:set_int("bee_count", bee_count)

            unilib.pkg.misc_hive_normal.set_infotext(meta, honey_count, bee_count)

        end,

        on_destruct = function(pos)

            core.add_entity(pos, "unilib:mob_bee_queen")
            unimobs.kitz_api.make_node_drop_items(pos)

        end,

        on_rightclick = function(pos, node, player, itemstack, pointed_thing)

            local wielded_item = player:get_wielded_item()
            local wielded_name = wielded_item:get_name()
            local meta, pollen_count, honey_count, bee_count =
                    unilib.pkg.misc_hive_normal.get_stats(pos)
            local pname = player:get_player_name()

            if unimobs.petz_setting.beehive_protected_flag then

                local owner_name = meta:get_string("owner")
                if owner_name ~= "" and owner_name ~= pname then

                    core.chat_send_player(pname, S("This beehive belongs to @1", owner_name))
                    return

                end

            end

            if wielded_name == "unilib:vessel_bottle_glass_empty" or
                    wielded_name == "vessels:glass_bottle" then

                if honey_count > 0 then

                    local inv = player:get_inventory()
                    if inv:room_for_item("main", "unilib:food_honey_normal") then

                        local itemstack_name = itemstack:get_name()
                        local stack = ItemStack("unilib:food_honey_normal 1")

                        if (
                            itemstack_name == "unilib:food_honey_normal" or itemstack_name == ""
                        ) and itemstack:get_count() < itemstack:get_stack_max() then
                            itemstack:add_item(stack)
                        else
                            inv:add_item("main", stack)
                        end

                        itemstack:take_item()
                        honey_count = honey_count - 1
                        meta:set_int("honey_count", honey_count)
                        unilib.pkg.misc_hive_normal.set_infotext(meta, honey_count, bee_count)
                        return itemstack

                    else

                        core.chat_send_player(
                            pname,
                            S("There isn't enough room in your inventory for the bottle of honey")
                        )

                    end

                else

                    core.chat_send_player(pname, S("There is no honey in the beehive"))

                end

            elseif wielded_name == "unilib:spawnegg_bee_worker" then

                local total_bees =
                        meta:get_int("total_bees") or unimobs.petz_setting.beehive_max_bees
                if total_bees < unimobs.petz_setting.beehive_max_bees then

                    bee_count = bee_count + 1
                    total_bees = total_bees + 1
                    meta:set_int("bee_count", bee_count)
                    meta:set_int("total_bees", total_bees)
                    unilib.pkg.misc_hive_normal.set_infotext(meta, honey_count, bee_count)
                    itemstack:take_item()
                    return itemstack

                else

                    -- (Unlikely, but we need to handle it anyway...)
                    if unimobs.petz_setting.beehive_max_bees == 1 then

                        core.chat_send_player(pname, S("This beehive already has a bee inside it"))

                    else

                        core.chat_send_player(
                            pname,
                            S(
                                "This beehive already has @1 bees inside it",
                                tostring(unimobs.petz_setting.beehive_max_bees)
                            )
                        )

                    end

                end

            end

        end,

        on_timer = function(pos)

            local meta, pollen_count, honey_count, bee_count =
                    unilib.pkg.misc_hive_normal.get_stats(pos)

            -- (If a bee is inside...)
            if bee_count > 0 then

                local target_pos = {x = pos. x, y = pos.y - 4, z = pos.z}
                -- (Check if fire/torch below)
                local ray = core.raycast(pos, target_pos, false, false)
                local igniter_below_flag = false

                for thing in ray do

                    if thing.type == "node" then

                        local node_name = core.get_node(thing.under).name
                        if core.get_item_group(node_name, "igniter") > 0 or
                                core.get_item_group(node_name, "torch") > 0 then

                            igniter_below_flag = true
                            break

                        end

                    end

                end

                local dispatch_chance = 1
                if igniter_below_flag == false then
                    dispatch_chance = unimobs.petz_setting.beehive_dispatch_chance
                end

                -- (An opportunity to leave the hive)
                if random(1, dispatch_chance) == 1 then

                    local nearby_pos = get_bee_spawn_pos(pos)
                    if nearby_pos then

                        local bee = core.add_entity(nearby_pos, "unilib:mob_bee_worker")
                        if bee then

                            local luaent = bee:get_luaentity()
                            luaent.beehive_pos = unimobs.mobkit_api.add_mob_memory(
                                luaent, "beehive_pos", pos
                            )
                            bee_count = bee_count - 1
                            meta:set_int("bee_count", bee_count)
                            unilib.pkg.misc_hive_normal.set_infotext(meta, honey_count, bee_count)

                        end

                    end

                end

            end

            return true

        end,
    })
    unilib.register_craft({
        -- From petz:beehive
        type = "shaped",
        output = "unilib:misc_hive_normal",
        recipe = {
            {c_honeycomb, c_honeycomb, c_honeycomb},
            {c_honeycomb, "unilib:spawnegg_bee_queen", c_honeycomb},
            {c_honeycomb, c_honeycomb, c_honeycomb},
        },
    })

end
