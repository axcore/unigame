---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.machine_noisy = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.machine_noisy.init()

    return {
        description = "Mysterious noisy machine",
        notes = "Generates a humming noise. This package exists to demonstrate how packages can" ..
            " register environment sound effects; the machine itself has no practical purpose" ..
            " (see the \"ambient_forest_light\" package for an example of registering ambient" ..
            " sound effects)",
        depends = {"metal_steel", "metal_tin"},
    }

end

function unilib.pkg.machine_noisy.exec()

    unilib.register_node("unilib:machine_noisy", nil, mode, {
        -- Original to unilib
        description =  S("Mysterious Noisy Machine"),
        tiles = {"unilib_machine_noisy_top.png", "unilib_machine_noisy.png"},
        groups = {cracky = 3},
        sounds = unilib.global.sound_table.metal,

        is_ground_content = false,
        light_source = 2,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:machine_noisy",
        recipe = {
            {"unilib:metal_tin_ingot", "unilib:metal_steel_ingot", "unilib:metal_tin_ingot"},
            {"unilib:metal_tin_ingot", "", "unilib:metal_tin_ingot"},
            {"unilib:metal_tin_ingot", "unilib:metal_steel_ingot", "unilib:metal_tin_ingot"},
        },
    })

    -- The constant hum produced by the machine is implemented with an environment effect (the same
    --      system that generates the sound of flowing water or lava)
    unilib.atmosphere.register_environment("unilib_machine_noisy", {
        sound = "unilib_machine_noisy",
        node_list = {"unilib:machine_noisy"},
        base_volume = 0.04,
        max_volume = 0.4,
        node_volume = 0.004,
    })

end
