---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    valleys_c
-- Code:    GPL 3.0/BSD/WTFPL
-- Media:   GPL 3.0/BSD/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_valleys_c_pebble_small = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.valleys_c.add_mode

-- Number of pebble variants for each super-stone type
local variant_count = 3

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_valleys_c_pebble_small.init()

    return {
        description = "Large ordinary stone pebble as decoration",
        depends = "pebble_small",
    }

end

function unilib.pkg.deco_valleys_c_pebble_small.post()

    for stone_type, _ in pairs(unilib.global.super_stone_table) do

        if unilib.global.pkg_executed_table["stone_" .. stone_type] ~= nil then

            for i = 1, variant_count do

                unilib.register_decoration_complete(
                    "valleys_c_pebble_small_stone_" .. stone_type .. "_" .. i,
                    nil,
                    {
                        -- From valleys_c/deco_rocks.lua
                        -- Completes decorations in package "pebble_small"
                        -- N.B. valleys_c biomes have not been imported, so this decorations works
                        --      in all biomes
                        place_on = {"group:soil", "group:sand"},
                    }
                )

            end

        end

    end

end
