---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_sheet_glow = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_sheet_glow.init()

    return {
        description = "Glow glass sheet",
        depends = {"pane_glass_glow", "shared_glass_stained"},
    }

end

function unilib.pkg.glass_sheet_glow.exec()

    unilib.pkg.shared_glass_stained.register_sheet({
        -- Original to unilib. Creates unilib:glass_sheet_glow_single, etc
        part_name = "glass_sheet_glow",
        orig_name = nil,
        description = S("Glow Glass Sheet"),

        replace_mode = mode,
        craft_output = 4,
        craft_table = {
            {"unilib:pane_glass_glow_flat", "unilib:pane_glass_glow_flat"},
            {"unilib:pane_glass_glow_flat", "unilib:pane_glass_glow_flat"},
        },
        edge_img = "unilib_pane_glass_ordinary_edge.png^[colorize:#E9CD61",
        front_img = "unilib_glass_ordinary.png^[colorize:#E9CD61",
        sound_type = "glass",
    })

end
