---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pkarcs/pkarcs_doors
-- Code:    LGPL-2.1
-- Media:   CC-BY-SA-4.0
--
-- From:    pkarcs/pkarcs_doors3
-- Code:    LGPL-2.1
-- Media:   CC-BY-SA-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.door_arched_metal_bars = {}

local S = unilib.intllib
local mode_1 = unilib.global.imported_mod_table.pkarcs_doors.add_mode
local mode_3 = unilib.global.imported_mod_table.pkarcs_doors3.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_arched_metal_bars.init()

    return {
        description = "Metal bar arched doors",
        depends = {"shared_pkarcs", "pane_steel_bar"},
    }

end

function unilib.pkg.door_arched_metal_bars.exec()

    unilib.pkg.shared_pkarcs.register_arched_door({
        -- From pkarcs_doors:bar_Ldoor, etc. Provides
        --      unilib:door_arched_metal_bars_left_closed, etc
        part_name = "metal_bars",
        orig_name = "bar",
        img_list = {name = "unilib_door_arched_metal_bars.png", backface_culling = true},
        ingredient = "unilib:pane_steel_bar_flat",

        replace_mode = mode_1,
        description = S("Metal Bar Arched Door"),
        group_table = {cracky = 1, door = 1, level = 2},
        open_sound = "unilib_steel_door",
        sound_type = "metal",
    })

    unilib.pkg.shared_pkarcs.register_tall_arched_door({
        -- From pkarcs_doors3:bar_Ldoor, etc. Provides
        --      unilib:door_arched_metal_bars_tall_left_closed, etc
        part_name = "metal_bars",
        orig_name = "bar",
        img_list = {name = "unilib_door_arched_metal_bars_tall.png", backface_culling = true},
        ingredient = "unilib:pane_steel_bar_flat",

        replace_mode = mode_3,
        description = S("Tall Metal Bar Arched Door"),
        group_table = {cracky = 1, door = 1, level = 2},
        open_sound = "unilib_steel_door",
        sound_type = "metal",
    })

end
