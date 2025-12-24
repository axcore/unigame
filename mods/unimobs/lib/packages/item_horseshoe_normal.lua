---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_horseshoe_normal = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function add_horseshoe(self)

    -- From petz.horseshoes_inc_speed()
    -- Updates the pony's properties, incrementing the number of horseshoes and re-calculating the
    --      speed bonus that applies

    -- Increment the horseshoe count...
    self.horseshoe_count = unimobs.mobkit_api.add_mob_memory(
        self, "horseshoe_count", (self.horseshoe_count + 1)
    )
    self.horseshoe_name = unimobs.mobkit_api.add_mob_memory(
        self, "horseshoe_name", "unilib:item_horseshoe_normal"
    )

    -- ...and apply the new speed bonus
    unimobs.petz_api.apply_horseshoe_speed_bonus(
        self, (self.horseshoe_count * unimobs.petz_setting.horseshoe_speed_increase)
    )

end

local function on_rightclick_mob_callback(self, clicker, wielded_item, wielded_name, is_owner_flag)

    -- Adapted from petz.put_horseshoe()

    if self.mob_type ~= "pony_normal" or self.owner ~= clicker:get_player_name() then

        -- This override was not applied; apply the standard behaviour instead
        return false

    end

    if self.horseshoe_count >= 4 then

        core.chat_send_player(clicker:get_player_name(), S("This pony already has four horseshoes"))
        -- Do not apply the standard behaviour
        return true


    elseif self.horseshoe_name ~= nil and self.horseshoe_name ~= "unilib:item_horseshoe_normal" then

        -- Per the comments in petz_init_prop.lua, each mounted mob must have only one type of
        --      horseshoe at a time
        core.chat_send_player(
            clicker:get_player_name(), S("This pony already has a different type of horseshoe")
        )

        -- Do not apply the standard behaviour
        return true

    end

    wielded_item:take_item()
    clicker:set_wielded_item(wielded_item)

    add_horseshoe(self)

    unimobs.kitz_api.make_sound(
        "object", self.object, "unilib_put_petz", unimobs.petz_setting.max_hear_distance
    )
    unimobs.kitz_api.make_sound(
        "object",
        self.object,
        "unilib_mob_" .. self.generic_type .. "_moaning",
        unimobs.petz_setting.max_hear_distance
    )

    -- Do not apply the standard behaviour
    return true

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_horseshoe_normal.init()

    return {
        description = "Normal horseshoe",
        depends = "metal_steel",
    }

end

function unilib.pkg.item_horseshoe_normal.exec()

    local c_ingot = "unilib:metal_steel_ingot"

    unilib.register_craftitem("unilib:item_horseshoe_normal", "petz:horseshoe", mode, {
        -- From petz:horseshoe
        description = S("Normal Horseshoe"),
        inventory_image = "unilib_item_horseshoe_normal.png",
    })
    unilib.register_craft({
        -- From petz:horseshoe
        type = "shaped",
        output = "unilib:item_horseshoe_normal",
        recipe = {
            {"", c_ingot, ""},
            {c_ingot, "", c_ingot},
            {c_ingot, "", c_ingot},
        },
    })

    -- Override the standard behaviour when a mob is right-clicked while wielding this item
    unimobs.petz_api.register_rightclick_override(
        "unilib:item_horseshoe_normal", on_rightclick_mob_callback
    )

end
