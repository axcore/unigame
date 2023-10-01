---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_moretrees = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moretrees.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_moretrees.grow_ltree(pos, part_name)

    -- Called to grow L-system trees
    -- Set up in each individual package's unilib.register_decoration_convertable() function
    --
    -- Args:
    --      pos (table): e.g. {x = 1, y = 1, z = 1}
    --      part_name (str): e.g. "tree_beech_common", matching the generic decoration name
    --          "convert_tree_beech_common"

    unilib.grow_tree_sapling(pos, "unilib:" .. part_name .. "_sapling")

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_moretrees.init()

    return {
        description = "Shared functions for L-system trees (from moretrees mod)",
    }

end
