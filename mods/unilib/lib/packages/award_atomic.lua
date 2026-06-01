---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.award_atomic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

local vapourise_count = 0
local construct_count = 0

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

unilib.pkg.award_atomic.vocation_name = "unilib_atomic"

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function compile_counts()

    for full_name, _ in pairs(unilib.pkg.shared_atomic.vapourise_item_table) do

        if unilib.utils.get_mod_name(full_name) == "unilib" then
            vapourise_count = vapourise_count + 1
        end

    end

    construct_count = unilib.utils.get_table_size(unilib.pkg.shared_atomic.construct_table)

end

local function handle_combined(player, trigger_prototype, multiple)

    for _, achievement_name in ipairs(
        unilib.awards.retrieve_data_from_simple_watch_table(player, trigger_prototype)
    ) do

        local achievement_table = unilib.global.awards_achievement_table[achievement_name]
        if achievement_table["trigger_table"]["prototype"] == trigger_prototype then
            unilib.awards.increment_achievement_counter(player, achievement_name, multiple)
        end

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.award_atomic.on_vapourise(player, full_name, multiple)

    -- Called by code in the "machine_atomic_vapouriser" package

    if not unilib.setting.awards_enable_flag or
            not unilib.utils.is_player(player) or
            not full_name then
        return
    end

    unilib.awards.handle_simple_trigger(player, "atomic_comb_vapourise", multiple)
    unilib.awards.handle_complex_trigger(player, "atomic_select_vapourise", full_name, multiple)
    unilib.awards.handle_collection_trigger(
        player, "atomic_collect_vapourise", "unilib_atomic_collect_vapourise_1", full_name
    )

end

function unilib.pkg.award_atomic.on_construct(player, full_name, multiple)

    -- Called by code in the "machine_atomic_collector" package

    if not unilib.setting.awards_enable_flag or
            not unilib.utils.is_player(player) or
            not full_name then
        return
    end

    unilib.awards.handle_simple_trigger(player, "atomic_comb_construct", multiple)
    unilib.awards.handle_complex_trigger(player, "atomic_select_construct", full_name, multiple)
    unilib.awards.handle_collection_trigger(
        player, "atomic_collect_construct", "unilib_atomic_collect_construct_1", full_name
    )

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.award_atomic.init()

    return {
        description = "Awards for the \"atomic\" remix (\"Mad Scientist\")",
        depends = "shared_atomic",
    }

end

