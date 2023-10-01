---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decorations_sea
-- Code:    GPLv3
-- Media:   CC BY 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_seashell_spiral = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.decorations_sea.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_seashell_spiral.init()

    return {
        description = "Spiral seashell",
        depends = "shared_decorations_sea",
    }

end

function unilib.pkg.misc_seashell_spiral.exec()

    unilib.pkg.shared_decorations_sea.register_sand_item({
        -- From decorations_sea:seashell_01, etc. Creates unilib:misc_seashell_spiral, etc
        part_name = "seashell_spiral",
        sand_orig_name = "decorations_sea:seashell_01_node",
        shell_orig_name = "decorations_sea:seashell_01",

        replace_mode = mode,
        sand_description = S("Spiral Seashell in Sand"),
        shell_description = S("Spiral Seashell"),
    })

    -- From decorations_sea/mapgen.lua
    unilib.pkg.shared_decorations_sea.register_sand_decoration("misc_seashell_spiral", 1, 0.01)
    unilib.pkg.shared_decorations_sea.register_sand_decoration("misc_seashell_spiral", 2, 0.002)

end
