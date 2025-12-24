---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_shelter_kennel = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_shelter_kennel.init()

    return {
        description = "Dog kennel",
        notes = "A structure that protects dogs from Tamagotchi Mode influences (for example," ..
                " while your character is far away from their base). Place the kennel by" ..
                " punching the ground with the kennel craftitem. If shelter placement has been" ..
                " disabled in settings, then only the constituent blocks, not the craftitem" ..
                " used to place kennels, will be available in the game. Note that other kinds of" ..
                " creature can be housed in cages",
        depends = "dye_basic",
    }

end

function unilib.pkg.misc_shelter_kennel.exec()

    unilib.register_node("unilib:misc_shelter_kennel_roof", "petz:red_gables", mode, {
        -- From petz:red_gables
        description = S("Dog Kennel Roof"),
        tiles = {"unilib_misc_shelter_kennel_roof.png"},
        groups = {choppy = 2, stone = 1},
        sounds = unilib.global.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_stairs("unilib:misc_shelter_kennel_roof", {
        basic_flag = true,
    })

    unilib.register_node(
        -- From petz:blue_stained_wood
        "unilib:misc_shelter_kennel_wall",
        "petz:blue_stained_wood",
        mode,
        {
            description = S("Dog Kennel Wall"),
            tiles = {"unilib_misc_shelter_kennel_wall.png"},
            groups = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 1, wood = 1},
            sounds = unilib.global.sound_table.wood,

            is_ground_content = false,
        }
    )
    unilib.register_stairs("unilib:misc_shelter_kennel_wall", {
        basic_flag = true,
    })

    unilib.register_node("unilib:misc_shelter_kennel_floor", "petz:yellow_paving", mode, {
        -- From petz:yellow_paving
        description = S("Dog Kennel Floor"),
        tiles = {"unilib_misc_shelter_kennel_floor.png"},
        groups = {cracky = 2, stone = 1},
        sounds = unilib.global.sound_table.stone,

        is_ground_content = false,
    })

    if not unimobs.petz_setting.disable_shelter_placement_flag then

        unilib.register_craftitem("unilib:misc_shelter_kennel", "petz:kennel", mode, {
            -- From petz:kennel
            description = S("Dog Kennel"),
            inventory_image = "unilib_misc_shelter_kennel.png",
            groups = {},

            wield_image = "unilib_misc_shelter_kennel.png",

            on_use = function (itemstack, user, pointed_thing)

                if pointed_thing.type ~= "node" then
                    return
                end

                local pos_above = pointed_thing.above
                -- N.B. Offsets in original code were x + 3, y + 5, z + 4
                local pos_corner = {x = pos_above.x + 4, y = pos_above.y + 5, z = pos_above.z + 3}
                local pname = user:get_player_name()

                if not core.is_area_protected(pos_above, pos_corner, pname, 4) then

                    core.place_schematic(
                        pos_above,
                        unimobs.path_mod .. "/mts/unilib_misc_shelter_kennel.mts",
                        -- N.B. Replaced incorrect numeric value in original code
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
            -- From petz:kennel
            type = "shaped",
            output = "unilib:misc_shelter_kennel",
            recipe = {
                {"group:wood", "unilib:dye_red", "group:wood"},
                {"group:wood", "unilib:dye_blue", "group:wood"},
                {"group:stone", "unilib:dye_yellow", "group:stone"},
            },
        })

    end

end
