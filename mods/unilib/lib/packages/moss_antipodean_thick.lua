---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.moss_antipodean_thick = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.moss_antipodean_thick.init()

    return {
        description = "Thick Antipodean moss",
    }

end

function unilib.pkg.moss_antipodean_thick.exec()

    unilib.register_node("unilib:moss_antipodean_thick", "aotearoa:moss", mode, {
        -- From aotearoa:moss
        description = S("Thick Antipodean Moss"),
        tiles = {"unilib_moss_antipodean_thick.png"},
        -- N.B. moss = 1 not in original code
        groups = {attached_node = 1, crumbly = 3, flammable = 1, flora = 1, moss = 1},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "nodebox",
        -- N.B. removed is_ground_content = false to match other mosses
--      is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
            },
        },
        paramtype = "light",
        sunlight_propagates = true,
        walkable = false,
    })

    unilib.register_decoration_generic("aotearoa_moss_antipodean_thick_dense", {
        -- From aotearoa/spawn_plants.lua
        deco_type = "simple",
        decoration = "unilib:moss_antipodean_thick",

        fill_ratio = 0.9,
        sidelen = 16,
    })
    unilib.register_decoration_generic("aotearoa_moss_antipodean_thick_rare", {
        -- From aotearoa/spawn_plants.lua
        deco_type = "simple",
        decoration = "unilib:moss_antipodean_thick",

        noise_params = {
            octaves = 2,
            offset = 0,
            persist = 0.7,
            scale = 0.095,
            seed = 8755361,
            spread = {x = 16, y = 16, z = 16},
        },
        sidelen = 16,
    })

end
