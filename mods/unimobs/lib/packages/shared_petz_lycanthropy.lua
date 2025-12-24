---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_petz_lycanthropy = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

-- Localise math functions (for speed)
local floor = math.floor
local random = math.random

-- Global variables in original code
-- (Was lycanthropy.werewolf.animation_speed)
local werewolf_animation_speed = 30
-- (Was lycanthropy.werewolf.animations)
local werewolf_animation_table = {
    lay = {x = 162, y = 166},
    mine = {x = 189, y = 198},
    sit = {x = 81, y = 160},
    stand = {x = 0, y = 79},
    walk = {x = 168, y = 187},
    walk_mine = {x = 200, y = 219},
    -- Compatibility with the "emote" mod
    freeze = {x = 205, y = 205, override_local = true},
    point = {x = 196, y = 196, override_local = true},
    wave = {x = 192, y = 196, override_local = true},
}
-- (Was lycanthropy.werewolf.override_table)
local werewolf_override_table = {
    gravity = 0.95,
    jump = 1.5,
    new_move = true,
    sneak = true,
    sneak_glitch = false,
    speed = 1.5,
}
-- (Was lycanthropy.werewolf.model)
local werewolf_model = "unilib_armour_werewolf.b3d"

-- Local variables in original code
-- (Was use_playerphysics)
local playerphysics_path = core.get_modpath("playerphysics")
-- (Was use_player_monoids)
local player_monoids_path = core.get_modpath("player_monoids")
-- (Was hud_id_by_player_name)
local id_table = {}
-- Cycle day/night changes
local lycanthropy_timer = 0
local last_period_of_day
-- Tag used of instead of the "petz:physics" string in calls to the "player_monoids" mod
local player_physics_tag = "unilib:lycanthropy_physics"

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

-- (Was lycanthropy.clans)
unilib.pkg.shared_petz_lycanthropy.clan_list = {
    {
        clan_name = S("The Savage Stalkers"),
        part_name = "grey_dark",
        part_description = S("Dark Grey"),
        probability = 1,
        texture = "unilib_mob_monster_werewolf_grey_dark.png",
    },
    {
        clan_name = S("The Bravehide Pride"),
        part_name = "grey",
        part_description = S("Grey"),
        probability = 0.5,
        texture = "unilib_mob_monster_werewolf_grey.png",
    },
    {
        clan_name = S("The Hidden Tails"),
        part_name = "brown",
        part_description = S("Brown"),
        probability = 0.1,
        texture = "unilib_mob_monster_werewolf_brown.png",
    },
    {
        clan_name = S("The Fierce Manes"),
        part_name = "black",
        part_description = S("Black"),
        probability = 0,            -- Mutation
        texture = "unilib_mob_monster_werewolf_black.png",
    },
}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function set_werewolf_physics(player)

    -- Was petz.set_werewolf_physics()

    if playerphysics_path then

        playerphysics.add_physics_factor(
            player, "speed", "werewolf_speed", werewolf_override_table.speed
        )
        playerphysics.add_physics_factor(
            player, "jump", "werewolf_jump", werewolf_override_table.jump
        )
        playerphysics.add_physics_factor(
            player, "gravity", "werewolf_gravity", werewolf_override_table.gravity
        )

    elseif player_monoids_path then

        player_monoids.speed:add_change(player, werewolf_override_table.speed, player_physics_tag)
        player_monoids.jump:add_change(player, werewolf_override_table.jump, player_physics_tag)
        player_monoids.gravity:add_change(
            player, werewolf_override_table.gravity, player_physics_tag
        )

    else

        local override_table = player:get_physics_override()
        if override_table then

            unilib.utils.serialise_player_attribute(
                player, "lycanthropy_physics_override_before_werewolf", override_table
            )

        end

        player:set_physics_override(werewolf_override_table)

    end

end

