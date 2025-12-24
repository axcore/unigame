---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mtb_attack_player = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_attack_player.do_action(self, priority, player)

    -- Adapted from petz.bh_attack_player()
    -- Checks conditions then, if the specified player is close enough, attacks it using the
    --      appropriate behaviour
    -- For some mobs, the response will be to flee the player instead, launching the "hqb_evade"
    --      behaviour

    -- (N.B. Fixed typo in original code, self.warn_asensorsttack)
    if self.pack_attack_mode_flag and
            not self.was_attacked_by_player_flag and
            unimobs.petz_api.is_mob_in_group(self) then

        -- N.B. As described in the comments in petz_init_prop.lua, .was_attacked_by_player_flag is
        --      not set with unimobs.mobkit_api.add_mob_memory()
        self.was_attacked_by_player_flag = true

    end

    local werewolf_flag = false
    if unilib.global.pkg_executed_table["shared_petz_lycanthropy"] ~= nil  and
            unilib.pkg.shared_petz_lycanthropy.is_werewolf(player) then
        werewolf_flag = true
    end

    if (
        not self.is_tamed_flag and not werewolf_flag
    ) or (
        self.is_tamed_flag and self.status == "guard" and player:get_player_name() ~= self.owner
    ) then

        -- If a player is close...
        if vector.distance(self.object:get_pos(), player:get_pos()) <= self.view_range then

            -- ...then attack it, if permitted
            if (self.hostile_to_players_flag and not self.avoid_players_flag) or
                    self.was_attacked_by_player_flag then

                if self.can_swim_flag then
                    unilib.pkg.hqb_aqua_attack.add_to_queue(self, priority, player, 6)
                elseif self.can_fly_flag then
                    unilib.pkg.hqb_fly_hunt.add_to_queue(self, priority, player)
                else
                    unilib.pkg.hqb_hunt.add_to_queue(self, priority, player)
                end

                return true

            else

                if not self.can_swim_flag and not self.can_fly_flag then

                    if self.avoid_players_flag then

                        -- Run away from the player
                        unilib.pkg.hqb_evade.add_to_queue(self, priority, player)
                        return true

                    end

                end

            end

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_attack_player.init()

    return {
        description = "Standard mob meta-behaviour: attack a nearby player",
        depends = {"hqb_aqua_attack", "hqb_evade", "hqb_fly_hunt", "hqb_hunt"},
        optional = "shared_petz_lycanthropy",
    }

end
