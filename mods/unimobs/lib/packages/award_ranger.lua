---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unimobs
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.award_ranger = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.unimobs.add_mode

-- Items for the "Silk Road" achievement
local silk_lookup_table = {
    ["unilib:clothing_boots_silk"] = true,
    ["unilib:clothing_coat_silk"] = true,
    ["unilib:clothing_trousers_silk"] = true,
}
-- Items for the "Prince of the North" achievement
local prince_lookup_table = {
    ["unilib:clothing_coat_wolf"] = true,
    ["unilib:clothing_crown_prince"] = true,
}
-- Items for "The Ball Pit" achievement
local ball_lookup_table = {
    ["unilib:item_ball_square_basketball"] = true,
    ["unilib:item_ball_square_beach"] = true,
    ["unilib:item_ball_square_football"] = true,
}
-- Mob types for perfect genetics achievements (populated below)
local perfect_lookup_table = {}
-- Mob types for mutations (populated below)
local mutation_lookup_table = {}

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

unilib.pkg.award_ranger.vocation_name = "unimobs_ranger"

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function handle_craft_special(player, full_name, lookup_table, achievement_name)

    -- The player data table has a key-value pair for every item of the set crafted
    local pname = player:get_player_name()
    local awards_table = unilib.global.awards_player_table[pname]

    if awards_table["data_table"][achievement_name] == nil then
        awards_table["data_table"][achievement_name] = {}
    end

    if awards_table["data_table"][achievement_name][full_name] ~= nil then
        return
    end

    -- New item of the set has been crafted
    awards_table["data_table"][main_achievement][full_name] = true
    if unilib.utils.get_table_size(awards_table["data_table"][achievement_name]) >=
            unilib.utils.get_table_size(lookup_table) then
        unilib.awards.unlock_achievement(player, achievement_name)
    end

end

local function on_craft_special(player, full_name)

    if not unilib.utils.is_player(player) or full_name == nil then
        return
    end

    if silk_lookup_table[full_name] then

        handle_craft_special(
            player, full_name, silk_lookup_table, "unimobs_ranger_select_craft_silk"
        )

    elseif prince_lookup_table[full_name] then

        handle_craft_special(
            player, full_name, prince_lookup_table, "unimobs_ranger_select_craft_prince"
        )

    elseif ball_lookup_table[full_name] then

        handle_craft_special(
            player, full_name, ball_lookup_table, "unimobs_ranger_select_craft_ball"
        )

    end

end

local function has_perfect_genetics(self)

    for gene_type, _ in pairs(self.genetic_table) do

        -- (Skin numbers are stored in .genetic_table; ignore them)
        if string.sub(gene_type, 1, 5) ~= "skin_" then

            local current_val, min_val, max_val =
                    unimobs.petz_api.get_genetic_range(self, gene_type)
            if current_val < max_val then
                return false
            end

        end

    end

    return true

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.award_ranger.on_mob_breed(player, self)

    -- Called by create_baby_entity() in unimobs/lib/system/petz/petz_breed.lua

    if not unilib.setting.awards_enable_flag or
            not unilib.utils.is_player(player) or
            self == nil or
            self.mob_type == nil or
            self.genetic_table == nil then
        return
    end

    if perfect_lookup_table[self.mob_type] ~= nil and has_perfect_genetics(self) then

        -- e.g. "unimobs_ranger_select_breed_pony_normal"
        local achievement_name = "unimobs_ranger_select_breed_" .. self.mob_type
        unilib.awards.unlock_achievement(player, achievement_name)

    end

    if mutation_lookup_table[self.mob_type] then

        local skin = unimobs.petz_api.get_skin_type(self)

        for _, achievement_name in ipairs(
            unilib.awards.retrieve_data_from_simple_watch_table(player, "ranger_select_mutation")
        ) do

            local trigger_table =
                    unilib.global.awards_achievement_table[achievement_name]["trigger_table"]

            -- N.B. In this case, we do NOT handle the event if .filter_list is nil
            if trigger_table.filter_list ~= nil and
                    self.mob_type == trigger_table.filter_list[1] and
                    skin == trigger_table.filter_list[2] then
                unilib.awards.unlock_achievement(player, achievement_name)
            end

        end

    end

end