function unilib.pkg.award_atomic.post()

    -- Sanity check -------------------------------------------------------------------------------

    if not unilib.setting.awards_enable_flag or
            not unilib.global.pkg_executed_table["shared_atomic"] then
        return
    end

    -- Setup --------------------------------------------------------------------------------------

    -- N.B. The shared variables in the "shared_atomic" package contain a lot of aliases for non-
    --      unilib items; filter them out
    compile_counts()

    -- Trigger prototypes -------------------------------------------------------------------------

    unilib.awards.register_trigger_prototype({
        name = "atomic_comb_vapourise",
        trigger_type = "simple",
        hint_list = {"Vapourise one thing", "Vapourise @1 things"},
        progress_list = {"Vapourise one thing", "Vapourise @1/@2 things"},
    })

    unilib.awards.register_trigger_prototype({
        name = "atomic_comb_construct",
        trigger_type = "simple",
        hint_list = {"Construct one sample", "Construct @1 samples"},
        progress_list = {"Construct one sample", "Construct @1/@2 samples"},
    })

    unilib.awards.register_trigger_prototype({
        name = "atomic_select_vapourise",
        trigger_type = "simple",
        hint_list = {"Vapourise one thing", "Vapourise @1 things"},
        progress_list = {"Vapourise one thing", "Vapourise @1/@2 things"},
    })

    unilib.awards.register_trigger_prototype({
        name = "atomic_select_construct",
        trigger_type = "simple",
        hint_list = {"Construct one sample", "Construct @1 samples"},
        progress_list = {"Construct one sample", "Construct @1/@2 samples"},
    })

    unilib.awards.register_trigger_prototype({
        name = "atomic_collect_vapourise",
        trigger_type = "custom",
        hint_list = {"Vapourise one thing", "Vapourise @1 different things"},
        progress_list = {"Vapourise one thing", "Vapourise @1/@2 different things"},
    })

    unilib.awards.register_trigger_prototype({
        name = "atomic_collect_construct",
        trigger_type = "custom",
        hint_list = {"Construct one sample", "Construct @1 different samples"},
        progress_list = {"Construct one sample", "Construct @1/@2 different samples"},
    })

    -- Vocations ----------------------------------------------------------------------------------

    -- Assumes the "atomic" remix providing at least 100 vapourisable items and 50 constructable
    --      samples, total score 720
    unilib.awards.register_vocation({
        name = unilib.pkg.award_atomic.vocation_name,

        title = S("Mad Scientist"),
        description = S("Make use of atomic collector and vapouriser machines"),
        icon = "unilib_award_vocation_atomic.png",
        level_list = {
            {title = S("What's the Worst That Could Happen?"), score = 10},
            {title = S("Oops, Was That Important?"), score = 20},
            {title = S("Safety Goggles Optional"), score = 40},
            {title = S("Unattended Experiment"), score = 60},
            {title = S("Should It Be Making That Noise?"), score = 100},
            {title = S("The Lab Is On Fire Again"), score = 150},
            {title = S("Break It Until You Make It"), score = 200},
            {title = S("Crafting? That's So Last Century"), score = 300},
            {title = S("Molecular Mixologist"), score = 400},
            {title = S("Minor Containment Breach"), score = 500},
            {title = S("Ye Cannae Change the Laws of Physics"), score = 600},
            {title = S("The Universe Is My Crafting Table"), score = 720},
        },
    })

    -- Achievements -------------------------------------------------------------------------------

    -- Combination achievements
    for i, mini_list in ipairs({
        {1, "atomic_comb_vapourise", S("Amateur Vapouriser"), S("Vapourise 10 things"), 10, 10},
        {2, "atomic_comb_vapourise", S("Novice Vapouriser"), S("Vapourise 100 things"), 10, 100},
        {3, "atomic_comb_vapourise", S("Skilled Vapouriser"), S("Vapourise 250 things"), 20, 250},
        {4, "atomic_comb_vapourise", S("Veteran Vapouriser"), S("Vapourise 1000 things"), 20, 1000},
        {5, "atomic_comb_vapourise", S("Master Vapouriser"), S("Vapourise 2500 things"), 20, 2500},
        {6, "atomic_comb_vapourise", S("Elite Vapouriser"), S("Vapourise 10,000 things"), 50, 10000},

        {1, "atomic_comb_construct", S("Amateur Constructor"), S("Construct 10 samples"), 10, 10},
        {2, "atomic_comb_construct", S("Novice Constructor"), S("Construct 100 samples"), 10, 100},
        {3, "atomic_comb_construct", S("Skilled Constructor"), S("Construct 250 samples"), 20, 250},
        {4, "atomic_comb_construct", S("Veteran Constructor"), S("Construct 1000 samples"), 20, 1000},
        {5, "atomic_comb_construct", S("Master Constructor"), S("Construct 2500 samples"), 20, 2500},
        {6, "atomic_comb_construct", S("Elite Constructor"), S("Construct 10,000 samples"), 50, 10000},
    }) do

        unilib.awards.register_achievement({
            name = "unilib_atomic_comb_" .. mini_list[2] .. "_" .. mini_list[1],
            trigger_table = {
                prototype = mini_list[2],
                target = mini_list[6],
            },

            title = mini_list[3],
            description = mini_list[4],
            score = mini_list[5],
            vocation_list = {unilib.pkg.award_atomic.vocation_name},
        })

    end

    -- Selective achievements
    for i, mini_list in ipairs({
        -- (Vapourising)
        {"tree_apple_trunk", "unilib:tree_apple_trunk", "atomic_select_vapourise", S("Wooden It Be Nice"), S("Vapourise 10 apple tree trunks"), 10, 10},
        {"tree_pine_sapling", "unilib:tree_pine_sapling", "atomic_select_vapourise", S("Seed of Success"), S("Vapourise 5 pine tree saplings"), 10, 5},
        {"stone_desert_cobble", "unilib:stone_desert_cobble", "atomic_select_vapourise", S("Desert in a Box"), S("Vapourise 10 desert cobble blocks"), 10, 10},
        {"clay_ordinary", "unilib:clay_ordinary", "atomic_select_vapourise", S("Claymation"), S("Vapourise 10 ordinary clay blocks"), 10, 10},
        {"flower_rose_red", "unilib:flower_rose_red", "atomic_select_vapourise", S("Blooming Marvellous"), S("Vapourise 12 red roses"), 10, 12},
        {"gravel_ordinary", "unilib:gravel_ordinary", "atomic_select_vapourise", S("Gravel Grinder"), S("Vapourise 10 ordinary gravel blocks"), 10, 10},
        {"sand_ordinary", "unilib:sand_ordinary", "atomic_select_vapourise", S("Sandstorm Starter Pack"), S("Vapourise 10 ordinary sand blocks"), 10, 10},
        {"dirt_ordinary", "unilib:dirt_ordinary", "atomic_select_vapourise", S("Up to Your Knees in Dirt"), S("Vapourise 10 ordinary dirt blocks"), 10, 10},
        {"metal_iron_lump", "unilib:metal_iron_lump", "atomic_select_vapourise", S("Ironworks"), S("Vapourise 20 iron lumps"), 10, 20},
        {"metal_tin_lump", "unilib:metal_tin_lump", "atomic_select_vapourise", S("Tin Man"), S("Vapourise 20 tin lumps"), 10, 20},
        {"mineral_coal_lump", "unilib:mineral_coal_lump", "atomic_select_vapourise", S("Hot Stuff"), S("Vapourise 20 coal lumps"), 10, 20},
        {"mineral_mese_crystal", "unilib:mineral_mese_crystal", "atomic_select_vapourise", S("What a Mess"), S("Vapourise 20 mese crystals"), 10, 20},
        -- (Constructing)
        {"helium", "unilib:substance_helium_sample", "atomic_select_construct", S("Up, Up and Away"), S("Construct 2 helium samples"), 10, 2},
        {"carbon", "unilib:substance_carbon_sample", "atomic_select_construct", S("Carbon Copy"), S("Construct 6 carbon samples"), 10, 6},
        {"iron", "unilib:metal_steel_powder", "atomic_select_construct", S("Iron-Clad Achievement"), S("Construct 26 iron powder samples"), 10, 26},
        {"copper", "unilib:metal_copper_powder", "atomic_select_construct", S("Wired for Progress"), S("Construct 29 copper powder samples"), 10, 29},
        {"silver", "unilib:metal_silver_powder", "atomic_select_construct", S("Silversmith"), S("Construct 47 silver powder samples"), 20, 47},
        {"gold", "unilib:metal_gold_powder", "atomic_select_construct", S("Golden Legacy"), S("Construct 79 gold powder samples"), 20, 79},
        {"mercury", "unilib:metal_mercury_sample", "atomic_select_construct", S("Quicksilver Poisoning"), S("Construct 80 mercury samples"), 20, 80},
        {"uranium", "unilib:metal_uranium_powder", "atomic_select_construct", S("Chain Reaction"), S("Construct 92 uranium powder samples"), 20, 92},
    }) do

        if unilib.awards.check_argument(mini_list[2]) then

            unilib.awards.register_achievement({
                name = "unilib_atomic_select_" .. mini_list[1],
                trigger_table = {
                    prototype = mini_list[3],
                    target = mini_list[7],
                    item_list = unilib.utils.convert_to_list(mini_list[2]),
                },

                title = mini_list[4],
                description = mini_list[5],
                score = mini_list[6],
                vocation_list = {unilib.pkg.award_atomic.vocation_name},
            })

        end

    end

    -- Collector achievements
    if vapourise_count >= 10 then

        local vapourise_list = {
            {S("Amateur Disintegrator"), S("Vapourise 5 different things"), 10, 5},
            {S("Aspiring Disintegrator"), S("Vapourise 10 different things"), 10, 10},
        }

        if vapourise_count >= 20 then
            table.insert(vapourise_list, {S("Novice Disintegrator"), S("Vapourise 20 different things"), 10, 20})
        end

        if vapourise_count >= 30 then
            table.insert(vapourise_list, {S("Competent Disintegrator"), S("Vapourise 30 different things"), 20, 30})
        end

        if vapourise_count >= 50 then
            table.insert(vapourise_list, {S("Skilled Disintegrator"), S("Vapourise 50 different things"), 20, 50})
        end

        if vapourise_count >= 100 then
            table.insert(vapourise_list, {S("Seasoned Disintegrator"), S("Vapourise 100 different things"), 50, 100})
        end

        if vapourise_count >= 200 then
            table.insert(vapourise_list, {S("Veteran Disintegrator"), S("Vapourise 200 different things"), 50, 200})
        end

        if vapourise_count >= 500 then
            table.insert(vapourise_list, {S("Master Disintegrator"), S("Vapourise 500 different things"), 100, 500})
        end

        for i, mini_list in ipairs(vapourise_list) do

            unilib.awards.register_achievement({
                name = "unilib_atomic_collect_vapourise_" .. i,
                trigger_table = {
                    prototype = "atomic_collect_vapourise",
                    target = mini_list[4],
                },

                title = mini_list[1],
                description = mini_list[2],
                score = mini_list[3],
                vocation_list = {unilib.pkg.award_atomic.vocation_name},
            })

        end

    end

    if construct_count >= 5 then

        local construct_list = {
            {S("Amateur Constructor"), S("Construct 5 different samples"), 10, 5},
            {S("Novice Constructor"), S("Construct 10 different samples"), 10, 10},
        }

        if construct_count >= 20 then
            table.insert(construct_list, {S("Competent Constructor"), S("Construct 20 different samples"), 10, 20})
        end

        if construct_count >= 30 then
            table.insert(construct_list, {S("Skilled Constructor"), S("Construct 30 different samples"), 20, 30})
        end

        if construct_count >= 50 then
            table.insert(construct_list, {S("Veteran Constructor"), S("Construct 50 different samples"), 50, 50})
        end

        if construct_count >= 92 then
            table.insert(construct_list, {S("Master Constructor"), S("Construct 92 different samples"), 100, 92})
        end

        for i, mini_list in ipairs(construct_list) do

            unilib.awards.register_achievement({
                name = "unilib_atomic_collect_construct_" .. i,
                trigger_table = {
                    prototype = "atomic_collect_construct",
                    target = mini_list[4],
                },

                title = mini_list[1],
                description = mini_list[2],
                score = mini_list[3],
                vocation_list = {unilib.pkg.award_atomic.vocation_name},
            })

        end

    end

end
