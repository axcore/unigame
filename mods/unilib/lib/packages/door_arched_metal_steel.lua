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

unilib.pkg.door_arched_metal_steel = {}

local S = unilib.intllib
local mode_1 = unilib.global.imported_mod_table.pkarcs_doors.add_mode
local mode_3 = unilib.global.imported_mod_table.pkarcs_doors3.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_arched_metal_steel.init()

    return {
        description = "Steel arched doors",
        depends = {"shared_pkarcs", "metal_steel"},
    }

end

function unilib.pkg.door_arched_metal_steel.exec()

    unilib.pkg.shared_pkarcs.register_arched_door({
        -- From pkarcs_doors:steel_Ldoor, etc. Provides
        --      unilib:door_arched_metal_steel_left_closed, etc
        part_name = "metal_steel",
        orig_name = "steel",
        img_list = {name = "unilib_door_arched_metal_steel.png", backface_culling = true},
        ingredient = "unilib:metal_steel_block",

        replace_mode = mode_1,
        description = S("Steel Arched Door"),
        group_table = {cracky = 1, door = 1, level = 2},
        open_sound = "unilib_steel_door",
        sound_type = "metal",
    })

    unilib.pkg.shared_pkarcs.register_tall_arched_door({
        -- From pkarcs_doors3:steel_Ldoor, etc. Provides
        --      unilib:door_arched_metal_steel_tall_left_closed, etc
        part_name = "metal_steel",
        orig_name = "steel",
        img_list = {name = "unilib_door_arched_metal_steel_tall.png", backface_culling = true},
        ingredient = "unilib:metal_steel_block",

        replace_mode = mode_3,
        description = S("Tall Steel Arched Door"),
        group_table = {cracky = 1, door = 1, level = 2},
        open_sound = "unilib_steel_door",
        sound_type = "metal",
    })

end
