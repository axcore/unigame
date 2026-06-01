---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.award_artisan = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

-- unilib basic 15-colour set
local colour_list = {
    {"black", S("Black")},
    {"blue", S("Blue")},
    {"brown", S("Brown")},
    {"cyan", S("Cyan")},
    {"green", S("Green")},
    {"green_dark", S("Dark Green")},
    {"grey", S("Grey")},
    {"grey_dark", S("Dark Grey")},
    {"magenta", S("Magenta")},
    {"orange", S("Orange")},
    {"pink", S("Pink")},
    {"red", S("Red")},
    {"violet", S("Violet")},
    {"white", S("White")},
    {"yellow", S("Yellow")},
}

-- Compiled lists/tables of items, based on the 15-colour set
local dye_list = {}
local dye_lookup_table = {}
local candle_list = {}
local candle_lookup_table = {}
local carpet_list = {}
local carpet_lookup_table = {}
local cushion_list = {}
local cushion_lookup_table = {}
local curtain_list = {}
local curtain_lookup_table = {}
local glass_list = {}
local glass_lookup_table = {}
local tinted_list = {}
local tinted_lookup_table = {}
local terracotta_list = {}
local terracotta_lookup_table = {}
local wool_list = {}
local wool_lookup_table = {}

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

unilib.pkg.award_artisan.vocation_name = "unilib_artisan"

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function compile_items()

    for _, mini_list in ipairs(colour_list) do

        local dye_name = "unilib:dye_" .. mini_list[1]
        table.insert(dye_list, dye_name)
        dye_lookup_table[dye_name] = true

        local candle_name = "unilib:candle_" .. mini_list[1]
        table.insert(candle_list, candle_name)
        candle_lookup_table[candle_name] = true

        local carpet_name = "unilib:carpet_" .. mini_list[1]
        table.insert(carpet_list, carpet_name)
        carpet_lookup_table[carpet_name] = true

        local curtain_name = "unilib:carpet_" .. mini_list[1]
        table.insert(curtain_list, curtain_name)
        curtain_lookup_table[curtain_name] = true

        local cushion_name = "unilib:furniture_cushion_simple_" .. mini_list[1]
        table.insert(cushion_list, cushion_name)
        cushion_lookup_table[cushion_name] = true

        local dyed_name = "unilib:glass_artisanal_dyed_" .. mini_list[1]
        table.insert(glass_list, dyed_name)
        glass_lookup_table[dyed_name] = true
        local cloudy_name = "unilib:glass_artisanal_cloudy_" .. mini_list[1]
        table.insert(glass_list, cloudy_name)
        glass_lookup_table[cloudy_name] = true
        local framed_name = "unilib:glass_artisanal_framed_" .. mini_list[1]
        table.insert(glass_list, framed_name)
        glass_lookup_table[framed_name] = true

        local tinted_name = "unilib:glass_tinted_" .. mini_list[1]
        table.insert(tinted_list, tinted_name)
        tinted_lookup_table[tinted_name] = true

        local terracotta_name = "unilib:clay_terracotta_" .. mini_list[1]
        table.insert(terracotta_list, terracotta_name)
        terracotta_lookup_table[terracotta_name] = true

        local wool_name = "unilib:wool_" .. mini_list[1]
        table.insert(wool_list, wool_name)
        wool_lookup_table[wool_name] = true

    end

end

