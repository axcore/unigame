---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_marble_blue = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_marble_blue.init()

    return {
        description = "Blue marble",
    }

end

function unilib.pkg.stone_marble_blue.exec()

    local c_stone = "unilib:stone_marble_blue"

    unilib.register_stone({
        -- Original to unilib
        part_name = "marble_blue",
        description = S("Blue Marble"),

        category = "metamorphic",
        grinder_flag = true,
        hardness = 3,
        not_super_flag = true,
    })

    unilib.register_node("unilib:stone_marble_blue", "ethereal:blue_marble", mode, {
        -- From ethereal:blue_marble
        description = S("Blue Marble"),
        tiles = {"unilib_stone_marble_blue.png"},
        -- N.B. marble = 1, smoothstone = 1 not in original code
        groups = {cracky = 1, marble = 1, smoothstone = 1, stone = 1},
        sounds = unilib.sound_table.stone,
    })
    --[[
    unilib.register_stairs("unilib:stone_marble_blue", {
        group_type = "smooth",
    })
    ]]--
    unilib.register_stone_smooth_cuttings({
        part_name = "marble_blue",

        drop_name = "unilib:stone_marble_blue",
    })

    -- (no block/brick/cobble/rubble variants)

    unilib.register_node("unilib:stone_marble_blue_tile", "ethereal:blue_marble_tile", mode, {
        -- From ethereal:blue_marble_tile
        description = S("Blue Marble Tile"),
        tiles = {"unilib_stone_marble_blue_tile.png"},
        groups = {cracky = 1, stone = 1},
        sounds = unilib.sound_table.stone,
    })
    unilib.register_craft_3x3x9({
        -- From ethereal:blue_marble_tile
        output = "unilib:stone_marble_blue_tile",
        ingredient = "unilib:stone_marble_blue",
    })
    if unilib.super_stone_table["marble_blue"] ~= nil then
        unilib.register_stairs("unilib:stone_marble_blue_tile")
    end

end
