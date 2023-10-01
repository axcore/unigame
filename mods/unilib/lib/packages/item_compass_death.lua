---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    death_compass
-- Code:    MIT
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_compass_death = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.death_compass.add_mode

local range_to_inactivate = 5
-- N.B. In original code, y was 0.9, but this interferes with over visible messages
local hud_posn_table = {x = 0.5, y = 0.8}
local hud_colour = 0xFFFF00
local player_ticking_table = {}
local player_hud_table = {}
local player_death_location_table = {}

-- (Messages set below)
local inv_msg, time_msg

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function clock_string(seconds, round_flag)

    -- If round_flag is true, the return string will only have the two largest-scale values

    seconds = math.floor(seconds)
    local days = math.floor(seconds / 86400)
    seconds = seconds - days * 86400
    local hours = math.floor(seconds / 3600)
    seconds = seconds - hours * 3600
    local minutes = math.floor(seconds / 60)
    seconds = seconds - minutes * 60

    local ret = {}

    if days == 1 then
        table.insert(ret, S("1 day"))
    elseif days > 1 then
        table.insert(ret, S("@1 days", days))
    end

    if hours == 1 then
        table.insert(ret, S("1 hour"))
    elseif hours > 1 then
        table.insert(ret, S("@1 hours", hours))
    end

    if minutes == 1 then
        table.insert(ret, S("1 minute"))
    elseif minutes > 1 then
        table.insert(ret, S("@1 minutes", minutes))
    end

    if seconds == 1 then
        table.insert(ret, S("1 second"))
    elseif seconds > 1 then
        table.insert(ret, S("@1 seconds", seconds))
    end

    if #ret == 0 then
        return S("@1 seconds", 0)
    end

    if #ret == 1 then
        return ret[1]
    elseif round_flag or #ret == 2 then
        return S("@1 and @2", ret[1], ret[2])
    end

    return table.concat(ret, S(", "))

end

local function set_target(stack, pos, name)

    -- Set a position to the compass stack

    local meta = stack:get_meta()
    meta:set_string("target_pos", minetest.pos_to_string(pos))
    meta:set_string("target_corpse", name)
    meta:set_int("time_of_death", minetest.get_gametime())

end

local function get_destination(player, stack)

    -- Get compass target
    local pos_str = stack:get_meta():get_string("target_pos")
    if pos_str ~= "" then
        return minetest.string_to_pos(pos_str)
    end

end

local function start_ticking(player_name)

    -- Looped ticking sound if a duration is set

    if not player_ticking_table[player_name] then

        player_ticking_table[player_name] = minetest.sound_play(
            "unilib_item_compass_death_tick",
            {to_player = player_name, gain = 0.125, loop = true}
        )

    end

end

local function stop_ticking(player_name)

    local tick_tock_handle = player_ticking_table[player_name]
    if tick_tock_handle then

        minetest.sound_stop(tick_tock_handle)
        player_ticking_table[player_name] = nil

    end

end

local function hide_hud(player, player_name)

    local id = player_hud_table[player_name]
    if id then

        player:hud_remove(id)
        player_hud_table[player_name] = nil

    end

end

local function update_hud(player, player_name, compass)

    local metadata = compass:get_meta()

    -- N.B. Seems to be an error in the original code, fixed below
    --[[
    local target_pos = minetest.string_to_pos(metadata:get_string("target_pos"))
    local player_pos = player:get_pos()
    local distance = vector.distance(player_pos, target_pos)
    if not target_pos then
        return
    end
    ]]--
    local target_pos = minetest.string_to_pos(metadata:get_string("target_pos"))
    if not target_pos then
        return
    end

    local player_pos = player:get_pos()
    local distance = vector.distance(player_pos, target_pos)
    local time_of_death = metadata:get_int("time_of_death")
    local target_name = metadata:get_string("target_corpse")

    local description
    if unilib.death_compass_duration > 0 then

        local remaining = time_of_death + unilib.death_compass_duration - minetest.get_gametime()
        if remaining < 0 then
            return
        end

        description = S(
            "@1m to @2's corpse, @3 remaining",
            math.floor(distance),
            target_name,
            clock_string(remaining, true)
        )

    else

        description = S(
            "@1m to @2's corpse, died @3 ago",
            math.floor(distance),
            target_name,
            clock_string(minetest.get_gametime() - time_of_death, true)
        )

    end

    local id = player_hud_table[player_name]
    if not id then

        id = player:hud_add({
            name = "death_compass",
            hud_elem_type = "text",

            position = hud_posn_table,
            text = description,
            number = hud_colour,
            scale = 20,
        })

        player_hud_table[player_name] = id

    else

        player:hud_change(id, "text", description)

    end

