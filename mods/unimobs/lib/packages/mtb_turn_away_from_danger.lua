---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mtb_turn_away_from_danger = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

-- Localise math functions (for speed)
local atan = math.atan

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_turn_away_from_danger.do_action(self, danger_pos)

    -- Was petz.lookback() and the identical function, petz.lookat()
    -- Rotates the specified mob to face the opposite direction to "danger_pos"; the mob is then
    --      free to move in that direction, if required

    if not unimobs.mobkit_api.is_behaviour_safe(self) then
        return
    end

    local mob_pos = self.object:get_pos()
    local vec = {
        x = mob_pos.x - danger_pos.x,
        y = mob_pos.y - danger_pos.y,
        z = mob_pos.z - danger_pos.z
    }

    local yaw = atan(vec.z / vec.x) - math.pi / 2
    if mob_pos.x >= danger_pos.x then
        yaw = yaw + math.pi
    end

    self.object:set_yaw(yaw + math.pi)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_turn_away_from_danger.init()

    return {
        description = "Standard mob meta-behaviour: rotate the mob away from danger",
    }

end
