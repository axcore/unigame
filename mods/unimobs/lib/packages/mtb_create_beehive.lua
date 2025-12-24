---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mtb_create_beehive = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_create_beehive.do_action(self)

    -- Adapted from petz.bh_create_beehive()
    -- Called only for queen bees
    -- If there is a tree node in front of the queen (including both trunks and leaves), not higher
    --      than the queen's maximum roaming height, then place a beehive at the queen's location
    -- The queen's entity itself is removed the world, having "teleported inside" the beehive

    if not self.create_colony_flag then
        return
    end

    local front_node = unimobs.petz_api.get_node_at_named_location(self, "front")
    if front_node and (
        core.get_item_group(front_node.name, "wood") > 0 or
        core.get_item_group(front_node.name, "leaves") > 0
    ) then

        -- N.B. Fixed bug in original code, that did not check for a nil value of
        --      self.max_roam_height
        -- This value matches the one used in the "mob_bee_misc" package
        local pos = self.object:get_pos()
        local max_roam_height = self.max_roam_height or 5

        local min_pos = {
            x = pos.x - (max_roam_height * 4),
            y = pos.y - max_roam_height,
            z = pos.z - (max_roam_height * 4),
        }

        local max_pos = {
            x = pos.x + (max_roam_height * 4),
            y = pos.y + max_roam_height,
            z = pos.z + (max_roam_height * 4),
        }

        if #core.find_nodes_in_area(min_pos, max_pos, {"unilib:misc_hive_normal"}) < 1 then

            core.set_node(pos, {name = "unilib:misc_hive_normal"})
            unimobs.kitz_api.remove_mob(self)
            return true

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_create_beehive.init()

    return {
        description = "Standard mob meta-behaviour: create a beehive",
        depends = "misc_hive_normal",
    }

end
