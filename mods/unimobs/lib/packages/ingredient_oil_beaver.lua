---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_oil_beaver = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function on_rightclick_mob_callback(self, clicker, wielded_item, wielded_name, is_owner_flag)

    -- Adapted from petz.on_rightclick() and .brush()

    if not self.is_pet_flag or not is_owner_flag or not self.can_groom_flag then

        -- This override was not applied; apply the standard behaviour instead
        return false

    end

    if unimobs.petz_setting.enable_tamagotchi_mode_flag then

        if not self.lotion_applied_flag then

            unimobs.petz_api.set_mob_affinity(self, unimobs.petz_setting.tamagotchi_groom_rate)
            self.lotion_applied_flag =
                    unimobs.mobkit_api.add_mob_memory(self, "lotion_applied_flag", true)

        else

            core.chat_send_player(
                self.owner,
                unilib.utils.capitalise_translation(
                    S(
                        "Your @1 has already been rubbed with beaver oil",
                        unimobs.petz_api.get_insertion(self.mob_type, "subject")
                    )
                )
            )

        end

    end

    unimobs.kitz_api.make_sound(
        "object", self.object, "unilib_item_hairbrush", unimobs.petz_setting.max_hear_distance
    )

    unimobs.petz_api.show_standard_particles(self.object:get_pos(), "star")

    -- Do not apply the standard behaviour
    return true

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_oil_beaver.init()

    return {
        description = "Beaver oil",
        notes = "Used in lyncanthropy remedies; can also be in Tamagotchi Mode for mobs that" ..
                " have the \"can_groom_flag\" property",
        depends = {"organ_fur_beaver", "vessel_bottle_glass_empty"},
    }

end

function unilib.pkg.ingredient_oil_beaver.exec()

    unilib.register_craftitem("unilib:ingredient_oil_beaver", "petz:beaver_oil", mode, {
        -- From petz:beaver_oil
        description = S("Beaver Oil"),
        inventory_image = "unilib_ingredient_oil_beaver.png",

        wield_image = "unilib_ingredient_oil_beaver.png",
    })
    unilib.register_craft({
        -- From petz:beaver_oil
        type = "shaped",
        output = "unilib:ingredient_oil_beaver",
        recipe = {
            {"", "", ""},
            {"", "unilib:organ_fur_beaver", ""},
            {"", "unilib:vessel_bottle_glass_empty", ""},
        },
    })

    -- Override the standard behaviour when a mob is right-clicked while wielding this item
    unimobs.petz_api.register_rightclick_override(
        "unilib:ingredient_oil_beaver", on_rightclick_mob_callback
    )

end
