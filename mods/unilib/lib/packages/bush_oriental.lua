---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.bush_oriental = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.bush_oriental.init()

    return {
        description = "Bush used as a decoration in ethereal-ng's bamboo biome",
        optional = "tree_bamboo",
    }

end

function unilib.pkg.bush_oriental.exec()

    unilib.register_node("unilib:bush_oriental", "ethereal:bush", mode, {
        -- From ethereal:bush
        description = S("Oriental Bush"),
        tiles = {"unilib_bush_oriental.png"},
        -- N.B. no bush = 1 in original code
        groups = {bush = 1, flammable = 2, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        walkable = true,
    })
    if unilib.global.pkg_executed_table["tree_bamboo"] ~= nil then

        unilib.register_craft({
            -- From ethereal:bush
            output = "unilib:bush_oriental",
            recipe = {
                {"group:leaves", "group:leaves", "group:leaves"},
                {"group:leaves", "unilib:tree_bamboo_leaves", "group:leaves"},
                {"group:leaves", "group:leaves", "group:leaves"},
            },
        })

    end
    unilib.register_craft({
        -- From ethereal:bush
        type = "fuel",
        recipe = "unilib:bush_oriental",
        burntime = 1,
    })

    unilib.register_decoration_generic("ethereal_bush_oriental", {
        -- From ethereal-ng/schems.lua
        deco_type = "schematic",
        schematic = unilib.core.path_mod .. "/mts/unilib_bush_oriental.mts",

        fill_ratio = 0.08,
        flags = "place_center_x, place_center_z",
        sidelen = 80,
    })

end