function unilib.pkg.award_ranger.on_mob_milk(player, self)

    -- Called by unimobs.petz_api.extract_milk_from_mob()

    if not unilib.setting.awards_enable_flag or
            not unilib.utils.is_player(player) or
            self == nil or
            self.mob_type == nil then
        return
    end

    for _, achievement_name in ipairs(
        unilib.awards.retrieve_data_from_simple_watch_table(player, "ranger_comb_milk")
    ) do

        local trigger_table =
                unilib.global.awards_achievement_table[achievement_name]["trigger_table"]

        -- N.B. In this case, we do NOT handle the event if .filter_list is nil
        if trigger_table.filter_list ~= nil and
                unilib.utils.is_value_in_list(self.mob_type, trigger_table.filter_list) then
            unilib.awards.increment_achievement_counter(player, achievement_name, 1)
        end

    end

end

function unilib.pkg.award_ranger.on_mob_mount(player, self)

    -- Called by unimobs.petz_api.mount_player_on_mob()

    if not unilib.setting.awards_enable_flag or
            not unilib.utils.is_player(player) or
            self == nil or
            self.mob_type == nil then
        return
    end

    if self.mob_type == "pony_normal" then

        unilib.awards.unlock_achievement(player, "unimobs_ranger_select_ride_pony_normal")
        if has_perfect_genetics(self) then

            unilib.awards.unlock_achievement(
                player, "unimobs_ranger_select_ride_pony_normal_perfect"
            )

        end

    elseif self.mob_type == "camel_normal" then

        unilib.awards.unlock_achievement(player, "unimobs_ranger_select_ride_camel_normal")
        if has_perfect_genetics(self) then

            unilib.awards.unlock_achievement(
                player, "unimobs_ranger_select_ride_camel_normal_perfect"
            )

        end

    end

end

function unilib.pkg.award_ranger.on_mob_shear(player, self)

    -- Called by code in the "mob_sheep_normal" package

    if not unilib.setting.awards_enable_flag or
            not unilib.utils.is_player(player) or
            self == nil or
            self.mob_type == nil then
        return
    end

    for _, achievement_name in ipairs(
        unilib.awards.retrieve_data_from_simple_watch_table(player, "ranger_comb_shear")
    ) do

        local trigger_table =
                unilib.global.awards_achievement_table[achievement_name]["trigger_table"]

        -- N.B. In this case, we do NOT handle the event if .filter_list is nil
        if trigger_table.filter_list ~= nil and
                unilib.utils.is_value_in_list(self.mob_type, trigger_table.filter_list) then
            unilib.awards.increment_achievement_counter(player, achievement_name, 1)
        end

    end

end

function unilib.pkg.award_ranger.on_wagon_ride(player, self)

    -- Called by unimobs.petz_api.mount_player_on_mob()

    if not unilib.setting.awards_enable_flag or
            not unilib.utils.is_player(player) or
            self == nil or
            self.mob_type == nil then
        return
    end

    unilib.awards.unlock_achievement(player, "unimobs_ranger_select_general_wagon_pony")

end

function unilib.pkg.award_ranger.on_lycanthropy_infect(player)

    -- Called by unilib.pkg.shared_petz_lycanthropy.infect_player()

    if not unilib.setting.awards_enable_flag or not unilib.utils.is_player(player) then
        return
    end

    unilib.awards.unlock_achievement(player, "unimobs_ranger_select_curse_infect")

end

function unilib.pkg.award_ranger.on_lycanthropy_cure(player)

    -- Called by unilib.pkg.shared_petz_lycanthropy.cure_player()

    if not unilib.setting.awards_enable_flag or not unilib.utils.is_player(player) then
        return
    end

    unilib.awards.unlock_achievement(player, "unimobs_ranger_select_curse_cure")

end

function unilib.pkg.award_ranger.on_sketchbook_fill(player, advanced_flag)

    -- Called by update_sketch_counts() in the "item_book_sketch" package

    if not unilib.setting.awards_enable_flag or not unilib.utils.is_player(player) then
        return
    end

    if not advanced_flag then
        unilib.awards.unlock_achievement(player, "unimobs_ranger_select_sketch_beginner")
    else
        unilib.awards.unlock_achievement(player, "unimobs_ranger_select_sketch_advanced")
    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.award_ranger.init()

    return {
        description = "Awards for various animal-related activities (\"Park Ranger\")",
        notes = "Works with petz-compatible mobs in the unimobs expansion pack (only). Assumes a" ..
                " world with the \"petz\", \"gaia_unimobs\" remixes (or similar)",
    }

end

