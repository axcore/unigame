---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.award_toolsmith = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

-- Compiled lists/tables of items
local axe_lookup_table = {}
local hoe_lookup_table = {}
local pick_lookup_table = {}
local shovel_lookup_table = {}
local all_select_list = {}

-- Achievements for specific armours
-- Items can be added or removed from this list; as appropriate. Any items that don't exist in the
--      world are removed automatically
-- mini_lists in the form
--      [partial_achievement_name, full_name, title, description, score, target]
local axe_init_list = {
    -- (mtgame)
    {"axe_bronze", "unilib:tool_axe_bronze", S("Bronze Axe to Grind"), S("Craft a bronze axe"), 10, 1},
    {"axe_diamond", "unilib:tool_axe_diamond", S("Diamond Axe to Grind"), S("Craft a diamond axe"), 10, 1},
    {"axe_mese", "unilib:tool_axe_mese", S("Mese Axe to Grind"), S("Craft a mese axe"), 10, 1},
    {"axe_steel", "unilib:tool_axe_steel", S("Steel Axe to Grind"), S("Craft a steel axe"), 10, 1},
    {"axe_stone", "unilib:tool_axe_stone", S("Stone Axe to Grind"), S("Craft a stone axe"), 10, 1},
    {"axe_wood", "unilib:tool_axe_wood", S("Splinters in Your Thumbs"), S("Craft a wooden axe"), 10, 1},
    -- (earthbuild)
    {"axe_flint", "unilib:tool_axe_flint", S("Flint Axe to Grind"), S("Craft a flint axe"), 10, 1},
    -- (ethereal)
    {"axe_crystallite", "unilib:tool_axe_crystallite", S("Crystallite Axe to Grind"), S("Craft a crystallite axe"), 20, 1},
    -- (gemtools)
    {"axe_emerald", "unilib:tool_axe_emerald", S("Emerald Axe to Grind"), S("Craft an emerald axe"), 20, 1},
    {"axe_octu", "unilib:tool_axe_octu", S("Octu Axe to Grind"), S("Craft an octu axe"), 20, 1},
    {"axe_ruby", "unilib:tool_axe_ruby", S("Ruby Axe to Grind"), S("Craft a ruby axe"), 20, 1},
    {"axe_sapphire", "unilib:tool_axe_sapphire", S("Sapphire Axe to Grind"), S("Craft a sapphire axe"), 20, 1},
    -- (moreores)
    {"axe_mithril", "unilib:tool_axe_mithril", S("Mithril Axe to Grind"), S("Craft a mithril axe"), 10, 1},
    {"axe_silver", "unilib:tool_axe_silver", S("Silver Axe to Grind"), S("Craft a silver axe"), 10, 1},
    -- (pigiron)
    {"axe_iron_pig", "unilib:tool_axe_iron_pig", S("Pig Iron Axe to Grind"), S("Craft a pig iron axe"), 10, 1},
    -- (xtraores)
    {"axe_sybilline", "unilib:tool_axe_sybilline", S("Sybilline Axe to Grind"), S("Craft a sybilline axe"), 30, 1},
    {"axe_planexium", "unilib:tool_axe_planexium", S("Planexium Axe to Grind"), S("Craft a planexium axe"), 30, 1},
    {"axe_ozymandium", "unilib:tool_axe_ozymandium", S("Ozymandium Axe to Grind"), S("Craft an ozymandium axe"), 30, 1},
    {"axe_adamantite", "unilib:tool_chainsaw_adamantite", S("Chained Up with Adamantite"), S("Craft an adamantite chainsaw"), 30, 1},
    {"axe_geminitium", "unilib:tool_chainsaw_geminitium", S("Chained Up with Geminitium"), S("Craft a geminitium chainsaw"), 30, 1},
    {"axe_rarium", "unilib:tool_chainsaw_rarium", S("Chained Up with Rarium"), S("Craft a rarium chainsaw"), 40, 1},
    {"axe_tritonium", "unilib:tool_chainsaw_tritonium", S("Chained Up with Tritonium"), S("Craft a tritonium chainsaw"), 40, 1},
    {"axe_unobtainium", "unilib:tool_chainsaw_unobtainium", S("Chained Up with Unobtainium"), S("Craft an unobtainium chainsaw"), 40, 1},
}
local hoe_init_list = {
    -- (mtgame)
    {"hoe_bronze", "unilib:tool_hoe_bronze", S("Bronze Hoedown"), S("Craft a bronze hoe"), 10, 1},
    {"hoe_diamond", "unilib:tool_hoe_diamond", S("Diamond Hoedown"), S("Craft a diamond hoe"), 10, 1},
    {"hoe_mese", "unilib:tool_hoe_mese", S("Mese Hoedown"), S("Craft a mese hoe"), 10, 1},
    {"hoe_steel", "unilib:tool_hoe_steel", S("Steel Hoedown"), S("Craft a steel hoe"), 10, 1},
    {"hoe_stone", "unilib:tool_hoe_stone", S("Stone Hoedown"), S("Craft a stone hoe"), 10, 1},
    {"hoe_wood", "unilib:tool_hoe_wood", S("Splintered Hoedown"), S("Craft a wooden hoe"), 10, 1},
    -- (moreores)
    {"hoe_mithril", "unilib:tool_hoe_mithril", S("Mithril Hoedown"), S("Craft a mithril hoe"), 10, 1},
    {"hoe_silver", "unilib:tool_hoe_silver", S("Silver Hoedown"), S("Craft a silver hoe"), 10, 1},
    -- (pigiron)
    {"hoe_iron_pig", "unilib:tool_hoe_iron_pig", S("Pig Iron Hoedown"), S("Craft a pig iron hoe"), 10, 1},
}
local pick_init_list = {
    -- (mtgame)
    {"pick_bronze", "unilib:tool_pick_bronze", S("Bronze Pick-Me-Up"), S("Craft a bronze pickaxe"), 10, 1},
    {"pick_diamond", "unilib:tool_pick_diamond", S("Diamond Pick-Me-Up"), S("Craft a diamond pickaxe"), 10, 1},
    {"pick_mese", "unilib:tool_pick_mese", S("Mese Pick-Me-Up"), S("Craft a mese pickaxe"), 10, 1},
    {"pick_steel", "unilib:tool_pick_steel", S("Steel Pick-Me-Up"), S("Craft a steel pickaxe"), 10, 1},
    {"pick_stone", "unilib:tool_pick_stone", S("Stone Pick-Me-Up"), S("Craft a stone pickaxe"), 10, 1},
    {"pick_wood", "unilib:tool_pick_wood", S("Splintered Pick-Me-Up"), S("Craft a wooden pickaxe"), 10, 1},
    -- (ethereal)
    {"pick_crystallite", "unilib:tool_pick_crystallite", S("Crystallite Pick-Me-Up"), S("Craft a crystallite pickaxe"), 20, 1},
    -- (gemtools)
    {"pick_emerald", "unilib:tool_pick_emerald", S("Emerald Pick-Me-Up"), S("Craft an emerald pickaxe"), 20, 1},
    {"pick_octu", "unilib:tool_pick_octu", S("Octu Pick-Me-Up"), S("Craft an octu pickaxe"), 20, 1},
    {"pick_ruby", "unilib:tool_pick_ruby", S("Ruby Pick-Me-Up"), S("Craft a ruby pickaxe"), 20, 1},
    {"pick_sapphire", "unilib:tool_pick_sapphire", S("Sapphire Pick-Me-Up"), S("Craft a sapphire pickaxe"), 20, 1},
    -- (moreores)
    {"pick_mithril", "unilib:tool_pick_mithril", S("Mithril Pick-Me-Up"), S("Craft a mithril pickaxe"), 10, 1},
    {"pick_silver", "unilib:tool_pick_silver", S("Silver Pick-Me-Up"), S("Craft a silver pickaxe"), 10, 1},
    -- (pigiron)
    {"pick_iron_pig", "unilib:tool_pick_iron_pig", S("Pig Iron Pick-Me-Up"), S("Craft a pig iron pickaxe"), 10, 1},
    -- (xtraores)
    {"pick_adamantite", "unilib:tool_pick_adamantite", S("Adamantite Pick-Me-Up"), S("Craft an adamantite pickaxe"), 30, 1},
    {"pick_ozymandium", "unilib:tool_pick_ozymandium", S("Ozymandium Pick-Me-Up"), S("Craft an ozymandium pickaxe"), 30, 1},
    {"pick_planexium", "unilib:tool_pick_planexium", S("Planexium Pick-Me-Up"), S("Craft a planexium pickaxe"), 30, 1},
    {"pick_sybilline", "unilib:tool_pick_sybilline", S("Sybilline Pick-Me-Up"), S("Craft a sybilline pickaxe"), 30, 1},
    {"pick_geminitium", "unilib:tool_drill_geminitium", S("Geminitium Drill Seeker"), S("Craft a geminitium drill"), 40, 1},
    {"pick_rarium", "unilib:tool_drill_rarium", S("Rarium Drill Seeker"), S("Craft a rarium drill"), 40, 1},
    {"pick_tritonium", "unilib:tool_drill_tritonium", S("Tritonium Drill Seeker"), S("Craft a tritonium drill"), 40, 1},
    {"pick_unobtainium", "unilib:tool_drill_unobtainium", S("Unobtainium Drill Seeker"), S("Craft an unobtainium drill"), 40, 1},
}
local shovel_init_list = {
    -- N.B. unilib:tool_shovel_pounamu is excluded
    -- (mtgame)
    {"shovel_bronze", "unilib:tool_shovel_bronze", S("Shovelling Bronze"), S("Craft a bronze shovel"), 10, 1},
    {"shovel_diamond", "unilib:tool_shovel_diamond", S("Shovelling Diamond"), S("Craft a diamond shovel"), 10, 1},
    {"shovel_mese", "unilib:tool_shovel_mese", S("Shovelling Mese"), S("Craft a mese shovel"), 10, 1},
    {"shovel_steel", "unilib:tool_shovel_steel", S("Shovelling Steel"), S("Craft a steel shovel"), 10, 1},
    {"shovel_stone", "unilib:tool_shovel_stone", S("Shovelling Stone"), S("Craft a stone shovel"), 10, 1},
    {"shovel_wood", "unilib:tool_shovel_wood", S("Shovelling Splinters"), S("Craft a wooden shovel"), 10, 1},
    -- (ethereal)
    {"shovel_crystallite", "unilib:tool_shovel_crystallite", S("Shovelling Crystallite"), S("Craft a crystallite shovel"), 20, 1},
    -- (gemtools)
    {"shovel_emerald", "unilib:tool_shovel_emerald", S("Shovelling Emerald"), S("Craft an emerald shovel"), 20, 1},
    {"shovel_octu", "unilib:tool_shovel_octu", S("Shovelling Octu"), S("Craft an octu shovel"), 20, 1},
    {"shovel_ruby", "unilib:tool_shovel_ruby", S("Shovelling Ruby"), S("Craft a ruby shovel"), 20, 1},
    {"shovel_sapphire", "unilib:tool_shovel_sapphire", S("Shovelling Sapphire"), S("Craft a sapphire shovel"), 20, 1},
    -- (moreores)
    {"shovel_mithril", "unilib:tool_shovel_mithril", S("Shovelling Mithril"), S("Craft a mithril shovel"), 10, 1},
    {"shovel_silver", "unilib:tool_shovel_silver", S("Shovelling Silver"), S("Craft a silver shovel"), 10, 1},
    -- (pigiron)
    {"shovel_iron_pig", "unilib:tool_shovel_iron_pig", S("Shovelling Pig Iron"), S("Craft a pig iron shovel"), 10, 1},
    -- (xtraores)
    {"shovel_adamantite", "unilib:tool_shovel_adamantite", S("Shovelling Adamantite"), S("Craft an adamantite shovel"), 30, 1},
    {"shovel_ozymandium", "unilib:tool_shovel_ozymandium", S("Shovelling Ozymandium"), S("Craft an ozymandium shovel"), 30, 1},
    {"shovel_planexium", "unilib:tool_shovel_planexium", S("Shovelling Planexium"), S("Craft a planexium shovel"), 30, 1},
    {"shovel_sybilline", "unilib:tool_shovel_sybilline", S("Shovelling Sybilline"), S("Craft a sybilline shovel"), 30, 1},
}
local other_init_list = {
    -- N.B. unilib:tool_sickle_grass is excluded
    -- (mtgame)
    {"scythe_mithril", "unilib:tool_scythe_mithril", S("Mithril Scythe Swipe"), S("Craft a mithril scythe"), 10, 1},
    -- (earthbuild)
    {"knife_flint", "unilib:tool_knife_flint", S("Flint Knife to Meet You"), S("Craft a flint knife"), 10, 1},
    -- (sickles)
    {"sickle_bronze", "unilib:tool_sickle_bronze", S("Bronze Sickle of Life"), S("Craft a bronze sickle"), 10, 1},
    {"sickle_gold", "unilib:tool_sickle_gold", S("Gold Sickle of Life"), S("Craft a gold sickle"), 10, 1},
    {"sickle_steel", "unilib:tool_sickle_steel", S("Steel Sickle of Life"), S("Craft a steel sickle"), 10, 1},
    {"scythe_bronze", "unilib:tool_scythe_bronze", S("Bronze Scythe Swipe"), S("Craft a bronze scythe"), 10, 1},
    {"scythe_steel", "unilib:tool_scythe_steel", S("Steel Scythe Swipe"), S("Craft a steel scythe"), 10, 1},
}

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

