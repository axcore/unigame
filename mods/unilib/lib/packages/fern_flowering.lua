---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.fern_flowering = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fern_flowering.init()

    return {
        description = "Flowering fern",
        optional = "dye_basic",
    }

end

function unilib.pkg.fern_flowering.exec()

    unilib.register_node("unilib:fern_flowering", "cropocalypse:flowering_fern", mode, {
        -- From cropocalypse:flowering_fern
        description = S("Flowering Fern"),
        tiles = {"unilib_fern_flowering.png"},
        -- N.B. flora = 1 not in original code
        groups = {attached_node = 1, decorative_plants = 1, flammable = 1, flora = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_fern_flowering.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_fern_flowering.png",
    })
    if unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- From cropocalypse:flowering_fern
            output = "unilib:dye_green 2",
            recipe = {
                {"unilib:fern_flowering"},
            },
        })

    end
    unilib.register_plant_in_pot("unilib:fern_flowering", "cropocalypse:flowering_fern")

    unilib.register_decoration("cropocalypse_fern_flowering", {
        -- From cropocalypse/decorative_plants.lua
        deco_type = "simple",
        decoration = "unilib:fern_flowering",

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 0.7,
            scale = 0.35,
            seed = 7288,
            spread = {x = 10, y = 10, z = 10},
        },
        sidelen = 16,
    })

end
