---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_buttercup_large = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_buttercup_large.init()

    return {
        description = "Large buttercup",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_buttercup_large.exec()

    unilib.register_node("unilib:flower_buttercup_large", "cropocalypse:buttercup", mode, {
        -- From cropocalypse:buttercup
        description = unilib.utils.annotate(S("Large Buttercup"), "Ranunculus"),
        tiles = {"unilib_flower_buttercup_large.png"},
        -- N.B. Replaced original groups with standard flower groups
--      groups = {attached_node = 1, decorative_plants = 1, flammable = 1, snappy = 3},
        groups = {
            attached_node = 1, color_yellow = 1, colour_yellow = 1, flammable = 1, flora = 1,
            flower = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_flower_buttercup_large.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_flower_buttercup_large.png",
    })
    if unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- From cropocalypse:buttercup
            output = "unilib:dye_yellow 2",
            recipe = {
                {"unilib:flower_buttercup_large"},
            },
        })

    end
    unilib.register_flower_in_pot("unilib:flower_buttercup_large", "cropocalypse:buttercup")

    unilib.register_decoration_generic("cropocalypse_flower_buttercup_large", {
        -- From cropocalypse/decorative_plants.lua
        deco_type = "simple",
        decoration = "unilib:flower_buttercup_large",

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 0.7,
            scale = 0.1,
            seed = 8095,
            spread = {x = 10, y = 10, z = 10},
        },
        sidelen = 16,
    })

end
