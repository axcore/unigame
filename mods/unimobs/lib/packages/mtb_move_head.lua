---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mtb_move_head = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

-- Localise math functions (for speed)
local asin = math.asin
local atan2 = math.atan2
local rad = math.rad

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_move_head.do_action(self, target_pos)

    -- Was petz.move_head()
    -- Rotates the mob's head in the direction of the specified "target_pos", which is often the
    --      position of a nearby player

    if not unimobs.mobkit_api.is_behaviour_safe(self) then
        return
    end

    -- Get the mob pos...
    local pos = self.object:get_pos()
    -- ...and the position of the player's eyes (1.625 higher)
    pos.y = pos.y + (self.head_prop_table.eye_offset or 0)
    target_pos.y = target_pos.y + 1.625

    -- (The vector direction from mob to player's eyes)
    local direction = vector.direction(pos, target_pos)
    -- (Important: normalize the vector)
    local look_at_dir = vector.normalize(direction)

    -- Functions to calculate the pitch & yaw (in degrees)
    local pitch = unimobs.kitz_api.convert_yaw_to_degrees(asin(look_at_dir.y))
    local yaw = unimobs.kitz_api.convert_yaw_to_degrees(atan2(look_at_dir.x, look_at_dir.z))
    -- (Yaw of the body in degrees)
    local body_yaw = unimobs.kitz_api.convert_yaw_to_degrees(self.object:get_yaw())
    -- (Get the head yaw relative to the body)
    local final_yaw = yaw + body_yaw
    -- (The head movement: pitch, yaw, roll)
    local head_rotation = {x = pitch, y = final_yaw, z = 0}
    -- (The offset for the rotation, which depends on the blender model)
    self.head_rotation = vector.add(head_rotation, self.head_prop_table.rotation_origin)

    -- N.B. The original code allows unrealistic rotations; correct for that in compatible mobs
    if self.head_prop_table.clamp_list ~= nil then

        for _, mini_table in ipairs(self.head_prop_table.clamp_list) do

            -- Mini_table in the form { dim = x/y/z, min = angle, max = angle, correction = angle }
            local angle = self.head_rotation[mini_table.dim]
            if angle >= mini_table.min and angle <= mini_table.max then
                self.head_rotation[mini_table.dim] = mini_table.correction
            end

        end

    end

    -- (Set the head movement)
    self.object:set_bone_override("head", {
        position = {vec = self.head_prop_table.position, absolute = true},
        rotation = {vec = self.head_rotation:apply(rad), absolute = true}
    })

    -- N.B. Removed, as the calling code doesn't need it
--  return unimobs.kitz_api.convert_degrees_to_radians(body_yaw - yaw)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_move_head.init()

    return {
        description = "Standard mob meta-behaviour: move the mob's head in the direction of the" ..
                " specified position",
    }

end
