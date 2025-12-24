---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_whistle_pet = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

-- Localise math functions (for speed)
local floor = math.floor

local nametag_colour = "#EE0"
-- Was local variable "context"
local player_table = {}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_formspec(user_name, user_pos)

    -- From petz.create_form_list_by_owner()
    -- Formspec opened when a player "uses" the whistle

    -- Get the values of the list
    local active_mobs_by_owner_list = unimobs.kitz_api.get_active_mobs_by_owner(user_name, true)
    if unimobs.kitz_api.is_table_empty(active_mobs_by_owner_list) then

        core.chat_send_player(
            user_name, S("Before summoning your tamed creatures, you must first name them")
        )

        return ""

    end

    local mob_str = ""
    for _, mob in pairs(active_mobs_by_owner_list) do

        if unimobs.mobkit_api.is_object_alive(mob.object) then

            local mob_pos = mob.object:get_pos()

            local distance, mob_pos_x, mob_pos_y, mob_pos_z
            if mob_pos then

                distance = tostring(
                    unimobs.kitz_api.round_number(vector.distance(user_pos, mob_pos))
                )
                mob_pos_x = tostring(floor(mob_pos.x + 0.5))
                mob_pos_y = tostring(floor(mob_pos.y + 0.5))
                mob_pos_z = tostring(floor(mob_pos.z + 0.5))

            else

                distance = S("too far away")
                mob_pos_x = "X"
                mob_pos_y = "Y"
                mob_pos_z = "Z"

            end

            -- N.B. Changed the format of items in the original code's textlist to match the main
            --      mob formspec
            mob_str = mob_str .. core.colorize(nametag_colour, mob.nametag) .. " | " ..
                unimobs.petz_api.get_insertion(mob.mob_type, "subject") .. " | " ..
                "x=" .. mob_pos_x .. " y=" .. mob_pos_y ..
                " z=".. mob_pos_z .. " | " .. distance .. "m,"

        end

    end

    player_table[user_name] = active_mobs_by_owner_list

    -- N.B. Improved layout of original formspec, also removing the useless "selected idx" value
    return "size[6,8;]" ..
            "image[2.5,0;1,1;unilib_item_whistle_pet.png]" ..
            "textlist[0,1.2;5.8,5.8;mob_list;" .. mob_str .. ";]" ..
            "button_exit[2.5,7.25;1,1;btn_exit;" .. S("Close") .. "]"

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_whistle_pet.init()

    return {
        description = "Pet whistle",
        notes = "Can be used to summon any tamed creatures you have named. Left-click while" ..
                " wielding the whistle in order to open the formspec, then click on one of the" ..
                " listed creatures to summon it",
        depends = "metal_steel",
        suggested = {
            "organ_feather_duck",               -- group:feather
        },
    }

end

function unilib.pkg.item_whistle_pet.exec()

    unilib.register_craftitem("unilib:item_whistle_pet", "petz:whistle", mode, {
        -- From petz:whistle
        description = S("Pet Whistle"),
        inventory_image = "unilib_item_whistle_pet.png",
        groups = {},

        on_use = function (itemstack, user, pointed_thing)

            local user_name = user:get_player_name()
            core.show_formspec(
                user_name,
                "unilib:form_item_whistle_pet",
                get_formspec(user_name, user:get_pos())
            )

        end,
    })
    unilib.register_craft({
        -- From petz:whistle
        type = "shaped",
        output = "unilib:item_whistle_pet",
        recipe = {
            {"", "", ""},
            -- N.B. Original code used unilib:organ_feather_duck
            {"", "group:feather", ""},
            {"", "unilib:metal_steel_ingot", ""},
        },
    })

    core.register_on_player_receive_fields(function(player, formname, fields)

        if formname ~= "unilib:form_item_whistle_pet" then
            return false
        end

        if fields.mob_list then

            local pname = player:get_player_name()
            local event = core.explode_textlist_event(fields.mob_list)
            local mob_index = event.index
            if not player_table[pname] then
                return
            end

            local pet = player_table[pname][mob_index]
            if pet then

                local pos_front_player = unimobs.petz_api.get_pos_in_front_of_player(player)
                local pet_pos = {
                    x = pos_front_player.x,
                    y = pos_front_player.y + 1,
                    z = pos_front_player.z,
                }
                pet.object:set_pos(pet_pos)

                core.close_formspec(pname, "unilib:form_item_whistle_pet")
                unimobs.kitz_api.make_sound(
                    "player",
                    player,
                    "unilib_item_whistle_petz",
                    unimobs.petz_setting.max_hear_distance
                )

            end

        end

        return true

    end)

end
