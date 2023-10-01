---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_construction = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.earthbuild.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_construction.init()

    return {
        description = "Construction dirts",
        notes = "Use a turf cutter to slice off the turf layer from compatible dirt blocks. The" ..
                " grass roots retain their strength, so can be used in construction",
        optional = "dirt_ordinary",
    }

end

function unilib.pkg.dirt_construction.exec()

    if unilib.pkg_executed_table["dirt_ordinary"] ~= nil then

        -- Original mod behaviour: the turf cutter works with only one dirt-with-turf node
        unilib.register_node("unilib:dirt_construction_with_turf", "earthbuild:turf", mode, {
            -- From earthbuild:turf
            description = unilib.brackets(S("Construction Dirt"), S("Turf")),
            tiles = {
                "unilib_turf_ordinary_top.png",
                "unilib_dirt_compacted.png",
                "unilib_dirt_construction.png",
                "unilib_dirt_construction.png",
                "unilib_dirt_construction.png",
                "unilib_dirt_construction.png",
            },
            groups = {crumbly = 2, falling_node = 1},
            sounds = unilib.sound_table.dirt,

            drawtype = "normal",
            paramtype = "light",
        })
        unilib.register_stairs("unilib:dirt_construction_with_turf", {
            basic_flag = true,
        })

    end

end

function unilib.pkg.dirt_construction.post()

    if unilib.earthbuild_extend_cutter_flag then

        -- Add compatibility with other "fertile" dirts
        for fertile_name, data_table in pairs(unilib.dirt_with_turf_table) do

            local construction_name = "unilib:dirt_construction_with_" ..
                    data_table.turf_part_name

            -- (Avoid duplicate turfs on different bare dirts, e.g. those created by various GLEM
            --      packages)
            if minetest.registered_nodes[construction_name] == nil and
                    fertile_name ~= "unilib:dirt_ordinary_with_turf" then

                local turf_name = "unilib:" .. data_table.dirt_part_name .. "_with_" ..
                        data_table.turf_part_name
                local turf_def_table = minetest.registered_nodes[turf_name]

                unilib.register_node(construction_name, nil, mode, {
                    -- Original to unilib
                    description = unilib.brackets(
                        S("Construction Dirt"), data_table.turf_description
                    ),
                    tiles = {
                        turf_def_table.tiles[1],
                        "unilib_dirt_compacted.png",
                        "unilib_dirt_construction.png",
                        "unilib_dirt_construction.png",
                        "unilib_dirt_construction.png",
                        "unilib_dirt_construction.png",
                    },
                    groups = {crumbly = 2, falling_node = 1},
                    sounds = unilib.sound_table.dirt,

                    drawtype = "normal",
                    paramtype = "light",
                })
                unilib.register_stairs(construction_name, {
                    basic_flag = true,
                })

            end

        end

    end

end
