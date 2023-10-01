---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nbea
-- Code:    WTFPL
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.light_lantern_steel = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.nbea.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_lantern_steel.init()

    return {
        description = "Steel-framed lantern",
        notes = "Acts as an always-on signal in a mesecons circuit",
        depends = {"metal_steel", "mineral_mese"},
    }

end

function unilib.pkg.light_lantern_steel.exec()

    local c_ingot = "unilib:metal_steel_ingot"

    unilib.register_node("unilib:light_lantern_steel", "nbea:nbox_004", mode, {
        -- From nbea:nbox_004
        description = S("Steel-Framed Lantern"),
        tiles = {"unilib_light_block_mese.png"},
        groups = {cracky = 3},
        sounds = unilib.node_sound_metal_defaults({
            footstep = {name = "unilib_glass_footstep", gain = 0.5},
            dug = {name = "unilib_break_glass", gain = 1.0},
        }),

        drawtype = "nodebox",
        is_ground_content = false,
        light_source = 13,
        node_box = {
            type = "fixed",
            fixed = {
                -- Corner frame
                {-0.5, 0.4375, -0.4375, -0.4375, 0.5, 0.4375},
                {-0.5, -0.5, -0.4375, -0.4375, -0.4375, 0.4375},
                {-0.5, -0.5, -0.5, -0.4375, 0.5, -0.4375},
                {-0.5, -0.5, 0.4375, -0.4375, 0.5, 0.5},
                {-0.4375, 0.4375, -0.5, 0.4375, 0.5, -0.4375},
                {-0.4375, -0.5, -0.5, 0.4375, -0.4375, -0.4375},
                {-0.4375, 0.4375, 0.4375, 0.4375, 0.5, 0.5},
                {-0.4375, -0.5, 0.4375, 0.4375, -0.4375, 0.5},
                {0.4375, 0.4375, -0.5, 0.5, 0.5, 0.5},
                {0.4375, -0.5, -0.5, 0.5, -0.4375, 0.5},
                {0.4375, -0.4375, 0.4375, 0.5, 0.4375, 0.5},
                {0.4375, -0.4375, -0.5, 0.5, 0.4375, -0.4375},
                -- Centre-mass 14px
                {-0.4375, -0.4375, -0.4375, 0.4375, 0.4375, 0.4375},
            },
        },
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            },
        },
        sunlight_propagates = true,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:light_lantern_steel 2",
        recipe = {
            {c_ingot, c_ingot, c_ingot},
            {c_ingot, "unilib:unilib:mineral_mese_block", c_ingot},
            {c_ingot, c_ingot, c_ingot},
        },
    })

    if minetest.get_modpath("mesecons") then

        unilib.override_item("unilib:light_lantern_steel", {
            groups = {cracky = 1, mesecon = 1},

            mesecons = {
                receptor = {
                    state = mesecon.state.on,
                },
            },
        })

    end

end
