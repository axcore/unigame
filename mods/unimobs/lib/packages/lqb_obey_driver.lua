---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.lqb_obey_driver = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

-- Localise math functions (for speed)
local abs = math.abs
local cos = math.cos
local sin = math.sin
local sqrt = math.sqrt

-- Optional table of nodes which increase/decrease a mounted mob's speed, when riding over them
-- Table in the form
--      racing_node_table[full_name] = factor
-- The table is read from the "racing_nodes.csv" file in the remix, if present
-- The factor may be positive (e.g. 0.1, representing a 10% increase in speed), or negative
--      (e.g. -0.1, representing a 10% decrease in speed)
-- Note that mounted mobs have a built-in speed limit, so it's not worth specifying very large
--      increases. The absolute maximum/minimum values are 1 / -1
local racing_node_table = {}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_sign(i)

    i = i or 0
    if i == 0 then
        return 0
    else
        return i / abs(i)
    end

end

local function get_velocity(v, yaw, y)

    local x = -sin(yaw) * v
    local z =  cos(yaw) * v
    local vel = vector.new(x, y, z)
    return vel

end

local function get_horizontal_distance(v)

    -- Returns the Euclidian distance in 2D space
    return sqrt((v.x * v.x) + (v.z * v.z))

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.lqb_obey_driver.add_to_queue(self)

    -- Adapted from petz.lq_mountdriver()
    -- Called for a mob that's being ridden to a player. Responds to the player's riding commands,
    --      changing direction or speed as appropriate

    -- (Persistent data used to preserve state between calls to the closure below)
    local auto_drive_flag = false

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) or not self.driver then
            return true
        end

        local rot_view = 0
        if self.player_rotation.y == 90 then
            rot_view = math.pi / 2
        end

        local accel_y = 0
        local speed_vector = vector.new(
            self.mounted_forward_speed / 3,
            0,
            self.mounted_forward_speed / 3
        )
        local velocity = get_horizontal_distance(speed_vector)

        -- Process controls
        local ctrl = self.driver:get_player_control()
        if ctrl.up and ctrl.aux1 then
            auto_drive_flag = true
        elseif auto_drive_flag and ctrl.sneak then
            auto_drive_flag = false
        end

        if (ctrl.up or auto_drive_flag) and self.isonground then

            -- Move forwards
            velocity = velocity + (self.mounted_speed_boost / 2)
            if ctrl.jump then

                speed_vector.y = speed_vector.y + (self.jump_height * 4)
                accel_y = accel_y * 1.5

            end

        elseif ctrl.down and self.isonground then

            -- Move backwards
            if self.mounted_reverse_speed == 0 and velocity == 0 then
                return
            end

            velocity = velocity - (self.mounted_speed_boost / 4)
            if velocity > 0 then
                velocity = -velocity
            end

        elseif ctrl.jump and self.isonground then

            -- Jump
            speed_vector.y = speed_vector.y + (self.jump_height * 4)
            accel_y = accel_y * 1.5

        else

            -- Stand
            unimobs.mobkit_api.do_entity_animation(self, "still")
            unimobs.petz_api.do_wagon_animation(self, "stand")
            return

        end

        -- Gallop
        if ctrl.up and ctrl.sneak and not self.gallop_mode_exhaustion_flag then

            if not self.gallop_mode_flag then

                -- N.B. As explained in the comments in petz_init_prop.lua, this property is not set
                --      using unimobs.mobkit_api.add_mob_memory()
                self.gallop_mode_flag = true

                unimobs.kitz_api.make_sound(
                    "object",
                    self.object,
                    "unilib_mob_pony_normal_whinny",
                    unimobs.petz_setting.max_hear_distance
                )
                unimobs.kitz_api.make_sound(
                    "object",
                    self.object,
                    "unilib_mob_pony_normal_gallop",
                    unimobs.petz_setting.max_hear_distance
                )

            end

            velocity = velocity + self.mounted_speed_boost

        end

        -- Adjust the velocity for the nodes below the mob, if they were specified in the remix CSV
        --      file
        local pos = unimobs.mobkit_api.get_feet_pos(self.object)
        pos.y = pos.y - 1
        local node_under = core.get_node(pos)
        local factor = racing_node_table[node_under.name]
        if factor ~= nil then
            velocity = velocity + (factor * velocity)
        end

        -- Fix mob rotation
        local horiz_yaw = self.driver:get_look_horizontal() or 0
        self.object:set_yaw(horiz_yaw - self.default_rotation)

        -- Enforce speed limit in the forward and reverse directions
        local speed_limit = self.mounted_reverse_speed
        if get_sign(velocity) >= 0 then
            speed_limit = self.mounted_forward_speed
        end

        if abs(velocity) > speed_limit then
            velocity = velocity - get_sign(velocity)
        end

        -- Set position, velocity and acceleration
        local new_vel = get_velocity(velocity, self.object:get_yaw() - rot_view, speed_vector.y)
        self.object:set_velocity(new_vel)

        local new_accel = vector.new(0, unimobs.constant.gravity, 0)
        new_accel.y = new_accel.y + accel_y
        self.object:set_acceleration(new_accel)

        -- Set animations
        if not self.gallop_mode_flag then
            unimobs.mobkit_api.do_entity_animation(self, "walk")
        else
            unimobs.mobkit_api.do_entity_animation(self, "run")
        end

        unimobs.petz_api.do_wagon_animation(self, "roll")

        return

    end

    unimobs.mobkit_api.add_to_low_level_queue(self, "lqb_obey_driver", func)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.lqb_obey_driver.init()

    return {
        description = "Standard low-level mob behaviour: handle the mob's behaviour while it is" ..
                " being ridden by a player",
        notes = "See also the related behaviour in the \"hqb_obey_driver\" package",
        depends = "misc_wagon_pony",
    }

end

function unilib.pkg.lqb_obey_driver.exec()

    -- Read CSVs from the first remix with the label "petz" (default: the "petz" remix itself)
    local remix_name = unilib.utils.get_remix_by_label("petz") or "petz"
    local remix_dir = unilib.utils.get_remix_dir(remix_name)
    local racing_path = remix_dir .. "/racing_nodes.csv"
    if unilib.utils.is_file(racing_path) then

        for i, csv_table in ipairs(unilib.utils.read_csv(racing_path)) do

            local key, value = unpack(csv_table)
            if key ~= nil and
                    value ~= nil and
                    string.find(key, "%a") and
                    string.find(value, "%w") and
                    tonumber(value) ~= nil then

                value = tonumber(value)
                if value > 1 then
                    value = 1
                elseif value < -1 then
                    value = -1
                end

                racing_node_table[key] = value

            end

        end

    end

end
