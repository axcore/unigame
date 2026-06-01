---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unimobs
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.award_warrior = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.unimobs.add_mode

local monster_count = 0
local wild_count = 0
local passive_count = 0

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

unilib.pkg.award_warrior.vocation_name = "unimobs_warrior"

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function compile_counts()

    for mob_type, _ in pairs(unimobs.petz_global.mob_table) do

        local defn_table = core.registered_entities["unilib:mob_" .. mob_type]
        if defn_table then

            if defn_table.is_monster_flag then
                monster_count = monster_count + 1
            elseif defn_table.is_wild_flag then
                wild_count = wild_count + 1
            else
                passive_count = passive_count + 1
            end

        end

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.award_warrior.on_mob_kill(player, self)

    -- Called by unimobs.petz_api.on_punch_callback()

    -- Ignored petz-incompatible mobs, and mobs owned by players (including the specified one)
    if not unilib.setting.awards_enable_flag or
            not unilib.utils.is_player(player) or
            not self or
            self.mob_type == nil or
            self.owner_name ~= nil then
        return
    end

    if self.is_monster_flag then

        unilib.awards.handle_simple_trigger(player, "warrior_comb_monster")
        unilib.awards.handle_collection_trigger(
            player, "warrior_collect_monster", "unimobs_warrior_collect_monster_1", self.mob_type
        )

    elseif self.is_wild_flag then

        unilib.awards.handle_simple_trigger(player, "warrior_comb_wild")
        unilib.awards.handle_collection_trigger(
            player, "warrior_collect_wild", "unimobs_warrior_collect_wild_1", self.mob_type
        )

    else

        unilib.awards.handle_simple_trigger(player, "warrior_comb_passive")
        unilib.awards.handle_collection_trigger(
            player, "warrior_collect_passive", "unimobs_warrior_collect_passive_1", self.mob_type
        )

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.award_warrior.init()

    return {
        description = "Awards for killing non-player mobs (\"Warrior\")",
        notes = "Works with petz-compatible mobs in the unimobs expansion pack (only)",
    }

end

