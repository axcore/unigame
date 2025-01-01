---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_matrix_gaia = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_matrix_gaia.init()

    return {
        description = "Matrix stones (used by the \"gaia\" remix to place strata at high" ..
                " altitudes)",
    }

end

function unilib.pkg.misc_matrix_gaia.exec()

    -- N.B. Although most matrix stones are successfully replaced, Minetest draws dungeons using the
    --      matrix nodes; therefore we disguise them as the surrounding material, and switch them
    --      for that material when punched

    -- Used by the "ore_gaia_hot_arid" package
    unilib.register_matrix_stone("unilib:misc_matrix_gaia_hot", nil, mode, {
        -- Original to unilib, adapted from underch:bulk
        description = S("Hot Mysterious Stone"),
        tiles = {"unilib_clay_baked_orange.png"},
        groups = {not_in_creative_inventory = 1},
        -- (no sounds)

        drop = {},
        diggable = false,

        on_punch = function(pos, node, puncher, pointed_thing)
            core.set_node(pos, {name = "unilib:clay_baked_orange"})
        end,
    })

    -- Used by the "ore_gaia_mild_arid" package
    unilib.register_matrix_stone("unilib:misc_matrix_gaia_mild", nil, mode, {
        -- Original to unilib, adapted from underch:bulk
        description = S("Mild Mysterious Stone"),
        tiles = {"unilib_gravel_sandstone_golden.png"},
        groups = {not_in_creative_inventory = 1},
        -- (no sounds)

        drop = {},
        diggable = false,

        on_punch = function(pos, node, puncher, pointed_thing)
            core.set_node(pos, {name = "unilib:gravel_sandstone_golden"})
        end,
    })

end
