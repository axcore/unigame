---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hqb_fly_hunt = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_fly_hunt.add_to_queue(self, priority, target_obj)

    -- Adapted from petz.hq_flyhunt()
    -- Standard hunting behaviour for flying mobs
    -- Waits until the low-level queue is empty. Then, if close enough to the specified
    --      "target_obj", the mob attacks it. Otherwise it flies towards (or follows) the
    --      "target_obj"

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) or
                not unimobs.mobkit_api.is_object_alive(target_obj) then
            return true
        end

        if unimobs.mobkit_api.is_low_level_queue_empty(self) then

            local stand_pos = unimobs.mobkit_api.get_standing_pos(self)
            if not stand_pos then
                return true
            end

            local target_pos = target_obj:get_pos()
            local dist = vector.distance(stand_pos, target_pos)

            if dist > self.view_range then
                return true
            elseif dist > 3 then
                unilib.pkg.mtb_fly_to.do_action(self, target_obj)
            else
                unilib.pkg.hqb_fly_attack.add_to_queue(self, (priority + 1), target_obj)
            end

        end

    end

    unimobs.mobkit_api.add_to_high_level_queue(self, "hqb_fly_hunt", func, priority)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_fly_hunt.init()

    return {
        description = "Standard high-level mob behaviour: follow the target object and, when" ..
                " close enough, attack it",
        depends = {"hqb_fly_attack", "mtb_fly_to"},
    }

end
