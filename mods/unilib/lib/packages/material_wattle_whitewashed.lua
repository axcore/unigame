---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.material_wattle_whitewashed = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.earthbuild.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.material_wattle_whitewashed.init()

    return {
        description = "Whitewashed wattle and daub",
        depends = {"material_lime_slaked", "material_wattle"},
    }

end

function unilib.pkg.material_wattle_whitewashed.exec()

    unilib.register_node(
        -- From earthbuild:whitewashed_wattle_and_daub
        "unilib:material_wattle_and_daub_whitewashed",
        "earthbuild:whitewashed_wattle_and_daub",
        mode,
        {
            description = S("Whitewashed Wattle and Daub"),
            tiles = {"unilib_dirt_whitewashed.png"},
            groups = {choppy = 2, cracky = 2, crumbly = 1},
            sounds = unilib.global.sound_table.dirt,

            connects_to = {
                "group:crumbly",
                "group:stone",
                "group:tree",
                "group:wood",
                "unilib:material_wattle",
                "unilib:material_wattle_loose",
            },
            drawtype = "nodebox",
            -- N.B. The item looks better when it is 3D-rendered in the inventory
--          inventory_image = "unilib_dirt_whitewashed.png",
            -- N.B. is_ground_content = false not in original code
            is_ground_content = false,
            node_box = {
                type = "connected",
                fixed = {
                    {-1/4, -1/2, -1/4, 1/4, 1/2, 1/4},
                },
                connect_front = {
                    {-1/4, -1/2, -1/2,  1/4, 1/2, -1/4},
                },
                connect_left = {
                    {-1/2, -1/2, -1/4, -1/4, 1/2,  1/4},
                },
                connect_back = {
                    {-1/4, -1/2,  1/4,  1/4, 1/2,  1/2},
                },
                connect_right = {
                    { 1/4, -1/2, -1/4,  1/2, 1/2,  1/4},
                },
            },
            paramtype = "light",
            wield_image = "unilib_dirt_whitewashed.png",
        }
    )
    unilib.register_craft({
        -- From earthbuild:whitewashed_wattle_and_daub
        output = "unilib:material_wattle_and_daub_whitewashed",
        recipe = {
            {"unilib:material_wattle_and_daub", "unilib:material_lime_slaked"},
        },
    })
    unilib.register_craft({
        -- From earthbuild:wattle
        output = "unilib:material_wattle",
        recipe = {
            {"unilib:material_wattle_and_daub_whitewashed"},
        },
    })

end
