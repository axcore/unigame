---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_puddle = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

local evaporate_time = 120
local puddle_count = 4

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_puddle.get_puddle_count()

    -- Some weather packages use these puddles; they need to ask how many different nodes are
    --      available
    return puddle_count

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_puddle.init()

    return {
        description = "Puddles",
    }

end

function unilib.pkg.misc_puddle.exec()

    local check_table = {}

    for i = 1, puddle_count do

        local full_name = "unilib:misc_puddle_" .. i
        check_table[full_name] = true

        unilib.register_node(full_name, nil,  mode, {
            -- Original to unilib
            description = S("Puddle"),
            -- unilib_misc_puddle_5.png is the original square texture, used to create the other 4;
            --      it could be used here, if you really want square puddles
--          tiles = {"unilib_misc_puddle_5.png"},
            tiles = {"unilib_misc_puddle_" .. i .. ".png"},
            groups = {falling_node = 1, not_in_creative_inventory = 1, puddle = 1},
            sounds = {
                footstep = {name = "unilib_misc_puddle", gain = 0.4},
            },

            buildable_to = true,
            -- (.collision_box is taller than the node_box, so that the sound effect is triggered)
            collision_box = {
                type = "fixed",
                fixed = {
                    {-0.4, -0.5, -0.4, 0.4, -0.45, 0.4},
                },
            },
            drawtype = "nodebox",
            floodable = true,
            node_box = {
                type = "fixed",
                fixed = {
                    {-0.4, -0.5, -0.4, 0.4, -0.49, 0.4},
                },
            },
            paramtype = "light",
            pointable = false,
            sunlight_propagates = true,
            use_texture_alpha = "blend",
            walkable = false,

            on_construct = function(pos)

                core.after(math.random((evaporate_time / 2), evaporate_time), function()

                    local node = core.get_node(pos)
                    -- (Remove any puddle at this location, in case the original was replaced)
                    if node and check_table[node.name] then
                        core.remove_node(pos)
                    end

                end)

            end,
        })

    end

    -- (Need an LBM to remove stray puddles, for example after a server restart)
    unilib.register_lbm({
        label = "Remove puddles [misc_puddle]",
        name = "unilib:lbm_misc_puddle",
        nodenames = {"group:puddle"},
        run_at_every_load = true,

        action = function(pos)
            core.remove_node(pos)
        end
    })

end
