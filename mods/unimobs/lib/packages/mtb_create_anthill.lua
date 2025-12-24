---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mtb_create_anthill = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_create_anthill.do_action(self)

    -- Adapted from petz.bh_create_anthill()
    -- Called only for queen ants
    -- If the queen is on a suitable node (dirt or sand, no higher than y=8), and if there are no
    --      other anthills in the vicinity, then places the anthill schematic at this location
    -- Note that queens can only create one anthill during their lifetimes

    if not unimobs.mobkit_api.is_behaviour_safe(self) then
        return
    end

    -- Create anthills close to coasts (to avoid mountains)
    local pos = self.object:get_pos()
    if not self.create_colony_flag or pos.y > 8 then
        return
    end

    local below_node, below_pos = unimobs.petz_api.get_node_at_named_location(self, "below")
    -- Don't build on protected nodes
    if not below_node or not below_pos or core.is_protected(below_pos, "") then
        return
    end

    -- Only build anthills on "soil" or "sand" nodes
    if core.get_item_group(below_node.name, "soil") > 0 or
            core.get_item_group(below_node.name, "sand") > 0 then

        local min_pos = {x = pos.x - 50, y = pos.y - 50, z = pos.z - 50}
        local max_pos = {x = pos.x + 50, y = pos.y + 50, z = pos.z + 50}

        if #core.find_nodes_in_area(min_pos, max_pos, {"unilib:misc_anthill_bed"}) < 1 then

            core.place_schematic(
                {x = pos.x - 6, y = pos.y - 25, z = pos.z - 6},
                unimobs.path_mod .. "/mts/unilib_misc_anthill.mts",
                "0",
                nil,
                true
            )

            -- Replace the entrance node with another entrance node, in order to trigger its
            --      .on_construct event of the node (because that event is not triggered by the
            --      placement of schematics)
            local entrance_node, entrance_pos
                    = unimobs.petz_api.get_node_at_named_location(self, "below")
            if entrance_node and entrance_node.name == "unilib:misc_anthill_entrance" then
                core.set_node(entrance_pos, {name = entrance_node.name})
            end

            -- Mark this creature as having founded an anthill (the "brain_ant" package guarantees
            --      that a queen can only found one anthill)
            self.colony_created_flag =
                    unimobs.mobkit_api.add_mob_memory(self, "colony_created_flag", true)
            -- (y offset for placing the queen inside the anthill)
            pos.y = pos.y - 24
            -- Place the queen
            self.object:move_to(pos)

            return true

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_create_anthill.init()

    return {
        description = "Standard mob meta-behaviour: create an anthill",
        depends = "misc_anthill",
    }

end