end

local function get_compass_stack(player, stack)

    -- Get the right image for the player's compass

    local target = get_destination(player, stack)
    local inactive_return

    if unilib.death_compass_auto_flag then
        inactive_return = ItemStack("")
    else
        inactive_return = ItemStack("unilib:item_compass_death_off")
    end

    if not target then
        return inactive_return
    end

    local pos = player:get_pos()
    local distance = vector.distance(pos, target)
    local player_name = player:get_player_name()

    if distance < range_to_inactivate then

        stop_ticking(player_name)
        minetest.sound_play(
            "unilib_item_compass_death_crunch",
            {to_player = player_name, gain = 1.0}
        )
        -- Change to original code: upon reaching the target, hide the HUD
        hide_hud(player, player_name)

        return inactive_return

    end

    local dir = player:get_look_horizontal()
    local angle_north = math.deg(math.atan2(target.x - pos.x, target.z - pos.z))
    if angle_north < 0 then
        angle_north = angle_north + 360
    end

    local angle_dir = math.deg(dir)
    local angle_relative = (angle_north + angle_dir) % 360
    local compass_image = math.floor((angle_relative / 22.5) + 0.5) % 16

    -- Create new stack with metadata copied
    local metadata = stack:get_meta():to_table()
    local meta_fields = metadata.fields
    local time_of_death = tonumber(meta_fields.time_of_death)

    if unilib.death_compass_duration > 0 then

        local remaining = time_of_death + unilib.death_compass_duration - minetest.get_gametime()
        if remaining < 0 then

            stop_ticking(player_name)
            minetest.sound_play(
                "unilib_item_compass_death_crunch",
                {to_player = player_name, gain = 1.0}
            )

            -- Change to original code: upon expiration of time limit, hide the HUD
            hide_hud(player, player_name)

            return inactive_return

        end

        start_ticking(player_name)

    end

    local newstack = ItemStack("unilib:item_compass_death_" .. compass_image)
    if metadata then
        newstack:get_meta():from_table(metadata)
    end

    return newstack

end

local function display_doc(itemstack, user)

    local player_name = user:get_player_name()
    minetest.chat_send_player(player_name, inv_msg .. "\n" .. time_msg)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_compass_death.init()

    return {
        description = "Death compass",
        notes = "A compass that points to the location of the player's death. Minetest settings" ..
                " specify a time limit (or none), and whether the compass is placed in the" ..
                " player's inventory automatically on death (or not). Cannot be crafted if the" ..
                " bones mod is not loaded",
        mod_optional = "bones",
    }

end

