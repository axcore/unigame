---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary_with_coral = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.australia.add_mode

local init_list = {
    {"brain", "unilib:coral_brain"},
    {"cauliflower_brown", "unilib:coral_cauliflower_brown"},
    {"cauliflower_green", "unilib:coral_cauliflower_green"},
    {"cauliflower_pink", "unilib:coral_cauliflower_pink"},
    {"cluster_green", "unilib:coral_cluster_green"},
    {"cluster_orange", "unilib:coral_cluster_orange"},
    {"cluster_purple", "unilib:coral_cluster_purple"},
    {"hammer", "unilib:coral_hammer"},
    {"seafan_white", "unilib:coral_seafan_white"},
    {"staghorn_blue", "unilib:coral_staghorn_blue"},
    {"staghorn_pink", "unilib:coral_staghorn_pink"},
    {"staghorn_purple", "unilib:coral_staghorn_purple"},
    {"staghorn_yellow", "unilib:coral_staghorn_yellow"},
    {"tube_sponge", "unilib:plant_sponge_tube"},
}

local part_list = {}
local stone_list = {}
local convert_table = {}
for _, mini_list in ipairs(init_list) do

    local part_name = mini_list[1]
    local stone_name = "unilib:stone_ordinary_with_coral_" .. part_name
    local coral_name = mini_list[2]

    table.insert(part_list, part_name)
    table.insert(stone_list, stone_name)
    convert_table[stone_name] = coral_name

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary_with_coral.init()

    return {
        description = "Ordinary stone with coral",
        notes = "All corals spawned by this package heal nearby objects, for example players",
        depends = "liquid_water_ordinary",
        at_least_one = {
            "coral_brain",
            "coral_cauliflower_brown",
            "coral_cauliflower_green",
            "coral_cauliflower_pink",
            "coral_cluster_green",
            "coral_cluster_orange",
            "coral_cluster_purple",
            "coral_hammer",
            "coral_seafan_white",
            "coral_staghorn_blue",
            "coral_staghorn_pink",
            "coral_staghorn_purple",
            "coral_staghorn_yellow",
            "plant_sponge_tube",
        },
    }

end

function unilib.pkg.stone_ordinary_with_coral.exec()

    for _, part_name in ipairs(part_list) do

        unilib.register_node(
            -- From australia:coral_stone_brain, etc. Creates
            --      unilib:stone_ordinary_with_coral_brain, etc
            "unilib:stone_ordinary_with_coral_" .. part_name,
            "australia:coral_stone_" .. part_name,
            mode,
            {
                description = S("Ordinary Stone with Coral"),
                tiles = {"unilib_stone_ordinary_with_coral.png"},
                groups = {cracky = 3, not_in_creative_inventory = 1, stone = 1},
                sounds = unilib.global.sound_table.stone,

                drop = "unilib:stone_ordinary",
            }
        )

    end

    -- (Spawn on suitable stone)
    unilib.register_abm({
        -- From australia:coral_stone_brain, etc
        label = "Spawn coral on stone [stone_ordinary_with_coral]",
        nodenames = stone_list,

        chance = 5,
        interval = 15,

        action = function(pos, node)

            local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
            if core.get_node(yp).name == "unilib:liquid_water_ordinary_source" then

                pos.y = pos.y + 1
                core.add_node(pos, {name = convert_table[node.name]})

            else

                return

            end

        end
    })

    -- (Heal nearby objects, for example players)
    unilib.register_abm({
        -- From australia:coral_stone_brain, etc
        label = "Heal near coral [stone_ordinary_with_coral]",
        nodenames = {"group:coral"},

        chance = 1,
        interval = 3,

        action = function(pos)

            local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
            local yyp = {x = pos.x, y = pos.y + 2, z = pos.z}

            if core.get_node(yp).name == "unilib:liquid_water_ordinary_source" and
                    core.get_node(yyp).name == "unilib:liquid_water_ordinary_source" then

                local objs = core.get_objects_inside_radius(pos, 2)
                for k, obj in pairs(objs) do
                    obj:set_hp(obj:get_hp() + 1)
                end

            else

                return

            end

        end,
    })

end
