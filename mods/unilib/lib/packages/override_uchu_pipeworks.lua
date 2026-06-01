---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    quartzmese
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.override_uchu_pipeworks = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.quartzmese.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.override_uchu_pipeworks.init()

    return {
        description = "Override craft recipes for various items from pipeworks",
        -- N.B. This package replaces recipes using items from digilines and homedecor, but we won't
        --      require those mods/modpacks; nothing bad happens if they're absent
        mod_depends = "pipeworks",
        depends = "mineral_quartz_white",
    }

end

function unilib.pkg.override_uchu_pipeworks.exec()

    local c_quartz = "unilib:mineral_quartz_white_crystal"
    local c_sheeting = "homedecor:plastic_sheeting"
    local c_wire = "digilines:wire_std_00000000"

    unilib.register_craft( {
        output = "pipeworks:detector_tube_off_1 0",
        recipe = {
            {c_sheeting, c_sheeting, c_sheeting},
            {"mesecons:mesecon", "mesecons_materials:silicon", "mesecons:mesecon"},
            {c_sheeting, c_sheeting, c_sheeting},
        },
    })
    unilib.register_craft( {
        output = "pipeworks:detector_tube_off_1 2",
        recipe = {
            {c_sheeting, c_sheeting, c_sheeting},
            {"mesecons:mesecon", c_quartz, "mesecons:mesecon"},
            {c_sheeting, c_sheeting, c_sheeting},
        },
    })

    unilib.register_craft( {
        output = "pipeworks:digiline_detector_tube_1 0",
        recipe = {
            {c_sheeting, c_sheeting, c_sheeting},
            {c_wire, "mesecons_materials:silicon", c_wire},
            {c_sheeting, c_sheeting, c_sheeting},
        },
    })
    unilib.register_craft( {
        output = "pipeworks:digiline_detector_tube_1 2",
        recipe = {
            {c_sheeting, c_sheeting, c_sheeting},
            {c_wire, c_quartz, c_wire},
            {c_sheeting, c_sheeting, c_sheeting},
        },
    })

end