function unilib.pkg.award_ranger.post()

    -- Sanity check -------------------------------------------------------------------------------

    if not unilib.setting.awards_enable_flag then
        return
    end

    -- Trigger prototypes -------------------------------------------------------------------------

    unilib.awards.register_trigger_prototype({
        name = "ranger_comb_milk",
        trigger_type = "simple",
        hint_list = {"Milk one creature", "Milk @1 creatures"},
        progress_list = {"Milk one creature", "Milk @1/@2 creatures"},
    })

    unilib.awards.register_trigger_prototype({
        name = "ranger_comb_shear",
        trigger_type = "simple",
        hint_list = {"Shear one creature", "Shear @1 creatures"},
        progress_list = {"Shear one creature", "Shear @1/@2 creatures"},
    })

    unilib.awards.register_trigger_prototype({
        name = "ranger_select_craft",
        trigger_type = "simple",
        hint_list = {"Craft one set of items", "Craft @1 sets of items"},
        progress_list = {"Craft one set of items", "Craft @1/@2 sets of items"},
    })

    unilib.awards.register_trigger_prototype({
        name = "ranger_select_ride",
        trigger_type = "simple",
        hint_list = {"Collect one riding achievement", "Collect @1 riding achievements"},
        progress_list = {"Collect one riding achievement", "Collect @1/@2 riding achievements"},
    })

    unilib.awards.register_trigger_prototype({
        name = "ranger_select_curse",
        trigger_type = "simple",
        hint_list = {"Collect one lycanthropy achievement", "Collect @1 lycanthropy achievements"},
        progress_list = {"Collect one lycanthropy achievement", "Collect @1/@2 lycanthropy achievements"},
    })

    unilib.awards.register_trigger_prototype({
        name = "ranger_select_sketch",
        trigger_type = "simple",
        hint_list = {"Fill one sketchbook", "Fill @1 sketchbooks"},
        progress_list = {"Fill one sketchbook", "Fill @1/@2 sketchbooks"},
    })

    unilib.awards.register_trigger_prototype({
        name = "ranger_select_breed",
        trigger_type = "simple",
        hint_list = {"Breed one pedigree creature", "Breed @1 pedigree creatures"},
        progress_list = {"Breed one pedigree creature", "Breed @1/@2 pedigree creatures"},
    })

    unilib.awards.register_trigger_prototype({
        name = "ranger_select_mutation",
        trigger_type = "simple",
        hint_list = {"Breed one mutation", "Breed @1 mutations"},
        progress_list = {"Breed one mutation", "Breed @1/@2 mutations"},
    })

    -- Trigger event callbacks --------------------------------------------------------------------

    core.register_on_craft(function(itemstack, player, old_craft_grid, craft_inv)
        on_craft_special(player, itemstack:get_name())
    end)

    -- Vocations ----------------------------------------------------------------------------------

    -- The achievements below provide the following total scores:
    --      - general: 330
    --      - special: 920
    --      - mutations: 1300
    --      - (total): 2550
    -- Let's use all achievements with scores of 20 or lower (total 450), plus five achievements
    --      with scores of 100, or equivalent; for a grand total of 950
    unilib.awards.register_vocation({
        name = unilib.pkg.award_ranger.vocation_name,

        title = S("Park Ranger"),
        description = S("Animal lover? You can probably make a career out of it!"),
        icon = "unilib_award_vocation_ranger.png",
        level_list = {
            {title = S("Bad Egg"), score = 10},
            {title = S("Shear Luck"), score = 20},
            {title = S("Feather Forecast"), score = 50},
            {title = S("Piggyback Ride"), score = 100},
            {title = S("Wax On, Wax Off"), score = 150},
            {title = S("Wool You Just Look at That"), score = 200},
            {title = S("Fur Real?"), score = 300},
            {title = S("Run, Rabbit, Run!"), score = 400},
            {title = S("Milk it for All It's Worth"), score = 500},
            {title = S("Honey, I'm Comb"), score = 600},
            {title = S("Shell-Shocked"), score = 750},
            {title = S("Eggs-ecutive Decision"), score = 950},
        },
    })

    -- Achievements -------------------------------------------------------------------------------

    -- Combination achievements (milking/shearing animals)
    for i, mini_list in ipairs({
        {"milk_cow_1", "cow_normal", S("Amateur Milkmaid"), S("Milk a cow"), 10, 1},
        {"milk_cow_2", "cow_normal", S("Skilled Milkmaid"), S("Milk 20 cows"), 20, 20},
        {"milk_cow_3", "cow_normal", S("Veteran Milkmaid"), S("Milk 400 cows"), 30, 400},

        {"milk_camel_1", "camel_normal", S("Amateur Camel Farmer"), S("Milk a camel"), 10, 1},
        {"milk_camel_2", "camel_normal", S("Skilled Camel Farmer"), S("Milk 20 camels"), 20, 20},
        {"milk_camel_3", "camel_normal", S("Veteran Camel Farmer"), S("Milk 400 camels"), 30, 400},

        {"milk_goat_1", "goat_normal", S("Amateur Goatherd"), S("Milk a goat"), 10, 1},
        {"milk_goat_2", "goat_normal", S("Skilled Goatherd"), S("Milk 20 goats"), 20, 20},
        {"milk_goat_3", "goat_normal", S("Veteran Goatherd"), S("Milk 400 goats"), 30, 400},

        {"shear_sheep_1", "sheep_normal", S("Amateur Sheep Shearer"), S("Shear a sheep"), 10, 1},
        {"shear_sheep_2", "sheep_normal", S("Skilled Sheep Shearer"), S("Shear 20 sheep"), 20, 20},
        {"shear_sheep_3", "sheep_normal", S("Veteran Sheep Shearer"), S("Shear 400 sheep"), 30, 400},
    }) do

        local prototype = "ranger_comb_milk"
        if mini_list[2] == "sheep_normal" then
            prototype = "ranger_comb_shear"
        end

        unilib.awards.register_achievement({
            name = "unimobs_ranger_comb_" .. mini_list[1],
            trigger_table = {
                prototype = prototype,
                target = mini_list[6],
                filter_list = unilib.utils.convert_to_list(mini_list[2]),
            },

            title = mini_list[3],
            description = mini_list[4],
            score = mini_list[5],
            vocation_list = {unilib.pkg.award_ranger.vocation_name},
        })

    end

    -- Selective achievements (general)
    for i, mini_list in ipairs({
        -- (Crafting)
        {"candle_beeswax", "unilib:candle_beeswax", "unilib_craft", S("Chandler"), S("Craft 50 beeswax candles"), 10, 50},
        {"book_leather", "unilib:item_book_leather", "unilib_craft", S("Bookbinder"), S("Craft 5 leather books"), 10, 5},
        {"book_bestiary", "unilib:item_book_bestiary", "unilib_craft", S("Natural Historian"), S("Craft a bestiary"), 10, 1},
        {"sketchbook", {"unilib:item_book_sketch_beginner", "unilib:item_book_sketch_advanced"}, "unilib_craft", S("Sketch Artist"), S("Craft a creature sketchbook"), 10, 1},
        {"dreamcatcher_pet", "unilib:item_dreamcatcher_pet", "unilib_craft", S("Catcher of Dreams"), S("Craft 5 dreamcatchers"), 10, 5},
        {"hairbrush", "unilib:item_hairbrush", "unilib_craft", S("Brushmaker"), S("Craft a hairbrush"), 10, 1},
        {"horseshoe_normal", "unilib:item_horseshoe_normal", "unilib_craft", S("Farrier"), S("Craft 8 horseshoes"), 10, 8},
        {"net_animal", "unilib:item_net_animal", "unilib_craft", S("Netmaker"), S("Craft an animal net"), 10, 1},
        {"paper_parchment", "unilib:item_paper_parchment", "unilib_craft", S("Vellum Maker"), S("Craft 20 parchments"), 10, 20},
        {"saddle_normal", "unilib:item_saddle_normal", "unilib_craft", S("Saddler"), S("Craft 6 saddles"), 10, 6},
        {"saddlebag_normal", "unilib:item_saddlebag_normal", "unilib_craft", S("Old Bag"), S("Craft 3 saddle-bags"), 10, 3},
        {"syringe_glass", "unilib:item_syringe_glass_empty", "unilib_craft", S("Veterinarian"), S("Craft 2 glass syringes"), 10, 2},
        {"whip_obedience", "unilib:item_whip_obedience", "unilib_craft", S("Circus trainer"), S("Craft an obedience whip"), 10, 1},
        {"whistle_pet", "unilib:item_whistle_pet", "unilib_craft", S("Whistler"), S("Craft a pet whistle"), 10, 1},
        {"machine_spinning", "unilib:machine_wheel_spinning", "unilib_craft", S("Spinster"), S("Craft a spinning wheel"), 10, 1},
        {"basket_cat", "unilib:misc_basket_cat", "unilib_craft", S("Basket case"), S("Craft 3 cat baskets"), 10, 3},
        {"bowl_pet", "unilib:misc_bowl_pet", "unilib_craft", S("Bowled Over"), S("Craft 3 pet bowls"), 10, 3},
        {"dung_guano", "unilib:misc_dung_guano_block", "unilib_craft", S("Guano Analyst"), S("Craft 14 guano blocks"), 10, 14},
        {"dung_normal", "unilib:misc_dung_normal_block", "unilib_craft", S("Coprologist"), S("Craft 14 normal blocks"), 10, 14},
        {"dung_scat", "unilib:misc_dung_scat_block", "unilib_craft", S("Scat Miner"), S("Craft 14 scat blocks"), 10, 14},
        {"hive_normal", "unilib:misc_hive_normal", "unilib_craft", S("Skep Maker"), S("Craft 3 bee hives"), 10, 3},
        {"stand_bird", "unilib:misc_stand_bird", "unilib_craft", S("Aviary Carpenter"), S("Craft a bird stand"), 10, 1},
        {"wagon_pony", "unilib:misc_wagon_pony", "unilib_craft", S("Wainwright"), S("Craft 2 pony wagons"), 10, 2},
        {"potion_lycanthropy", "unilib:potion_lycanthropy", "unilib_craft", S("Lycanthropist"), S("Craft a lycanthropy potion"), 10, 1},
        {"crook_shepherd", "unilib:tool_crook_shepherd", "unilib_craft", S("Country Stickmaker"), S("Craft a shepherd's crook"), 10, 1},
        {"lasso_normal", "unilib:tool_lasso_normal", "unilib_craft", S("Rawhider"), S("Craft a normal lasso"), 10, 1},
        {"shears_steel", "unilib:tool_shears_steel", "unilib_craft", S("Sheepshearer"), S("Craft steel shears"), 10, 1},
        {"bottle_butterfly", "unilib:vessel_bottle_glass_with_butterfly", "unilib_craft", S("Lepidopterist"), S("Craft a butterfly in a glass bottle"), 10, 1},
        {"bottle_moth", "unilib:vessel_bottle_glass_with_moth", "unilib_craft", S("Drawn to the Light"), S("Craft a moth in a glass bottle"), 10, 1},
        -- (Placing)
        {"shelter_cage", "unilib:misc_shelter_cage", "unilib_place", S("Caged In"), S("Place an animal cage"), 10, 1},
        {"shelter_kennel", "unilib:misc_shelter_kennel", "unilib_place", S("Kennel maker"), S("Place a dog kennel"), 10, 1},
        {"showcase_butterfly", "unilib:misc_showcase_butterfly", "unilib_place", S("Wing It"), S("Place a butterfly showcase"), 10, 1},
        {"tank_fish", "unilib:misc_tank_fish", "unilib_place", S("Aquarium Keeper"), S("Place a fish tank"), 10, 1},
    }) do

        if unilib.awards.check_argument(mini_list[2]) then

            unilib.awards.register_achievement({
                name = "unimobs_ranger_select_general_" .. mini_list[1],
                trigger_table = {
                    prototype = mini_list[3],
                    target = mini_list[7],
                    item_list = unilib.utils.convert_to_list(mini_list[2]),
                },

                title = mini_list[4],
                description = mini_list[5],
                score = mini_list[6],
                vocation_list = {unilib.pkg.award_ranger.vocation_name},
            })

        end

    end

    -- Selective achievements (special)
    for _, mini_list in ipairs({
        -- (Crafting)
        {"silk", "ranger_select_craft", S("Silk Road"), S("Craft a silk dress coat, trousers and boots"), 10, 1},
        {"prince", "ranger_select_craft", S("Prince of the North"), S("Craft a wolf coat and a crown"), 10, 1},
        {"ball", "ranger_select_craft", S("The Ball Pit"), S("Craft 3 types of square ball"), 10, 1},
        -- (Riding)
        {"pony_normal", "ranger_select_ride", S("Pony Express"), S("Ride a pony"), 10, 1},
        {"pony_normal_perfect", "ranger_select_ride", S("Grand Prix"), S("Ride a pony with perfect genetics"), 20, 1},
        {"camel_normal", "ranger_select_ride", S("Camelot Tourist"), S("Ride a camel"), 10, 1},
        {"camel_normal_perfect", "ranger_select_ride", S("Sand in my Shoes"), S("Ride a camel with perfect genetics"), 20, 1},
        {"wagon_pony", "ranger_select_ride", S("Wagon Wheel"), S("Ride a pony wagon"), 10, 1},
        -- (Lycanthropy)
        {"infect", "ranger_select_curse", S("Puppy Problems"), S("Get infected by the Curse of Lycanthropy"), 10, 1},
        {"cure", "ranger_select_curse", S("Paw and Order"), S("Cure yourself of the Curse of Lycanthropy"), 10, 1},
        -- (Sketchbooks)
        {"beginner", "ranger_select_sketch", S("Paw-trait Practice"), S("Fill a beginner's creature sketchbook"), 100, 1},
        {"advanced", "ranger_select_sketch", S("Cock-a-Doodle-Doo"), S("Fill an advanced creature sketchbook"), 200, 1},
    }) do

        unilib.awards.register_achievement({
            name = "unimobs_" .. mini_list[2] .. "_" .. mini_list[1],
            trigger_table = {
                prototype = mini_list[2],
                target = mini_list[6],
            },

            title = mini_list[3],
            description = mini_list[4],
            score = mini_list[5],
            vocation_list = {unilib.pkg.award_ranger.vocation_name},
        })

    end

    -- Selective achievements (special - breeding)
    for _, mini_list in ipairs({
        -- (Breeding)
        {"pony_normal", "ranger_select_breed", S("Pony Up"), S("Breed a pony with perfect genetics"), 100, 1},
        {"camel_normal", "ranger_select_breed", S("Dune Buggy"), S("Breed a camel with perfect genetics"), 100, 1},
        {"cat_normal", "ranger_select_breed", S("Furmidable Ally"), S("Breed a cat with perfect genetics"), 100, 1},
        {"dog_normal", "ranger_select_breed", S("Leader of the Pack"), S("Breed a dog with perfect genetics"), 100, 1},
        {"penguin_normal", "ranger_select_breed", S("Frosty Friend"), S("Breed a penguin with perfect genetics"), 100, 1},
    }) do

        perfect_lookup_table[mini_list[1]] = true

        unilib.awards.register_achievement({
            name = "unimobs_" .. mini_list[2] .. "_" .. mini_list[1],
            trigger_table = {
                prototype = mini_list[2],
                target = mini_list[6],
            },

            title = mini_list[3],
            description = mini_list[4],
            score = mini_list[5],
            vocation_list = {unilib.pkg.award_ranger.vocation_name},
        })

    end

    -- Selective achievements (mutations)
    for i, mini_list in ipairs({
        {"cat_normal", "gina", S("Feline Groovy"), S("Breed a gina cat"), 100, 1},
        {"cat_normal", "lavender", S("Kitten Around"), S("Breed a lavender cat"), 100, 1},
        {"camel_normal", "white", S("Four-Legged Sultan"), S("Breed a white camel"), 100, 1},
        {{"elephant_normal_male", "elephant_normal_female"}, "white", S("The Ivory Tower"), S("Breed a white elephant"), 100, 1},
        {"hamster_normal", "pink", S("Tickled Pink"), S("Breed a pink hamster"), 100, 1},
        {"pig_normal", "blue", S("Feeling Blue"), S("Breed a blue pig"), 100, 1},
        {"pigeon_normal", "purple", S("Pigeon Impossible"), S("Breed a purple pigeon"), 100, 1},
        {"pony_normal", "lavender", S("Mane Attraction"), S("Breed a lavender pony"), 100, 1},
        {"pony_normal", "rainbow", S("Neigh-On Impossible"), S("Breed a rainbow pony"), 100, 1},
        {"rabbit_normal", "pink", S("Hare Today, Gone Tomorrow"), S("Breed a pink rabbit"), 100, 1},
        {"sheep_normal", "strawberry", S("Jam-Packed"), S("Breed a strawberry sheep"), 100, 1},
        {"sheep_normal", "vanilla", S("Ewe Tried"), S("Breed a vanilla sheep"), 100, 1},
        {"toucan_normal", "white", S("Albino Airforce"), S("Breed a white toucan"), 100, 1},
    }) do

        mutation_lookup_table[mini_list[1]] = true

        local mob_type
        if type(mini_list[1]) == "table" then
            mob_type = mini_list[1][1]
        else
            mob_type = mini_list[1]
        end

        unilib.awards.register_achievement({
            name = "unimobs_ranger_select_mutation_" .. mob_type .. "_" .. mini_list[2],
            trigger_table = {
                prototype = "ranger_select_mutation",
                target = mini_list[6],
                filter_list = {mini_list[1], mini_list[2]},
            },

            title = mini_list[3],
            description = mini_list[4],
            score = mini_list[5],
            vocation_list = {unilib.pkg.award_ranger.vocation_name},
        })

    end

end
