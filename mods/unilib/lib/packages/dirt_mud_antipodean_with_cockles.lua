---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_mud_antipodean_with_cockles = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_mud_antipodean_with_cockles.init()

    return {
        description = "Antipodean mud with cockles",
        notes = "Drops cockles, which are edible",
        depends = {"dirt_mud_antipodean", "food_clam_cockle"},
    }

end

function unilib.pkg.dirt_mud_antipodean_with_cockles.exec()

    unilib.register_node(
        -- From aotearoa:mud_with_cockles
        "unilib:dirt_mud_antipodean_with_cockles",
        "aotearoa:mud_with_cockles",
        mode,
        {
            description = S("Antipodean Mud with Cockles"),
            tiles = {"unilib_dirt_mud_antipodean_with_cockles.png"},
            groups = {crumbly = 3, puts_out_fire = 1},
            sounds = unilib.node_sound_dirt_defaults({
                footstep = {name = "unilib_dirt_mud_antipodean", gain = 0.4},
                dug = {name = "unilib_dirt_mud_antipodean", gain = 0.4},
            }),

            is_ground_content = unilib.caves_chop_dirt_flag,

            on_punch = function(pos, node, puncher)

                -- Dig up cockles
                puncher:get_inventory():add_item("main", "unilib:food_clam_cockle")
                minetest.set_node(pos, {name = "unilib:dirt_mud_antipodean_dry"})

            end,
        }
    )

end
