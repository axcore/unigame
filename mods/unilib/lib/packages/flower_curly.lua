---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_curly = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_curly.init()

    return {
        description = "Curly flower",
        notes = "Produces curly fruit",
        depends = "fruit_curly",
    }

end

function unilib.pkg.flower_curly.exec()

    unilib.register_node("unilib:flower_curly", "moreplants:curly", mode, {
        -- From moreplants:curly
        description = S("Curly Flower"),
        tiles = {"unilib_flower_curly.png"},
        -- N.B. Replaced original groups with standard flower groups
--      groups = {attached_node = 1, flammable = 1, flora = 1, snappy = 3},
        groups = {
            attached_node = 1, color_yellow = 1, colour_yellow = 1, flammable = 1, flora = 1,
            flower = 1, snappy = 3,
        },
        -- N.B. no sounds in original code
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        drop = "unilib:fruit_curly",
        inventory_image = "unilib_flower_curly.png",
        -- N.B. removed is_ground_content = false to match other flowers
--      is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0.4, 0.3},
        },
        sunlight_propagates = true,
        visual_scale = 1.1,
        walkable = false,
        wield_scale = {x = 0.5, y = 0.5, z = 0.5},
    })
    -- (not compatible with flowerpots)

    unilib.register_decoration_generic("moreplants_flower_curly", {
        -- From moreplants:curly
        deco_type = "simple",
        decoration = "unilib:flower_curly",

        fill_ratio = 0.005,
        height = 1,
        sidelen = 26,
    })

end
