---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.bush_hawthorn = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr11.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.bush_hawthorn.init()

    return {
        description = "Hawthorn bush",
        optional = "item_stick_ordinary",
    }

end

function unilib.pkg.bush_hawthorn.exec()

    local burnlevel = 2
    -- (no sci_name)

    unilib.register_bush_stem({
        -- Original to unilib. Creates unilib:bush_hawthorn_stem
        part_name = "hawthorn",
        orig_name = nil,

        replace_mode = mode,
        common_group = 2,
        description = S("Hawthorn Bush Stem"),
        select_table = {-7 / 16, -0.5, -7 / 16, 7 / 16, 0.5, 7 / 16},
    })
    if unilib.pkg_executed_table["item_stick_ordinary"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:item_stick_ordinary",
            recipe = {
                {"unilib:bush_hawthorn_stem"},
            }
        })

    end
    unilib.register_craft({
        -- Original to unilib
        type = "fuel",
        recipe = "unilib:bush_hawthorn_stem",
        burntime = unilib.bush_burn_table.stem[burnlevel],
    })

    unilib.register_bush_leaves({
        -- Texture from GLEMr11, lib_ecology_bush_hawthorne.png. Original code. Creates
        --      unilib:bush_hawthorne_leaves
        part_name = "hawthorn",
        orig_name = "lib_ecology:bush_hawthorne_leaves",

        replace_mode = mode,
        description = S("Hawthorn Bush Leaves"),
        img_list = {"unilib_bush_hawthorn_leaves.png"},
    })
    unilib.register_quick_bush_leafdecay("hawthorn", 2)

    unilib.register_bush_sapling({
        -- Original to unilib. Creates unilib:bush_hawthorn_sapling
        part_name = "hawthorn",
        orig_name = nil,

        replace_mode = mode,
        common_group = 2,
        description = S("Hawthorn Bush Sapling"),
        max_volume = 2,
        maxp_table = {x = 1, y = 2, z = 1},
        minp_table = {x = -1, y = 1, z = -1},
        schem_list = {
            {"unilib_glem_bush_hawthorn", 1, 1, 1},
        },
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, 2 / 16, 4 / 16},
    })
    unilib.register_craft({
        -- Original to unilib
        type = "fuel",
        recipe = "unilib:bush_hawthorn_sapling",
        burntime = unilib.bush_burn_table.sapling[burnlevel],
    })

    unilib.register_decoration("glem_bush_hawthorn", {
        -- Original to unilib
        deco_type = "schematic",
        schematic = unilib.path_mod .. "/mts/unilib_glem_bush_hawthorn.mts",

        fill_ratio = 0.005,
        flags = "place_center_x, place_center_z",
        rotation = "random",
        sidelen = 80,
    })

end
