---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_shelter_cage = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_shelter_cage.init()

    return {
        description = "Animal cage",
        notes = "A structure that protects creatures from Tamagotchi Mode influences (for" ..
                " example, while your character is far away from their base). Place the cage by" ..
                " punching the ground with the cage craftitem. If shelter placement has been" ..
                " disabled in settings, then only the constituent blocks, not the craftitem" ..
                " used to place cages, will be available in the game. Note that dogs can be" ..
                " housed in kennels",
        depends = {"metal_bronze", "metal_steel"},
    }

end

function unilib.pkg.misc_shelter_cage.exec()

    local c_pane = "unilib:pane_cage_bar_flat"

    unilib.register_node("unilib:misc_shelter_cage_roof", nil, mode, {
        -- Original to unimobs
        description = S("Animal Cage Roof"),
        tiles = {"unilib_misc_shelter_cage_roof.png"},
        groups = {cracky = 2, stone = 1},
        sounds = unilib.global.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_stairs("unilib:misc_shelter_cage_roof", {
        basic_flag = true,
    })

    unilib.register_pane({
        -- Original to unimobs. Creates unilib:pane_cage_bar_flat, unilib:pane_cage_bar_crossed
        part_name = "cage_bar",
        orig_name = {nil, nil},
        def_table = {
            description = S("Animal Cage Bars"),
            textures = {"unilib_pane_cage_bar.png", "", "unilib_pane_cage_bar_top.png"},
            groups = {cracky = 2},
            sounds = unilib.global.sound_table.metal,

            inventory_image = "unilib_pane_cage_bar.png",
            recipe = {
                {
                    "unilib:metal_steel_ingot",
                    "unilib:metal_brass_ingot",
                    "unilib:metal_steel_ingot",
                },
                {
                    "unilib:metal_steel_ingot",
                    "unilib:metal_brass_ingot",
                    "unilib:metal_steel_ingot",
                },
            },
            wield_image = "unilib_pane_cage_bar.png",
        },

        replace_mode = mode,
    })

    unilib.register_node("unilib:misc_shelter_cage_floor", "petz:gray_paving_stone", mode, {
        -- From petz:gray_paving_stone
        description = S("Animal Cage Floor"),
        tiles = {"unilib_misc_shelter_cage_floor.png"},
        groups = {cracky = 2, stone = 1},
        sounds = unilib.global.sound_table.stone,

        is_ground_content = false,
    })

    if not unimobs.petz_setting.disable_shelter_placement_flag then

        unilib.register_craftitem("unilib:misc_shelter_cage", nil, mode, {
            -- Original to unimobs, using code based on petz:kennel
            description = S("Animal Cage"),
            inventory_image = "unilib_misc_shelter_cage.png",
            groups = {},

            wield_image = "unilib_misc_shelter_cage.png",

            on_use = function (itemstack, user, pointed_thing)

                if pointed_thing.type ~= "node" then
                    return
                end

                local pos_above = pointed_thing.above
                local pos_corner = {x = pos_above.x + 5, y = pos_above.y + 4, z = pos_above.z + 3}
                local pname = user:get_player_name()

                if not core.is_area_protected(pos_above, pos_corner, pname, 4) then

                    core.place_schematic(
                        pos_above,
                        unimobs.path_mod .. "/mts/unilib_misc_shelter_cage.mts",
                        "0",
                        nil,
                        true
                    )

                    itemstack:take_item()
                    return itemstack

                end

            end,
        })
        unilib.register_craft({
            -- Original to unimobs
            type = "shaped",
            output = "unilib:misc_shelter_cage",
            recipe = {
                {"group:stone", "group:stone", "group:stone"},
                {c_pane, "", c_pane},
                {"group:stone", "group:stone", "group:stone"},
            },
        })

    end

end
