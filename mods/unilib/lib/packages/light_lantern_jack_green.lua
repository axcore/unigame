---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.light_lantern_jack_green = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_lantern_jack_green.init()

    return {
        description = "Green Jack 'O Lantern",
        depends = {"plant_watermelon_wild", "torch_ordinary"},
    }

end

function unilib.pkg.light_lantern_jack_green.exec()

    unilib.register_node(
        -- From cropocalypse:carved_watermelon
        "unilib:light_lantern_jack_green_off",
        "cropocalypse:carved_watermelon",
        mode,
        {
            description = unilib.utils.hint(
                S("Green Jack 'O Lantern"), S("punch to turn on and off")
            ),
            tiles = {
                "unilib_plant_watermelon_wild_top.png",
                "unilib_plant_watermelon_wild_top.png",
                "unilib_plant_watermelon_wild.png",
                "unilib_plant_watermelon_wild.png",
                "unilib_plant_watermelon_wild.png",
                "unilib_light_lantern_jack_green_off.png",
            },
            groups = {choppy = 2, flammable = 1, oddly_breakable_by_hand = 2, watermelon = 1},
            sounds = unilib.global.sound_table.wood,

            is_ground_content = false,
            node_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
                },
            },
            paramtype2 = "facedir",

            -- N.B. .on_punch() not in original code
            on_punch = function(pos, node, puncher)

                local name = puncher:get_player_name() or ""
                if core.is_protected(pos, name) then
                    return
                end

                node.name = "unilib:light_lantern_jack_green_on"
                core.swap_node(pos, node)

            end,
        }
    )
    unilib.register_craft({
        -- Original to unilib, replacing the original recipe to match the one in the
        --      "light_lantern_jack_yellow" pacakage
        output = "unilib:light_lantern_jack_green_off",
        recipe = {
            {"unilib:torch_ordinary"},
            {"unilib:plant_watermelon_wild"},
        },
    })

    unilib.register_node(
        -- From cropocalypse:jack_o_lantern
        "unilib:light_lantern_jack_green_on",
        "cropocalypse:jack_o_lantern",
        mode,
        {
            description = unilib.utils.hint(
                S("Green Jack 'O Lantern"), S("punch to turn on and off")
            ),
            tiles = {
                "unilib_plant_watermelon_wild_top.png",
                "unilib_plant_watermelon_wild_top.png",
                "unilib_plant_watermelon_wild.png",
                "unilib_plant_watermelon_wild.png",
                "unilib_plant_watermelon_wild.png",
                "unilib_light_lantern_jack_green_on.png",
            },
            -- N.B. not_in_creative_inventory = 1 not in original code
            groups = {
                choppy = 2, flammable = 1, not_in_creative_inventory = 1,
                oddly_breakable_by_hand = 2, watermelon = 1,
            },
            sounds = unilib.global.sound_table.wood,

            is_ground_content = false,
            light_source = 11,
            node_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
                },
            },
            paramtype2 = "facedir",

            -- N.B. .on_punch() not in original code
            on_punch = function(pos, node, puncher)

                local name = puncher:get_player_name() or ""
                if core.is_protected(pos, name) then
                    return
                end

                node.name = "unilib:light_lantern_jack_green_off"
                core.swap_node(pos, node)

            end,
        }
    )

end
