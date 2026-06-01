---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.award_trainspotter = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

unilib.pkg.award_trainspotter.vocation_name = "unilib_trainspotter"

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.award_trainspotter.init()

    return {
        description = "Awards for trains mods (\"Trainspotter\")",
        notes = "Assumes the \"Advanced Trains\" and \"Advtrains Basic Trains\" mods, as well" ..
                " as the \"carts\" mod from minetest_game",
    }

end

function unilib.pkg.award_trainspotter.post()

    -- Sanity check -------------------------------------------------------------------------------

    if unilib.setting.awards_enable_flag or not core.get_modpath("advtrains") then
        return
    end

    -- Vocations ----------------------------------------------------------------------------------

    -- Assumes a total score of 650 (not including the 100,000 tracks achievement)
    unilib.awards.register_vocation({
        name = unilib.pkg.award_trainspotter.vocation_name,

        title = S("Trainspotter"),
        description = S("Train, planes and... well, just trains, really"),
        icon = "unilib_award_vocation_trainspotter.png",
        level_list = {
            {title = S("Station in the Middle of Nowhere"), score = 10},
            {title = S("Rail Fail"), score = 20},
            {title = S("Tunnel Vision"), score = 50},
            {title = S("Signal Failure"), score = 80},
            {title = S("Paint Your Wagon"), score = 120},
            {title = S("Express Yourself"), score = 160},
            {title = S("Freight Expectations"), score = 200},
            {title = S("Off the Rails"), score = 250},
            {title = S("Locomotion Sickness"), score = 350},
            {title = S("Track Star"), score = 450},
            {title = S("Railroad Tycoon"), score = 550},
            {title = S("Grand Station Central"), score = 650},
        },
    })

    -- Achievements -------------------------------------------------------------------------------

    -- Combination achievements
    for i, mini_list in ipairs({
        -- advtrains
        {"track_1", "group:advtrains_track", "unilib_place", S("Amateur Track Star"), S("Place 20 tracks"), 10, 20},
        {"track_2", "group:advtrains_track", "unilib_place", S("Novice Track Star"), S("Place 200 tracks"), 20, 200},
        {"track_3", "group:advtrains_track", "unilib_place", S("Skilled Track Star"), S("Place 2000 tracks"), 30, 2000},
        {"track_4", "group:advtrains_track", "unilib_place", S("Veteran Track Star"), S("Place 20,000 tracks"), 50, 20000},
        {"track_5", "group:advtrains_track", "unilib_place", S("Elite Track Star"), S("Place 100,000 tracks"), 100, 100000},

        {"tcb_1", "advtrains_interlocking:tcb_node", "unilib_place", S("Amateur Track Technician"), S("Place 10 TCBs"), 10, 10},
        {"tcb_2", "advtrains_interlocking:tcb_node", "unilib_place", S("Skilled Track Technician"), S("Place 100 TCBs"), 20, 100},
        {"tcb_3", "advtrains_interlocking:tcb_node", "unilib_place", S("Veteran Track Technician"), S("Place 1000 TCBs"), 30, 1000},
        -- advtrains basic trains
        {"wagon_subway_1", "advtrains:subway_wagon", "unilib_craft", S("Amateur Transit Engineer"), S("Craft a subway passenger wagon"), 10, 1},
        {"wagon_subway_2", "advtrains:subway_wagon", "unilib_craft", S("Skilled Transit Engineer"), S("Craft 10 subway passenger wagons"), 20, 10},
        {"wagon_subway_3", "advtrains:subway_wagon", "unilib_craft", S("Veteran Transit Engineer"), S("Craft 100 subway passenger wagons"), 30, 100},

        {"wagon_box_1", "advtrains:wagon_box", "unilib_craft", S("Amateur Boxcar Fabricator"), S("Craft a box wagon"), 10, 1},
        {"wagon_box_2", "advtrains:wagon_box", "unilib_craft", S("Skilled  Boxcar Fabricator"), S("Craft 10 box wagons"), 20, 10},

        {"engine_steam_1", "advtrains:newlocomotive", "unilib_craft", S("Amateur Steam Engineer"), S("Craft a steam engine"), 10, 1},
        {"engine_steam_2", "advtrains:newlocomotive", "unilib_craft", S("Skilled Steam Engineer"), S("Craft 10 steam engines"), 20, 10},
        {"engine_detailed_1", "advtrains:detailed_steam_engine", "unilib_craft", S("Novice Steam Engineer"), S("Craft a detailed steam engine"), 10, 1},
        {"engine_detailed_2", "advtrains:wagon_default", "unilib_craft", S("Veteran Steam Engineer"), S("Craft 10 detailed steam engines"), 20, 10},
        {"wagon_passenger_1", "advtrains:wagon_default", "unilib_craft", S("Amateur Wagonwright"), S("Craft a passenger wagon"), 10, 1},
        {"wagon_passenger_2", "advtrains:wagon_default", "unilib_craft", S("Skilled Wagonwright"), S("Craft 10 passenger wagons"), 20, 10},

        {"engine_japanese_1", "advtrains:engine_japan", "unilib_craft", S("Amateur Shinkansen Engineer"), S("Craft a Japanese train engine"), 10, 1},
        {"engine_japanese_2", "advtrains:engine_japan", "unilib_craft", S("Skilled Shinkansen Engineer"), S("Craft 10 Japanese train engines"), 20, 10},
        {"engine_japanese_3", "advtrains:engine_japan", "unilib_craft", S("Veteran Shinkansen Engineer"), S("Craft 100 Japanese train engines"), 30, 100},
        {"wagon_japanese_1", "advtrains:wagon_japan", "unilib_craft", S("Amateur Shinkansen Smith"), S("Craft a Japanese train wagon"), 10, 1},
        {"wagon_japanese_2", "advtrains:wagon_japan", "unilib_craft", S("Skilled Shinkansen Smith"), S("Craft 10 Japanese train wagons"), 20, 10},
        {"wagon_japanese_3", "advtrains:wagon_japan", "unilib_craft", S("Veteran Shinkansen Smith"), S("Craft 100 Japanese train wagons"), 30, 100},

        {"engine_industrial_1", "advtrains:engine_industrial", "unilib_craft", S("Amateur Locomotive Engineer"), S("Craft an industrial train engine"), 10, 1},
        {"engine_industrial_2", "advtrains:engine_industrial", "unilib_craft", S("Skilled Locomotive Engineer"), S("Craft 10 industrial train engines"), 20, 10},
        {"engine_industrial_3", "advtrains:engine_industrial_big", "unilib_craft", S("Veteran Locomotive Engineer"), S("Craft 10 big industrial train engines"), 20, 10},
        {"wagon_tank_1", "advtrains:wagon_tank", "unilib_craft", S("Amateur Railcar Technician"), S("Craft an industrial tank wagon"), 10, 1},
        {"wagon_tank_2", "advtrains:wagon_tank", "unilib_craft", S("Novice Railcar Technician"), S("Craft 10 industrial tank wagons"), 20, 10},
        {"wagon_wood_1", "advtrains:wagon_wood", "unilib_craft", S("Skilled Railcar Technician"), S("Craft an industrial wood wagon"), 10, 1},
        {"wagon_wood_2", "advtrains:wagon_wood", "unilib_craft", S("Veteran Railcar Technician"), S("Craft 10 industrial wood wagons"), 20, 10},
        -- carts
        {"rail_1", "group:rail", "unilib_place", S("Amateur Rollercoaster Designer"), S("Place 20 cart rails"), 10, 20},
        {"rail_2", "group:rail", "unilib_place", S("Skilled Rollercoaster Designer"), S("Place 200 cart rails"), 20, 200},
        {"rail_3", "group:rail", "unilib_place", S("Veteran Rollercoaster Designer"), S("Place 2000 cart rails"), 30, 2000},
    }) do

        if unilib.awards.check_argument(mini_list[2]) then

            unilib.awards.register_achievement({
                name = "unilib_trainspotter_comb_" .. mini_list[1],
                trigger_table = {
                    prototype = mini_list[3],
                    target = mini_list[7],
                    item_list = unilib.utils.convert_to_list(mini_list[2]),
                },

                title = mini_list[4],
                description = mini_list[5],
                score = mini_list[6],
                vocation_list = {unilib.pkg.award_trainspotter.vocation_name},
            })

        end

    end

    -- Selective achievements
    for i, mini_list in ipairs({
        -- advtrains
        {"track_atc", "advtrains:dtrack_atc_placer", "unilib_craft", S("Auto Train Confuser"), S("Place 20 ATC controllers"), 10, 20},
        {"track_bumper", "advtrains:dtrack_bumper_placer", "unilib_craft", S("Bumpkin"), S("Craft 20 bumpers"), 10, 20},
        {"track_slope", "advtrains:dtrack_slopeplacer", "unilib_craft", S("Going On Tilt"), S("Craft 120 track slopes"), 20, 120},
        {"track_tool", "advtrains:trackworker", "unilib_craft", S("Spanner in the Works"), S("Craft a track worker tool"), 10, 1},
        {"interlock_tool", "advtrains_interlocking:tool", "unilib_craft", S("Master of Misalignment"), S("Craft an interlocking tool"), 10, 1},
        -- carts
        {"cart_ordinary", "unilib:cart_ordinary", "unilib_craft", S("Wheeler Dealer"), S("Craft 2 ordinary carts"), 10, 2},
        {"rail_break", "unilib:rail_ordinary_brake", "unilib_place", S("Fun Regulator"), S("Place 111 ordinary breaking rails"), 10, 111},
        {"rail_copper", "unilib:rail_copper", "unilib_place", S("Twist and Shout"), S("Place 111 copper rails"), 10, 111},
        {"rail_powered", "unilib:rail_ordinary_powered", "unilib_place", S("On the Fast Track"), S("Place 111 ordinary powered rails"), 10, 111},
    }) do

        if unilib.awards.check_argument(mini_list[2]) then

            unilib.awards.register_achievement({
                name = "unilib_trainspotter_select_" .. mini_list[1],
                trigger_table = {
                    prototype = mini_list[3],
                    target = mini_list[7],
                    item_list = unilib.utils.convert_to_list(mini_list[2]),
                },

                title = mini_list[4],
                description = mini_list[5],
                score = mini_list[6],
                vocation_list = {unilib.pkg.award_trainspotter.vocation_name},
            })

        end

    end

end
