---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mtb_straggle_parents = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

local straggle_distance = 5

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_straggle_parents.do_action(self)

    -- Was petz.follow_parents()
    -- Called by severeal brain packages
    -- If the specified mob is near any of the mobs specified by self.straggle_type_list (which will
    --      include its own parents), then initiate the "hqb_goto" behaviour in order to follow
    --      (straggle behind) them

    for _, mob_type in ipairs(self.straggle_type_list) do

        local target_obj = unimobs.mobkit_api.get_closest_entity(self, "unilib:mob_" .. mob_type)
        if target_obj and unimobs.mobkit_api.is_object_alive(target_obj) then

            local luaent = target_obj:get_luaentity()
            if luaent and not luaent.is_baby_flag then

                local target_pos = target_obj:get_pos()
                local distance = vector.distance(self.object:get_pos(), target_pos)
                -- Baby straggles the adult when the distance between them is greater than 5
                if distance > straggle_distance then

                    unilib.pkg.hqb_goto.add_to_queue(self, 10, target_pos)
                    return true

                end

            end

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_straggle_parents.init()

    return {
        description = "Standard mob meta-behaviour: the mob follows (straggles) its parents",
    }

end
