---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_sheet_clean = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_sheet_clean.init()

    return {
        description = "Clean glass sheet",
        depends = {"pane_glass_clean", "shared_glass_stained"},
    }

end

function unilib.pkg.glass_sheet_clean.exec()

    unilib.pkg.shared_glass_stained.register_sheet({
        -- Original to unilib. Creates unilib:glass_sheet_clean_single, etc
        part_name = "glass_sheet_clean",
        orig_name = nil,
        description = S("Clean Glass Sheet"),

        replace_mode = mode,
        craft_output = 4,
        craft_table = {
            {"unilib:pane_glass_clean_flat", "unilib:pane_glass_clean_flat"},
            {"unilib:pane_glass_clean_flat", "unilib:pane_glass_clean_flat"},
        },
        edge_img = "unilib_pane_glass_ordinary_edge.png",
        front_img = "unilib_glass_clean.png",
        sound_type = "glass",
    })

end
