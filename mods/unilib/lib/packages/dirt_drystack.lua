---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_drystack = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.earthbuild.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_drystack.init()

    return {
        description = "Drystack dirt",
        notes = "Use a turf cutter to slice off the turf layer from compatible dirt blocks. The" ..
                " grass roots retain their strength, so can be used in construction. Combine" ..
                " construction dirt with drystack to produce this dirt, typically used at the" ..
                " bottom of walls",
        depends = {"decor_stone_drystack", "dirt_construction"},
        optional = "dirt_ordinary",
    }

end

function unilib.pkg.dirt_drystack.exec()

    if unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

        -- Original mod behaviour: the turf cutter works with only one dirt-with-turf node
        unilib.register_node(
            -- From earthbuild:turf_and_drystack
            "unilib:dirt_drystack_with_turf",
            "earthbuild:turf_and_drystack",
            mode,
            {
                description = unilib.brackets(S("Drystack Dirt"), S("Turf")),
                tiles = {
                    "unilib_turf_ordinary_top.png",
                    "unilib_dirt_compacted.png",
                    "unilib_dirt_drystack.png",
                    "unilib_dirt_drystack.png",
                    "unilib_dirt_drystack.png",
                    "unilib_dirt_drystack.png",
                },
                groups = {cracky = 3, crumbly = 1, falling_node = 1, oddly_breakable_by_hand = 1},
                sounds = unilib.sound_table.dirt,

                drawtype = "normal",
                paramtype = "light",
            }
        )
        unilib.register_craft({
            -- From earthbuild:turf_and_drystack
            output = "unilib:dirt_drystack_with_turf 2",
            recipe = {
                {"unilib:dirt_construction_with_turf"},
                {"unilib:decor_stone_drystack"},
            },
        })

    end

end

function unilib.pkg.dirt_drystack.post()

    if unilib.earthbuild_extend_cutter_flag then

        -- Add compatibility with other "fertile" dirts
        for fertile_name, data_table in pairs(unilib.dirt_with_turf_table) do

            local drystack_name = "unilib:dirt_drystack_with_" .. data_table.turf_part_name

            -- (Avoid duplicate turfs on different bare dirts, e.g. those created by various GLEM
            --      packages)
            if minetest.registered_nodes[drystack_name] == nil and
                    fertile_name ~= "unilib:dirt_ordinary_with_turf" then

                local construction_name = "unilib:dirt_construction_with_" ..
                        data_table.turf_part_name
                local turf_name = "unilib:" .. data_table.dirt_part_name .. "_with_" ..
                        data_table.turf_part_name
                local turf_def_table = minetest.registered_nodes[turf_name]

                unilib.register_node(drystack_name, nil, mode, {
                    -- Original to unilib
                    description = unilib.brackets(S("Drystack Dirt"), data_table.turf_description),
                    tiles = {
                        turf_def_table.tiles[1],
                        "unilib_dirt_compacted.png",
                        "unilib_dirt_drystack.png",
                        "unilib_dirt_drystack.png",
                        "unilib_dirt_drystack.png",
                        "unilib_dirt_drystack.png",
                    },
                    groups = {
                        cracky = 3, crumbly = 1, falling_node = 1, oddly_breakable_by_hand = 1,
                    },
                    sounds = unilib.sound_table.dirt,

                    drawtype = "normal",
                    paramtype = "light",
                })
                unilib.register_craft({
                    -- Original to unilib
                    output = drystack_name .. " 2",
                    recipe = {
                        {construction_name},
                        {"unilib:decor_stone_drystack"},
                    },
                })

            end

        end

    end

end