unilib.pkg.award_toolsmith.vocation_name = "unilib_toolsmith"

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function compile_items()

    for _, mini_list in ipairs(axe_init_list) do

        if core.registered_tools[mini_list[2]] ~= nil then

            axe_lookup_table[mini_list[2]] = true
            table.insert(all_select_list, mini_list)

        end

    end

    for _, mini_list in ipairs(hoe_init_list) do

        if core.registered_tools[mini_list[2]] ~= nil then

            hoe_lookup_table[mini_list[2]] = true
            table.insert(all_select_list, mini_list)

        end

    end

    for _, mini_list in ipairs(pick_init_list) do

        if core.registered_tools[mini_list[2]] ~= nil then

            pick_lookup_table[mini_list[2]] = true
            table.insert(all_select_list, mini_list)

        end

    end

    for _, mini_list in ipairs(shovel_init_list) do

        if core.registered_tools[mini_list[2]] ~= nil then

            shovel_lookup_table[mini_list[2]] = true
            table.insert(all_select_list, mini_list)

        end

    end

end

local function on_collect(player, full_name)

    if not unilib.utils.is_player(player) or full_name == nil then
        return
    end

    if axe_lookup_table[full_name] ~= nil then

        unilib.awards.handle_collection_trigger(
            player, "toolsmith_collect_axe", "unilib_toolsmith_collect_axe_1", full_name
        )

    elseif hoe_lookup_table[full_name] ~= nil then

        unilib.awards.handle_collection_trigger(
            player, "toolsmith_collect_hoe", "unilib_toolsmith_collect_hoe_1", full_name
        )

    elseif pick_lookup_table[full_name] ~= nil then

        unilib.awards.handle_collection_trigger(
            player, "toolsmith_collect_pick", "unilib_toolsmith_collect_pick_1", full_name
        )

    elseif shovel_lookup_table[full_name] ~= nil then

        unilib.awards.handle_collection_trigger(
            player, "toolsmith_collect_shovel", "unilib_toolsmith_collect_shovel_1", full_name
        )

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.award_toolsmith.init()

    return {
        description = "Awards for crafting various types of tool (\"Toolsmith\")",
        notes = "Assumes a world containing at least as many axes, hoes, pickaxes and shovels as" ..
                " minetest_game",
    }

