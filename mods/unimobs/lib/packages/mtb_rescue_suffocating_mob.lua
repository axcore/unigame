---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mtb_rescue_suffocating_mob = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

-- Localise math functions (for speed)
local random = math.random

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_rescue_suffocating_mob.do_action(self)

    -- Was petz.check_ground_suffocation()
    -- Called by many brain packages as a standard emergency suffocation recovery check
    -- When a mob gets stuck inside a node (as tends to happen quite frequently), teleport it to a
    --      nearby air node
    -- The recovery system is not used on flying mobs, which could otherwise escape any enclosure
    --      through its roof

    if not unimobs.mobkit_api.is_behaviour_safe(self) then
        return
    end

    -- Don't rescue flying mobs, otherwise they'll be able to escape enclosures through the roof
    if unimobs.petz_setting.enable_suffocation_recovery_flag and
            self.petz_compat_flag and
            unimobs.mobkit_api.is_object_alive(self) and
            not self.can_fly_flag and
            not self.is_baby_flag then

        local pos = self.object:get_pos()
        local def_table = unimobs.mobkit_api.get_node_defn_at_pos(pos)
        if def_table and def_table.walkable and def_table.drawtype == "normal" then

            -- Compile a list of adjacent "air" nodes
            local grid_list = unimobs.kitz_api.get_list_of_adjacent_node_positions(pos)
            local air_cell_list = {}

            for _, cell_pos in ipairs(grid_list) do

                if unimobs.kitz_api.is_air(cell_pos) and
                        unimobs.kitz_api.is_walkable(cell_pos, -1) then
                    air_cell_list[#air_cell_list + 1] = cell_pos
                end

            end

            -- Decide where the suffocating mob should be teleported
            local teleport_pos
            if unimobs.kitz_api.is_table_empty(air_cell_list) then

                -- Last-ditch effort: move the mob to the top of its jump range
                teleport_pos = vector.new(pos.x, pos.y + self.jump_height, pos.z)

            else

                -- Choose an adjacent air node
                teleport_pos = air_cell_list[random(1, #air_cell_list)]
                teleport_pos.y = teleport_pos.y + 1.01

            end

            -- Teleport the mob
            self.object:set_pos(teleport_pos)
            -- Confirm the emergency teleportation in logs
            unilib.utils.log(
                "action",
                string.format(
                    "[unimobs] Suffocating %s at %s has been teleported to safety",
                    self.mob_type,
                    unimobs.petz_api.pos_to_string(teleport_pos)
                )
            )

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_rescue_suffocating_mob.init()

    return {
        description = "Standard mob meta-behaviour: rescue a mob suffocating inside a node",
    }

end
