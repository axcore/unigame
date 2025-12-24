---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_syringe_glass = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function on_rightclick_mob_callback(self, clicker, wielded_item, wielded_name, is_owner_flag)

    -- Adapted from petz.pony_breed()

    -- N.B. The .disable_syringe setting has been removed; to disable the use of syringes, remove
    --      this package from your remix
    -- N.B. In original code, the .disable_non_owner_syringe_flag setting was ignored; unimobs code
    --      uses it as originally intended
    if self.is_baby_flag or
            (unimobs.petz_setting.disable_stranger_syringe_flag and not is_owner_flag) then

        -- This override was not applied; apply the standard behaviour instead
        return false

    end

    if wielded_name == "unilib:item_syringe_glass_empty" and self.is_male_flag then

        local new_wielded_item = ItemStack("unilib:item_syringe_glass_full")
        local meta = new_wielded_item:get_meta()

        meta:set_string("mob_type", self.mob_type)
        -- (self.genetic_table stores the original values, before any speed bonuses were applied
        --      to genes like "mounted_forward_speed")
        meta:set_string("genetic_table", core.serialize(self.genetic_table))

        if wielded_item:get_count() > 1 then

            local inv = clicker:get_inventory()
            if not inv:room_for_item("main", new_wielded_item) then

                core.chat_send_player(
                    clicker:get_player_name(),
                    S("There isn't enough room in your inventory for the glass syringe")
                )

                return

            end

            wielded_item:take_item(1)
            clicker:set_wielded_item(wielded_item)
            inv:add_item("main", new_wielded_item)

        else

            clicker:set_wielded_item(new_wielded_item)

        end

        -- Do not apply the standard behaviour
        return true

    elseif wielded_name == "unilib:item_syringe_glass_full" and not self.is_male_flag then

        local meta = wielded_item:get_meta()
        local mob_type = meta:get_string("mob_type")

        if self.mob_type == mob_type and
                not self.is_pregnant_flag and
                unimobs.petz_api.is_mob_fertile(self) then

            unimobs.petz_api.breed_mob_with_implement(
                self,
                core.deserialize(meta:get_string("genetic_table"))
            )

            clicker:set_wielded_item("unilib:item_syringe_glass_empty")

        end

        -- Do not apply the standard behaviour
        return true

    else

        -- This override was not applied; apply the standard behaviour instead
        return false

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_syringe_glass.init()

    return {
        description = "Glass syringe",
        notes = "A convenient method for breeding creatures who aren't at the same location. In" ..
                " the original code, it was only used for breeding ponies and camels, but that" ..
                " restriction no longer applies",
        depends = "metal_steel",
    }

end

function unilib.pkg.item_syringe_glass.exec()

    unilib.register_craftitem("unilib:item_syringe_glass_empty", "petz:glass_syringe", mode, {
        -- From petz:glass_syringe
        description = S("Empty Glass Syringe"),
        inventory_image = "unilib_item_syringe_glass_empty.png",

        wield_image = "unilib_item_syringe_glass_empty.png",
    })
    unilib.register_craft({
        -- From petz:glass_syringe
        type = "shaped",
        output = "unilib:item_syringe_glass_empty",
        recipe = {
            {"", "", "unilib:glass_ordinary_fragments"},
            {"", "unilib:glass_ordinary_fragments", ""},
            {"unilib:metal_steel_ingot", "", ""},
        },
    })

    unilib.register_craftitem("unilib:item_syringe_glass_full", "petz:glass_syringe_sperm", mode, {
        -- From petz:glass_syringe_sperm
        description = S("Full Glass Syringe"),
        inventory_image = "unilib_item_syringe_glass_full.png",
        -- N.B. No .groups in original code
        groups = {not_in_creative_inventory = 1},

        stack_max = 1,
        wield_image = "unilib_item_syringe_glass_full.png",
    })

    -- Override the standard behaviour when a mob is right-clicked while wielding these items
    unimobs.petz_api.register_rightclick_override(
        "unilib:item_syringe_glass_empty", on_rightclick_mob_callback
    )
    unimobs.petz_api.register_rightclick_override(
        "unilib:item_syringe_glass_full", on_rightclick_mob_callback
    )

end
