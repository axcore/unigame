---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_waratah = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_waratah.init()

    return {
        description = "Waratah",
    }

end

function unilib.pkg.plant_waratah.exec()

    unilib.register_node("unilib:plant_waratah", "australia:waratah", mode, {
        -- From australia:waratah
        description = unilib.utils.annotate(S("Waratah"), "Telopea speciosissima"),
        tiles = {"unilib_plant_waratah.png"},
        groups = {attached_node = 1, flammable = 2, flora = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "allfaces_optional",
        inventory_image = "unilib_plant_waratah.png",
        paramtype = "light",
        sunlight_propagates = true,
        visual_scale = 1.0,
        wield_image = "unilib_plant_waratah.png",
    })
    unilib.register_plant_in_pot("unilib:plant_waratah", "australia:waratah")

    unilib.register_decoration_generic("australia_plant_waratah", {
        -- From australia/biome_eastern_coasts.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_plant_waratah.mts",

        fill_ratio = 0.005,
        flags = "force_placement",
        sidelen = 80,
    })

end
