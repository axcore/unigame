---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
lib_ecology:cactus_purple_column
{
    tiles = {
        [1] = "lib_ecology_cactus_purple_trunk_top.png",
        [2] = "lib_ecology_cactus_purple_trunk_top.png",
        [3] = "lib_ecology_cactus_purple_trunk.png",
        [4] = "lib_ecology_cactus_purple_trunk.png",
        [5] = "lib_ecology_cactus_purple_trunk.png",
        [6] = "lib_ecology_cactus_purple_trunk.png",
    },
    selection_box = {
        type = "fixed",
        fixed = {
            [1] = {
                [1] = "-0.25",
                [2] = "-0.5",
                [3] = "-0.25",
                [4] = "0.25",
                [5] = "0.5",
                [6] = "0.25",
            },
        },
    },
    is_ground_content = false,
    groups = {
        flammable = 2,
        oddly_breakable_by_hand = 1,
        choppy = 2,
        tree = 1,
    },
    drawtype = "nodebox",
    sounds = {
    },
    walkable = true,
    node_box = {
        type = "fixed",
        fixed = {
            [1] = {
                [1] = "-0.25",
                [2] = "-0.5",
                [3] = "-0.25",
                [4] = "0.25",
                [5] = "0.5",
                [6] = "0.25",
            },
        },
    },
    damage_per_second = 1,
    paramtype2 = "facedir",
    paramtype = "light",
    legacy_wallmounted = false,
    description = "Cactus - Purple Column",
}
]]--
