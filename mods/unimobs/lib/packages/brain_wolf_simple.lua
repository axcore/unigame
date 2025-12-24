---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    wildlife
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.brain_wolf_simple = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.wildlife.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.brain_wolf_simple.brain(self)

    -- Logic code for mobs defined in the "mob_wolf_simple" package (only)

    -- Vitals should be checked on every engine step
    if unimobs.mobkit_api.check_main_timer(self, 1) then
        unilib.pkg.shared_wildlife.apply_damage_from_nearby_nodes(self)
    end

    unimobs.mobkit_api.check_vitals(self)
    if self.hp <= 0 then

        -- Cease all activity, then die
        unimobs.mobkit_api.clear_high_level_queue(self)
        unilib.pkg.hqb_die.add_to_queue(self)
        return

    end

    -- Decision-making doesn't need to happen on every engine step
    if unimobs.mobkit_api.check_main_timer(self, 1) then

        -- If in water, find land (N.B. In most petz brain packages, the priority is 40)
        local priority = unimobs.mobkit_api.get_queue_priority(self)
        if priority < 20 and self.isinliquid then

            unilib.pkg.hqb_find_land.add_to_queue(self, 20)
            return

        end

        -- If not busy with anything important, then hunt simple deer
        if priority < 10 then

            -- Look for prey, and chase it
            local prey = unimobs.mobkit_api.get_closest_entity(self, "unilib:mob_deer_simple")
            if prey then
                unilib.pkg.hqb_hunt.add_to_queue(self, 10, prey)
            end

        end

        -- If a player is close, try to ward them off; the "hqb_warn" behaviour will trigger
        --      subsequent behaviours, if needed
        if priority < 9 then

            local player = unimobs.mobkit_api.get_random_nearby_player(self)
            if player and vector.distance(self.object:get_pos(), player:get_pos()) < 10 then
                unilib.pkg.hqb_warn.add_to_queue(self, 9, player)
            end

        end

        -- Handle default roaming
        if unimobs.mobkit_api.is_high_level_queue_empty(self) then
            unilib.pkg.hqb_roam.add_to_queue(self, 0)
        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.brain_wolf_simple.init()

    return {
        description = "Logic code for mobs defined in the \"mob_wolf_simple\" package (only)",
        depends = {
            "hqb_die",
            "hqb_find_land",
            "hqb_hunt",
            "hqb_roam",
            "hqb_warn",
            "shared_wildlife",
        },
        optional = "mob_deer_simple",
    }

end
