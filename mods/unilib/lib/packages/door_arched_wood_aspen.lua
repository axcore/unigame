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

unilib.pkg.door_arched_wood_aspen = {}

local S = unilib.intllib
local mode_1 = unilib.global.imported_mod_table.pkarcs_doors.add_mode
local mode_3 = unilib.global.imported_mod_table.pkarcs_doors3.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_arched_wood_aspen.init()

    return {
        description = "Aspen wood arched doors",
        depends = {"shared_pkarcs", "tree_aspen"},
    }

end

function unilib.pkg.door_arched_wood_aspen.exec()

    unilib.pkg.shared_pkarcs.register_arched_door({
        -- From pkarcs_doors:aspen_wood_Ldoor, etc. Provides
        --      unilib:door_arched_wood_aspen_left_closed, etc
        part_name = "wood_aspen",
        orig_name = "aspen_wood",
        img_list = {name = "unilib_door_arched_wood_aspen.png", backface_culling = true},
        ingredient = "unilib:tree_aspen_wood",

        replace_mode = mode_1,
        description = S("Aspen Wood Arched Door"),
        group_table = {choppy = 2, door = 1},
        open_sound = "unilib_door",
        sound_type = "wood",
    })

    unilib.pkg.shared_pkarcs.register_tall_arched_door({
        -- From pkarcs_doors3:aspen_wood_Ldoor, etc. Provides
        --      unilib:door_arched_wood_aspen_tall_left_closed, etc
        part_name = "wood_aspen",
        orig_name = "aspen_wood",
        img_list = {name = "unilib_door_arched_wood_aspen_tall.png", backface_culling = true},
        ingredient = "unilib:tree_aspen_wood",

        replace_mode = mode_3,
        description = S("Tall Aspen Wood Arched Door"),
        group_table = {choppy = 2, door = 1},
        open_sound = "unilib_door",
        sound_type = "wood",
    })

end
