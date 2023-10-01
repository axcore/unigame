---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.moss_antipodean = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.moss_antipodean.init()

    return {
        description = "Antipodean moss",
    }

end

function unilib.pkg.moss_antipodean.exec()

    unilib.register_node("unilib:moss_antipodean", "australia:moss", mode, {
        -- From australia:moss
        description = S("Antipodean Moss"),
        tiles = {"unilib_moss_antipodean.png"},
        -- N.B. moss = 1 not in original code
        groups = {flammable = 3, moss = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = false,
        drawtype = "nodebox",
        inventory_image = "unilib_moss_antipodean.png",
        node_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.46875, 0.5},
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
        },
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        walkable = false,
        wield_image = "unilib_moss_antipodean.png",
    })

    unilib.register_decoration("australia_moss_antipodean_in_range", {
        -- From australia:moss
        deco_type = "simple",
        decoration = "unilib:moss_antipodean",

        fill_ratio = 0.06,
        sidelen = 80,
    })
    unilib.register_decoration("australia_moss_antipodean_in_tasmania", {
        -- From australia:moss
        deco_type = "simple",
        decoration = "unilib:moss_antipodean",

        fill_ratio = 0.9,
        sidelen = 80,
    })
    unilib.register_decoration("australia_moss_antipodean_in_victoria", {
        -- From australia:moss
        deco_type = "simple",
        decoration = "unilib:moss_antipodean",

        fill_ratio = 0.07,
        sidelen = 80,
    })

    unilib.register_node("unilib:moss_antipodean_with_fungus", "australia:moss_with_fungus", mode, {
        -- From australia:moss_with_fungus
        description = S("Antipodean Moss with Fungus"),
        tiles = {"unilib_moss_antipodean_with_fungus.png"},
        groups = {flammable = 3, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = false,
        drawtype = "nodebox",
        inventory_image = "unilib_moss_antipodean_with_fungus.png",
        node_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.46875, 0.5},
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
        },
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        walkable = false,
        wield_image = "unilib_moss_antipodean_with_fungus.png",
    })

    unilib.register_decoration("australia_moss_antipodean_with_fungus", {
        -- From australia:moss_with_fungus
        deco_type = "simple",
        decoration = "unilib:moss_antipodean_with_fungus",

        fill_ratio = 0.02,
        sidelen = 80,
    })

end
