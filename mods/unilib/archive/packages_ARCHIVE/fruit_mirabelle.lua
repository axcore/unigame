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
lib_ecology:fruit_mirabelle
{
    tiles = {
        [1] = "lib_ecology_fruit_mirabelle.png",
        [2] = "lib_ecology_fruit_mirabelle.png",
    },
    visual_scale = 1,
    selection_box = {
        type = "fixed",
        fixed = {
            [1] = {
                [1] = "-0.35",
                [2] = "-0.5",
                [3] = "-0.35",
                [4] = "0.35",
                [5] = "0.5",
                [6] = "0.35",
            },
        },
    },
    is_ground_content = false,
    groups = {
        dig_immediate = 3,
        leafdecay_drop = 1,
        fleshy = 3,
        leafdecay = 1,
        flammable = 2,
    },
    drawtype = "plantlike",
    sounds = {
    },
    walkable = false,
    on_use = "function: 0x406eae40",
    sunlight_propagates = true,
    paramtype = "light",
    legacy_wallmounted = false,
    description = "Fruit - Mirabelle",
}
]]--
