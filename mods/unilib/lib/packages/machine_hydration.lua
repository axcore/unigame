---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    thirsty
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.machine_hydration = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.thirsty.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.machine_hydration.init()

    return {
        description = "Hydration machines",
        notes = "Fills the hydration of any nearby player, as if they were standing in water." ..
                " Checks all nodes in a 5-node-high pyramid starting one node above itself," ..
                " counting all water nodes (source and flowing), and also counting other" ..
                " hydration machines and extenders. The smaller count is used to set the" ..
                " machine's range (minimum 5 nodes, maximum 100 nodes) - in other words," ..
                " you need an equal number of water nodes and machines. The recommended" ..
                " arrangement is water above and extenders below",
        depends = {"metal_copper", "mineral_mese"},
    }

end

function unilib.pkg.machine_hydration.exec()

    unilib.register_node("unilib:machine_hydration", "thirsty:water_fountain", mode, {
        -- From thirsty:water_fountain
        description = S("Hydration Machine"),
        tiles = {
            "unilib_machine_hydration_top.png",
            "unilib_machine_hydration_top.png",
            "unilib_machine_hydration_side.png",
            "unilib_machine_hydration_side.png",
            "unilib_machine_hydration_side.png",
            "unilib_machine_hydration_side.png",
        },
        groups = {cracky = 2},
        -- (no sounds)

        paramtype = "light",
    })

    unilib.register_node("unilib:machine_hydration_extender", "thirsty:water_extender", mode, {
        -- From thirsty:water_extender
        description = S("Hydration Machine Extender"),
        tiles = {
            "unilib_machine_hydration_extender_top.png",
            "unilib_machine_hydration_extender_top.png",
            "unilib_machine_hydration_extender_side.png",
            "unilib_machine_hydration_extender_side.png",
            "unilib_machine_hydration_extender_side.png",
            "unilib_machine_hydration_extender_side.png",
        },
        groups = {cracky = 2},
        -- (no sounds)

        paramtype = "light",
    })

    unilib.register_abm({
        label = "Hydration machine [machine_hydration]",
        nodenames = {"unilib:machine_hydration"},
        interval = 2,
        chance = 5,

        action = unilib.hydration_fountain_abm,
    })

end

function unilib.pkg.machine_hydration.post()

    local c_ingot = "unilib:metal_copper_ingot"

    unilib.register_craft({
        -- From thirsty:water_fountain
        output = "unilib:machine_hydration",
        recipe = {
            {c_ingot, "group:potable_bucket", c_ingot},
            {"", c_ingot, ""},
            {c_ingot, "unilib:mineral_mese_crystal", c_ingot},
        },
    })

    unilib.register_craft({
        -- From thirsty:water_extender
        output = "unilib:machine_hydration_extender",
        recipe = {
            {"", "group:potable_bucket", ""},
            {"", c_ingot, ""},
            {c_ingot, "unilib:mineral_mese_crystal", c_ingot},
        },
    })

end
