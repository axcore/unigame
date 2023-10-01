---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_marble_grey = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_marble_grey.init()

    return {
        description = "Grey marble",
    }

end

function unilib.pkg.stone_marble_grey.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "marble_grey",
        description = S("Grey Marble"),

        category = "metamorphic",
        grinder_flag = true,
        -- (N.B. In-game hardness adjusted to match cracky groups below, should be 3)
        hardness = 1,
        hardness_real = 3,
        not_super_flag = true,
    })

    local smooth_cracky, block_cracky = unilib.get_adjusted_cracky("marble_grey", 3, nil)

    unilib.register_node("unilib:stone_marble_grey", "darkage:marble", mode, {
        -- From darkage:marble
        description = S("Grey Marble"),
        tiles = {"unilib_stone_marble_grey.png"},
        -- N.B. marble = 1 not in original code
        groups = {cracky = smooth_cracky, marble = 1, smoothstone = 1, stone = 1},
        sounds = unilib.sound_table.stone,
    })
    --[[
    unilib.register_stairs("unilib:stone_marble_grey", {
        group_type = "smooth",
    })
    unilib.register_carvings("unilib:stone_marble_grey", {
        facade_flag = true,
    })
    ]]--
    unilib.register_stone_smooth_cuttings({
        part_name = "marble_grey",

        drop_name = "unilib:stone_marble_grey",
    })

    -- (no block/brick/cobble/rubble variants)

    unilib.register_node("unilib:stone_marble_grey_tile", "darkage:marble_tile", mode, {
        -- From darkage:marble_tile
        description = S("Grey Marble Tile"),
        tiles = {"unilib_stone_marble_grey_tile.png"},
        groups = {cracky = 2},
        sounds = unilib.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft({
        -- From darkage:marble_tile
        output = "unilib:stone_marble_grey_tile 2",
        recipe = {
            {"unilib:stone_marble_grey", "unilib:stone_marble_grey"},
            {"unilib:stone_marble_grey", "unilib:stone_marble_grey"},
        }
    })
    if unilib.super_stone_table["marble_grey"] ~= nil then
        unilib.register_stairs("unilib:stone_marble_grey_tile")
    end

end
