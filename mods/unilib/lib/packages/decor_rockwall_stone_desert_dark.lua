---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr6
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_rockwall_stone_desert_dark = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr6.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_rockwall_stone_desert_dark.init()

    return {
        description = "Dark rockwall of desert stone",
        depends = {"mineral_coal", "stone_desert"},
    }

end

function unilib.pkg.decor_rockwall_stone_desert_dark.exec()

    local c_stone = "unilib:stone_desert"
    local c_cobble = "unilib:stone_desert_cobble"

    unilib.register_node(
        -- From GLEMr6, lib_materials:stone_desert_cobble_small
        "unilib:decor_rockwall_stone_desert_dark",
        "lib_materials:stone_desert_cobble_small",
        mode,
        {
            description = S("Dark Rockwall of Desert Stone"),
            tiles = {"unilib_decor_rockwall_stone_desert_dark.png"},
            groups = {cracky = 3, stone = 2},
            sounds = unilib.sound_table.stone,

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