end

function unilib.pkg.award_toolsmith.post()

    -- Sanity check -------------------------------------------------------------------------------

    if not unilib.setting.awards_enable_flag then
        return
    end

    -- Setup --------------------------------------------------------------------------------------

    -- N.B. Filter out tools that are not in the game
    compile_items()

    -- Trigger prototypes -------------------------------------------------------------------------

    unilib.awards.register_trigger_prototype({
        name = "toolsmith_collect_axe",
        trigger_type = "custom",
        hint_list = {"Craft one type of axe", "Craft @1 types of axe"},
        progress_list = {"Craft one type of axe", "Craft @1/@2 types of axe"},
    })

    unilib.awards.register_trigger_prototype({
        name = "toolsmith_collect_hoe",
        trigger_type = "custom",
        hint_list = {"Craft one type of hoe", "Craft @1 types of hoe"},
        progress_list = {"Craft one type of hoe", "Craft @1/@2 types of hoe"},
    })

    unilib.awards.register_trigger_prototype({
        name = "toolsmith_collect_pick",
        trigger_type = "custom",
        hint_list = {"Craft one type of pick", "Craft @1 types of pick"},
        progress_list = {"Craft one type of pick", "Craft @1/@2 types of pick"},
    })

    unilib.awards.register_trigger_prototype({
        name = "toolsmith_collect_shovel",
        trigger_type = "custom",
        hint_list = {"Craft one type of shovel", "Craft @1 types of shovel"},
        progress_list = {"Craft one type of shovel", "Craft @1/@2 types of shovel"},
    })

    -- Trigger event callbacks --------------------------------------------------------------------

    core.register_on_craft(function(itemstack, player, old_craft_grid, craft_inv)
        on_collect(player, itemstack:get_name())
    end)

    -- Vocations ----------------------------------------------------------------------------------

    -- Assumes at least the "3d_armor" remix, total score 520
    local score_list = {10, 20, 40, 60, 90, 120, 150, 200, 250, 300, 400, 500}
    -- Assumes at least the "3d_armor" and "xtraores" remixes, total score 1190
