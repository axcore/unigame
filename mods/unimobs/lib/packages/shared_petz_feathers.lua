---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_petz_feathers = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared function
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_petz_feathers.pluck(self, clicker, feather_name)

    local inv = clicker:get_inventory()
    if inv:room_for_item("main", feather_name) then
        inv:add_item("main", feather_name)
    else
        core.add_item(self.object:get_pos(), feather_name)
    end

    unimobs.kitz_api.make_sound(
        "object",
        self.object,
        "unilib_mob_" .. self.generic_type .. "_moaning",
        unimobs.petz_setting.max_hear_distance
    )

    self.is_plucked_flag = unimobs.mobkit_api.add_mob_memory(self, "is_plucked_flag", true)
    if unilib.global.pkg_executed_table["mtb_show_fear"] ~= nil then
        unilib.pkg.mtb_show_fear.do_action(self, clicker:get_pos())
    end

    if self.can_fly_flag and not self.status then

        self.status = unimobs.mobkit_api.add_mob_memory(self, "status", "alight")
        if unilib.global.pkg_executed_table["mtb_fly_alight"] ~= nil then
            unilib.pkg.mtb_fly_alight.do_action(self, 0, nil)
        end

    end

end

function unilib.pkg.shared_petz_feathers.unpluck(self, clicker, feather_name)

    local inv = clicker:get_inventory()
    inv:remove_item("main", feather_name)

    unimobs.kitz_api.make_sound(
        "object",
        self.object,
        "unilib_mob_" .. self.generic_type .. "_moaning",
        unimobs.petz_setting.max_hear_distance
    )

    self.is_plucked_flag = unimobs.mobkit_api.add_mob_memory(self, "is_plucked_flag", false)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_petz_feathers.init()

    return {
        description = "Shared functions for feathers (from petz)",
        notes = "This package is used not by feather packages such as \"organ_feather_duck\"," ..
                " but by the corresponding mob packages (such as \"mob_duck_normal\")",
    }

end
