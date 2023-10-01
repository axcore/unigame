---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.furniture_bench_simple = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cottages.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.furniture_bench_simple.init()

    return {
        description = "Simple wooden bench",
        depends = "shared_cottages",
    }

end

function unilib.pkg.furniture_bench_simple.exec()

    unilib.register_node("unilib:furniture_bench_simple", "cottages:bench", mode, {
        -- From cottages:bench
        description = S("Simple Wooden Bench"),
        tiles = {"unilib_misc_wood_rustic.png"},
        groups = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, snappy = 1},
        sounds = unilib.sound_table.wood,

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.15, 0.1, 0.5, -0.05, 0.5},
                {-0.4, -0.5, 0.2, -0.3, -0.15, 0.4},
                { 0.3, -0.5, 0.2, 0.4, -0.15, 0.4},
            }
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, 0, 0.5, 0, 0.5},
            }
        },

        on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)

            return unilib.pkg.shared_cottages.sit_on_bench(
                pos, node, clicker, itemstack, pointed_thing
            )

        end,
    })
    unilib.register_craft({
        -- From cottages:bench
        output = "unilib:furniture_bench_simple",
        recipe = {
            {"", "group:wood", ""},
            {"group:wood", "", "group:wood"}
        }
    })

end
