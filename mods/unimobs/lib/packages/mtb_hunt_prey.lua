---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mtb_hunt_prey = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_hunt_prey.do_action(self, priority, force_flag)

    -- Adapted from petz.bh_hunt()
    -- Called by several brain pacakges, not just "brain_predator"
    -- Looks for nearby prey and, if one is found, launches the "hqb_hunt" behaviour to hunt it,
    --      using the specified priority
    -- If "force_flag" is specified, then this mob can hunt other creatures, even when it is tamed

    if self.is_tamed_flag and not force_flag then
        return
    end

    local prey_list = unimobs.petz_api.get_msetting(self.mob_type, "prey_list")
    if prey_list ~= nil then

        for _, mob_name in ipairs(prey_list) do

            -- Is this mob nearby?
            local obj = unimobs.mobkit_api.get_closest_entity(self, mob_name)
            if obj then

                unilib.pkg.hqb_hunt.add_to_queue(self, priority, obj)
                return

            end

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_hunt_prey.init()

    return {
        description = "Standard mob meta-behaviour: hunt nearby prey",
        depends = "hqb_hunt",
    }

end
