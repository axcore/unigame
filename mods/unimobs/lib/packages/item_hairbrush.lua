---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_hairbrush = {}

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

        if not self.brush_applied_flag then

            unimobs.petz_api.set_mob_affinity(self, unimobs.petz_setting.tamagotchi_groom_rate)
            self.brush_applied_flag =
                    unimobs.mobkit_api.add_mob_memory(self, "brush_applied_flag", true)

        else

            core.chat_send_player(
                self.owner,
                unilib.utils.capitalise_translation(
                    S(
                        "Your @1 has already been brushed",
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

function unilib.pkg.item_hairbrush.init()

    return {
        description = "Hairbrush for compatible mobs",
        notes = "Works only with creatures who have the \"can_groom_flag\" property",
        depends = {"item_stick_ordinary", "item_string_ordinary"},
    }

end

function unilib.pkg.item_hairbrush.exec()

    unilib.register_craftitem("unilib:item_hairbrush", "petz:hairbrush", mode, {
        -- From petz:hairbrush
        description = S("Hairbrush"),
        inventory_image = "unilib_item_hairbrush.png",

        wield_image = "unilib_item_hairbrush.png"
    })
    unilib.register_craft({
        -- From petz:hairbrush
        type = "shaped",
        output = "unilib:item_hairbrush",
        recipe = {
            {"", "", ""},
            {"", "unilib:item_stick_ordinary", "unilib:item_string_ordinary"},
            {"unilib:item_stick_ordinary", "", ""},
        },
    })

    -- Override the standard behaviour when a mob is right-clicked while wielding this item
    unimobs.petz_api.register_rightclick_override(
        "unilib:item_hairbrush", on_rightclick_mob_callback
    )

end
