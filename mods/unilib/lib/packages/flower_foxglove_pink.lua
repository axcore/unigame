---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_foxglove_pink = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_foxglove_pink.init()

    return {
        description = "Pink foxglove",
    }

end

function unilib.pkg.flower_foxglove_pink.exec()

    unilib.register_node("unilib:flower_foxglove_pink", "flowers_plus:foxglove", mode, {
        -- From farlands, flowers_plus:foxglove
        description = unilib.annotate(S("Pink Foxglove"), "Digitalis purpurea"),
        tiles = {"unilib_flower_foxglove_pink.png"},
        -- N.B. Replaced original groups with standard flower groups
--      groups = {attatched_node = 1, flammable = 1, flora = 1, snappy = 3},
        groups = {
            attached_node = 1, color_pink = 1, flammable = 1, flora = 1, flower = 1, snappy = 3,
        },
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_flower_foxglove_pink.png",
        is_ground_content = false,
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
    unilib.register_flower_in_pot("unilib:flower_foxglove_pink", "flowers_plus:foxglove")

    unilib.register_decoration("farlands_flower_foxglove_pink", {
        -- From farlands, flowers_plus/init.lua
        deco_type = "simple",
        decoration = "unilib:flower_foxglove_pink",

        fill_ratio = 0.03,
        height = 1,
        sidelen = 16,
    })

end
