---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_fish_bonus = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_fish_bonus.init()

    return {
        description = "Bonus item set for fishing rods",
    }

end

function unilib.pkg.ingredient_fish_bonus.post()

    -- Bonus item set (includes items that were present in ethereal-ng 2021, but absent in
    --      ethereal-ng 2024)
    local bonus_list = {
        {"unilib:bucket_steel_empty",                       nil,                nil},
        {"unilib:fruit_banana_bunch",                       "ethereal_grove",   nil},
        {"unilib:item_book_ordinary",                       nil,                nil},
        {"unilib:item_rod_fishing",                         nil,                9000},
        {"unilib:mineral_crystallite_spike",                "ethereal_frost"},
        {"unilib:plant_shrub_firethorn",                    "ethereal_glacier"},
        {"unilib:tnt_ordinary_stick",                       nil,                nil},
        {"unilib:tool_sword_steel",                         nil,                12000},
        {"unilib:vessel_bottle_glass_with_firefly_yellow",  nil,                nil},
        -- From animalia mod
        {"animalia:nametag",                                nil,                nil},
        {"animalia:net",                                    nil,                nil},
        {"animalia:saddle",                                 nil,                nil},
        -- From mobs_redo mod
        {"mobs:nametag",                                    nil,                nil},
        {"mobs:net",                                        nil,                nil},
        {"mobs:saddle",                                     nil,                nil},
        -- From petz mod (there is no name tag)
        {"petz:net",                                        nil,                nil},
        {"petz:saddle",                                     nil,                nil},
    }

    -- Register bonus items
    for _, row_list in ipairs(bonus_list) do

        unilib.fishing.register_bonus({
            full_name = row_list[1],
            biome_part_name = row_list[2],
            tool_wear = row_list[3],
        })

    end

end