local function on_collect(player, full_name)

    if not unilib.utils.is_player(player) or full_name == nil then
        return
    end

    if dye_lookup_table[full_name] ~= nil then

        unilib.awards.handle_collection_trigger(
            player, "aristan_collect_dye", "unilib_artisan_collect_dye_1", full_name
        )

    elseif candle_lookup_table[full_name] ~= nil then

        unilib.awards.handle_collection_trigger(
            player, "aristan_collect_candle", "unilib_artisan_collect_candle_1", full_name
        )

    elseif carpet_lookup_table[full_name] ~= nil then

        unilib.awards.handle_collection_trigger(
            player, "aristan_collect_carpet", "unilib_artisan_collect_carpet_1", full_name
        )

    elseif curtain_lookup_table[full_name] ~= nil then

        unilib.awards.handle_collection_trigger(
            player, "aristan_collect_curtain", "unilib_artisan_collect_curtain_1", full_name
        )

    elseif cushion_lookup_table[full_name] ~= nil then

        unilib.awards.handle_collection_trigger(
            player, "aristan_collect_cushion", "unilib_artisan_collect_cushion_1", full_name
        )

    elseif glass_lookup_table[full_name] ~= nil then

        unilib.awards.handle_collection_trigger(
            player, "aristan_collect_glass", "unilib_artisan_collect_glass_1", full_name
        )

    elseif terracotta_lookup_table[full_name] ~= nil then

        unilib.awards.handle_collection_trigger(
            player, "aristan_collect_dye", "unilib_artisan_collect_terracotta_1", full_name
        )

    elseif tinted_lookup_table[full_name] ~= nil then

        unilib.awards.handle_collection_trigger(
            player, "aristan_collect_tinted", "unilib_artisan_collect_tinted_1", full_name
        )

    elseif wool_lookup_table[full_name] ~= nil then

        unilib.awards.handle_collection_trigger(
            player, "aristan_collect_wool", "unilib_artisan_collect_wool_1", full_name
        )

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.award_artisan.init()

    return {
        description = "Awards for players of a creative bent (\"Artisan\")",
        depends = "dye_basic",
        optional = {
            "candle_basic",
            "carpet_basic",
            "clay_baked_basic",
            "furniture_curtain_basic",
            "furniture_cushion_simple_basic",
            "glass_artisanal_basic",
            "glass_tinted_basic",
            "wool_basic"
        }
    }

end

function unilib.pkg.award_artisan.post()

    -- Sanity check -------------------------------------------------------------------------------

    if not unilib.setting.awards_enable_flag then
        return
    end

    -- Setup --------------------------------------------------------------------------------------

    -- Compile 15-colour sets of various items
    compile_items()

    -- Trigger prototypes -------------------------------------------------------------------------

    unilib.awards.register_trigger_prototype({
        name = "artisan_collect_dye",
        trigger_type = "custom",
        hint_list = {"Craft one type of dye", "Craft @1 types of dye"},
        progress_list = {"Craft one type of dye", "Craft @1/@2 types of dye"},
    })

    unilib.awards.register_trigger_prototype({
        name = "artisan_collect_candle",
        trigger_type = "custom",
        hint_list = {"Craft one type of candle", "Craft @1 types of candle"},
        progress_list = {"Craft one type of candle", "Craft @1/@2 types of candle"},
    })

    unilib.awards.register_trigger_prototype({
        name = "artisan_collect_carpet",
        trigger_type = "custom",
        hint_list = {"Craft one type of carpet", "Craft @1 types of carpet"},
        progress_list = {"Craft one type of carpet", "Craft @1/@2 types of carpet"},
    })

    unilib.awards.register_trigger_prototype({
        name = "artisan_collect_curtain",
        trigger_type = "custom",
        hint_list = {"Craft one type of curtain", "Craft @1 types of curtain"},
        progress_list = {"Craft one type of curtain", "Craft @1/@2 types of curtain"},
    })

    unilib.awards.register_trigger_prototype({
        name = "artisan_collect_cushion",
        trigger_type = "custom",
        hint_list = {"Craft one type of simple cushion", "Craft @1 types of simple cushion"},
        progress_list = {"Craft one type of simple cushion", "Craft @1/@2 types of simple cushion"},
    })

    unilib.awards.register_trigger_prototype({
        name = "artisan_collect_glass",
        trigger_type = "custom",
        hint_list = {"Craft one type of artisanal glass", "Craft @1 types of artisanal glass"},
        progress_list = {"Craft one type of artisanal glass", "Craft @1/@2 types of artisanal glass"},
    })

    unilib.awards.register_trigger_prototype({
        name = "artisan_collect_tinted",
        trigger_type = "custom",
        hint_list = {"Craft one type of tinted glass", "Craft @1 types of tinted glass"},
        progress_list = {"Craft one type of tinted glass", "Craft @1/@2 types of tinted glass"},
    })

    unilib.awards.register_trigger_prototype({
        name = "artisan_collect_terracotta",
        trigger_type = "custom",
        hint_list = {"Craft one type of terracotta", "Craft @1 types of terracotta"},
        progress_list = {"Craft one type of terracotta", "Craft @1/@2 types of terracotta"},
    })

    unilib.awards.register_trigger_prototype({
        name = "artisan_collect_wool",
        trigger_type = "custom",
        hint_list = {"Craft one type of wool", "Craft @1 types of wool"},
        progress_list = {"Craft one type of wool", "Craft @1/@2 types of wool"},
    })

    -- Trigger event callbacks --------------------------------------------------------------------

    core.register_on_craft(function(itemstack, player, old_craft_grid, craft_inv)
        on_collect(player, itemstack:get_name())
    end)

    -- Vocations ----------------------------------------------------------------------------------

    -- Assumes 3 of the 9 compatible packages are loaded, total score 180 (ignoring 3rd-stage
    --      achievements)
    local score_list = {10, 20, 30, 40, 50, 60, 80, 100, 120, 140, 160, 180}
    -- Assumes 6 of the 9 compatible packages are loaded, total score 360
