---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mtb_set_forward_velocity = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

-- Localise math functions (for speed)
local cos = math.cos
local sin = math.sin

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_set_forward_velocity.do_action(self, vel)

    -- Was petz.set_velocity()
    -- Sets the mob's velocity to the specified vector "vel", relative to its current yaw

    if not unimobs.mobkit_api.is_behaviour_safe(self) then
        return
    end

    local yaw = self.object:get_yaw() or 0
    self.object:set_velocity({
        x = (sin(yaw) * -vel.x),
        y = vel.y or 0,
        z = (cos(yaw) * vel.z),
    })

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_set_forward_velocity.init()

    return {
        description = "Standard mob meta-behaviour: set the mob's forward velocity",
    }

end
