---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.fern_crown_antipodean = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fern_crown_antipodean.init()

    return {
        description = "Antipoedan crown fern",
    }

end

function unilib.pkg.fern_crown_antipodean.exec()

    unilib.register_node("unilib:fern_crown_antipodean", "aotearoa:crown_fern", mode, {
        -- From aotearoa:crown_fern
        description = unilib.annotate(S("Antipodean Crown Fern"), "Blechnum discolor"),
        tiles = {"unilib_fern_crown_antipodean.png"},
        groups = {attached_node = 1, flammable = 1, flora = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_fern_crown_antipodean.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.4, -0.5, -0.4, 0.4, -0.2, 0.4},
        },
        sunlight_propagates = true,
        visual_scale = 1,
        walkable = false,
        waving = 1,
        wield_image = "unilib_fern_crown_antipodean.png",
    })
    unilib.register_craft({
        -- From aotearoa:crown_fern
        type = "fuel",
        recipe = "unilib:fern_crown_antipodean",
        burntime = 1,
    })
    unilib.register_plant_in_pot("unilib:fern_crown_antipodean", "aotearoa:crown_fern")

    unilib.register_decoration("aotearoa_fern_crown_antipodean_normal", {
        -- From aotearoa/spawn_plants.lua
        deco_type = "simple",
        decoration = "unilib:fern_crown_antipodean",

        fill_ratio = 0.01,
        sidelen = 16,
    })
    unilib.register_decoration("aotearoa_fern_crown_antipodean_dense", {
        -- From aotearoa/spawn_plants.lua
        deco_type = "simple",
        decoration = "unilib:fern_crown_antipodean",

        fill_ratio = 0.1,
        sidelen = 16,
    })

end
