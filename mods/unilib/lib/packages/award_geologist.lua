---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.award_geologist = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

-- Lists and lookup tables for the minerals, metals and gems used in this package's achievements
local mineral_lump_list = {}
local mineral_lookup_table = {}
local metal_lump_list = {}
local metal_lookup_table = {}
local gem_polish_list = {}
local gem_lookup_table = {}
-- List of minerals/metals/gems that are excluded from achievements, in the form
--      FULL_NAME = true
local exclude_table = {}

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

unilib.pkg.award_geologist.vocation_name = "unilib_geologist"

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function compile_metal_mineral_items()

    -- Add minerals
    for part_name, data_table in pairs(unilib.global.mineral_table) do

        if not data_table.no_lump_flag then

            local full_name = "unilib:mineral_" .. part_name .. "_lump"
            if exclude_table[full_name] == nil then

                table.insert(mineral_lump_list, full_name)
                mineral_lookup_table[full_name] = part_name

            end

        elseif data_table.gem_flag then

            -- Gem instead of a lump, e.g. the "mineral_diamond" package
            -- For the purposes of the awards below, treat them as if they were lumps
            -- (N.B. These gems are not created by polishing machines)
            local full_name = "unilib:mineral_" .. part_name .. "_gem"
            if exclude_table[full_name] == nil then

                table.insert(mineral_lump_list, full_name)
                mineral_lookup_table[full_name] = part_name

            end

        end

    end

    -- Add metals
    for part_name, data_table in pairs(unilib.global.metal_table) do

        local full_name = "unilib:metal_" .. part_name .. "_lump"
        if exclude_table[full_name] == nil then

            table.insert(metal_lump_list, full_name)
            metal_lookup_table[full_name] = part_name

        end

    end

    -- Add a few common items that are not added by the code above
    -- For the purposes of the awards below, treat them as if they were lumps
    for part_name, full_name in pairs({
        mese = "unilib:mineral_mese_crystal",
        aquamarine = "unilib:mineral_aquamarine_crystal",
        amethyst = "unilib:mineral_amethyst_crystal",
    }) do

        if exclude_table[full_name] == nil and
                unilib.global.pkg_executed_table["mineral_" .. part_name] ~= nil then

            table.insert(mineral_lump_list, full_name)
            mineral_lookup_table[full_name] = part_name

        end

    end

    -- Add polished gems (made by the gem-polishing machine)
    if unilib.global.pkg_executed_table["machine_polishing"] ~= nil then

        -- There is no central register for them, so just include any lumps for which gems also
        --      exist (which is what the "machine_polishing" package does)
        for part_name, data_table in pairs(unilib.global.mineral_table) do

            local lump_name = "unilib:mineral_" .. part_name .. "_lump"
            local gem_name = "unilib:mineral_" .. part_name .. "_gem"

            if exclude_table[gem_name] == nil and
                    core.registered_items[lump_name] ~= nil and
                    core.registered_items[gem_name] ~= nil then

                table.insert(gem_polish_list, gem_name)
                gem_lookup_table[gem_name] = lump_name

            end

        end

    end

end

local function on_collect_metal_mineral(player, full_name)

    if not unilib.utils.is_player(player) or full_name == nil then
        return
    end

    if mineral_lookup_table[full_name] ~= nil then

        local mineral_type = mineral_lookup_table[full_name]
        unilib.awards.handle_collection_trigger(
            player, "geologist_collect_mineral", "unilib_geologist_collect_mineral_1", mineral_type
        )

    elseif metal_lookup_table[full_name] ~= nil then

        local metal_type = metal_lookup_table[full_name]
        unilib.awards.handle_collection_trigger(
            player, "geologist_collect_metal", "unilib_geologist_collect_metal_1", metal_type
        )

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.award_geologist.on_collect_gem(player, full_name, multiple)

    -- Called by the on_metadata_inventory_take() function in the "machine_polishing" package

    if not unilib.setting.awards_enable_flag or
            not unilib.utils.is_player(player) or
            full_name == nil then
        return
    end

    if gem_lookup_table[full_name] ~= nil then

        unilib.awards.handle_complex_trigger(player, "geologist_comb_gem", full_name, multiple)
        unilib.awards.handle_collection_trigger(
            player, "geologist_collect_gem", "unilib_geologist_collect_gem_1", item
        )

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.award_geologist.init()

    return {
        description = "Awards for collecting metals/minerals (\"Geologist\")",
        notes = "Assumes a world with at least 4 types of mineral and 6 types of metal (as in" ..
                " minetest_game), each providing lumps (or equivalent items)",
        optional = "machine_polishing",
    }

