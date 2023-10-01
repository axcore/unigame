---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decorations_sea
-- Code:    GPLv3
-- Media:   CC BY 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_seashell_auger = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.decorations_sea.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_seashell_auger.init()

    return {
        description = "Auger seashell",
        depends = "shared_decorations_sea",
    }

end

function unilib.pkg.misc_seashell_auger.exec()

    unilib.pkg.shared_decorations_sea.register_sand_item({
        -- From decorations_sea:seashell_03, etc. Creates unilib:misc_seashell_auger, etc
        part_name = "seashell_auger",
        sand_orig_name = "decorations_sea:seashell_03_node",
        shell_orig_name = "decorations_sea:seashell_03",

        replace_mode = mode,
        sand_description = S("Auger Seashell in Sand"),
        shell_description = S("Auger Seashell"),
    })

    -- From decorations_sea/mapgen.lua
    unilib.pkg.shared_decorations_sea.register_sand_decoration("misc_seashell_auger", 1, 0.01)
    unilib.pkg.shared_decorations_sea.register_sand_decoration("misc_seashell_auger", 2, 0.002)

end
