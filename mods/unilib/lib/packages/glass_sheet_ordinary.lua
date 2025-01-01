---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    glass_stained
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_sheet_ordinary = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glass_stained.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_sheet_ordinary.init()

    return {
        description = "Ordinary glass sheet",
        depends = {"pane_glass_ordinary", "shared_glass_stained"},
    }

end

function unilib.pkg.glass_sheet_ordinary.exec()

    unilib.pkg.shared_glass_stained.register_sheet({
        -- From stained_glass, glass_stained:pane_glass_single, etc. Creates
        --      unilib:glass_sheet_ordinary_single, etc
        part_name = "glass_sheet_ordinary",
        orig_name = "glass_stained:pane_glass",
        description = S("Ordinary Glass Sheet"),

        replace_mode = mode,
        craft_output = 4,
        craft_table = {
            {"unilib:pane_glass_ordinary_flat", "unilib:pane_glass_ordinary_flat"},
            {"unilib:pane_glass_ordinary_flat", "unilib:pane_glass_ordinary_flat"},
        },
        edge_img = "unilib_pane_glass_ordinary_edge.png",
        front_img = "unilib_glass_ordinary.png",
        sound_type = "glass",
    })

end
