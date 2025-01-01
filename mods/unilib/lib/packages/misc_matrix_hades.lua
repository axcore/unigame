---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_matrix_hades = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_matrix_hades.do_blob_matrix(index)

    local full_name = "unilib:misc_matrix_hades_blob_" .. index

    unilib.register_matrix_stone("unilib:misc_matrix_hades_blob_" .. index, nil, mode, {
        -- Original to unilib, adapted from underch:bulk. Creates "unilib:misc_matrix_hades_blob_1",
        --      etc
        description = S("Slightly Mysterious Stone"),
        tiles = {"unilib_stone_ordinary.png"},
        groups = {not_in_creative_inventory = 1},
        -- (no sounds)

        drop = {},
        diggable = false,

        on_punch = function(pos, node, puncher, pointed_thing)
            core.set_node(pos, {name = "unilib:stone_ordinary"})
        end,
    })

    return full_name

end

function unilib.pkg.misc_matrix_hades.do_scatter_matrix(index)

    local full_name = "unilib:misc_matrix_hades_scatter_" .. index

    unilib.register_matrix_stone(full_name, nil, mode, {
        -- Original to unilib, adapted from underch:bulk. Creates
        --      "unilib:misc_matrix_hades_scatter_1", etc
        description = S("Somewhat Mysterious Stone"),
        tiles = {"unilib_stone_ordinary.png"},
        groups = {not_in_creative_inventory = 1},
        -- (no sounds)

        drop = {},
        diggable = false,

        on_punch = function(pos, node, puncher, pointed_thing)
            core.set_node(pos, {name = "unilib:stone_ordinary"})
        end,
    })

    return full_name

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_matrix_hades.init()

    return {
        description = "Matrix stones (used by the \"hades\" remix to place different ores in" ..
                " different biomes)",
    }

end
