---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.lqb_find_beehive = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

-- Localise math functions (for speed)
local abs = math.abs

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.lqb_find_beehive.add_to_queue(self)

    -- Adapted from petz.lq_search_beehive()
    -- Called only for bees
    -- Bees fly towards their hive, "teleporting inside" the hive when they get close enough. The
    --      bee's "has_pollen_flag" property is set back to false, if true (and the hive's pollen
    --      and honey counts are incremented)

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        if not unimobs.mobkit_api.is_behaviour_safe(self) or not self.beehive_pos then
            return true
        end

        local target_pos = self.beehive_pos
        local pos = self.object:get_pos()
        local y_distance = target_pos.y - pos.y

        local abs_y_distance = abs(y_distance)
        if abs_y_distance > 1 and abs_y_distance < self.view_range then

            unilib.pkg.mtb_set_forward_velocity.do_action(
                self, {x = 0, y = y_distance, z = 0}
            )

        end

        if unimobs.mobkit_api.move_towards_pos(self, target_pos, 1.5, 6.28, 1.01) and
                unilib.pkg.mob_bee_misc.does_beehive_exist(self) then

            unimobs.kitz_api.remove_mob(self)

            local meta, pollen_count, honey_count, bee_count =
                    unilib.pkg.misc_hive_normal.get_stats(self.beehive_pos)

            pollen_count = pollen_count + 1
            if pollen_count >= unimobs.petz_setting.beehive_max_pollen then

                pollen_count = 0
                honey_count = honey_count + 1

            end

            meta:set_int("pollen_count", pollen_count)
            meta:set_int("honey_count", honey_count)

            bee_count = bee_count + 1
            meta:set_int("bee_count", bee_count)

            unilib.pkg.misc_hive_normal.set_infotext(meta, honey_count, bee_count)
            self.has_pollen_flag = unimobs.mobkit_api.add_mob_memory(self, "has_pollen_flag", false)

        end

    end

    unimobs.mobkit_api.add_to_low_level_queue(self, "lqb_find_beehive", func)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.lqb_find_beehive.init()

    return {
        description = "Standard low-level mob behaviour: find the beehive and deposit pollen",
        notes = "This behaviour can only be used with bees from the \"mob_bee_misc\" package," ..
                " and with the hive from the \"misc_hive_normal\" package",
        depends = {"misc_hive_normal", "mob_bee_misc", "mtb_set_forward_velocity"},
    }

end