--  local score_list = {10, 20, 40, 60, 90, 120, 160, 200, 240, 280, 320, 360}
    -- Assumes 9 of the 9 compatible packages are loaded, total score 540
--  local score_list = {10, 20, 40, 60, 100, 150, 200, 250, 300, 374, 450, 540}

    unilib.awards.register_vocation({
        name = unilib.pkg.award_artisan.vocation_name,

        title = S("Artisan"),
        description = S("Awards for players of a creative bent"),
        icon = "unilib_award_vocation_artisan.png",
        level_list = {
            {title = S("Rectangular Residence"), score = score_list[1]},
            {title = S("Slightly Fancy Shack"), score = score_list[2]},
            {title = S("Miner's Block"), score = score_list[3]},
            {title = S("Now With Windows"), score = score_list[4]},
            {title = S("Roof Attempt #2"), score = score_list[5]},
            {title = S("Brush with Greatness"), score = score_list[6]},
            {title = S("Masterpiece in Progress"), score = score_list[7]},
            {title = S("Colour Me Confused"), score = score_list[8]},
            {title = S("Interior Designer"), score = score_list[9]},
            {title = S("Pixel Perfect"), score = score_list[10]},
            {title = S("Baroque Blocksmith"), score = score_list[11]},
            {title = S("Castle Caretaker"), score = score_list[12]},
        },
    })

    -- Achievements -------------------------------------------------------------------------------

    -- Combination achievements (colour sets)
    local comb_list = {
        {"dye_1", "group:dye", "unilib_craft", S("Amateur Dye Maker"), S("Craft 100 dyes"), 10, 100},
        {"dye_2", "group:dye", "unilib_craft", S("Skilled Dye Maker"), S("Craft 1000 dyes"), 20, 1000},
        {"dye_3", "group:dye", "unilib_craft", S("Veteran Dye Maker"), S("Craft 10,000 dyes"), 30, 10000},
    }

    if unilib.global.pkg_executed_table["candle_basic"] ~= nil then

        table.insert(comb_list, {"candle_1", "group:candle", "unilib_craft", S("Amateur Candle Maker"), S("Craft 25 candles"), 10, 25})
        table.insert(comb_list, {"candle_2", "group:candle", "unilib_craft", S("Skilled Candle Maker"), S("Craft 250 candles"), 20, 250})
        table.insert(comb_list, {"candel_3", "group:candle", "unilib_craft", S("Veteran Candle Maker"), S("Craft 2500 candles"), 30, 2500})

    end

    if unilib.global.pkg_executed_table["carpet_basic"] ~= nil then

        table.insert(comb_list, {"carpet_1", "group:carpet", "unilib_craft", S("Amateur Carpet Maker"), S("Craft 100 carpets"), 10, 100})
        table.insert(comb_list, {"carpet_2", "group:carpet", "unilib_craft", S("Skilled Carpet Maker"), S("Craft 1000 carpets"), 20, 1000})

    end

    if unilib.global.pkg_executed_table["clay_baked_basic"] ~= nil then

        table.insert(comb_list, {"terracotta_1", "group:terracotta", "unilib_craft", S("Amateur Kiln Operator"), S("Craft 100 terracotta blocks"), 10, 100})
        table.insert(comb_list, {"terracotta_2", "group:terracotta", "unilib_craft", S("Skilled Kiln Operator"), S("Craft 1000 terracotta blocks"), 20, 1000})
        table.insert(comb_list, {"terracotta_3", "group:terracotta", "unilib_craft", S("Veteran Kiln Operator"), S("Craft 10,000 terracotta blocks"), 30, 10000})

    end

    if unilib.global.pkg_executed_table["furniture_curtain_basic"] ~= nil then

        table.insert(comb_list, {"curtain_1", "group:curtain", "unilib_craft", S("Amateur Curtain Maker"), S("Craft 30 curtains"), 10, 30})
        table.insert(comb_list, {"curtain_2", "group:curtain", "unilib_craft", S("Skilled Curtain Maker"), S("Craft 300 curtains"), 20, 300})

    end

    if unilib.global.pkg_executed_table["furniture_cushion_simple_basic"] ~= nil then

        table.insert(comb_list, {"cushion_1", "group:cushion", "unilib_craft", S("Amateur Cushion Maker"), S("Craft 20 simple cushions"), 10, 20})
        table.insert(comb_list, {"cushion_2", "group:cushion", "unilib_craft", S("Skilled Cushion Maker"), S("Craft 200 simple cushions"), 20, 200})

    end

    if unilib.global.pkg_executed_table["glass_artisanal_basic"] ~= nil then

        table.insert(comb_list, {"glass_1", glass_list, "unilib_craft", S("Amateur Glassmaker"), S("Craft 75 artisanal glass blocks"), 10, 75})
        table.insert(comb_list, {"glass_2", glass_list, "unilib_craft", S("Skilled Glassmaker"), S("Craft 750 carpets"), 20, 750})
        table.insert(comb_list, {"glass_3", glass_list, "unilib_craft", S("Skilled Glassmaker"), S("Craft 7500 carpets"), 30, 7500})

    end

    if unilib.global.pkg_executed_table["glass_tinted_basic"] ~= nil then

        table.insert(comb_list, {"tinted_1", tinted_list, "unilib_craft", S("Amateur Tinted Glassmaker"), S("Craft 80 tinted glass blocks"), 10, 80})
        table.insert(comb_list, {"tinted_2", tinted_list, "unilib_craft", S("Skilled Tinted Glassmaker"), S("Craft 800 tinted glass blocks"), 20, 800})

    end

    if unilib.global.pkg_executed_table["wool_basic"] ~= nil then

        table.insert(comb_list, {"wool_1", "group:wool", "unilib_craft", S("Amateur Spinner"), S("Craft 88 wools"), 10, 88})
        table.insert(comb_list, {"wool_2", "group:wool", "unilib_craft", S("Skilled Spinner"), S("Craft 888 wools"), 20, 888})

    end

    for i, mini_list in ipairs(comb_list) do

        unilib.awards.register_achievement({
            name = "unilib_artison_comb_" .. mini_list[1],
            trigger_table = {
                prototype = mini_list[3],
                target = mini_list[7],
                item_list = unilib.utils.convert_to_list(mini_list[2]),
            },

            title = mini_list[4],
            description = mini_list[5],
            score = mini_list[6],
            vocation_list = {unilib.pkg.award_artisan.vocation_name},
        })

    end

    -- Selective achievements (colour sets)
    local select_list = {}

    if unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        for _, mini_list in ipairs(colour_list) do
            table.insert(select_list, {"dye_" .. mini_list[1], "unilib:dye_" .. mini_list[1], "unilib_craft", unilib.utils.brackets(S("A Good Day to Dye"), mini_list[2]), unilib.utils.brackets(S("Craft 99 dyes"), mini_list[2]), 10, 99})
        end

    end

    for i, mini_list in ipairs(select_list) do

        if unilib.awards.check_argument(mini_list[2]) then

            unilib.awards.register_achievement({
                name = "unilib_artisan_select_" .. mini_list[1],
                trigger_table = {
                    prototype = mini_list[3],
                    target = mini_list[7],
                    item_list = unilib.utils.convert_to_list(mini_list[2]),
                },

                title = mini_list[4],
                description = mini_list[5],
                score = mini_list[6],
                vocation_list = {unilib.pkg.award_artisan.vocation_name},
            })

        end

    end

    -- Collector achievements (colour sets)
    local collect_list = {
        {"dye_1", dye_list, "artisan_collect_dye", S("Amateur Colourist"), S("Craft 5 types of dye"), 10, 5},
        {"dye_2", dye_list, "artisan_collect_dye", S("Skilled Colourist"), S("Craft every type of dye"), 20, 15},
    }

    if unilib.global.pkg_executed_table["candle_basic"] ~= nil then

        table.insert(collect_list, {"candle_1", candle_list, "artisan_collect_candle", S("Amateur Chandler"), S("Craft 5 types of candle"), 10, 5})
        table.insert(collect_list, {"candle_2", candle_list, "artisan_collect_candle", S("Skilled Chandler"), S("Craft every type of candle"), 20, 15})

    end

    if unilib.global.pkg_executed_table["carpet_basic"] ~= nil then

        table.insert(collect_list, {"carpet_1", carpet_list, "artisan_collect_carpet", S("Amateur Carpet Weaver"), S("Craft 5 types of carpet"), 10, 5})
        table.insert(collect_list, {"carpet_2", carpet_list, "artisan_collect_carpet", S("Skilled Carpet Weaver"), S("Craft every type of carpet"), 20, 15})

    end

    if unilib.global.pkg_executed_table["clay_baked_basic"] ~= nil then

        table.insert(collect_list, {"terracotta_1", terracotta_list, "artisan_collect_terracotta", S("Amateur Ceramic Artist"), S("Craft 5 types of terracotta"), 10, 5})
        table.insert(collect_list, {"terracotta_2", terracotta_list, "artisan_collect_terracotta", S("Skilled Ceramic Artist"), S("Craft every type of terracotta"), 20, 15})

    end

    if unilib.global.pkg_executed_table["furniture_curtain_basic"] ~= nil then

        table.insert(collect_list, {"curtain_1", curtain_list, "artisan_collect_curtain", S("Amateur Draper"), S("Craft 5 types of curtain"), 10, 5})
        table.insert(collect_list, {"curtain_2", curtain_list, "artisan_collect_curtain", S("Skilled Draper"), S("Craft every type of curtain"), 20, 15})

    end

    if unilib.global.pkg_executed_table["furniture_cushion_simple_basic"] ~= nil then

        table.insert(collect_list, {"cushion_1", cushion_list, "artisan_collect_cushion", S("Amateur Soft Furnisher"), S("Craft 5 types of simple cushion"), 10, 5})
        table.insert(collect_list, {"cushion_2", cushion_list, "artisan_collect_cushion", S("Skilled Soft Furnisher"), S("Craft every type of simple cushion"), 20, 15})

    end

    if unilib.global.pkg_executed_table["glass_artisanal_basic"] ~= nil then

        table.insert(collect_list, {"glass_1", carpet_list, "artisan_collect_glass", S("Amateur Glass Fabricator"), S("Craft 5 types of artisanal glass block"), 10, 5})
        table.insert(collect_list, {"glass_2", carpet_list, "artisan_collect_glass", S("Skilled Glass Fabricator"), S("Craft 15 types of artisanal glass block"), 20, 15})
        table.insert(collect_list, {"glass_3", carpet_list, "artisan_collect_glass", S("Veteran Glass Fabricator"), S("Craft every type of artisanal glass block"), 30, 45})

    end

    if unilib.global.pkg_executed_table["glass_tinted_basic"] ~= nil then

        table.insert(collect_list, {"tinted_1", tinted_list, "artisan_collect_tinted", S("Amateur Tinted Glass Fabricator"), S("Craft 5 types of tinted glass block"), 10, 5})
        table.insert(collect_list, {"tinted_2", tinted_list, "artisan_collect_tinted", S("Skilled Tinted Glass Fabricator"), S("Craft every type of tinted glass block"), 20, 15})

    end

    if unilib.global.pkg_executed_table["wool_basic"] ~= nil then

        table.insert(collect_list, {"wool_1", wool_list, "artisan_collect_wool", S("Amateur Felter"), S("Craft 5 types of wool"), 10, 5})
        table.insert(collect_list, {"wool_2", wool_list, "artisan_collect_wool", S("Skilled Felter"), S("Craft every type of  "), 20, 15})

    end

    for i, mini_list in ipairs(collect_list) do

        unilib.awards.register_achievement({
            name = "unilib_artisan_collect_" .. mini_list[1],
            trigger_table = {
                prototype = mini_list[3],
                target = mini_list[7],
                item_list = unilib.utils.convert_to_list(mini_list[2]),
            },

            title = mini_list[4],
            description = mini_list[5],
            score = mini_list[6],
            vocation_list = {unilib.pkg.award_artisan.vocation_name},
        })

    end

end
