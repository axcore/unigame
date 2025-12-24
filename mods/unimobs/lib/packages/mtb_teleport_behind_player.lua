---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mtb_teleport_behind_player = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_teleport_behind_player.do_action(self, player, particle_type)

    -- Adapted from petz.bh_teleport()
    -- Teleports the mob to a position behind the specified player. No teleportation occurs if there
    --      is a node at that position, rather than air
    -- If "particle_type" is specified, it is emitted

    if not unimobs.mobkit_api.is_behaviour_safe(self) then
        return
    end

    local behind_pos = unimobs.petz_api.get_pos_behind_player(player)
    local node = core.get_node_or_nil(behind_pos)
    if node and node.name == "air" then

        -- N.B. Original code did not include a "particle_type" argument, and only called this
        --      function for the "monster_mr_pumpkin" mob; our version is more flexible
        if particle_type ~= nil then
            unimobs.petz_api.show_standard_particles(self.object:get_pos(), particle_type)
        end

        self.object:set_pos(behind_pos)
        -- N.B. Fixed error in original code; call to kitz.make_sound() should have been a call to
        --      kitz.play_sound()
        unimobs.mobkit_api.do_entity_sound(self, "laugh")

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_teleport_behind_player.init()

    return {
        description = "Standard mob meta-behaviour: teleport the mob behind the player",
    }

end