function unilib.pkg.award_warrior.post()

    -- Sanity check -------------------------------------------------------------------------------

    if not unilib.setting.awards_enable_flag then
        return
    end

    -- Setup code ---------------------------------------------------------------------------------

    -- Count monsters, wild animals and passive creatures
    compile_counts()

    -- Trigger prototypes -------------------------------------------------------------------------

    unilib.awards.register_trigger_prototype({
        name = "warrior_comb_monster",
        trigger_type = "simple",
        hint_list = {"Kill one monster", "Kill @1 monsters"},
        progress_list = {"Kill one monster", "Kill @1/@2 monsters"},
    })

    unilib.awards.register_trigger_prototype({
        name = "warrior_comb_wild",
        trigger_type = "simple",
        hint_list = {"Kill one wild animal", "Kill @1 wild animals"},
        progress_list = {"Kill one wild animal", "Kill @1/@2 wild animals"},
    })

    unilib.awards.register_trigger_prototype({
        name = "warrior_comb_passive",
        trigger_type = "simple",
        hint_list = {"Kill one passive animal", "Kill @1 passive animals"},
        progress_list = {"Kill one passive animal", "Kill @1/@2 passive animals"},
    })

    unilib.awards.register_trigger_prototype({
        name = "warrior_collect_monster",
        trigger_type = "custom",
        hint_list = {"Kill one type of monster", "Kill @1 types of monster"},
        progress_list = {"Kill one type of monster", "Kill @1/@2 types of monster"},
    })

    unilib.awards.register_trigger_prototype({
        name = "warrior_collect_wild",
        trigger_type = "custom",
        hint_list = {"Kill one type of wild animal", "Kill @1 types of wild animal"},
        progress_list = {"Kill one type of wild animal", "Kill @1/@2 types of wild animal"},
    })

    unilib.awards.register_trigger_prototype({
        name = "warrior_collect_passive",
        trigger_type = "custom",
        hint_list = {"Kill one type of passive animal", "Kill @1 types of passive animal"},
        progress_list = {"Kill one type of passive animal", "Kill @1/@2 types of passive animal"},
    })

    -- Vocations ----------------------------------------------------------------------------------

    -- Assumes the creatures provided by the "petz" remix (5 monsters, 11 wild animals, 36 passive
    --      creatures) for a total score of 870
    unilib.awards.register_vocation({
        name = unilib.pkg.award_warrior.vocation_name,

        title = S("Warrior"),
        description = S("Kill monsters, wild animals and - yes - even fluffy bunnies!"),
        icon = "unilib_award_vocation_warrior.png",
        level_list = {
            {title = S("Featherweight"), score = 10},
            {title = S("Pelt Collector"), score = 20},
            {title = S("Fowl Play"), score = 50},
            {title = S("Lamb to the Slaughter"), score = 100},
            {title = S("Pig Problem"), score = 150},
            {title = S("Farmhouse Fallout"), score = 200},
            {title = S("A Beef With Everything"), score = 300},
            {title = S("A Horizon Without Movement"), score = 400},
            {title = S("Pastoral Apocalypse"), score = 500},
            {title = S("The Silent Meadow"), score = 600},
            {title = S("Farmageddon"), score = 700},
            {title = S("World's Quietest Farm"), score = 850},
        },
    })

    -- Achievements -------------------------------------------------------------------------------

    -- Combination achievements
    for i, mini_list in ipairs({
        {1, "warrior_comb_monster", S("Amateur Predator"), S("Kill 3 monsters"), 10, 3},
        {2, "warrior_comb_monster", S("Novice Predator"), S("Kill 9 monsters"), 20, 9},
        {3, "warrior_comb_monster", S("Skilled Predator"), S("Kill 27 monsters"), 30, 27},
        {4, "warrior_comb_monster", S("Veteran Predator"), S("Kill 81 monsters"), 40, 81},
        {5, "warrior_comb_monster", S("Elite Predator"), S("Kill 243 monsters"), 50, 243},

        {1, "warrior_comb_wild", S("Amateur Hunter"), S("Kill 3 wild animals"), 10, 3},
        {2, "warrior_comb_wild", S("Novice Hunter"), S("Kill 15 wild animals"), 20, 15},
        {3, "warrior_comb_wild", S("Skilled Hunter"), S("Kill 75 wild animals"), 30, 75},
        {4, "warrior_comb_wild", S("Veteran Hunter"), S("Kill 375 wild animals"), 50, 375},
        {5, "warrior_comb_wild", S("Elite Hunter"), S("Kill 1875 wild animals"), 100, 1875},

        {1, "warrior_comb_passive", S("Amateur Poacher"), S("Kill 3 passive animals"), 10, 3},
        {2, "warrior_comb_passive", S("Novice Poacher"), S("Kill 15 passive animals"), 10, 15},
        {3, "warrior_comb_passive", S("Skilled Poacher"), S("Kill 75 passive animals"), 20, 75},
        {4, "warrior_comb_passive", S("Veteran Poacher"), S("Kill 375 passive animals"), 20, 375},
        {5, "warrior_comb_passive", S("Elite Poacher"), S("Kill 1875 passive animals"), 50, 1875},
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
            vocation_list = {unilib.pkg.award_warrior.vocation_name},
        })

    end

    -- Collector achievements
    if monster_count >= 5 then

        local monster_list = {
            {S("Elite Eradicator"), S("Kill every type of monster"), 100, monster_count},
            {S("Amateur Eradicator"), S("Kill 2 types of monster"), 10, 2},
            {S("Aspiring Eradicator"), S("Kill 5 types of monster"), 10, 5},
        }

        if monster_count > 10 then
            table.insert(monster_list, {S("Novice Eradicator"), S("Kill 10 types of monster"), 10, 10})
        end

        if monster_count > 20 then
            table.insert(monster_list, {S("Skilled Eradicator"), S("Kill 20 types of monster"), 20, 20})
        end

        if monster_count > 30 then
            table.insert(monster_list, {S("Seasoned Eradicator"), S("Kill 30 types of monster"), 20, 30})
        end

        if monster_count > 50 then
            table.insert(monster_list, {S("Master Eradicator"), S("Kill 50 types of monster"), 30, 50})
        end

        if monster_count > 100 then
            table.insert(monster_list, {S("Grandmaster Eradicator"), S("Kill 100 types of monster"), 50, 100})
        end

        for i, mini_list in ipairs(monster_list) do

            unilib.awards.register_achievement({
                name = "unimobs_warrior_collect_monster_" .. i,
                trigger_table = {
                    prototype = "warrior_collect_monster",
                    target = mini_list[4],
                },

                title = mini_list[1],
                description = mini_list[2],
                score = mini_list[3],
                vocation_list = {unilib.pkg.award_warrior.vocation_name},
            })

        end

    end

    if wild_count >= 5 then

        local wild_list = {
            {S("Elite Annihilator"), S("Kill every type of wild animal"), 100, wild_count},
            {S("Amateur Annihilator"), S("Kill 2 types of wild animal"), 10, 2},
            {S("Aspiring Annihilator"), S("Kill 5 types of wild animal"), 10, 5},
        }

        if wild_count > 10 then
            table.insert(wild_list, {S("Novice Annihilator"), S("Kill 10 types of wild animal"), 10, 10})
        end

        if wild_count > 20 then
            table.insert(wild_list, {S("Skilled Annihilator"), S("Kill 20 types of wild animal"), 20, 20})
        end

        if wild_count > 30 then
            table.insert(wild_list, {S("Seasoned Annihilator"), S("Kill 30 types of wild animal"), 20, 30})
        end

        if wild_count > 50 then
            table.insert(wild_list, {S("Master Annihilator"), S("Kill 50 types of wild animal"), 30, 50})
        end

        if wild_count > 100 then
            table.insert(wild_list, {S("Grandmaster Annihilator"), S("Kill 100 types of wild animal"), 50, 100})
        end

        for i, mini_list in ipairs(wild_list) do

            unilib.awards.register_achievement({
                name = "unimobs_warrior_collect_wild_" .. i,
                trigger_table = {
                    prototype = "warrior_collect_wild",
                    target = mini_list[4],
                },

                title = mini_list[1],
                description = mini_list[2],
                score = mini_list[3],
                vocation_list = {unilib.pkg.award_warrior.vocation_name},
            })

        end

    end

    if passive_count >= 5 then

        local passive_list = {
            {S("Elite Exterminator"), S("Kill every type of passive animal"), 100, passive_count},
            {S("Amateur Exterminator"), S("Kill 2 types of passive animal"), 10, 2},
            {S("Aspiring Exterminator"), S("Kill 5 types of passive animal"), 10, 5},
        }

        if passive_count > 10 then
            table.insert(passive_list, {S("Novice Exterminator"), S("Kill 10 types of passive animal"), 10, 10})
        end

        if passive_count > 20 then
            table.insert(passive_list, {S("Skilled Exterminator"), S("Kill 20 types of passive animal"), 20, 20})
        end

        if passive_count > 30 then
            table.insert(passive_list, {S("Seasoned Exterminator"), S("Kill 30 types of passive animal"), 20, 30})
        end

        if passive_count > 50 then
            table.insert(passive_list, {S("Master Exterminator"), S("Kill 50 types of passive animal"), 30, 50})
        end

        if passive_count > 100 then
            table.insert(passive_list, {S("Grandmaster Exterminator"), S("Kill 100 types of passive animal"), 50, 100})
        end

        for i, mini_list in ipairs(passive_list) do

            unilib.awards.register_achievement({
                name = "unimobs_warrior_collect_passive_" .. i,
                trigger_table = {
                    prototype = "warrior_collect_passive",
                    target = mini_list[4],
                },

                title = mini_list[1],
                description = mini_list[2],
                score = mini_list[3],
                vocation_list = {unilib.pkg.award_warrior.vocation_name},
            })

        end

    end

end
