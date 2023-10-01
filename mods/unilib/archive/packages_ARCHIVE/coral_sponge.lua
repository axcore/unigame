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
lib_ecology:coral_sponge
{
    tiles = {
        [1] = "lib_ecology_coral_sponge.png",
        [2] = "lib_ecology_coral_sponge.png",
    },
    light_source = 4,
    drop = {
        max_items = "",
        items = {
            [1] = {
                items = {
                    [1] = "lib_ecology:coral_skeleton",
                },
            },
            [2] = {
                items = {
                    [1] = "lib_ecology:coral_skeleton",
                },
            },
            [3] = {
                items = {
                    [1] = "lib_ecology:coral_skeleton",
                },
            },
            [4] = {
                items = {
                    [1] = "lib_ecology:coral_skeleton",
                },
            },
            [5] = {
                items = {
                    [1] = "lib_ecology:coral_skeleton",
                },
            },
            [6] = {
                items = {
                    [1] = "lib_ecology:coral_skeleton",
                },
            },
        },
    },
    groups = {
        stone = 1,
        sea = 1,
        cracky = 3,
    },
    sounds = {
        dug = {
            name = "default_hard_footstep",
            gain = 1,
        },
        footstep = {
            name = "default_hard_footstep",
            gain = 0.3,
        },
        place = {
            name = "default_place_node_hard",
            gain = 1,
        },
    },
    legacy_wallmounted = false,
    description = "Coral - Sponge",
}
]]--
