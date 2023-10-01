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
lib_ecology:cactus_prickly_pear
{
    is_ground_content = false,
    buildable_to = false,
    drawtype = "plantlike",
    sounds = {
    },
    damage_per_second = 1,
    paramtype = "light",
    description = "Cactus - Prickly Pear",
    tiles = {
        [1] = "lib_ecology_cactus_prickly_pear.png",
        [2] = "lib_ecology_cactus_prickly_pear.png",
    },
    visual_scale = 4,
    selection_box = {
        type = "fixed",
        fixed = {
            [1] = {
                [1] = "-0.3",
                [2] = "-0.5",
                [3] = "-0.3",
                [4] = "0.3",
                [5] = "0",
                [6] = "0.3",
            },
        },
    },
    floodable = true,
    sunlight_propagates = true,
    walkable = false,
    wield_scale = {
        y = 0.5,
        x = 0.5,
        z = 0.5,
    },
    waving = 1,
    legacy_wallmounted = false,
    groups = {
        leaves = 1,
        flora = 1,
        lib_ecology_plant = 1,
        attached_node = 1,
        snappy = 3,
        oddly_breakable_by_hand = 1,
        flammable = 1,
    },
}
]]--