--  local score_list = {10, 20, 50, 100, 150, 200, 300, 400, 500, 700, 900, 1100}

    unilib.awards.register_vocation({
        name = unilib.pkg.award_toolsmith.vocation_name,

        title = S("Toolsmith"),
        description = S("Craft axes, hoes, pickaxes, shovels and other tools"),
        icon = "unilib_award_vocation_toolsmith.png",
        level_list = {
            {title = S("Stick + Thing = Tool"), score = score_list[1]},
            {title = S("Barely Holding It Together"), score = score_list[2]},
            {title = S("Trying Your Best"), score = score_list[3]},
            {title = S("Picking Up the Slack"), score = score_list[4]},
            {title = S("Tooled Up"), score = score_list[5]},
            {title = S("Toolish Behaviour"), score = score_list[6]},
            {title = S("Pick up the Pace"), score = score_list[7]},
            {title = S("Axe to Grind"), score = score_list[8]},
            {title = S("Hoe for the Best"), score = score_list[9]},
            {title = S("Axe and You Shall Receive"), score = score_list[10]},
            {title = S("Tools of the Trade"), score = score_list[11]},
            {title = S("Fully Equipped"), score = score_list[12]},
        },
    })

    -- Achievements -------------------------------------------------------------------------------

    -- Selective achievements
    for _, mini_list in ipairs(all_select_list) do

        -- mini_list in the form
        --      [partial_achievement_name, full_name, title, description, score, target]
        unilib.awards.register_achievement({
            name = "unilib_toolsmith_select_" .. mini_list[1],
            trigger_table = {
                prototype = "unilib_craft",
                target = mini_list[6],
                item_list = unilib.utils.convert_to_list(mini_list[2]),
            },

            title = mini_list[3],
            description = mini_list[4],
            score = mini_list[5],
            vocation_list = {unilib.pkg.award_toolsmith.vocation_name},
        })

    end

    -- Collector achievements
    local axe_count = unilib.utils.get_table_size(axe_lookup_table)
    if axe_count >= 5 then

        local axe_list = {
            {S("Skilled Axemaker"), S("Craft 5 types of axe"), 20, 5},
            {S("Elite Axemaker"), S("Craft every type of axe"), 50, axe_count},
        }

        for i, mini_list in ipairs(axe_list) do

            unilib.awards.register_achievement({
                name = "unilib_toolsmith_collect_axe_" .. i,
                trigger_table = {
                    prototype = "toolsmith_collect_axe",
                    target = mini_list[4],
                    item_list = {"group:axe"},
                },

                title = mini_list[1],
                description = mini_list[2],
                score = mini_list[3],
                vocation_list = {unilib.pkg.award_toolsmith.vocation_name},
            })

        end

    end

    local hoe_count = unilib.utils.get_table_size(hoe_lookup_table)
    if hoe_count >= 5 then

        local hoe_list = {
            {S("Skilled Hoe Man"), S("Craft 5 types of hoe"), 20, 5},
            {S("Elite Hoe Man"), S("Craft every type of hoe"), 50, hoe_count},
        }

        for i, mini_list in ipairs(hoe_list) do

            unilib.awards.register_achievement({
                name = "unilib_toolsmith_collect_hoe_" .. i,
                trigger_table = {
                    prototype = "toolsmith_collect_hoe",
                    target = mini_list[4],
                    item_list = {"group:hoe"},
                },

                title = mini_list[1],
                description = mini_list[2],
                score = mini_list[3],
                vocation_list = {unilib.pkg.award_toolsmith.vocation_name},
            })

        end

    end

    local pick_count = unilib.utils.get_table_size(pick_lookup_table)
    if pick_count >= 5 then

        local pick_list = {
            {S("Skilled Pick of the Litter"), S("Craft 5 types of pickaxe"), 20, 5},
            {S("Elite Pick of the Litter"), S("Craft every type of pickaxe"), 50, pick_count},
        }

        for i, mini_list in ipairs(pick_list) do

            unilib.awards.register_achievement({
                name = "unilib_toolsmith_collect_pick_" .. i,
                trigger_table = {
                    prototype = "toolsmith_collect_pick",
                    target = mini_list[4],
                    item_list = {"group:pickaxe"},
                },

                title = mini_list[1],
                description = mini_list[2],
                score = mini_list[3],
                vocation_list = {unilib.pkg.award_toolsmith.vocation_name},
            })

        end

    end

    local shovel_count = unilib.utils.get_table_size(shovel_lookup_table)
    if shovel_count >= 5 then

        local shovel_list = {
            {S("Skilled Spade Specialist"), S("Craft 5 types of shovel"), 20, 5},
            {S("Elite Spade Specialist"), S("Craft every type of shovel"), 50, shovel_count},
        }

        for i, mini_list in ipairs(shovel_list) do

            unilib.awards.register_achievement({
                name = "unilib_toolsmith_collect_shovel_" .. i,
                trigger_table = {
                    prototype = "toolsmith_collect_shovel",
                    target = mini_list[4],
                    item_list = {"group:shovel"},
                },

                title = mini_list[1],
                description = mini_list[2],
                score = mini_list[3],
                vocation_list = {unilib.pkg.award_toolsmith.vocation_name},
            })

        end

    end

end
