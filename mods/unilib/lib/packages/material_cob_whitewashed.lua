---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.material_cob_whitewashed = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.earthbuild.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.material_cob_whitewashed.init()

    return {
        description = "Whitewashed cob",
        depends = {"material_cob", "material_lime_slaked"},
        optional = "dirt_rammed",
    }

end

function unilib.pkg.material_cob_whitewashed.exec()

    unilib.register_node(
        -- From earthbuild:whitewashed_earth
        "unilib:material_cob_whitewashed",
        "earthbuild:whitewashed_earth",
        mode,
        {
            description = S("Whitewashed Cob"),
            tiles = {"unilib_dirt_whitewashed.png"},
            groups = {cracky = 2, crumbly = 1, falling_node = 1},
            sounds = unilib.global.sound_table.dirt,

            drawtype = "normal",
            -- N.B. is_ground_content = false not in original code
            is_ground_content = false,
            paramtype = "light",
        }
    )
    unilib.register_craft({
        -- From earthbuild:whitewashed_earth
        output = "unilib:material_cob_whitewashed",
        recipe = {
            {"unilib:material_cob", "unilib:material_lime_slaked"},
        },
    })
    if unilib.global.pkg_executed_table["dirt_rammed"] ~= nil then

        -- Note from earthbuild:
        -- Whitewashed cob and rammed dirt look indistinguishable
        unilib.register_craft({
            -- From earthbuild:whitewashed_earth
            output = "unilib:material_cob_whitewashed",
            recipe = {
                {"unilib:dirt_rammed", "unilib:material_lime_slaked"},
            },
        })

    end
    unilib.register_stairs("unilib:material_cob_whitewashed")

    unilib.register_node(
        -- From earthbuild:whitewashed_mud_brick
        "unilib:material_cob_brick_whitewashed",
        "earthbuild:whitewashed_mud_brick",
        mode,
        {
            description = S("Whitewashed Mud Brick"),
            tiles = {"unilib_dirt_whitewashed.png"},
            groups = {cracky = 2, crumbly = 1},
            sounds = unilib.global.sound_table.dirt,

            drawtype = "normal",
            -- N.B. is_ground_content = false not in original code
            is_ground_content = false,
            paramtype = "light",
        }
    )
    unilib.register_craft({
        -- From earthbuild:whitewashed_mud_brick
        output = "unilib:material_cob_brick_whitewashed",
        recipe = {
            {"unilib:material_cob_brick", "unilib:material_lime_slaked"},
        },
    })
    unilib.register_stairs("unilib:material_cob_brick_whitewashed")

end
