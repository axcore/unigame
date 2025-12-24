---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unimobs
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.device_tagger_name = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.unimobs.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function on_rightclick_mob_callback(self, clicker, wielded_item, wielded_name, is_owner_flag)

    -- Original to unimobs

    if not self.petz_compat_flag then

        -- This override was not applied; apply the standard behaviour instead
        return false

    elseif self.owner == nil or self.owner ~= clicker:get_player_name() then

        core.chat_send_player(clicker:get_player_name(), S("This creature doesn't belong to you!"))

    elseif not self.is_pet_flag or not self._id then

        core.chat_send_player(clicker:get_player_name(), S("This creature can't be named!"))

    else

        if self.nametag ~= nil and self.nametag ~= "" then

            -- Remove the old nametag
            self.nametag = unimobs.mobkit_api.add_mob_memory(self, "nametag", "")

        else

            -- Set a new nametag
            self.nametag = unimobs.mobkit_api.add_mob_memory(
                self, "nametag", self.description .. " " .. self._id
            )

        end

        self.show_nametag_flag =
                unimobs.mobkit_api.add_mob_memory(self, "show_nametag_flag", true)

        -- Make the change visible
        unimobs.petz_api.update_mob_nametag(self)

    end

    -- Do not apply the standard behaviour
    return true

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.device_tagger_name.init()

    return {
        description = "Automatic name tagger",
        notes = "When used on a mob that has no name tag, assigns the mob a generic name (like" ..
                " \"Cat 32\"). Use the tagger again to remove the nametag. This may be useful" ..
                " during breeding programmes when you need to distinguish certain creatures from" ..
                " others, without the bother of giving them unique names. Not all creatures can" ..
                " be named (specifically, only those whose .is_pet_flag property is true)",
        depends = {"item_paper_ordinary", "metal_copper", "metal_steel"},
    }

end

function unilib.pkg.device_tagger_name.exec()

    local c_copper = "unilib:metal_copper_ingot"
    local c_paper = "unilib:item_paper_ordinary"
    local c_steel = "unilib:metal_steel_ingot"

    unilib.register_craftitem("unilib:device_tagger_name", nil, mode, {
        -- Original to unimobs
        description = unilib.utils.hint(S("Automatic Name Tagger"), S("right-click mobs")),
        inventory_image = "unilib_device_tagger_name.png",
        -- (no groups)
    })
    unilib.register_craft({
        -- Original to unimobs
        output = "unilib:device_tagger_name",
        recipe = {
            {c_steel, c_paper, c_steel},
            {c_copper, c_paper, c_copper},
            {c_steel, c_paper, c_steel},
        },
    })

    -- Override the standard behaviour when a mob is right-clicked while wielding this item
    unimobs.petz_api.register_rightclick_override(
        "unilib:device_tagger_name", on_rightclick_mob_callback
    )

end
