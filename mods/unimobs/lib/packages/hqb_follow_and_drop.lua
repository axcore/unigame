---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hqb_follow_and_drop = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_follow_and_drop.add_to_queue(self, priority, target_obj)

    -- Original to unimobs, based on the "hqb_follow" behaviour
    -- The mob follows the specified "target_obj" (which might be a player), one waypoint at a time
    -- When close enough to "target_obj", a mob carrying a clutchable item (like a square ball)
    --      drops it, and this behaviour terminates. Otherwise, the mob launches "lqb_idle" and this
    --      behaviour continues, with the mob ready to continue following "target_obj" as soon as it
    --      moves away

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) or
                not unimobs.mobkit_api.is_object_alive(target_obj) then
            return true
        end

        if unimobs.mobkit_api.is_low_level_queue_empty(self) and self.isonground then

            local stand_pos = unimobs.mobkit_api.get_standing_pos(self)
            if not stand_pos then
                return
            end

            local target_pos = target_obj:get_pos()
            if vector.distance(stand_pos, target_pos) > 3 then

                unimobs.mobkit_api.goto_next_waypoint(self, target_pos)

            elseif self.clutched_item_luaent and
                    self.clutched_item_luaent.name ~= nil and
                    unimobs.petz_api.is_entity_clutchable(self.clutched_item_luaent.name) then

                -- The mob drops the clutchable item at a point on the line between the mob and the
                --      player, at a distance of 1 from the mob
                local dir = vector.direction(stand_pos, target_pos)
                core.item_drop(
                    ItemStack(
                        unimobs.petz_api.convert_clutchable_entity_to_node(
                            self.clutched_item_luaent.name
                        )
                    ),
                    nil,
                    {
                        x = stand_pos.x + dir.x,
                        y = stand_pos.y + dir.y,
                        z = stand_pos.z + dir.z,
                    }
                )

                -- N.B. Required to avoid duplicate clutchable items
                self.clutched_item_luaent.waiting_for_removal_flag = true
                self.clutched_item_luaent.object:set_detach()
                -- N.B. As described in the comments in unimobs.petz_api.attach_clutchable_item(),
                --      .clutched_item_flag and .clutched_item_luaent are not set with
                --      unimobs.mobkit_api.add_mob_memory()
                self.clutched_item_flag = false
                self.clutched_item_luaent = nil

                return true

            else

                unilib.pkg.lqb_idle.add_to_queue(self, 1)

            end

        end

    end

    unimobs.mobkit_api.add_to_high_level_queue(self, "hqb_follow_and_drop", func, priority)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hqb_follow_and_drop.init()

    return {
        description = "Standard high-level mob behaviour: the mob follows the target object;" ..
                " when close enough, dropping any clutchable item (like a ball)",
        notes = "The closure function returns true if the target object becomes inactive",
        depends = "lqb_idle",
    }

end
