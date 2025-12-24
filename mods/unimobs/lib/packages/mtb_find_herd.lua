---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mtb_find_herd = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_find_herd.do_action(self, player)

    -- Adapted from petz.bh_herding()
    -- Looks for nearby mobs of the same type. If none is found, checks whether the specified
    --      player is wielding a shepherd's crook
    -- If either is condition is satisfied, launches the "hqb_goto" behaviour to approach the mob(s)
    --      or player

    if not self.is_tamed_flag or not self.can_herd_flag or not self.is_herding_flag then
        return
    end

    -- Look for a herd to join
    local join_herd_flag = false
    local pos = self.object:get_pos()

    local target_obj =
            unimobs.mobkit_api.get_closest_entity(self, "unilib:mob_" .. self.mob_type)
    local target_pos

    if target_obj then

        local luaent = target_obj:get_luaentity()
        if luaent and luaent.is_herding_flag then

            target_pos = target_obj:get_pos()
            local distance = vector.distance(pos, target_pos)
            if distance > unimobs.petz_setting.herding_max_distance then
                join_herd_flag = true
            end

        end

    end

    -- If no herd is nearby, search for a shepherd (i.e. a player wielding a shepherd's crook)
    if not join_herd_flag and player then

        local pname = player:get_player_name()
        if self.owner == pname then

            local wielded_item = player:get_wielded_item()
            if wielded_item:get_name() == "unilib:tool_crook_shepherd" then

                -- If the shepherd is close enough...
                target_pos = player:get_pos()
                if vector.distance(pos, target_pos) >
                        unimobs.petz_setting.shepherd_max_distance then
                    join_herd_flag = true
                end

            end

        end

    end

    if join_herd_flag and target_pos then

        unilib.pkg.hqb_goto.add_to_queue(self, 4.5, target_pos)
        return true

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_find_herd.init()

    return {
        description = "Standard mob meta-behaviour: look for a herd to join (or a shepherd to" ..
                " follow)",
        depends = "hqb_goto",
        optional = "tool_crook_shepherd",
    }

end
