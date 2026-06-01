---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.award_weaponsmith = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

-- Compiled lists/tables of items
local sword_lookup_table = {}
local spear_lookup_table = {}
local all_select_list = {}

-- Achievements for specific weapons
-- Items can be added or removed from this list; as appropriate. Any items that don't exist in the
--      world are removed automatically
-- mini_lists in the form
--      [partial_achievement_name, full_name, title, description, score, target]
local sword_init_list = {
    -- (minetest_game)
    {"sword_bronze", "unilib:tool_sword_bronze", S("Armed with Bronze"), S("Craft a bronze sword"), 10, 1},
    {"sword_diamond", "unilib:tool_sword_diamond", S("Armed with Diamonds"), S("Craft a diamond sword"), 10, 1},
    {"sword_mese", "unilib:tool_sword_mese", S("Armed with Mese Crystals"), S("Craft a mese sword"), 10, 1},
    {"sword_steel", "unilib:tool_sword_steel", S("Armed with Steel"), S("Craft a steel sword"), 10, 1},
    {"sword_stone", "unilib:tool_sword_stone", S("Armed with Stone"), S("Craft a stone sword"), 10, 1},
    {"sword_wood", "unilib:tool_sword_wood", S("Armed with Wood"), S("Craft a wooden sword"), 10, 1},
    -- ethereal
    {"sword_crystallite", "unilib:tool_sword_crystallite", S("Armed with Crystallite"), S("Craft a crystallite sword"), 20, 1},
    -- gemtools
    {"sword_emerald", "unilib:tool_sword_emerald", S("Armed with Emeralds"), S("Craft an emerald sword"), 20, 1},
    {"sword_octu", "unilib:tool_sword_octu", S("Armed with Octu Crystals"), S("Craft an octu sword"), 20, 1},
    {"sword_ruby", "unilib:tool_sword_ruby", S("Armed with Rubies"), S("Craft a ruby sword"), 20, 1},
    {"sword_sapphire", "unilib:tool_sword_sapphire", S("Armed with Sapphires"), S("Craft a sapphire sword"), 20, 1},
    -- moreores
    {"sword_mithril", "unilib:tool_sword_mithril", S("Armed with Mithril"), S("Craft a mithril sword"), 10, 1},
    {"sword_silver", "unilib:tool_sword_silver", S("Armed with Silver"), S("Craft a silver sword"), 10, 1},
    -- pigiron
    {"sword_iron_pig", "unilib:tool_sword_iron_pig", S("Armed with Pig Iron"), S("Craft a pig iron sword"), 10, 1},
    -- xtraores
    {"sword_adamantite", "unilib:tool_sword_adamantite", S("Armed with Adamantite"), S("Craft an adamantite sword"), 30, 1},
    {"sword_excalibur", "unilib:tool_sword_excalibur", S("Chosen by Excalibur"), S("Craft Excalibur"), 50, 1},
    {"sword_geminitium", "unilib:tool_sword_geminitium", S("Armed with Geminitium"), S("Craft a geminitium sword"), 30, 1},
    {"sword_ozymandium", "unilib:tool_sword_ozymandium", S("Armed with Ozymandium"), S("Craft an ozymandium sword"), 30, 1},
    {"sword_planexium", "unilib:tool_sword_planexium", S("Armed with Planexium"), S("Craft a planexium sword"), 30, 1},
    {"sword_rarium", "unilib:tool_sword_rarium", S("Armed with Rarium"), S("Craft a rarium sword"), 30, 1},
    {"sword_sybilline", "unilib:tool_sword_sybilline", S("Armed with Sybilline"), S("Craft a sybilline sword"), 30, 1},
    {"sword_tritonium", "unilib:tool_sword_tritonium", S("Armed with Tritonium"), S("Craft a tritonium sword"), 30, 1},
    {"sword_unobtainium", "unilib:tool_sword_unobtainium", S("Armed with Unobtainium"), S("Craft an unobtainium sword"), 30, 1},
}
local spear_init_list = {
    -- xtraores
    {"spear_adamantite", "unilib:tool_spear_adamantite", S("Wielding Adamantite"), S("Craft an adamantite spear"), 20, 1},
    {"spear_geminitium", "unilib:tool_spear_geminitium", S("Wielding Geminitium"), S("Craft a geminitium spear"), 20, 1},
    {"spear_gungir", "unilib:tool_spear_gungir", S("Wielding the Gungir"), S("Craft Gungir"), 50, 1},
    {"spear_ozymandium", "unilib:tool_spear_ozymandium", S("Wielding Ozymandium"), S("Craft an ozymandium spear"), 20, 1},
    {"spear_planexium", "unilib:tool_spear_planexium", S("Wielding Planexium"), S("Craft a planexium spear"), 20, 1},
    {"spear_rarium", "unilib:tool_spear_rarium", S("Wielding Rarium"), S("Craft a rarium spear"), 20, 1},
    {"spear_sybilline", "unilib:tool_spear_sybilline", S("Wielding Sybilline"), S("Craft a sybilline spear"), 20, 1},
    {"spear_tritonium", "unilib:tool_spear_tritonium", S("Wielding Tritonium"), S("Craft a tritonium spear"), 20, 1},
    {"spear_unobtainium", "unilib:tool_spear_unobtainium", S("Wielding Unobtainium"), S("Craft an unobtainium spear"), 20, 1},
}
local other_init_list = {}

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

