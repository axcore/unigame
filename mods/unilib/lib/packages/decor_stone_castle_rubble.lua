---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    castle/castle_masonry
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_stone_castle_rubble = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.castle_masonry.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_stone_castle_rubble.init()

    return {
        description = "Castle wall rubble",
        optional = {"decor_stone_castle_wall", "gravel_ordinary", "stone_desert"},
    }

end

function unilib.pkg.decor_stone_castle_rubble.exec()

    unilib.register_node("unilib:decor_stone_castle_rubble", "castle_masonry:rubble", mode, {
        -- From castle_masonry:rubble
        description = S("Castle Wall Rubble"),
        tiles = {"unilib_decor_stone_castle_rubble.png"},
        groups = {crumbly = 3, falling_node = 1},
        sounds = unilib.global.sound_table.gravel,

        drawtype = "normal",
        -- N.B. is_ground_content = false not in original code; added to match other decor items
        is_ground_content = false,
        paramtype = "light",
    })
    if unilib.global.pkg_executed_table["decor_stone_castle_wall"] ~= nil then

        unilib.register_craft({
            -- From castle_masonry:rubble
            output = "unilib:decor_stone_castle_rubble",
            recipe = {
                {"unilib:decor_stone_castle_wall"},
            },
        })

    end
    if unilib.global.pkg_executed_table["gravel_ordinary"] ~= nil and
            unilib.global.pkg_executed_table["stone_desert"] ~= nil then

        unilib.register_craft({
            -- From castle_masonry:rubble
            output = "unilib:decor_stone_castle_rubble 2",
            recipe = {
                {"unilib:gravel_ordinary"},
                {"unilib:stone_desert"},
            },
        })

    end
    unilib.register_stairs("unilib:decor_stone_castle_rubble")

end
