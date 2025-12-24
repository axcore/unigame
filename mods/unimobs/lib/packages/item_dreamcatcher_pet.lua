---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_dreamcatcher_pet = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

-- Localise math functions (for speed)
local floor = math.floor

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_formspec(user_name, user_pos)

    -- From petz.create_form_list_by_owner_dreamcatcher()
    -- Formspec opened when a player "uses" the dreamcatcher

    -- Get the values of the list
    local active_mobs_by_owner_list = unimobs.kitz_api.get_active_mobs_by_owner(user_name)
    if unimobs.kitz_api.is_table_empty(active_mobs_by_owner_list) then

        core.chat_send_player(
            user_name, S("Before listing your tamed creatures, you must first name them")
        )

        return ""

    end

    local mob_str = ""
    for _, mob in ipairs(active_mobs_by_owner_list) do

        local mob_pos, mob_nametag
        local list_mob_flag = false

        -- Check the creature is alive and has a dreamcatcher
        if unimobs.mobkit_api.is_object_alive(mob.object) and mob.has_dreamcatcher_flag then

            mob_nametag = mob.nametag
            mob_pos = mob.object:get_pos()
            list_mob_flag = true

        end

        if list_mob_flag and mob_pos then

            local distance, mob_pos_x, mob_pos_y, mob_pos_z
            distance = tostring(unimobs.kitz_api.round_number(vector.distance(user_pos, mob_pos)))
            mob_pos_x = tostring(floor(mob_pos.x + 0.5))
            mob_pos_y = tostring(floor(mob_pos.y + 0.5))
            mob_pos_z = tostring(floor(mob_pos.z + 0.5))

            -- N.B. Changed the format of items in the original mob's textlist to match the main mob
            --      formspec
            mob_str = mob_str .. mob_nametag .. " | " ..
                unimobs.petz_api.get_insertion(mob.mob_type, "subject") .. " | " ..
                "x=" .. mob_pos_x .. " y=" .. mob_pos_y .. " z=".. mob_pos_z .. " | " ..
                distance .. "m,"

        end

    end

    -- N.B. Improved layout of original formspec, also removing the useless "selected idx" value
    return "size[6,8;]" ..
            "image[2.5,0;1,1;unilib_item_dreamcatcher_pet.png]" ..
            "textlist[0,1.2;5.8,5.8;mob_list;" .. mob_str .. ";]" ..
            "button_exit[2.5,7.25;1,1;btn_exit;" .. S("Close") .. "]"

end

local function on_rightclick_mob_callback(self, clicker, wielded_item, wielded_name, is_owner_flag)

    -- Adapted from petz.put_dreamcatcher()
    -- Gives the dreamcatcher to the mob, if it doesn't already have one

    if not self.is_tamed_flag or not self.is_pet_flag or not is_owner_flag then

        -- This override was not applied; apply the standard behaviour instead
        return false

    end

    if self.has_dreamcatcher_flag then

        core.chat_send_player(
            clicker:get_player_name(), S("This creature already has a dreamcatcher")
        )

        -- Do not apply the standard behaviour
        return true

    end

    wielded_item:take_item()
    clicker:set_wielded_item(wielded_item)
    self.has_dreamcatcher_flag =
            unimobs.mobkit_api.add_mob_memory(self, "has_dreamcatcher_flag", true)

    unimobs.kitz_api.make_sound(
        "object",
        self.object,
        "unilib_item_dreamcatcher_pet",
        unimobs.petz_setting.max_hear_distance
    )
    unimobs.petz_api.show_standard_particles(self.object:get_pos(), "dreamcatcher")

    -- Do not apply the standard behaviour
    return true

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_dreamcatcher_pet.drop_from_mob(self)

    -- From petz.drop_dreamcatcher()
    -- Called by several functions, e.g. unimobs.petz_api.handle_mob_death()
    -- Forces the mob to drop its dreamcatcher, if it has one

    if self.has_dreamcatcher_flag then

        core.add_item(self.object:get_pos(), "unilib:item_dreamcatcher_pet")
        unimobs.kitz_api.make_sound(
            "object", self.object, "unilib_pop_petz", unimobs.petz_setting.max_hear_distance
        )
        self.has_dreamcatcher_flag =
                unimobs.mobkit_api.add_mob_memory(self, "has_dreamcatcher_flag", false)

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_dreamcatcher_pet.init()

    return {
        description = "Pet dreamcatcher",
        notes = "Protects your pets from attacks by other players. It can also be used to get a" ..
                " list of your tamed creatures and their locations (use a whistle to summon them)",
        depends = "item_string_ordinary",
        suggested = {
            "organ_feather_duck",               -- group:feather
        },
    }

end

function unilib.pkg.item_dreamcatcher_pet.exec()

    local c_string = "unilib:item_string_ordinary"

    unilib.register_craftitem("unilib:item_dreamcatcher_pet", "petz:dreamcatcher", mode, {
        -- From petz:dreamcatcher
        description = S("Pet Dreamcatcher"),
        inventory_image = "unilib_item_dreamcatcher_pet.png",
        groups = {},

        on_use = function (itemstack, user, pointed_thing)

            local user_name = user:get_player_name()
            core.show_formspec(
                user_name,
                "unilib:form_item_dreamcatcher_pet",
                get_formspec(user_name, user:get_pos())
            )

        end,
    })
    unilib.register_craft({
        -- From petz:dreamcatcher
        type = "shaped",
        output = "unilib:item_dreamcatcher_pet",
        recipe = {
            {"", "group:wood", ""},
            {c_string, c_string, c_string},
            -- N.B. Original code used unilib:organ_feather_duck
            {"group:feather", "group:feather", "group:feather"},
        },
    })

    -- Override the standard behaviour when a mob is right-clicked while wielding this item
    unimobs.petz_api.register_rightclick_override(
        "unilib:item_dreamcatcher_pet", on_rightclick_mob_callback
    )

end