end

function unilib.pkg.award_geologist.post()

    -- Sanity check -------------------------------------------------------------------------------

    if not unilib.setting.awards_enable_flag then
        return
    end

    -- Setup --------------------------------------------------------------------------------------

    -- N.B. Metal/mineral items generally do not have groups identifying them as such; instead,
    --      we're forced to compile a list of items that actually exist in the world
    compile_metal_mineral_items()

    -- Trigger prototypes -------------------------------------------------------------------------

    unilib.awards.register_trigger_prototype({
        name = "geologist_collect_mineral",
        trigger_type = "custom",
        hint_list = {"Obtain one type of mineral", "Obtain @1 types of mineral"},
        progress_list = {"Obtain one type of mineral", "Obtain @1/@2 types of mineral"},
    })

    unilib.awards.register_trigger_prototype({
        name = "geologist_collect_metal",
        trigger_type = "custom",
        hint_list = {"Obtain one type of metal", "Obtain @1 types of metal"},
        progress_list = {"Obtain one type of metal", "Obtain @1/@2 types of metal"},
    })

    unilib.awards.register_trigger_prototype({
        name = "geologist_collect_gem",
        trigger_type = "custom",
        hint_list = {"Polish one type of gem", "Polish @1 types of gem"},
        progress_list = {"Polish one type of gem", "Polish @1/@2 types of gem"},
    })

    unilib.awards.register_trigger_prototype({
        name = "geologist_comb_gem",
        trigger_type = "complex",
        hint_list = {"Polish one gem", "Polish @1 gems"},
        progress_list = {"Polish one gem", "Polish @1/@2 gems"},
    })

    -- Trigger event callbacks --------------------------------------------------------------------

    core.register_on_dignode(function(pos, oldnode, digger)

        local tool = digger and digger:get_wielded_item():get_name()
        local drops = minetest.get_node_drops(oldnode.name, tool)

        for _, item_str in ipairs(drops) do

            local full_name, _ = unilib.utils.get_item_and_multiple(item_str)
            on_collect_metal_mineral(digger, full_name)

        end

    end)

    -- Vocations ----------------------------------------------------------------------------------

    -- Assumes at least 4 mineral types and 6 metal types (as in minetest_game), giving a minimum
    --      total score of 560
    -- If the "machine_polishing" package is loaded and at least 5 gems are available, the minimum
    --      total score becomes 740
    local score_list, description
    if #gem_polish_list < 5 then

        score_list = {10, 20, 30, 50, 70, 100, 150, 200, 300, 400, 480, 560}
        description = S("Collect many metals and minerals")

    else

        score_list = {10, 20, 40, 60, 100, 150, 200, 300, 400, 500, 600, 740}
        description = S("Collect many metals, minerals and gems")

    end

    unilib.awards.register_vocation({
        name = unilib.pkg.award_geologist.vocation_name,

        title = S("Geologist"),
        description = description,
        icon = "unilib_award_vocation_geologist.png",
        level_list = {
            {title = S("Pebble Picker"), score = score_list[1]},
            {title = S("Accidental Geologist"), score = score_list[2]},
            {title = S("Pocket Full of Rocks"), score = score_list[3]},
            {title = S("Miner Inconvenience"), score = score_list[4]},
            {title = S("Oops, That's Just Dirt"), score = score_list[5]},
            {title = S("Metal Detector"), score = score_list[6]},
            {title = S("Copper Dropper"), score = score_list[7]},
            {title = S("Rock Around the Block"), score = score_list[8]},
            {title = S("Sedimentary, My Dear Watson"), score = score_list[9]},
            {title = S("Gold Digger"), score = score_list[10]},
            {title = S("Below the Bedrock"), score = score_list[11]},
            {title = S("World's Heaviest Backpack"), score = score_list[12]},
        },
    })

    -- Achievements -------------------------------------------------------------------------------

    -- Combination achievements
    for i, mini_list in ipairs({
        {"mineral_1", mineral_lump_list, "unilib_receive", S("Amateur Mineral Hoarder"), S("Obtain 15 minerals"), 10, 15},
        {"mineral_2", mineral_lump_list, "unilib_receive", S("Novice Mineral Hoarder"), S("Obtain 150 minerals"), 20, 150},
        {"mineral_3", mineral_lump_list, "unilib_receive", S("Skilled Mineral Hoarder"), S("Obtain 1500 minerals"), 30, 1500},
        {"mineral_4", mineral_lump_list, "unilib_receive", S("Veteran Mineral Hoarder"), S("Obtain 15000 minerals"), 50, 15000},

        {"metal_1", metal_lump_list, "unilib_receive", S("Amateur Metal Hoarder"), S("Obtain 15 metals"), 10, 15},
        {"metal_2", metal_lump_list, "unilib_receive", S("Novice Metal Hoarder"), S("Obtain 150 metals"), 20, 150},
        {"metal_3", metal_lump_list, "unilib_receive", S("Skilled Metal Hoarder"), S("Obtain 1500 metals"), 30, 1500},
        {"metal_4", metal_lump_list, "unilib_receive", S("Veteran Metal Hoarder"), S("Obtain 15000 metals"), 50, 15000},
    }) do

        if unilib.awards.check_argument(mini_list[2]) then

            unilib.awards.register_achievement({
                name = "unilib_geologist_comb_" .. mini_list[1],
                trigger_table = {
                    prototype = mini_list[3],
                    target = mini_list[7],
                    item_list = unilib.utils.convert_to_list(mini_list[2]),
                },

                title = mini_list[4],
                description = mini_list[5],
                score = mini_list[6],
                vocation_list = {unilib.pkg.award_geologist.vocation_name},
            })

        end

    end

    -- Selective achievements
    for _, full_name in ipairs(mineral_lump_list) do

        local mineral_type = mineral_lookup_table[full_name]
        local data_table = unilib.global.mineral_table[mineral_type]

        unilib.awards.register_achievement({
            name = "unilib_geologist_select_mineral_" .. data_table.part_name,
            trigger_table = {
                prototype = "unilib_break",
                target = 250,
                item_list = {full_name},
            },

            title = unilib.utils.brackets(S("Mineralogist"), data_table.description),
            description = unilib.utils.brackets(
                S("Obtain 250 minerals"), data_table.description
            ),
            score = 10,
            vocation_list = {unilib.pkg.award_geologist.vocation_name},
        })

    end

    for _, full_name in ipairs(metal_lump_list) do

        local metal_type = metal_lookup_table[full_name]
        local data_table = unilib.global.metal_table[metal_type]

        unilib.awards.register_achievement({
            name = "unilib_geologist_select_metal_" .. data_table.part_name,
            trigger_table = {
                prototype = "unilib_break",
                target = 250,
                item_list = {full_name},
            },

            title = unilib.utils.brackets(S("Geochemist"), data_table.description),
            description = unilib.utils.brackets(
                S("Obtain 250 minerals"), data_table.description
            ),
            score = 10,
            vocation_list = {unilib.pkg.award_geologist.vocation_name},
        })

    end

    -- Collector achievements
    -- N.B. In minetest_game, there are 4 minerals and 6 metals
    local mineral_count = #mineral_lump_list
    local mineral_list = {
        {S("Elite Mineral Collector"), S("Obtain every type of mineral"), 100, mineral_count},
        {S("Amateur Mineral Collector"), S("Obtain 2 types of mineral"), 10, 2},
        {S("Aspiring Mineral Collector"), S("Obtain 4 types of mineral"), 10, 4},
    }

    if mineral_count > 10 then
        table.insert(mineral_list, {S("Novice Mineral Collector"), S("Obtain 10 types of mineral"), 10, 10})
    end

    if mineral_count > 20 then
        table.insert(mineral_list, {S("Skilled Mineral Collector"), S("Obtain 20 types of mineral"), 10, 20})
    end

    if mineral_count > 30 then
        table.insert(mineral_list, {S("Seasoned Mineral Collector"), S("Obtain 30 types of mineral"), 20, 30})
    end

    if mineral_count > 50 then
        table.insert(mineral_list, {S("Master Mineral Collector"), S("Obtain 50 types of mineral"), 30, 50})
    end

    if mineral_count > 100 then
        table.insert(mineral_list, {S("Grandmaster Mineral Collector"), S("Obtain 100 types of mineral"), 40, 100})
    end

    for i, mini_list in ipairs(mineral_list) do

        unilib.awards.register_achievement({
            name = "unilib_geologist_collect_mineral_" .. i,
            trigger_table = {
                prototype = "geologist_collect_mineral",
                target = mini_list[4],
                item_list = mineral_lump_list,
            },

            title = mini_list[1],
            description = mini_list[2],
            score = mini_list[3],
            vocation_list = {unilib.pkg.award_geologist.vocation_name},
        })

    end

    local metal_count = #metal_lump_list
    local metal_list = {
        {S("Elite Metal Collector"), S("Obtain every type of metal"), 100, metal_count},
        {S("Amateur Metal Collector"), S("Obtain 2 types of metal"), 10, 2},
        {S("Aspiring Metal Collector"), S("Obtain 6 types of metal"), 10, 6},
    }

    if metal_count > 10 then
        table.insert(metal_list, {S("Novice Metal Collector"), S("Obtain 10 types of metal"), 10, 10})
    end

    if metal_count > 20 then
        table.insert(metal_list, {S("Skilled Metal Collector"), S("Obtain 20 types of metal"), 10, 20})
    end

    if metal_count > 30 then
        table.insert(metal_list, {S("Seasoned Metal Collector"), S("Obtain 30 types of metal"), 20, 30})
    end

    if metal_count > 50 then
        table.insert(metal_list, {S("Master Metal Collector"), S("Obtain 50 types of metal"), 30, 50})
    end

    if metal_count > 100 then
        table.insert(metal_list, {S("Grandmaster Metal Collector"), S("Obtain 100 types of metal"), 40, 100})
    end

    for i, mini_list in ipairs(metal_list) do

        unilib.awards.register_achievement({
            name = "unilib_geologist_collect_metal_" .. i,
            trigger_table = {
                prototype = "geologist_collect_metal",
                target = mini_list[4],
                item_list = metal_lump_list,
            },

            title = mini_list[1],
            description = mini_list[2],
            score = mini_list[3],
            vocation_list = {unilib.pkg.award_geologist.vocation_name},
        })

    end

    -- Gem polishing achievements (available only if the "machine_polishing" package has been
    --      loaded, and there are at least 5 polished gems available)
    local polish_count = #gem_polish_list
    if polish_count >= 5 then

        -- (Combination achievements)
        for i, mini_list in ipairs({
            {S("Amateur Lapidarist"), S("Polish 12 gems"), 10, 12},
            {S("Novice Lapidarist"), S("Polish 120 gems"), 20, 120},
            {S("Skilled Lapidarist"), S("Polish 1200 gems"), 30, 1200},
        }) do

            unilib.awards.register_achievement({
                name = "unilib_geologist_comb_gem_" .. i,
                trigger_table = {
                    prototype = "geologist_comb_gem",
                    target = mini_list[4],
                    item_list = gem_polish_list,
                },

                title = mini_list[1],
                description = mini_list[2],
                score = mini_list[3],
                vocation_list = {unilib.pkg.award_geologist.vocation_name},
            })

        end

        -- (Collector achievements)
        local polish_list = {
            {S("Elite Gem Collector"), S("Obtain every type of gem"), 100, polish_count},
            {S("Amateur Gem Collector"), S("Obtain 2 types of gem"), 10, 2},
            {S("Aspiring Gem Collector"), S("Obtain 5 types of gem"), 10, 5},
        }

        if polish_count > 10 then
            table.insert(polish_list, {S("Novice Gem Collector"), S("Polish 10 types of gem"), 10, 10})
        end

        if polish_count > 20 then
            table.insert(polish_list, {S("Skilled Gem Collector"), S("Polish 20 types of gem"), 10, 20})
        end

        if polish_count > 30 then
            table.insert(polish_list, {S("Seasoned Gem Collector"), S("Polish 30 types of gem"), 20, 30})
        end

        if polish_count > 50 then
            table.insert(polish_list, {S("Master Gem Collector"), S("Polish 50 types of gem"), 30, 50})
        end

        if polish_count > 100 then
            table.insert(polish_list, {S("Grandmaster Gem Collector"), S("Polish 100 types of gem"), 40, 100})
        end

        for i, mini_list in ipairs(polish_list) do

            unilib.awards.register_achievement({
                name = "unilib_geologist_collect_gem_" .. i,
                trigger_table = {
                    prototype = "geologist_collect_gem",
                    target = mini_list[4],
                    item_list = gem_polish_list,
                },

                title = mini_list[1],
                description = mini_list[2],
                score = mini_list[3],
                vocation_list = {unilib.pkg.award_geologist.vocation_name},
            })

        end

    end

end
