---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    glass_stained
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_sheet_obsidian = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glass_stained.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_sheet_obsidian.init()

    return {
        description = "Obsidian glass sheet",
        depends = {"pane_glass_obsidian", "shared_glass_stained"},
    }

end

function unilib.pkg.glass_sheet_obsidian.exec()

    unilib.pkg.shared_glass_stained.register_sheet({
        -- From stained_glass, glass_stained:pane_obsidian_glass_single, etc. Creates
        --      unilib:glass_sheet_obisidian_single, etc
        part_name = "glass_sheet_obsidian",
        orig_name = "glass_stained:pane_obsidian_glass",
        description = S("Obsidian Glass Sheet"),

        replace_mode = mode,
        craft_output = 4,
        craft_table = {
            {"unilib:pane_glass_obsidian_flat", "unilib:pane_glass_obsidian_flat"},
            {"unilib:pane_glass_obsidian_flat", "unilib:pane_glass_obsidian_flat"}
        },
        edge_img = "unilib_pane_glass_obsidian_edge.png",
        front_img = "unilib_glass_obsidian.png",
        sound_type = "glass",
    })

end
