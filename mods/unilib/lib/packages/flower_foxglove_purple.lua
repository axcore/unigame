---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_foxglove_purple = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_foxglove_purple.init()

    return {
        description = "Purple foxglove",
    }

end

function unilib.pkg.flower_foxglove_purple.exec()

    unilib.register_node("unilib:flower_foxglove_purple", "flowers_plus:foxglove_purple", mode, {
        -- From farlands, flowers_plus:foxglove_purple
        description = unilib.utils.annotate(S("Purple Foxglove"), "Digitalis purpurea"),
        tiles = {"unilib_flower_foxglove_purple.png"},
        -- N.B. Replaced original groups with standard flower groups
--      groups = {attached_node = 1, flammable = 1, flora = 1, snappy = 3},
        groups = {
            attached_node = 1, color_violet = 1, colour_violet = 1, flammable = 1, flora = 1,
            flower = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_flower_foxglove_purple.png",
        -- N.B. removed is_ground_content = false to match other flowers
--      is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
        },
        sunlight_propagates = true,
        visual_scale = 2,
        walkable = false,
        wield_scale = {x = 0.5, y = 0.5, z = 0.5},
    })
    unilib.register_flower_in_pot("unilib:flower_foxglove_purple", "flowers_plus:foxglove_purple")

    unilib.register_decoration_generic("farlands_flower_foxglove_purple", {
        -- From farlands, flowers_plus/init.lua
        deco_type = "simple",
        decoration = "unilib:flower_foxglove_purple",

        fill_ratio = 0.03,
        height = 1,
        sidelen = 16,
    })

end
