---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mtb_climb_tree = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_climb_tree.do_action(self, priority)

    -- Adapted from petz.bh_climb()
    -- Checks for an adjacent tree node (including both trunks and leaves). If one is found,
    --      launches the "hqb_climb_tree" behaviour to climb it
    -- Otherwise, searches for tree nodes within its view range. If one is found, launches
    --      "hqb_goto" to approach it

    if unimobs.petz_api.check_tree(self) then

        unilib.pkg.hqb_climb_tree.add_to_queue(self, priority)
        unimobs.mobkit_api.do_entity_animation(self, "climb")
        return true

    elseif unimobs.mobkit_api.check_main_timer(self, 60) then

        -- Search for a tree
        local pos = self.object:get_pos()
        local view_range = self.view_range
        local nearby_wood_list = core.find_nodes_in_area(
            {x = pos.x - view_range, y = pos.y - view_range, z = pos.z - view_range},
            {x = pos.x + view_range, y = pos.y + view_range, z = pos.z + view_range},
            {"group:wood"}
        )

        if #nearby_wood_list >= 1 then

            local first_wood_pos = nearby_wood_list[1]
            unilib.pkg.hqb_goto.add_to_queue(self, priority, first_wood_pos)

            return true

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_climb_tree.init()

    return {
        description = "Standard mob meta-behaviour: climb a tree",
        notes = "See also the related behaviours in the \"hqb_climb_tree\" and" ..
                " \"lqb_climb_tree\" packages",
        depends = {"hqb_climb_tree", "hqb_goto"},
    }

end
