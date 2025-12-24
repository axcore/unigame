---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_whip_obedience = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function on_punch_mob_callback(self, clicker, wielded_item, wielded_name, is_owner_flag)

    -- Adapted from petz.on_rightclick() and .brush()

    if not self.is_pet_flag or not is_owner_flag or not self.is_wild_flag then

        -- This override was not applied; apply the standard behaviour instead
        return false

    end

    if unimobs.petz_setting.enable_tamagotchi_mode_flag then

        if not self.lash_applied_flag then

            unimobs.petz_api.set_mob_affinity(self, unimobs.petz_setting.tamagotchi_lash_rate)
            self.lash_applied_flag =
                    unimobs.mobkit_api.add_mob_memory(self, "lash_applied_flag", true)

        else

            core.chat_send_player(
                self.owner,
                unilib.utils.capitalise_translation(
                    S(
                        "Your @1 has already been lashed",
                        unimobs.petz_api.get_insertion(self.mob_type, "subject")
                    )
                )
            )

        end

    end

    unimobs.kitz_api.make_sound(
        "object", self.object, "unilib_item_whip_obedience", unimobs.petz_setting.max_hear_distance
    )

    unimobs.kitz_api.make_sound(
        "object",
        self.object,
        "unilib_mob_" .. self.generic_type .. "_moaning",
        unimobs.petz_setting.max_hear_distance
    )

    unimobs.petz_api.show_standard_particles(self.object:get_pos(), "star")

    -- Do not apply the standard behaviour
    return true

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_whip_obedience.init()

    return {
        description = "Obedience whip",
        notes = "Used to tame wild animals such as lions and bears",
        depends = {"dye_basic", "item_stick_ordinary", "item_string_ordinary"},
    }

end

function unilib.pkg.item_whip_obedience.exec()

    unilib.register_craftitem("unilib:item_whip_obedience", "petz:whip", mode, {
        -- From petz:whip
        description = S("Obedience Whip"),
        inventory_image = "unilib_item_whip_obedience.png",

        wield_image = "unilib_item_whip_obedience.png",

        after_use = function(itemstack, user, node, digparams)

            unimobs.kitz_api.make_sound(
                "player",
                user,
                "unilib_item_whip_obedience",
                unimobs.petz_setting.max_hear_distance
            )

        end,
    })
    unilib.register_craft({
        -- From petz:whip
        type = "shaped",
        output = "unilib:item_whip_obedience",
        recipe = {
            {"", "", "unilib:item_string_ordinary"},
            {"", "unilib:item_string_ordinary", "unilib:dye_brown"},
            {"unilib:item_stick_ordinary", "", ""},
        },
    })

    -- Override the standard behaviour when a mob is punched while wielding this item
    unimobs.petz_api.register_punch_with_extension(
        "unilib:item_whip_obedience", on_punch_mob_callback
    )

end