local function unset_werewolf_physics(player)

    -- Was petz.unset_werewolf_physics()

    if playerphysics_path then

        playerphysics.remove_physics_factor(player, "speed", "werewolf_speed")
        playerphysics.remove_physics_factor(player, "jump", "werewolf_jump")
        playerphysics.remove_physics_factor(player, "gravity", "werewolf_gravity")

    elseif player_monoids_path then

        player_monoids.speed:del_change(player, player_physics_tag)
        player_monoids.jump:del_change(player, player_physics_tag)
        player_monoids.gravity:del_change(player, player_physics_tag)

    else

        -- N.B. This code fixes a possible bug in the original code, in which the
        --      "petz:old_override_table" was serialised when stored, but not deserialised when
        --      retrieved
        local override_table = unilib.utils.deserialise_player_attribute(
            player, "lycanthropy_physics_override_before_werewolf"
        )

        if override_table then
            player:set_physics_override(override_table)
        end

    end

end

local function set_werewolf_appearance(player)

    -- Was petz.set_werewolf_appearance()

    if not unilib.pkg.shared_petz_lycanthropy.is_werewolf(player) then

        local old_animation = unilib.player_api.get_animation(player)
        unilib.utils.serialise_player_attribute(
            player, "lycanthropy_animation_before_werewolf", old_animation
        )

    end

    unilib.player_api.set_model(player, werewolf_model)
    local clan_id =
            tonumber(unilib.utils.get_player_attribute(player, "lycanthropy_werewolf_clan_id"))
    local werewolf_texture = unilib.pkg.shared_petz_lycanthropy.clan_list[clan_id]["texture"]

    local pname = player:get_player_name()
    local player_texture_table = unilib.armour.get_player_texture(pname)
    unilib.player_api.set_textures(player, {
        unilib.pkg.shared_petz_lycanthropy.clan_list[clan_id]["texture"],
        player_texture_table.armour,
        player_texture_table.wielditem,
    })

end

local function unset_werewolf_appearance(player)

    -- Was petz.unset_werewolf_appearance()

    local pre_werewolf_animation = unilib.utils.deserialise_player_attribute(
        player, "lycanthropy_animation_before_werewolf"
    )
    if pre_werewolf_animation then

        -- Notes from original code:
        -- TODO: This still isn't perfect, but it gets rid of weird glitchy appearances due to
        --      mismatched models. It results in the player looking exactly like they did before
        --      they became a werewolf, until their next model update. However, they may momentarily
        --      appear to be wearing the wrong armor, or to be weilding the wrong item.
        -- N.B. This bug may be resolved by the unimobs bugfix in the unset_werewolf_physics()
        --      function; but as I'm not able to reproduce the original bug, we'll keep this bugfix
        --      in place too
        unilib.utils.set_player_attribute(player, "lycanthropy_animation_before_werewolf", "")
        if pre_werewolf_animation.model then
            unilib.player_api.set_model(player, pre_werewolf_animation.model)
        end

        if pre_werewolf_animation.textures then
            unilib.player_api.set_textures(player, pre_werewolf_animation.textures)
        end

    else

        local pname = player:get_player_name()
        unilib.player_api.set_model(player, "unilib_armour_character.b3d")

        local player_texture_table = unilib.armour.get_player_texture(pname)
        unilib.player_api.set_textures(player, {
            player_texture_table.skin,
            player_texture_table.armour,
            player_texture_table.wielditem,
        })

    end

end

local function show_werewolf_vignette(player)

    -- Was petz.show_werewolf_vignette()

    local pname = player:get_player_name()

    local hud_id = id_table[pname]
    if hud_id then

        local hud_def_table = player:hud_get(hud_id)
        -- If already showing the vignette, do nothing
        if hud_def_table and hud_def_table.name == "unillib:hud_werewolf_vignette" then
            return
        end

    end

    id_table[pname] = player:hud_add({
        name = "unillib:hud_werewolf_vignette",
        type = "image",

        alignment = {x = 1, y = 1},
        offset = {x = 0, y = 0},
        position = {x = 0, y = 0},
        scale = {x = -100, y = -100},
        text = "unilib_gui_petz_vignette.png",
    })

end

local function hide_werewolf_vignette(player)

    -- Was petz.remove_werewolf_vignette()

    local pname = player:get_player_name()

    local hud_id = id_table[pname]
    if hud_id then

        local hud_def_table = player:hud_get(hud_id)
        if hud_def_table and hud_def_table.name == "unillib:hud_werewolf_vignette" then
            player:hud_remove(hud_id)
        end

    end

    id_table[pname] = nil

end

