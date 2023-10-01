---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.mushroom_king = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mushroom_king.init()

    return {
        description = "King mushroom",
        optional = {"shared_cropocalypse_mushroom", "stone_ordinary_with_gold"},
    }

end

function unilib.pkg.mushroom_king.exec()

    -- Add a special mushroom-spreading ABM, and a particle-spawning ABM. To avoid creating these
    --      additional ABMs, just omit the "shared_cropocalypse_mushroom" package from your remixes
    if unilib.pkg_executed_table["shared_cropocalypse_mushroom"] ~= nil and
            unilib.pkg_executed_table["stone_ordinary_with_gold"] ~= nil then

        unilib.pkg.shared_cropocalypse_mushroom.register_abms(
            "king", "group:king_mushroom", "unilib:stone_ordinary_with_gold"
        )

    end

    unilib.register_node("unilib:mushroom_king", "cropocalypse:king_mushroom", mode, {
        -- From cropocalypse:king_mushroom
        description = S("King Mushroom"),
        tiles = {"unilib_mushroom_king.png"},
        -- N.B. mushroom = 1 not in original code
        groups = {
            attached_node = 1, flammable = 1, food_king_mushroom = 1, king_mushroom = 1,
            mushroom = 1, snappy = 3,
        },
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_mushroom_king.png",
        light_source = 9,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_mushroom_king.png",

        on_use = unilib.cuisine_eat_on_use("unilib:mushroom_king", 4),
    })
    unilib.register_mushroom_in_pot("unilib:mushroom_king", "cropocalypse:king_mushroom")

    unilib.register_decoration("cropocalypse_mushroom_king", {
        -- From cropocalypse/glowing_mushrooms.lua
        deco_type = "simple",
        decoration = "unilib:mushroom_king",

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 0.7,
            scale = 0.1,
            seed = 6031,
            spread = {x = 10, y = 10, z = 10},
        },
        sidelen = 16,
    })

end
