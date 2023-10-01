---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    tsm_pyramids
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_tsm_pyramids = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.tsm_pyramids.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_tsm_pyramids.register_trap(
    cracked_name, crumbling_name, cracked_description, crumbling_description
)
    -- Called to convert decorative traps into actual traps (when unilib.tsm_pyramids_real_trap_flag
    --      is true)

    unilib.override_item(cracked_name, {
        description = cracked_description,

        on_construct = function(pos)
            minetest.get_node_timer(pos):start(0.1)
        end,

        on_timer = function(pos, elapsed)

            local n = minetest.get_node(pos)
            if not (n and n.name) then
                return true
            end

            -- Drop trap stone when player is nearby
            local objs = minetest.get_objects_inside_radius(pos, 2)
            for i, obj in pairs(objs) do

                if obj:is_player() then

                    if n.name == cracked_name then

                        -- 70% chance to ignore player to make the time of falling less predictable
                        if math.random(1, 10) >= 3 then
                            return true
                        end

                        minetest.set_node(pos, {name = crumbling_name})
                        minetest.check_for_falling(pos)
                        return true

                    end

                end

            end

            return true

        end,
    })

    unilib.override_item(crumbling_name, {
        description = crumbling_description,
        groups = {cracky = 3, crumbly = 3, falling_node = 1, not_in_creative_inventory = 1},
    })

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_tsm_pyramids.init()

    return {
        description = "Shared functions for sandstone traps (from tsm_pyramids mod)",
    }

end