local function set_werewolf(player)

    -- Was petz.set_werewolf()

    if not unilib.pkg.shared_petz_lycanthropy.has_lycanthropy(player) then
        return
    end

    show_werewolf_vignette(player)
    set_werewolf_appearance(player)
    set_werewolf_physics(player)

    unilib.utils.set_player_attribute(player, "lycanthropy_is_werewolf", "true")

end

local function do_probabilistic_round(val)

    -- Was probabilistic_round()
    -- Rounds up or down by chance depending on the fractional part

    return floor(val + random())

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_petz_lycanthropy.cure_player(player)

    -- Was petz.cure_lycanthropy()

    local pname = player:get_player_name()
    if unilib.pkg.shared_petz_lycanthropy.is_werewolf(player) then
        unilib.pkg.shared_petz_lycanthropy.reset_infected_player(player)
    end

    unilib.utils.set_player_attribute(player, "lycanthropy_is_infected", "false")
    core.chat_send_player(pname, S("You have been cured of the Curse of Lycanthropy!"))

end

function unilib.pkg.shared_petz_lycanthropy.infect_player(player)

    -- Was petz.set_lycanthropy()

    local pname = player:get_player_name()
    if not unilib.pkg.shared_petz_lycanthropy.has_lycanthropy(player) then

        unilib.utils.set_player_attribute(player, "lycanthropy_is_infected", "true")

        local clan_index = random(1, #unilib.pkg.shared_petz_lycanthropy.clan_list)
        unilib.utils.set_player_attribute(player, "lycanthropy_werewolf_clan_id", clan_index)

        core.chat_send_player(pname, S("You have been infected by the Curse of Lycanthropy!"))
        set_werewolf(player)

    end

end

function unilib.pkg.shared_petz_lycanthropy.reset_infected_player(player)

    -- Was petz.unset_werewolf()

    hide_werewolf_vignette(player)
    unset_werewolf_physics(player)
    unset_werewolf_appearance(player)

    unilib.utils.set_player_attribute(player, "lycanthropy_is_werewolf", "false")

end

function unilib.pkg.shared_petz_lycanthropy.is_werewolf(player)

    -- Was petz.is_werewolf()

    if not core.is_player(player) then
        return false
    end

    return unilib.utils.get_player_attribute(player, "lycanthropy_is_werewolf") == "true"

end

function unilib.pkg.shared_petz_lycanthropy.has_lycanthropy(player)

    -- Was petz.has_lycanthropy()

    if not core.is_player(player) then
        return false
    end

    return unilib.utils.get_player_attribute(player, "lycanthropy_is_infected") == "true"

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_petz_lycanthropy.init()

    return {
        description = "Shared functions for lycanthropy (from petz)",
        notes = "An optional package that can be added alongside the \"mob_monster_werewolf\"" ..
                " and/or \"mob_wolf_normal\" packages, in order to add a \"Curse of" ..
                " Lycanthropy\". If this package is not loaded, then werewolves (and wolves)" ..
                " behave like ordinary mobs. However, when this package is in fact loaded," ..
                " players can be infected by the curse; cure it by drinking the potion from the" ..
                " \"potion_lycanthropy\" package",
    }

end

function unilib.pkg.shared_petz_lycanthropy.exec()

    -- (When this code is run, the unilib mod is not guaranteed to have been loaded yet)
    core.after(0.1, function()

        unilib.player_api.register_model(werewolf_model, {
            animation_speed = werewolf_animation_speed,
            textures = {
                unilib.pkg.shared_petz_lycanthropy.clan_list[1]["texture"],
                -- N.B. Original code used a 3d_armor texture, "3d_armor_trans.png", that doesn't
                --      exist in modern versions of the mod; use a standard transparent texture
                --      instead
                "unilib_transparent_x16.png",
                "unilib_transparent_x16.png",
            },
            animations = werewolf_animation_table,
        })

        unilib.armour.register_callback_on_update(function(player)

            if unilib.pkg.shared_petz_lycanthropy.is_werewolf(player) then
                set_werewolf_appearance(player)
            end

        end)

    end)

    core.register_on_leaveplayer(function(player)

        -- Clean up HUD IDs
        id_table[player:get_player_name()] = nil

    end)

    core.register_on_punchplayer(

        -- Lycanthropy infection system: a player may become infected or not (depending on
        --      settings), when bitten (punched) by a werewolf, or a "normal" wolf with a black
        --      skin, or occasionally by other types of wolves
        function(player, hitter, time_from_last_punch, tool_capabilities, dir, damage)

            -- Players can't spread infection, and an infected player can't be re-infected
            if hitter:is_player() or unilib.pkg.shared_petz_lycanthropy.has_lycanthropy(player) then
                return
            end

            -- (The hitter is an entity, not a player)
            local hitter_luaent = hitter:get_luaentity()
            -- (Only wolves and werewolves can spread an infection)
            if not hitter_luaent.petz_compat_flag or (
                hitter_luaent.mob_type ~= "wolf_normal" and
                hitter_luaent.mob_type ~= "monster_werewolf"
            ) then
                return
            end

            -- (Skin #4 is a rare mutation)
            local is_black_wolf_flag = hitter_luaent.mob_texture_num == 4 and
                    hitter_luaent.mob_type == "wolf_normal"

            local bitten_by_wolf_flag =
                (hitter_luaent.mob_type == "wolf_normal") and
                (random(1, unimobs.petz_setting.lycanthropy_wolf_infection_chance) == 1)

            local bitten_by_werewolf_flag =
                (hitter_luaent.mob_type == "monster_werewolf") and
                (random(1, unimobs.petz_setting.lycanthropy_werewolf_infection_chance) == 1)

            if is_black_wolf_flag or bitten_by_wolf_flag or bitten_by_werewolf_flag then
                unilib.pkg.shared_petz_lycanthropy.infect_player(player)
            end

        end
    )

    core.register_on_player_hpchange(function(player, hp_change, reason)

        -- Players who are werewolves receive less damage
        if reason and
                reason.type == "punch" and
                unilib.pkg.shared_petz_lycanthropy.is_werewolf(player) and
                hp_change < 0 then

            local reduction_factor = unimobs.petz_setting.lycanthropy_damage_reduction_factor
            return do_probabilistic_round(hp_change * (1 - reduction_factor))

        end

        return hp_change

    end, true)

    core.register_globalstep(function(dtime)

        -- Cycle day/night changes
        lycanthropy_timer = lycanthropy_timer + dtime
        if lycanthropy_timer < 5 then
            return
        end

        lycanthropy_timer = 0
        local current_period_of_day = unimobs.petz_api.is_night()

        -- If day has become night, or vice-versa...
        if current_period_of_day ~= last_period_of_day then

            last_period_of_day = current_period_of_day
            for _, player in pairs(core.get_connected_players()) do

                if unilib.pkg.shared_petz_lycanthropy.has_lycanthropy(player) then

                    if unimobs.petz_api.is_night() then

                        if not unilib.pkg.shared_petz_lycanthropy.is_werewolf(player) then

                            set_werewolf(player)
                            core.chat_send_player(
                                player:get_player_name(), S("You are now a werewolf")
                            )

                        end

                    else

                        if unilib.pkg.shared_petz_lycanthropy.is_werewolf(player) then

                            unilib.pkg.shared_petz_lycanthropy.reset_infected_player(player)
                            core.chat_send_player(
                                player:get_player_name(), S("You are no longer a werewolf")
                            )

                        end

                    end

                end

            end

        end

    end)

    core.register_on_joinplayer(function(player)

        -- Check whether joining players are werewolves, and take action if so
        if unilib.pkg.shared_petz_lycanthropy.has_lycanthropy(player) then

            if unimobs.petz_api.is_night() then
                set_werewolf(player)
            else
                unilib.pkg.shared_petz_lycanthropy.reset_infected_player(player)
            end

        end

    end)

    core.register_on_item_eat(function(hp_change, replace_with_item, itemstack, user, pointed_thing)

        -- Werewolves can only eat raw meat
        if unilib.pkg.shared_petz_lycanthropy.is_werewolf(user) and
                core.get_item_group(itemstack:get_name(), "food_meat_raw") == 0 then

            local user_name = user:get_player_name()
            core.chat_send_player(user_name, S("Werewolves can only eat raw meat!"))
            return itemstack

        end

    end)

end