function unilib.pkg.item_compass_death.exec()

    -- Set help messages used in the call to display_doc()
    inv_msg = S(
        "This does nothing in its current inert state. If you have this in your inventory when" ..
        " you die, however, it will follow you into your next life's inventory and point toward" ..
        " the location of your previous life's end."
    )

    if unilib.death_compass_duration > 0 then

        time_msg = S(
            "The Death Compass' guidance will only last for @1 after death.",
            clock_string(unilib.death_compass_duration, false)
        )

    else

        time_msg = S("The Death Compass will point toward your corpse until you find it.")

    end

    -- Update inventory and hud
    minetest.register_globalstep(function(dtime)

        for i, player in ipairs(minetest.get_connected_players()) do

            local player_name = player:get_player_name()
            local compass_in_quickbar
            local inv = player:get_inventory()

            if inv then

                for i, stack in ipairs(inv:get_list("main")) do

                    if i > unilib.hotbar_size then
                        break
                    end

                    if string.sub(stack:get_name(), 0, 26) == "unilib:item_compass_death_" then

                        player:get_inventory():set_stack(
                            "main", i, get_compass_stack(player, stack)
                        )
                        compass_in_quickbar = true

                    end

                end

                if compass_in_quickbar then

                    local wielded = player:get_wielded_item()
                    if string.sub(wielded:get_name(), 0, 26) == "unilib:item_compass_death_" then
                        update_hud(player, player_name, wielded)
                    else
                        hide_hud(player, player_name)
                    end

                end

            end

            if not compass_in_quickbar then

                stop_ticking(player_name)
                hide_hud(player, player_name)

            end

        end

    end)

    -- Register craftitems
    for i = 0, 15 do

        local img = "unilib_item_compass_death_" .. i .. ".png"
        unilib.register_craftitem("unilib:item_compass_death_" .. i, "death_compass:dir"..i, mode, {
            -- From death_compass:dir0, etc
            description = S("Death Compass"),
            inventory_image = img,
            groups = {death_compass = 1, not_in_creative_inventory = 1},

            stack_max = 1,
            wield_image = img,
        })

    end

    if not unilib.death_compass_auto_flag then

        unilib.register_craftitem("unilib:item_compass_death_off", "death_compass:inactive", mode, {
            -- From death_compass:inactive
            description = S("Death Compass"),
            inventory_image = "unilib_item_compass_death_off.png",
            -- (no groups)

            stack_max = 1,
            wield_image = "unilib_item_compass_death_off.png",

            on_place = display_doc,

            on_secondary_use = display_doc,
        })
        -- N.B. The "bones" mod is an optional mod for this package; if the compass is not
        --      craftable, the compass still might be placed in the player's inventory automatically
        --      upon death (depending on Minetest settings)
        -- In this case, this package does not check that the "bones" mod has been loaded, in case
        --      it will be loaded after unilib
        unilib.register_craft({
            -- From death_compass:inactive
            output = "unilib:item_compass_death_off",
            recipe = {
                {"", "bones:bones", ""},
                {"bones:bones", "unilib:mineral_mese_crystal_fragment", "bones:bones"},
                {"", "bones:bones", ""}
            }
        })
        -- Notes from death_compass:
        -- Allow a player to deliberately deactivate a death compass
        unilib.register_craft({
            -- From death_compass:inactive
            type = "shapeless",
            output = "unilib:item_compass_death_off",
            recipe = {
                "group:death_compass",
            },
        })

    end

    -- Code to call when a player dies
    minetest.register_on_dieplayer(function(player, reason)

        -- Notes from death_compass:
        -- "reason": a PlayerHPChangeReason table, see register_on_player_hpchange

        local player_name = player:get_player_name()
        local inv = minetest.get_inventory({type = "player", name = player:get_player_name()})
        local list = inv:get_list("main")
        local count = 0

        if unilib.death_compass_auto_flag then

            count = 1

        else

            for i, itemstack in pairs(list) do

                if itemstack:get_name() == "unilib:item_compass_death_off" then

                    count = count + itemstack:get_count()
                    list[i] = ItemStack("")

                end

            end

        end

        if count > 0 then

            inv:set_list("main", list)
            player_death_location_table[player_name] = {count = count, pos = player:get_pos()}

        end

    end)

    -- Notes from death_compass:
    -- Using the regular minetest.register_on_dieplayer() causes the new callback to be inserted
    --      *after* the on_dieplayer() used by the bones mod, which means the bones mod clears the
    --      player inventory before, so we can't tell if there was a death compass in it
    -- We must therefore rearrange the callback table to move this mod's callback to the front to
    --      ensure it always goes first
    local dieplayer_callback = table.remove(minetest.registered_on_dieplayers)
    table.insert(minetest.registered_on_dieplayers, 1, dieplayer_callback)

    -- Notes from death_compass:
    -- Code to call when the player is to be respawned, before repositioning of the player occurs
    -- This function should return true to disable regular player placement
    minetest.register_on_respawnplayer(function(player)

        local player_name = player:get_player_name()
        local compasses = player_death_location_table[player_name]

        if compasses then

            local inv = minetest.get_inventory({type = "player", name = player_name})

            -- Remove any death compasses the player might still have for some reason
            local current = inv:get_list("main")
            for i, item in pairs(current) do

                if item:get_name() == "unilib:item_compass_death_off" then
                    current[i] = ItemStack("")
                end

            end

            inv:set_list("main", current)

            -- Give the player new compasses pointing to their place of death
            for i = 1, compasses.count do

                local compass = ItemStack("unilib:item_compass_death_0")
                set_target(compass, compasses.pos, player_name)
                inv:add_item("main", compass)

            end

        end

        return false

    end)

    -- Tidy up
    minetest.register_on_leaveplayer(function(player, timed_out)
        hide_hud(player, player:get_player_name())
    end)

end
