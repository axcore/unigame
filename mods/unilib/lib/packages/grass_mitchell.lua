---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.grass_mitchell = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.grass_mitchell.init()

    return {
        description = "Mitchell grass",
    }

end

function unilib.pkg.grass_mitchell.exec()

    unilib.register_node("unilib:grass_mitchell", "australia:mitchell_grass", mode, {
        -- From australia:mitchell_grass
        description = unilib.annotate(S("Mitchell Grass"), "Astrebla pectinata"),
        tiles = {"unilib_grass_mitchell.png"},
        -- N.B. grass = 1, mitchell_grass = 1 not in original code
        groups = {
            attached_node = 1, flammable = 2, flora = 1, grass = 1, mitchell_grass = 1, snappy = 3,
        },
        sounds = unilib.sound_table.leaves,

        buildable_to = false,
        drawtype = "plantlike",
        inventory_image = "unilib_grass_mitchell.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
        },
        sunlight_propagates = true,
        visual_scale = 1.0,
        walkable = false,
        waving = 0,
        wield_image = "unilib_grass_mitchell.png",
    })
    unilib.register_plant_in_pot("unilib:grass_mitchell", "australia:mitchell_grass")

    unilib.register_decoration("australia_grass_mitchell", {
        -- From australia:mitchell_grass
        deco_type = "simple",
        decoration = "unilib:grass_mitchell",

        fill_ratio = 0.05,
        sidelen = 80,
    })

end
