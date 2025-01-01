---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    glass_stained
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_sheet_steel_bar = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glass_stained.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_sheet_steel_bar.init()

    return {
        description = "Decorative steel bar sheet",
        depends = {"pane_steel_bar", "shared_glass_stained"},
    }

end

function unilib.pkg.decor_sheet_steel_bar.exec()

    local c_pane = "unilib:pane_steel_bar_flat"

    unilib.pkg.shared_glass_stained.register_sheet({
        -- From stained_glass, glass_stained:pane_bar_single, etc. Creates
        --      unilib:decor_sheet_steel_bar_single, etc
        part_name = "decor_sheet_steel_bar",
        orig_name = "glass_stained:pane_bar",
        description = S("Decorative Steel Bar Sheet"),

        replace_mode = mode,
        -- N.B. Original craft recipe conflicts with recipe in "trapdoor_steel_bar" package
        --[[
        craft_output = 4,
        craft_table = {
            {"unilib:pane_steel_bar_flat", "unilib:pane_steel_bar_flat"},
            {"unilib:pane_steel_bar_flat", "unilib:pane_steel_bar_flat"},
        },
        ]]--
        craft_output = 6,
        craft_table = {
            {c_pane, c_pane, c_pane},
            {c_pane, c_pane, c_pane},
        },
        edge_img = "unilib_pane_steel_bar_top.png",
        front_img = "unilib_pane_steel_bar.png",
        sound_type = "metal",
    })

end
