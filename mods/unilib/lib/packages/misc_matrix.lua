---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_matrix = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.underch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_matrix.init()

    return {
        description = "Matrix stone (used in code imported from the \"experimental\" underch mod)",
    }

end

function unilib.pkg.misc_matrix.exec()

    unilib.register_node("unilib:misc_matrix_bulk", "underch:bulk", mode, {
        -- From underch:bulk
        description = "Very Mysterious Stone",
        tiles = {"unilib_misc_matrix_bulk.png"},
        -- N.B. not_in_creative_inventory not in original code
        groups = {jit_shadow = 1, not_in_creative_inventory = 1},
        -- (no sounds)

        drop = {},
        diggable = false,

        after_dig_node = unilib.jbiome_dig_shadow,

        on_punch = function(pos, node, puncher, pointed_thing)
            unilib.jbiome_reveal(pos, true, false)
        end,
    })

    unilib.register_node("unilib:misc_matrix_crust", "underch:crust", mode, {
        -- From underch:crust
        description = "Mysterious Stone",
        tiles = {"unilib_misc_matrix_crust.png"},
        -- N.B. not_in_creative_inventory not in original code
        groups = {jit_shadow = 1, not_in_creative_inventory = 1},
        -- (no sounds)

        drop = {},
        diggable = false,

        after_dig_node = unilib.jbiome_dig_shadow,

        on_punch = function(pos, node, puncher, pointed_thing)
            unilib.jbiome_reveal(pos, true, false)
        end,
    })

end
