---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mtb_fly_to = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

-- Localise math functions (for speed)
local abs = math.abs

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_fly_to.do_action(self, target_obj)

    -- Was petz.flyto()
    -- Sets the mob's direction and velocity, so that it flies towards the specified "target_obj"

    if not unimobs.mobkit_api.is_behaviour_safe(self) then
        return
    end

    local pos = self.object:get_pos()
    local target_pos = target_obj:get_pos()
    local cbox = target_obj:get_properties().collisionbox
    local height = abs(cbox[3]) + abs(cbox[6])
    target_pos.y = target_pos.y + (2 * height)

    local dir = vector.direction(pos, target_pos)
    local velocity = {
        x = self.max_speed * dir.x,
        y = self.max_speed * dir.y,
        z = self.max_speed * dir.z,
    }
    local new_yaw = core.dir_to_yaw(dir)

    self.object:set_yaw(new_yaw)
    self.object:set_velocity(velocity)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_fly_to.init()

    return {
        description = "Standard mob meta-behaviour: fly towards the specified target",
    }

end
