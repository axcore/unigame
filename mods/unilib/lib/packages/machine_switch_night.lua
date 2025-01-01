---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.machine_switch_night = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.machine_switch_night.init()

    return {
        description = "Night-switching machine",
        depends = {"metal_copper", "metal_tin", "mineral_diamond"},
    }

end

function unilib.pkg.machine_switch_night.exec()

    unilib.register_node("unilib:machine_switch_night", nil, mode, {
        -- Original to unilib
        description = unilib.utils.brackets(
            S("Night-Switching Machine"), S("right-click to change the time")
        ),
        tiles = {
            "unilib_machine_switch_night_off.png",
            "unilib_machine_switch_night_bottom.png",
            "unilib_machine_switch_night_side.png",
        },
        groups = {oddly_breakable_by_hand = 3},
        sounds = unilib.global.sound_table.metal,

        drawtype = "nodebox",
        is_ground_content = false,
        light_source = 3,
        node_box = {
            type = "fixed",
            fixed = {
                {-8/16, -8/16, -8/16, 8/16, 7/16, 8/16},    -- Main box
                {-5/16, 6/16, -3/16, 5/16, 8/16, 3/16},     -- Button
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        use_texture_alpha = "clip",

        on_rightclick = function(pos, node)

            core.swap_node(pos, {name = "unilib:machine_switch_night_on", param2 = node.param2})
            core.sound_play("unilib_misc_bin_skip", {pos = pos}, true)
            core.get_node_timer(pos):start(2)

            -- 19:12 (matches the unilib chat command /dusk)
            core.set_timeofday(0.8)

        end,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:machine_switch_night",
        recipe = {
            {"", "unilib:metal_copper_ingot", ""},
            {"unilib:metal_tin_ingot", "unilib:mineral_diamond_block", "unilib:metal_tin_ingot"},
            {"unilib:metal_tin_ingot", "unilib:metal_tin_ingot", "unilib:metal_tin_ingot"},
        },
    })

    unilib.register_node("unilib:machine_switch_night_on", nil, mode, {
        -- Original to unilib
        description = unilib.utils.brackets(
            S("Night-Switching Machine"), S("right-click to change the time")
        ),
        tiles = {
            "unilib_machine_switch_night_on.png",
            "unilib_machine_switch_night_bottom.png",
            "unilib_machine_switch_night_side.png",
        },
        groups = {not_in_creative_inventory = 1, oddly_breakable_by_hand = 3},
        sounds = unilib.global.sound_table.metal,

        drawtype = "nodebox",
        is_ground_content = false,
        light_source = 7,
        node_box = {
            type = "fixed",
            fixed = {
                {-8/16, -8/16, -8/16, 8/16, 7/16, 8/16},    -- Main box
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        use_texture_alpha = "clip",

        on_timer = function(pos)

            local node = core.get_node(pos)
            if node.name ~= "unilib:machine_switch_night_on" then

                -- Node was dug, since the button was pressed
                return

            end

            core.swap_node(pos, {name = "unilib:machine_switch_night", param2 = node.param2})

        end
    })

end
