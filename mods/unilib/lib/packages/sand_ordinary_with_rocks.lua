---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    valleys_c
-- Code:    GPL 3.0/BSD/WTFPL
-- Media:   GPL 3.0/BSD/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_ordinary_with_rocks = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.valleys_c.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_ordinary_with_rocks.init()

    return {
        description = "Ordinary sand with rocks",
        depends = "sand_ordinary",
        optional = "pebble_small"
    }

end

function unilib.pkg.sand_ordinary_with_rocks.exec()

    local drop = "unilib:sand_ordinary"
    local pebble_name = "unilib:pebble_small_stone_ordinary_1"
    if core.registered_nodes[pebble_name] ~= nil then

        drop = {
            max_items = 2,
            items = {
                {items = {pebble_name}, rarity = 1},
                {items = {"unilib:sand_ordinary"}, rarity = 1},
            },
        }

    end

    unilib.register_node("unilib:sand_ordinary_with_rocks", "valleys_c:sand_with_rocks", mode, {
        -- From valleys_c:sand_with_rocks
        description = S("Ordinary Sand with Rocks"),
        tiles = {"unilib_sand_ordinary_with_rocks.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.global.sound_table.sand,

        drop = drop,
    })

end
