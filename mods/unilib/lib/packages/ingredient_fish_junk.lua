---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_fish_junk = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_fish_junk.init()

    return {
        description = "Junk item set for fishing rods",
    }

end

function unilib.pkg.ingredient_fish_junk.post()

    -- Junk item set (includes items that were present in ethereal-ng 2021, but absent in
    --      ethereal-ng 2024)
    local junk_list = {
        {"unilib:armour_boots_wood 6000",                   nil,                6000},
        {"unilib:dye_black",                                nil,                nil},
        {"unilib:flower_waterlily_ordinary",                nil,                nil},
        {"unilib:item_bone",                                nil,                nil},
        {"unilib:item_paper_ordinary",                      nil,                nil},
        {"unilib:item_stick_ordinary",                      nil,                nil},
        {"unilib:item_string_ordinary",                     nil,                nil},
        {"unilib:mushroom_red",                             nil,                nil},
        {"unilib:plant_papyrus_ordinary",                   nil,                nil},
        {"unilib:tree_bamboo_trunk",                        "ethereal_bamboo",  nil},
        {"unilib:utensil_bowl_wooden",                      nil,                nil},
        {"unilib:vessel_bottle_glass_empty",                nil,                nil},
    }

    -- Register junk items
    for _, row_list in ipairs(junk_list) do

        unilib.fishing.register_junk({
            full_name = row_list[1],
            biome_part_name = row_list[2],
            tool_wear = row_list[3],
        })

    end

end
