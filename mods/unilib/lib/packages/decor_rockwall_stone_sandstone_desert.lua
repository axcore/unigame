---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
--
-- From:    GLEMr6
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_rockwall_stone_sandstone_desert = {}

local S = unilib.intllib
local glemr4_mode = unilib.global.imported_mod_table.glemr4.add_mode
local glemr6_mode = unilib.global.imported_mod_table.glemr6.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_rockwall_stone_sandstone_desert.init()

    return {
        description = "Rockwall of desert sandstone",
        depends = "stone_sandstone_desert",
        optional = "mineral_coal",
    }

end

function unilib.pkg.decor_rockwall_stone_sandstone_desert.exec()

    local c_stone = "unilib:stone_sandstone_desert"
    -- (Sandstone cobbles may not be available, so any cobble will have to do)
    local c_cobble = "group:cobble"

    unilib.register_node("unilib:decor_rockwall_stone_sandstone_desert", nil, glemr4_mode, {
        -- Adapted from GLEMr4, lib_materials:rockwall_stone
        description = S("Rockwall of Desert Sandstone"),
        tiles = {"unilib_decor_rockwall_stone_sandstone_desert.png"},
        groups = {cracky = 3, level = 2, stone = 1},
        sounds = unilib.global.sound_table.stone,

        drop = "unilib:stone_sandstone_desert",
        is_ground_content = false,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:decor_rockwall_stone_sandstone_desert 9",
        recipe = {
            {c_stone, c_stone, c_stone},
            {c_cobble, c_cobble, c_cobble},
            {c_stone, c_stone, c_stone},
        },
    })

    if unilib.global.pkg_executed_table["mineral_coal"] ~= nil then

        unilib.register_node(
            -- Adapted from GLEMr6, lib_materials:stone_cobble_small
            "unilib:decor_rockwall_stone_sandstone_desert_dark",
            nil,
            glemr6_mode,
            {
                description = S("Dark Rockwall of Desert Sandstone"),
                tiles = {"unilib_decor_rockwall_stone_sandstone_desert_dark.png"},
                groups = {cracky = 3, stone = 2},
                sounds = unilib.global.sound_table.stone,

                drop = "unilib:stone_sandstone_desert",
                is_ground_content = false,
            }
        )
        unilib.register_craft({
            -- Original to unilib
            output = "unilib:decor_rockwall_stone_sandstone_desert 8",
            recipe = {
                {c_stone, c_stone, c_stone},
                {c_cobble, "unilib:mineral_coal_lump", c_cobble},
                {c_stone, c_stone, c_stone},
            },
        })

    end

end
