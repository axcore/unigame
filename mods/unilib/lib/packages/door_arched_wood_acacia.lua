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

unilib.pkg.door_arched_wood_acacia = {}

local S = unilib.intllib
local mode_1 = unilib.imported_mod_table.pkarcs_doors.add_mode
local mode_3 = unilib.imported_mod_table.pkarcs_doors3.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_arched_wood_acacia.init()

    return {
        description = "Acacia wood arched doors",
        depends = {"shared_pkarcs", "tree_acacia"},
    }

end

function unilib.pkg.door_arched_wood_acacia.exec()

    unilib.pkg.shared_pkarcs.register_arched_door({
        -- From pkarcs_doors:acacia_wood_Ldoor, etc. Provides
        --      unilib:door_arched_wood_acacia_left_closed, etc
        part_name = "wood_acacia",
        orig_name = "acacia_wood",
        img_list = {name = "unilib_door_arched_wood_acacia.png", backface_culling = true},
        ingredient = "unilib:tree_acacia_wood",

        replace_mode = mode_1,
        description = S("Acacia Wood Arched Door"),
        group_table = {choppy = 2, door = 1},
        open_sound = "unilib_door",
        sound_type = "wood",
    })

    unilib.pkg.shared_pkarcs.register_tall_arched_door({
        -- From pkarcs_doors3:acacia_wood_Ldoor, etc. Provides
        --      unilib:door_arched_wood_acacia_tall_left_closed, etc
        part_name = "wood_acacia",
        orig_name = "acacia_wood",
        img_list = {name = "unilib_door_arched_wood_acacia_tall.png", backface_culling = true},
        ingredient = "unilib:tree_acacia_wood",

        replace_mode = mode_3,
        description = S("Tall Acacia Wood Arched Door"),
        group_table = {choppy = 2, door = 1},
        open_sound = "unilib_door",
        sound_type = "wood",
    })

end
