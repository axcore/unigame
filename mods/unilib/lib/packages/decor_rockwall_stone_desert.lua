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

unilib.pkg.decor_rockwall_stone_desert = {}

local S = unilib.intllib
local glemr4_mode = unilib.global.imported_mod_table.glemr4.add_mode
local glemr6_mode = unilib.global.imported_mod_table.glemr6.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_rockwall_stone_desert.init()

    return {
        description = "Rockwall of desert stone",
        depends = "stone_desert",
        optional = "mineral_coal",
    }

end

function unilib.pkg.decor_rockwall_stone_desert.exec()

    local c_stone = "unilib:stone_desert"
    local c_cobble = "unilib:stone_desert_cobble"

    unilib.register_node(
        -- Texture from GLEMr4, lib_materials_rockwall_stone_desert.png. Code adapted from
        --      unilib:decor_rockwall_stone_ordinary
        "unilib:decor_rockwall_stone_desert",
        "lib_materials:rockwall_stone",
        glemr4_mode,
        {
            description = S("Rockwall of Desert Stone"),
            tiles = {"unilib_decor_rockwall_stone_desert.png"},
            groups = {cracky = 3, level = 2, stone = 1},
            sounds = unilib.global.sound_table.stone,

            drop = "unilib:stone_desert_cobble",
            -- N.B. no is_ground_content in original code, this matches
            --      unilib:decor_rockwall_stone_desert_dark
            is_ground_content = false,
        }
    )
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:decor_rockwall_stone_desert 9",
        recipe = {
            {c_stone, c_stone, c_stone},
            {c_cobble, c_cobble, c_cobble},
            {c_stone, c_stone, c_stone},
        },
    })

    if unilib.global.pkg_executed_table["mineral_coal"] ~= nil then

        unilib.register_node(
            -- From GLEMr6, lib_materials:stone_desert_cobble_small
            "unilib:decor_rockwall_stone_desert_dark",
            "lib_materials:stone_desert_cobble_small",
            glemr6_mode,
            {
                description = S("Dark Rockwall of Desert Stone"),
                tiles = {"unilib_decor_rockwall_stone_desert_dark.png"},
                groups = {cracky = 3, stone = 2},
                sounds = unilib.global.sound_table.stone,

                -- N.B. no drop in original code, this matches unilib:decor_rockwall_stone_desert
                drop = "unilib:stone_desert_cobble",
                is_ground_content = false,
            }
        )
        unilib.register_craft({
            -- Original to unilib
            output = "unilib:decor_rockwall_stone_desert_dark 8",
            recipe = {
                {c_stone, c_stone, c_stone},
                {c_cobble, "unilib:mineral_coal_lump", c_cobble},
                {c_stone, c_stone, c_stone},
            },
        })

    end

end
