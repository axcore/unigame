---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_shrub_dry = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_shrub_dry.init()

    return {
        description = "Dry shrub",
    }

end

function unilib.pkg.plant_shrub_dry.exec()

    unilib.register_node("unilib:plant_shrub_dry", "default:dry_shrub", mode, {
        -- From default:dry_shrub
        description = S("Dry Shrub"),
        tiles = {"unilib_plant_shrub_dry.png"},
        -- N.B. flora = 1 not in original code
        groups = {attached_node = 1, flammable = 3, flora = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_shrub_dry.png",
        paramtype = "light",
        paramtype2 = "meshoptions",
        place_param2 = 4,
        selection_box = {
            type = "fixed",
            fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 4 / 16, 6 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_plant_shrub_dry.png",
    })
    unilib.register_craft({
        -- From default:dry_shrub
        type = "fuel",
        recipe = "unilib:plant_shrub_dry",
        burntime = 2,
    })
    unilib.register_plant_in_pot("unilib:plant_shrub_dry", "default:dry_shrub")

    unilib.register_decoration("default_plant_shrub_dry", {
        -- From default/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:plant_shrub_dry",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.02,
            seed = 329,
            spread = {x = 200, y = 200, z = 200},
        },
        param2 = 4,
        sidelen = 16,
    })

end
