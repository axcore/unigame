---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.grass_kauri = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.grass_kauri.init()

    return {
        description = "Kauri grass",
        optional = {"dye_basic", "item_paper_ordinary"},
    }

end

function unilib.pkg.grass_kauri.exec()

    unilib.register_node("unilib:grass_kauri", "aotearoa:kauri_grass", mode, {
        -- From aotearoa:kauri_grass
        description = unilib.utils.annotate(S("Kauri Grass"), "Astelia trinervia"),
        tiles = {"unilib_grass_kauri.png"},
        -- N.B. grass = 1, kauri_grass = 1 not in original code
        groups = {
            attached_node = 1, flammable = 1, flora = 1, grass = 1, kauri_grass = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "firelike",
        inventory_image = "unilib_grass_kauri.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.4, -0.5, -0.4, 0.4, -0.2, 0.4},
        },
        sunlight_propagates = true,
        visual_scale = 1,
        walkable = false,
        waving = 1,
        wield_image = "unilib_grass_kauri.png",
    })
    unilib.register_craft({
        -- From aotearoa:kauri_grass
        type = "fuel",
        recipe = "unilib:grass_kauri",
        burntime = 1,
    })
    if unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- From aotearoa:kauri_grass
            type = "shapeless",
            output = "unilib:dye_red 4",
            recipe = {"unilib:grass_kauri"},
        })

    end
    if unilib.global.pkg_executed_table["item_paper_ordinary"] ~= nil then

        unilib.register_craft({
            -- From aotearoa:kauri_grass
            output = "unilib:item_paper_ordinary",
            recipe = {
                {"unilib:grass_kauri", "unilib:grass_kauri", "unilib:grass_kauri"},
            },
        })

    end
    -- (not compatible with flowerpots)

    unilib.register_decoration_generic("aotearoa_grass_kauri", {
        -- From aotearoa/spawn_plants.lua
        deco_type = "simple",
        decoration = "unilib:grass_kauri",

        fill_ratio = 0.1,
        sidelen = 16,
    })

end
