---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.mushroom_slimy = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mushroom_slimy.init()

    return {
        description = "Slimy mushroom",
        optional = {"shared_cropocalypse_mushroom", "stone_ordinary_with_copper"},
    }

end

function unilib.pkg.mushroom_slimy.exec()

    -- Add a special mushroom-spreading ABM, and a particle-spawning ABM. To avoid creating these
    --      additional ABMs, just omit the "shared_cropocalypse_mushroom" package from your remixes
    if unilib.pkg_executed_table["shared_cropocalypse_mushroom"] ~= nil and
            unilib.pkg_executed_table["stone_ordinary_with_copper"] ~= nil then

        unilib.pkg.shared_cropocalypse_mushroom.register_abms(
            "slimiy", "group:slimy_mushroom", "unilib:stone_ordinary_with_copper"
        )

    end

    unilib.register_node("unilib:mushroom_slimy", "cropocalypse:slimy_mushroom", mode, {
        -- From cropocalypse:slimy_mushroom
        description = S("Slimy Mushroom"),
        tiles = {"unilib_mushroom_slimy.png"},
        -- N.B. mushroom = 1 not in original code
        groups = {
            attached_node = 1, flammable = 1, food_slimy_mushroom = 1, mushroom = 1,
            slimy_mushroom = 1, snappy = 3,
        },
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_mushroom_slimy.png",
        light_source = 9,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_mushroom_slimy.png",

        on_use = unilib.cuisine_eat_on_use("unilib:mushroom_slimy", 4),
    })
    unilib.register_mushroom_in_pot("unilib:mushroom_slimy", "cropocalypse:slimy_mushroom")

    unilib.register_decoration("cropocalypse_mushroom_slimy", {
        -- From cropocalypse/glowing_mushrooms.lua
        deco_type = "simple",
        decoration = "unilib:mushroom_slimy",

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 0.7,
            scale = 0.1,
            seed = 5567,
            spread = {x = 10, y = 10, z = 10},
        },
        sidelen = 16,
    })

end
