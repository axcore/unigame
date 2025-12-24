---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.lqb_climb_tree = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

-- Localise math functions (for speed)
local cos = math.cos
local sin = math.sin
-- Maximum height of the column of tree-like nodes that can be climbed using this behaviour. If the
--      value is much higher than 8, then there's a risk of death if, having failed to jump onto the
--      node at the top of the column, the node falls back to the surface
local max_height = 8

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.lqb_climb_tree.add_to_queue(self)

    -- Adapted from petz.lq_climb()
    -- Checks whether there's a tree that can be climbed (the maximum climbing height is specified
    --      above). If so, teleports the mob to the top of the tree, giving it a little forward
    --      momentum so that it appears to "step" onto the highest node

    -- (Behaviour implemented as a closure to preserve state between calls)
    local func = function(self)

        -- N.B. The original code was completely broken, leaving squirrels (etc) in an infinite
        --      teleportation loop
        -- The code below is an original to unimobs, and seems to work most of the time

        if not unimobs.mobkit_api.is_behaviour_safe(self) then
            return true
        end

        local climb_pos = self.object:get_pos()

        -- To consider climbing, the node above must be air, and the node to the front must be
        --      tree-like
        local above_node = unimobs.petz_api.get_node_at_named_location(self, "top")
        if not above_node or above_node.name ~= "air" then
            return true
        end

        local front_node = unimobs.petz_api.get_node_at_named_location(self, "front")
        if not front_node or
                not core.registered_nodes[front_node.name] or
                not unimobs.petz_api.is_tree_like(front_node) then
            return true
        end

        -- Calculuate the height of the "column" of tree-like nodes in front of the mob. If it's
        --      not higher than the maximum, then the mob can "climb" the column
        local climb_flag = false
        for i = 1, max_height do

            climb_pos.y = climb_pos.y + 1

            -- Node above this position must be air
            local this_node_above = core.get_node_or_nil(climb_pos)
            if not this_node_above or this_node_above.name ~= "air" then

                climb_flag = false
                break

            end

            -- Node in front of this position must be air, or a tree-like node. If it's air, we
            --      have found the top of the "column"
            local yaw = self.object:get_yaw()
            if not yaw then

                climb_flag = false
                break

            end

            local this_node_front = core.get_node_or_nil({
                x = climb_pos.x - sin(yaw),
                y = climb_pos.y,
                z = climb_pos.z + cos(yaw),
            })

            if not this_node_front then

                climb_flag = false
                break

            elseif this_node_front.name == "air" then

                climb_flag = true
                break

            elseif not unimobs.petz_api.is_tree_like(this_node_front) then

                climb_flag = false
                break

            end

        end

        if climb_flag then

            -- Larger mobs need to teleport a little higher, in order to clear the same "column"
            --      height. This code block increases the teleportation height for chimps, and any
            --      future mobs which are smaller than chimps, but bigger than squirrels
            local data_table = unimobs.petz_global.mob_table[self.mob_type]
            if data_table then

                if data_table.visual_size.y >= 25 then
                    climb_pos.y = climb_pos.y + 1
                elseif data_table.visual_size.y >= 15 then
                    climb_pos.y = climb_pos.y + 0.5
                end

            end

            -- Teleport the mob to the height of the "column"
            self.object:set_pos(climb_pos)
            self.status = unimobs.mobkit_api.add_mob_memory(self, "status", nil)

            -- Give the mob some upwards and forward momentum, so it can "climb onto" the tree-like
            --      node at the top of the "column"
            -- N.B. Commenting out this code block will force a failed climb, in case that's useful
            --      for testing
            local yaw = self.object:get_yaw()
            core.after(0.1, function()

                self.object:set_velocity({
                    x = - sin(yaw),
                    y = 2,
                    z = cos(yaw),
                })

            end)

        end

    end

    unimobs.mobkit_api.add_to_low_level_queue(self, "lqb_climb_tree", func)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.lqb_climb_tree.init()

    return {
        description = "Standard low-level mob behaviour: climb the adjacent tree",
        notes = "See also the related behaviours in the \"hqb_climb_tree\" and" ..
                " \"mtb_climb_tree\" packages",
    }

end