unilib.pkg.award_weaponsmith.vocation_name = "unilib_weaponsmith"

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function compile_items()

    for _, mini_list in ipairs(sword_init_list) do

        if core.registered_tools[mini_list[2]] ~= nil then

            sword_lookup_table[mini_list[2]] = true
            table.insert(all_select_list, mini_list)

        end

    end

    for _, mini_list in ipairs(spear_init_list) do

        if core.registered_tools[mini_list[2]] ~= nil then

            spear_lookup_table[mini_list[2]] = true
            table.insert(all_select_list, mini_list)

        end

    end

    for _, mini_list in ipairs(other_init_list) do

        if core.registered_tools[mini_list[2]] ~= nil then
            table.insert(all_select_list, mini_list)
        end

    end

end

local function on_collect(player, full_name)

    if not unilib.utils.is_player(player) or full_name == nil then
        return
    end

    if sword_lookup_table[full_name] ~= nil then

        unilib.awards.handle_collection_trigger(
            player, "weaponsmith_collect_sword", "unilib_weaponsmith_collect_sword_1", full_name
        )

    elseif spear_lookup_table[full_name] ~= nil then

        unilib.awards.handle_collection_trigger(
            player, "weaponsmith_collect_spear", "unilib_weaponsmith_collect_spear_1", full_name
        )

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.award_weaponsmith.init()

    return {
        description = "Awards for crafting weapons, including swords and spears (\"Weaponsmith\")",
        notes = "Assumes a world containing at least as many swords as minetest_game",
    }

end

function unilib.pkg.award_weaponsmith.post()

    -- Sanity check -------------------------------------------------------------------------------

    if not unilib.setting.awards_enable_flag then
        return
    end

    -- Setup --------------------------------------------------------------------------------------

    -- N.B. Filter out weapons that are not in the game
    compile_items()

    -- Trigger prototypes -------------------------------------------------------------------------

    unilib.awards.register_trigger_prototype({
        name = "weaponsmith_collect_sword",
        trigger_type = "custom",
        hint_list = {"Craft one type of sword", "Craft @1 types of sword"},
        progress_list = {"Craft one type of sword", "Craft @1/@2 types of sword"},
    })

    unilib.awards.register_trigger_prototype({
        name = "weaponsmith_collect_spear",
        trigger_type = "custom",
        hint_list = {"Craft one type of spear", "Craft @1 types of spear"},
        progress_list = {"Craft one type of spear", "Craft @1/@2 types of spear"},
    })

    -- Trigger event callbacks --------------------------------------------------------------------

    core.register_on_craft(function(itemstack, player, old_craft_grid, craft_inv)
        on_collect(player, itemstack:get_name())
    end)

    -- Vocations ----------------------------------------------------------------------------------

    -- Assume at least the "mtgame" remix, providing 6 swords (total score 130)
    local score_list = {10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 130}
    -- Assume at least the "mtgame" and "xtraores" remixes, providing 15 swords and 9 spears (total
    --      score 640)
--  local score_list = {10, 20, 40, 70, 100, 150, 200, 250, 300, 400, 500, 640}

    unilib.awards.register_vocation({
        name = unilib.pkg.award_weaponsmith.vocation_name,

        title = S("Weaponsmith"),
        description = S("Craft many different weapons"),
        icon = "unilib_award_vocation_weaponsmith.png",
        level_list = {
            {title = S("Armed With a Piece of Fruit"), score = score_list[1]},
            {title = S("Point Taken"), score = score_list[2]},
            {title = S("A Cut Above The Rest"), score = score_list[3]},
            {title = S("Edge Case"), score = score_list[4]},
            {title = S("Handle With Care"), score = score_list[5]},
            {title = S("Spear Pressure"), score = score_list[6]},
            {title = S("Cutting-Edge Technology"), score = score_list[7]},
            {title = S("Sharpen-Freude"), score = score_list[8]},
            {title = S("Slice to Meet You"), score = score_list[9]},
            {title = S("Blade to the Bone"), score = score_list[10]},
            {title = S("The Point of No Return"), score = score_list[11]},
            {title = S("The Final Cut"), score = score_list[12]},
        },
    })

    -- Achievements -------------------------------------------------------------------------------

    -- Selective achievements
    for _, mini_list in ipairs(all_select_list) do

        -- mini_list in the form
        --      [partial_achievement_name, full_name, title, description, score, target]
        unilib.awards.register_achievement({
            name = "unilib_weaponsmith_select_" .. mini_list[1],
            trigger_table = {
                prototype = "unilib_craft",
                target = mini_list[6],
                item_list = unilib.utils.convert_to_list(mini_list[2]),
            },

            title = mini_list[3],
            description = mini_list[4],
            score = mini_list[5],
            vocation_list = {unilib.pkg.award_weaponsmith.vocation_name},
        })

    end

    -- Collector achievements
    local sword_count = unilib.utils.get_table_size(sword_lookup_table)
    if sword_count >= 5 then

        local sword_list = {
            {S("Skilled Swordsmith"), S("Craft 5 types of sword"), 20, 5},
            {S("Elite Swordsmith"), S("Craft every type of sword"), 50, sword_count},
        }

        for i, mini_list in ipairs(sword_list) do

            unilib.awards.register_achievement({
                name = "unilib_weaponsmith_collect_sword_" .. i,
                trigger_table = {
                    prototype = "weaponsmith_collect_sword",
                    target = mini_list[4],
                    item_list = {"group:sword"},
                },

                title = mini_list[1],
                description = mini_list[2],
                score = mini_list[3],
                vocation_list = {unilib.pkg.award_weaponsmith.vocation_name},
            })

        end

    end

    local spear_count = unilib.utils.get_table_size(spear_lookup_table)
    if spear_count >= 5 then

        local spear_list = {
            {S("Skilled Spearsmith"), S("Craft 5 types of spear"), 20, 5},
            {S("Elite Spearsmith"), S("Craft every type of spear"), 50, spear_count},
        }

        for i, mini_list in ipairs(spear_list) do

            unilib.awards.register_achievement({
                name = "unilib_weaponsmith_collect_spear_" .. i,
                trigger_table = {
                    prototype = "weaponsmith_collect_spear",
                    target = mini_list[4],
                    item_list = {"group:spear"},
                },

                title = mini_list[1],
                description = mini_list[2],
                score = mini_list[3],
                vocation_list = {unilib.pkg.award_weaponsmith.vocation_name},
            })

        end

    end

end
