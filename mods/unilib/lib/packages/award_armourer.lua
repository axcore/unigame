---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.award_armourer = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

-- Compiled lists/tables of items
local boots_lookup_table = {}
local chestplate_lookup_table = {}
local gauntlets_lookup_table = {}
local helmet_lookup_table = {}
local leggings_lookup_table = {}
local shield_lookup_table = {}
local all_select_list = {}

-- Selective achievements for crafting specific armours
-- Items can be added or removed from this list; as appropriate. Any items that don't exist in the
--      world are removed automatically
-- mini_lists in the form
--      [partial_achievement_name, full_name, title, description, score, target]
local boots_init_list = {
    -- 3d_armor
    {"boots_bronze", "unilib:armour_boots_bronze", S("Marching in Bronze"), S("Craft a pair of bronze boots"), 10, 1},
    {"boots_cactus", "unilib:armour_boots_cactus", S("Marching in Cactus"), S("Craft a pair of cactus boots"), 10, 1},
    {"boots_crystallite", "unilib:armour_boots_crystallite", S("Marching in Crystallite"), S("Craft a pair of crystallite boots"), 20, 1},
    {"boots_diamond", "unilib:armour_boots_diamond", S("Marching in Diamond"), S("Craft a pair of diamond boots"), 20, 1},
    {"boots_gold", "unilib:armour_boots_gold", S("Marching in Gold"), S("Craft a pair of gold boots"), 10, 1},
    {"boots_mithril", "unilib:armour_boots_mithril", S("Marching in Mithril"), S("Craft a pair of mithril boots"), 10, 1},
    {"boots_nether", "unilib:armour_boots_nether", S("Marching in Nether"), S("Craft a pair of nether boots"), 10, 1},
    {"boots_steel", "unilib:armour_boots_steel", S("Marching in Steel"), S("Craft a pair of steel boots"), 10, 1},
    {"boots_wood", "unilib:armour_boots_wood", S("Marching with Splinters"), S("Craft a pair of wooden boots"), 10, 1},
    -- N.B. unilib:armour_boots_admin is excluded
    -- armor_expanded
    {"boots_leather", "unilib:armour_boots_leather", S("Marching in Leather"), S("Craft a pair of leather boots"), 10, 1},
    {"boots_woven", "unilib:armour_boots_woven", S("Marching in Weavings"), S("Craft a pair of woven boots"), 10, 1},
    -- technic_armor
    {"boots_brass", "unilib:armour_boots_brass", S("Marching in Brass"), S("Craft a pair of brass boots"), 10, 1},
    {"boots_iron_cast", "unilib:armour_boots_iron_cast", S("Marching in Cast Iron"), S("Craft a pair of cast iron boots"), 10, 1},
    {"boots_lead", "unilib:armour_boots_lead", S("Marching in Lead"), S("Craft a pair of lead boots"), 10, 1},
    {"boots_silver", "unilib:armour_boots_silver", S("Marching in Silver"), S("Craft a pair of silver boots"), 10, 1},
    {"boots_steel_carbon", "unilib:armour_boots_steel_carbon", S("Marching in Carbon Steel"), S("Craft a pair of carbon steel boots"), 10, 1},
    {"boots_steel_stainless", "unilib:armour_boots_steel_stainless", S("Marching in Stainless Steel"), S("Craft a pair of stainless steel boots"), 10, 1},
    {"boots_tin", "unilib:armour_boots_tin", S("Marching in Tin"), S("Craft a pair of tin boots"), 10, 1},
    -- xtraores
    {"boots_adamantite", "unilib:armour_boots_adamantite", S("Marching in Adamantite"), S("Craft a pair of adamantite boots"), 20, 1},
    {"boots_ozymandium", "unilib:armour_boots_ozymandium", S("Marching in Ozymandium"), S("Craft a pair of ozymandium boots"), 20, 1},
    {"boots_planexium", "unilib:armour_boots_planexium", S("Marching in Planexium"), S("Craft a pair of planexium boots"), 20, 1},
    {"boots_rarium", "unilib:armour_boots_rarium", S("Marching in Rarium"), S("Craft a pair of rarium boots"), 20, 1},
    {"boots_sybilline", "unilib:armour_boots_sybilline", S("Marching in Sybilline"), S("Craft a pair of sybilline boots"), 20, 1},
    {"boots_tritonium", "unilib:armour_boots_tritonium", S("Marching in Tritonium"), S("Craft a pair of tritonium boots"), 20, 1},
    {"boots_unobtainium", "unilib:armour_boots_unobtainium", S("Marching in Unobtainium"), S("Craft a pair of unobtainium boots"), 20, 1},
}
local chestplate_init_list = {
    -- 3d_armor
    {"chestplate_bronze", "unilib:armour_chestplate_bronze", S("Donning Bronze"), S("Craft a bronze chestplate"), 10, 1},
    {"chestplate_cactus", "unilib:armour_chestplate_cactus", S("Donning Cactus"), S("Craft a cactus chestplate"), 10, 1},
    {"chestplate_crystallite", "unilib:armour_chestplate_crystallite", S("Donning Crystallite"), S("Craft a crystallite chestplate"), 20, 1},
    {"chestplate_diamond", "unilib:armour_chestplate_diamond", S("Donning Diamond"), S("Craft a diamond chestplate"), 20, 1},
    {"chestplate_gold", "unilib:armour_chestplate_gold", S("Donning Gold"), S("Craft a gold chestplate"), 10, 1},
    {"chestplate_mithril", "unilib:armour_chestplate_mithril", S("Donning Mithril"), S("Craft a mithril chestplate"), 10, 1},
    {"chestplate_nether", "unilib:armour_chestplate_nether", S("Donning Nether"), S("Craft a nether chestplate"), 10, 1},
    {"chestplate_steel", "unilib:armour_chestplate_steel", S("Donning Steel"), S("Craft a steel chestplate"), 10, 1},
    {"chestplate_wood", "unilib:armour_chestplate_wood", S("Donning Splinters"), S("Craft a wooden chestplate"), 10, 1},
    -- N.B. unilib:armour_chestplate_admin is excluded
    -- armor_expanded
    {"chestplate_leather", "unilib:armour_chestplate_leather", S("Donning Leather"), S("Craft a leather tunic"), 10, 1},
    {"chestplate_woven", "unilib:armour_chestplate_woven", S("Donning Weavings"), S("Craft a woven tunic"), 10, 1},
    -- technic_armor
    {"chestplate_brass", "unilib:armour_chestplate_brass", S("Donning Brass"), S("Craft a brass chestplate"), 10, 1},
    {"chestplate_iron_cast", "unilib:armour_chestplate_iron_cast", S("Donning Cast Iron"), S("Craft a cast iron chestplate"), 10, 1},
    {"chestplate_lead", "unilib:armour_chestplate_lead", S("Donning Lead"), S("Craft a lead chestplate"), 10, 1},
    {"chestplate_silver", "unilib:armour_chestplate_silver", S("Donning Silver"), S("Craft a silver chestplate"), 10, 1},
    {"chestplate_steel_carbon", "unilib:armour_chestplate_steel_carbon", S("Donning Carbon Steel"), S("Craft a carbon steel chestplate"), 10, 1},
    {"chestplate_steel_stainless", "unilib:armour_chestplate_steel_stainless", S("Donning Stainless Steel"), S("Craft a stainless steel chestplate"), 10, 1},
    {"chestplate_tin", "unilib:armour_chestplate_tin", S("Donning Tin"), S("Craft a tin chestplate"), 10, 1},
    -- xtraores
    {"chestplate_adamantite", "unilib:armour_chestplate_adamantite", S("Donning Adamantite"), S("Craft an adamantite chestplate"), 20, 1},
    {"chestplate_ozymandium", "unilib:armour_chestplate_ozymandium", S("Donning Ozymandium"), S("Craft an ozymandium chestplate"), 20, 1},
    {"chestplate_planexium", "unilib:armour_chestplate_planexium", S("Donning Planexium"), S("Craft a planexium chestplate"), 20, 1},
    {"chestplate_rarium", "unilib:armour_chestplate_rarium", S("Donning Rarium"), S("Craft a rarium chestplate"), 20, 1},
    {"chestplate_sybilline", "unilib:armour_chestplate_sybilline", S("Donning Sybilline"), S("Craft a sybilline chestplate"), 20, 1},
    {"chestplate_tritonium", "unilib:armour_chestplate_tritonium", S("Donning Tritonium"), S("Craft a tritonium chestplate"), 20, 1},
    {"chestplate_unobtainium", "unilib:armour_chestplate_unobtainium", S("Donning Unobtainium"), S("Craft an unobtainium chestplate"), 20, 1},
}
local gauntlets_init_list = {
    -- 3d_armor
    {"gauntlets_bronze", "unilib:armour_gauntlets_bronze", S("Buckling Bronze"), S("Craft bronze gauntlets"), 10, 1},
    {"gauntlets_cactus", "unilib:armour_gauntlets_cactus", S("Buckling Cactus"), S("Craft cactus gloves"), 10, 1},
    {"gauntlets_crystallite", "unilib:armour_gauntlets_crystallite", S("Buckling Crystallite"), S("Craft crystallite gauntlets"), 20, 1},
    {"gauntlets_diamond", "unilib:armour_gauntlets_diamond", S("Buckling Diamond"), S("Craft diamond gauntlets"), 20, 1},
    {"gauntlets_gold", "unilib:armour_gauntlets_gold", S("Buckling Gold"), S("Craft gold gauntlets"), 10, 1},
    {"gauntlets_mithril", "unilib:armour_gauntlets_mithril", S("Buckling Mithril"), S("Craft mithril gauntlets"), 10, 1},
    {"gauntlets_steel", "unilib:armour_gauntlets_steel", S("Buckling Steel"), S("Craft steel gauntlets"), 10, 1},
    {"gauntlets_wood", "unilib:armour_gauntlets_wood", S("Buckling Splinters"), S("Craft wooden gloves"), 10, 1},
}
local helmet_init_list = {
    -- 3d_armor
    {"helmet_bronze", "unilib:armour_helmet_bronze", S("Sporting Bronze"), S("Craft a bronze helmet"), 10, 1},
    {"helmet_cactus", "unilib:armour_helmet_cactus", S("Sporting Cactus"), S("Craft a cactus helmet"), 10, 1},
    {"helmet_crystallite", "unilib:armour_helmet_crystallite", S("Sporting Crystallite"), S("Craft a crystallite helmet"), 20, 1},
    {"helmet_diamond", "unilib:armour_helmet_diamond", S("Sporting Diamond"), S("Craft a diamond helmet"), 20, 1},
    {"helmet_gold", "unilib:armour_helmet_gold", S("Sporting Gold"), S("Craft a gold helmet"), 10, 1},
    {"helmet_mithril", "unilib:armour_helmet_mithril", S("Sporting Mithril"), S("Craft a mithril helmet"), 10, 1},
    {"helmet_nether", "unilib:armour_helmet_nether", S("Sporting Nether"), S("Craft a nether helmet"), 10, 1},
    {"helmet_steel", "unilib:armour_helmet_steel", S("Sporting Steel"), S("Craft a steel helmet"), 10, 1},
    {"helmet_wood", "unilib:armour_helmet_wood", S("Sporting Splinters"), S("Craft a wooden helmet"), 10, 1},
    -- N.B. unilib:armour_helmet_admin is excluded
    -- armor_expanded
    {"helmet_leather", "unilib:armour_helmet_leather", S("Sporting Leather"), S("Craft a leather cap"), 10, 1},
    {"helmet_woven", "unilib:armour_helmet_woven", S("Sporting Weavings"), S("Craft a woven cap"), 10, 1},
    -- technic_armor
    {"helmet_brass", "unilib:armour_helmet_brass", S("Sporting Bronze"), S("Craft a bronze helmet"), 10, 1},
    {"helmet_iron_cast", "unilib:armour_helmet_iron_cast", S("Sporting Cast Iron"), S("Craft a cast iron helmet"), 10, 1},
    {"helmet_lead", "unilib:armour_helmet_lead", S("Sporting Lead"), S("Craft a lead helmet"), 10, 1},
    {"helmet_silver", "unilib:armour_helmet_silver", S("Sporting Silver"), S("Craft a silver helmet"), 10, 1},
    {"helmet_steel_carbon", "unilib:armour_helmet_steel_carbon", S("Sporting Carbon Steel"), S("Craft a carbon steel helmet"), 10, 1},
    {"helmet_steel_stainless", "unilib:armour_helmet_steel_stainless", S("Sporting Stainless Steel"), S("Craft a stainless steel helmet"), 10, 1},
    {"helmet_tin", "unilib:armour_helmet_tin", S("Sporting Tin"), S("Craft a tin helmet"), 10, 1},
    -- xtraores
    {"helmet_adamantite", "unilib:armour_helmet_adamantite", S("Sporting Adamantite"), S("Craft an adamantite helmet"), 20, 1},
    {"helmet_ozymandium", "unilib:armour_helmet_ozymandium", S("Sporting Ozymandium"), S("Craft an ozymandium helmet"), 20, 1},
    {"helmet_planexium", "unilib:armour_helmet_planexium", S("Sporting Planexium"), S("Craft a planexium helmet"), 20, 1},
    {"helmet_rarium", "unilib:armour_helmet_rarium", S("Sporting Rarium"), S("Craft a rarium helmet"), 20, 1},
    {"helmet_sybilline", "unilib:armour_helmet_sybilline", S("Sporting Sybilline"), S("Craft a sybilline helmet"), 20, 1},
    {"helmet_tritonium", "unilib:armour_helmet_tritonium", S("Sporting Tritonium"), S("Craft a tritonium helmet"), 20, 1},
    {"helmet_unobtainium", "unilib:armour_helmet_unobtainium", S("Sporting Unobtainium"), S("Craft an unobtainium helmet"), 20, 1},
}
local leggings_init_list = {
    -- 3d_armor
    {"leggings_bronze", "unilib:armour_leggings_bronze", S("Strapping Bronze"), S("Craft bronze leggings"), 10, 1},
    {"leggings_cactus", "unilib:armour_leggings_cactus", S("Strapping Cactus"), S("Craft cactus leggings"), 10, 1},
    {"leggings_crystallite", "unilib:armour_leggings_crystallite", S("Strapping Crystallite"), S("Craft crystallite leggings"), 20, 1},
    {"leggings_diamond", "unilib:armour_leggings_diamond", S("Strapping Diamond"), S("Craft diamond leggings"), 20, 1},
    {"leggings_gold", "unilib:armour_leggings_gold", S("Strapping Gold"), S("Craft gold leggings"), 10, 1},
    {"leggings_mithril", "unilib:armour_leggings_mithril", S("Strapping Mithril"), S("Craft mithril leggings"), 10, 1},
    {"leggings_nether", "unilib:armour_leggings_nether", S("Strapping Nether"), S("Craft nether leggings"), 10, 1},
    {"leggings_steel", "unilib:armour_leggings_steel", S("Strapping Steel"), S("Craft steel leggings"), 10, 1},
    {"leggings_wood", "unilib:armour_leggings_wood", S("Strapping Splinters"), S("Craft wooden leggings"), 10, 1},
    -- N.B. unilib:armour_leggings_admin is excluded
    -- armor_expanded
    {"leggings_leather", "unilib:armour_leggings_leather", S("Strapping Leather"), S("Craft leather trousers"), 10, 1},
    {"leggings_woven", "unilib:armour_leggings_woven", S("Strapping Weavings"), S("Craft woven trousers"), 10, 1},
    -- technic_armor
    {"leggings_brass", "unilib:armour_leggings_brass", S("Strapping Brass"), S("Craft brass leggings"), 10, 1},
    {"leggings_iron_cast", "unilib:armour_leggings_iron_cast", S("Strapping Cast Iron"), S("Craft cast iron leggings"), 10, 1},
    {"leggings_lead", "unilib:armour_leggings_lead", S("Strapping Lead"), S("Craft lead leggings"), 10, 1},
    {"leggings_silver", "unilib:armour_leggings_silver", S("Strapping Silver"), S("Craft silver leggings"), 10, 1},
    {"leggings_steel_carbon", "unilib:armour_leggings_steel_carbon", S("Strapping Carbon Steel"), S("Craft carbon steel leggings"), 10, 1},
    {"leggings_steel_stainless", "unilib:armour_leggings_steel_stainless", S("Strapping Stainless Steel"), S("Craft stainless steel leggings"), 10, 1},
    {"leggings_tin", "unilib:armour_leggings_tin", S("Strapping Tin"), S("Craft tin leggings"), 10, 1},
    -- xtraores
    {"leggings_adamantite", "unilib:armour_leggings_adamantite", S("Strapping Adamantite"), S("Craft adamantite leggings"), 20, 1},
    {"leggings_ozymandium", "unilib:armour_leggings_ozymandium", S("Strapping Ozymandium"), S("Craft ozymandium leggings"), 20, 1},
    {"leggings_planexium", "unilib:armour_leggings_planexium", S("Strapping Planexium"), S("Craft planexium leggings"), 20, 1},
    {"leggings_rarium", "unilib:armour_leggings_rarium", S("Strapping Rarium"), S("Craft rarium leggings"), 20, 1},
    {"leggings_sybilline", "unilib:armour_leggings_sybilline", S("Strapping Sybilline"), S("Craft sybilline leggings"), 20, 1},
    {"leggings_tritonium", "unilib:armour_leggings_tritonium", S("Strapping Tritonium"), S("Craft tritonium leggings"), 20, 1},
    {"leggings_unobtainium", "unilib:armour_leggings_unobtainium", S("Strapping Unobtainium"), S("Craft unobtainium leggings"), 20, 1},
}
local shield_init_list = {
    -- 3d_armor
    {"shield_bronze", "unilib:armour_shield_bronze", S("Carrying Bronze"), S("Craft a bronze shield"), 10, 1},
    {"shield_cactus", "unilib:armour_shield_cactus", S("Carrying Cactus"), S("Craft a cactus shield"), 10, 1},
    {"shield_crystallite", "unilib:armour_shield_crystallite", S("Carrying Crystallite"), S("Craft a crystallite shield"), 20, 1},
    {"shield_diamond", "unilib:armour_shield_diamond", S("Carrying Diamond"), S("Craft a diamond shield"), 20, 1},
    {"shield_gold", "unilib:armour_shield_gold", S("Carrying Gold"), S("Craft a gold shield"), 10, 1},
    {"shield_mithril", "unilib:armour_shield_mithril", S("Carrying Mithril"), S("Craft a mithril shield"), 10, 1},
    {"shield_nether", "unilib:armour_shield_nether", S("Carrying Nether"), S("Craft a nether shield"), 10, 1},
    {"shield_steel", "unilib:armour_shield_steel", S("Carrying Steel"), S("Craft a steel shield"), 10, 1},
    {"shield_wood", "unilib:armour_shield_wood", S("Carrying Splinters"), S("Craft a wooden shield"), 10, 1},
    -- N.B. unilib:armour_shield_admin is excluded
    -- technic_armor
    {"shield_brass", "unilib:armour_shield_brass", S("Carrying Brass"), S("Craft a brass shield"), 10, 1},
    {"shield_iron_cast", "unilib:armour_shield_iron_cast", S("Carrying Cast Iron"), S("Craft a cast iron shield"), 10, 1},
    {"shield_lead", "unilib:armour_shield_lead", S("Carrying Lead"), S("Craft a lead shield"), 10, 1},
    {"shield_silver", "unilib:armour_shield_silver", S("Carrying Silver"), S("Craft a silver shield"), 10, 1},
    {"shield_steel_carbon", "unilib:armour_shield_steel_carbon", S("Carrying Carbon Steel"), S("Craft a carbon steel shield"), 10, 1},
    {"shield_steel_stainless", "unilib:armour_shield_steel_stainless", S("Carrying Stainless Steel"), S("Craft a stainless steel shield"), 10, 1},
    {"shield_tin", "unilib:armour_shield_tin", S("Carrying Tin"), S("Craft a tin shield"), 10, 1},
    -- xtraores
    {"shield_adamantite", "unilib:armour_shield_adamantite", S("Carrying Adamantite"), S("Craft an adamantite shield"), 20, 1},
    {"shield_ozymandium", "unilib:armour_shield_ozymandium", S("Carrying Ozymandium"), S("Craft an ozymandium shield"), 20, 1},
    {"shield_planexium", "unilib:armour_shield_planexium", S("Carrying Planexium"), S("Craft a planexium shield"), 20, 1},
    {"shield_rarium", "unilib:armour_shield_rarium", S("Carrying Rarium"), S("Craft a rarium shield"), 20, 1},
    {"shield_sybilline", "unilib:armour_shield_sybilline", S("Carrying Sybilline"), S("Craft a sybilline shield"), 20, 1},
    {"shield_tritonium", "unilib:armour_shield_tritonium", S("Carrying Tritonium"), S("Craft a tritonium shield"), 20, 1},
    {"shield_unobtainium", "unilib:armour_shield_unobtainium", S("Carrying Unobtainium"), S("Craft an unobtainium shield"), 20, 1},
}

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

unilib.pkg.award_armourer.vocation_name = "unilib_armourer"

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function compile_items()

    for _, mini_list in ipairs(boots_init_list) do

        if core.registered_tools[mini_list[2]] ~= nil then

            boots_lookup_table[mini_list[2]] = true
            table.insert(all_select_list, mini_list)

        end

    end

    for _, mini_list in ipairs(chestplate_init_list) do

        if core.registered_tools[mini_list[2]] ~= nil then

            chestplate_lookup_table[mini_list[2]] = true
            table.insert(all_select_list, mini_list)

        end

    end

    for _, mini_list in ipairs(gauntlets_init_list) do

        if core.registered_tools[mini_list[2]] ~= nil then

            gauntlets_lookup_table[mini_list[2]] = true
            table.insert(all_select_list, mini_list)

        end

    end

    for _, mini_list in ipairs(helmet_init_list) do

        if core.registered_tools[mini_list[2]] ~= nil then

            helmet_lookup_table[mini_list[2]] = true
            table.insert(all_select_list, mini_list)

        end

    end

    for _, mini_list in ipairs(leggings_init_list) do

        if core.registered_tools[mini_list[2]] ~= nil then

            leggings_lookup_table[mini_list[2]] = true
            table.insert(all_select_list, mini_list)

        end

    end

    for _, mini_list in ipairs(shield_init_list) do

        if core.registered_tools[mini_list[2]] ~= nil then

            shield_lookup_table[mini_list[2]] = true
            table.insert(all_select_list, mini_list)

        end

    end

end

local function on_collect(player, full_name)

    if not unilib.utils.is_player(player) or full_name == nil then
        return
    end

    if boots_lookup_table[full_name] ~= nil then

        unilib.awards.handle_collection_trigger(
            player, "armourer_collect_boots", "unilib_armourer_collect_boots_1", full_name
        )

    elseif chestplate_lookup_table[full_name] ~= nil then

        unilib.awards.handle_collection_trigger(
            player, "armourer_collect_chestplate", "unilib_armourer_collect_chestplate_1", full_name
        )

    elseif gauntlets_lookup_table[full_name] ~= nil then

        unilib.awards.handle_collection_trigger(
            player, "armourer_collect_gauntlets", "unilib_armourer_collect_gauntlets_1", full_name
        )

    elseif helmet_lookup_table[full_name] ~= nil then

        unilib.awards.handle_collection_trigger(
            player, "armourer_collect_helmet", "unilib_armourer_collect_helmet_1", full_name
        )

    elseif leggings_lookup_table[full_name] ~= nil then

        unilib.awards.handle_collection_trigger(
            player, "armourer_collect_leggings", "unilib_armourer_collect_leggings_1", full_name
        )

    elseif shield_lookup_table[full_name] ~= nil then

        unilib.awards.handle_collection_trigger(
            player, "armourer_collect_shield", "unilib_armourer_collect_shield_1", full_name
        )

    end

end

local function on_equip(player, index, stack)

    local armour_category = unilib.utils.get_first_component(stack:get_name())
    unilib.awards.handle_collection_trigger(
        player, "armourer_collect_equip", "unilib_armourer_collect_equip", armour_category
    )

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.award_armourer.init()

    return {
        description = "Awards for crafting armour (\"Armourer\")",
        notes = "Assumes a world containing at least the armours provided by the \"3d_armor\"" ..
            " remix",
    }

end

function unilib.pkg.award_armourer.post()

    -- Sanity check -------------------------------------------------------------------------------

    if not unilib.setting.awards_enable_flag then
        return
    end

    -- Setup --------------------------------------------------------------------------------------

    -- N.B. Filter out armours that are not in the game
    compile_items()

    -- Trigger prototypes -------------------------------------------------------------------------

    unilib.awards.register_trigger_prototype({
        name = "armourer_collect_boots",
        trigger_type = "custom",
        hint_list = {"Craft one type of boots", "Craft @1 types of boots"},
        progress_list = {"Craft one type of boots", "Craft @1/@2 types of boots"},
    })

    unilib.awards.register_trigger_prototype({
        name = "armourer_collect_chestplate",
        trigger_type = "custom",
        hint_list = {"Craft one type of chestplate", "Craft @1 types of chestplate"},
        progress_list = {"Craft one type of chestplate", "Craft @1/@2 types of chestplate"},
    })

    unilib.awards.register_trigger_prototype({
        name = "armourer_collect_gauntlets",
        trigger_type = "custom",
        hint_list = {"Craft one type of gauntlets", "Craft @1 types of gauntlets"},
        progress_list = {"Craft one type of gauntlets", "Craft @1/@2 types of gauntlets"},
    })

    unilib.awards.register_trigger_prototype({
        name = "armourer_collect_helmet",
        trigger_type = "custom",
        hint_list = {"Craft one type of helmet", "Craft @1 types of helmet"},
        progress_list = {"Craft one type of helmet", "Craft @1/@2 types of helmet"},
    })

    unilib.awards.register_trigger_prototype({
        name = "armourer_collect_leggings",
        trigger_type = "custom",
        hint_list = {"Craft one type of leggings", "Craft @1 types of leggings"},
        progress_list = {"Craft one type of leggings", "Craft @1/@2 types of leggings"},
    })

    unilib.awards.register_trigger_prototype({
        name = "armourer_collect_shield",
        trigger_type = "custom",
        hint_list = {"Craft one type of shield", "Craft @1 types of shield"},
        progress_list = {"Craft one type of shield", "Craft @1/@2 types of shield"},
    })

    unilib.awards.register_trigger_prototype({
        name = "armourer_collect_set",
        trigger_type = "custom",
        hint_list = {"Equip one category of armour", "Equip @1 categories of armour"},
        progress_list = {"Equip one category of armour", "Equip @1/@2 categories of armour"},
    })

    -- Trigger event callbacks --------------------------------------------------------------------

    core.register_on_craft(function(itemstack, player, old_craft_grid, craft_inv)
        on_collect(player, itemstack:get_name())
    end)

    unilib.armour.register_callback_on_equip(on_equip)

    -- Vocations ----------------------------------------------------------------------------------

    -- Assumes at least the "3d_armor" remix, total score 1010
    local score_list = {10, 20, 50, 100, 150, 200, 300, 400, 500, 600, 800, 1000}
    -- Assumes at least the "3d_armor" and "xtraores" remixes, total score 1710
--  local score_list = {10, 20, 50, 100, 200, 400, 600, 800, 1000, 1200, 1400, 1700}

    unilib.awards.register_vocation({
        name = unilib.pkg.award_armourer.vocation_name,

        title = S("Armourer"),
        description = S("Armour? Completed it, mate"),
        icon = "unilib_award_vocation_armourer.png",
        level_list = {
            {title = S("Booting Up"), score = score_list[1]},
            {title = S("Chest Day"), score = score_list[2]},
            {title = S("Shield Yourself from Disappointment"), score = score_list[3]},
            {title = S("Suit Yourself"), score = score_list[4]},
            {title = S("Throwing Down the Gauntlet"), score = score_list[5]},
            {title = S("Helm Improvement"), score = score_list[6]},
            {title = S("Never Skipped Leg Day"), score = score_list[7]},
            {title = S("Shield of Approval"), score = score_list[8]},
            {title = S("Plate Expectations"), score = score_list[9]},
            {title = S("Over-protective"), score = score_list[10]},
            {title = S("Armourgeddon"), score = score_list[11]},
            {title = S("The Walking Tank"), score = score_list[12]},
        },
    })

    -- Achievements -------------------------------------------------------------------------------

    -- Selective achievements
    for _, mini_list in ipairs(all_select_list) do

        -- mini_list in the form
        --      [partial_achievement_name, full_name, title, description, score, target]
        unilib.awards.register_achievement({
            name = "unilib_armourer_select_" .. mini_list[1],
            trigger_table = {
                prototype = "unilib_craft",
                target = mini_list[6],
                item_list = unilib.utils.convert_to_list(mini_list[2]),
            },

            title = mini_list[3],
            description = mini_list[4],
            score = mini_list[5],
            vocation_list = {unilib.pkg.award_armourer.vocation_name},
        })

    end

    -- Collector achievements (crafting)
    local boots_count = unilib.utils.get_table_size(boots_lookup_table)
    if boots_count >= 5 then

        local boots_list = {
            {S("Skilled Shoemaker"), S("Craft 5 types of boots"), 20, 5},
            {S("Elite Shoemaker"), S("Craft every type of boots"), 50, boots_count},
        }

        for i, mini_list in ipairs(boots_list) do

            unilib.awards.register_achievement({
                name = "unilib_armourer_collect_boots_" .. i,
                trigger_table = {
                    prototype = "armourer_collect_boots",
                    target = mini_list[4],
                    item_list = {"group:armour_feet"},
                },

                title = mini_list[1],
                description = mini_list[2],
                score = mini_list[3],
                vocation_list = {unilib.pkg.award_armourer.vocation_name},
            })

        end

    end

    local chestplate_count = unilib.utils.get_table_size(chestplate_lookup_table)
    if chestplate_count >= 5 then

        local chestplate_list = {
            {S("Skilled Blacksmith"), S("Craft 5 types of chestplate"), 20, 5},
            {S("Elite Blacksmith"), S("Craft every type of chestplate"), 50, chestplate_count},
        }

        for i, mini_list in ipairs(chestplate_list) do

            unilib.awards.register_achievement({
                name = "unilib_armourer_collect_chestplate_" .. i,
                trigger_table = {
                    prototype = "armourer_collect_chestplate",
                    target = mini_list[4],
                    item_list = {"group:armour_torso"},
                },

                title = mini_list[1],
                description = mini_list[2],
                score = mini_list[3],
                vocation_list = {unilib.pkg.award_armourer.vocation_name},
            })

        end

    end

    local gauntlets_count = unilib.utils.get_table_size(gauntlets_lookup_table)
    if gauntlets_count >= 5 then

        local gauntlets_list = {
            {S("Skilled Glover"), S("Craft 5 types of gauntlets"), 20, 5},
            {S("Elite Glover"), S("Craft every type of gauntlets"), 50, gauntlets_count},
        }

        for i, mini_list in ipairs(gauntlets_list) do

            unilib.awards.register_achievement({
                name = "unilib_armourer_collect_gauntlets_" .. i,
                trigger_table = {
                    prototype = "armourer_collect_gauntlets",
                    target = mini_list[4],
                    item_list = {"group:armour_hands"},
                },

                title = mini_list[1],
                description = mini_list[2],
                score = mini_list[3],
                vocation_list = {unilib.pkg.award_armourer.vocation_name},
            })

        end

    end

    local helmet_count = unilib.utils.get_table_size(helmet_lookup_table)
    if helmet_count >= 5 then

        local helmet_list = {
            {S("Skilled Head Honcho"), S("Craft 5 types of helmet"), 20, 5},
            {S("Elite Head Honcho"), S("Craft every type of helmet"), 50, helmet_count},
        }

        for i, mini_list in ipairs(helmet_list) do

            unilib.awards.register_achievement({
                name = "unilib_armourer_collect_helmet_" .. i,
                trigger_table = {
                    prototype = "armourer_collect_helmet",
                    target = mini_list[4],
                    item_list = {"group:armour_head"},
                },

                title = mini_list[1],
                description = mini_list[2],
                score = mini_list[3],
                vocation_list = {unilib.pkg.award_armourer.vocation_name},
            })

        end

    end

    local leggings_count = unilib.utils.get_table_size(leggings_lookup_table)
    if leggings_count >= 5 then

        local leggings_list = {
            {S("Skilled Greavewright"), S("Craft 5 types of leggings"), 20, 5},
            {S("Elite Greavewright"), S("Craft every type of leggings"), 50, leggings_count},
        }

        for i, mini_list in ipairs(leggings_list) do

            unilib.awards.register_achievement({
                name = "unilib_armourer_collect_leggings_" .. i,
                trigger_table = {
                    prototype = "armourer_collect_leggings",
                    target = mini_list[4],
                    item_list = {"group:armour_legs"},
                },

                title = mini_list[1],
                description = mini_list[2],
                score = mini_list[3],
                vocation_list = {unilib.pkg.award_armourer.vocation_name},
            })

        end

    end

    local shield_count = unilib.utils.get_table_size(shield_lookup_table)
    if shield_count >= 5 then

        local shield_list = {
            {S("Skilled Shieldwright"), S("Craft 5 types of shield"), 20, 5},
            {S("Elite Shieldwright"), S("Craft every type of shield"), 50, shield_count},
        }

        for i, mini_list in ipairs(shield_list) do

            unilib.awards.register_achievement({
                name = "unilib_armourer_collect_shield_" .. i,
                trigger_table = {
                    prototype = "armourer_collect_shield",
                    target = mini_list[4],
                    item_list = {"group:armour_shield"},
                },

                title = mini_list[1],
                description = mini_list[2],
                score = mini_list[3],
                vocation_list = {unilib.pkg.award_armourer.vocation_name},
            })

        end

    end

    -- Collector achievements (equipping)
    if boots_count and
            chestplate_count and
            gauntlets_count and
            helmet_count and
            leggings_count and
            shield_count then

        unilib.awards.register_achievement({
            name = "unilib_armour_collect_set",
            trigger_table = {
                prototype = "armourer_collect_set",
                target = 6,
                item_list = {
                    "group:armour_feet",
                    "group:armour_torso",
                    "group:armour_hands",
                    "group:armour_head",
                    "group:armour_legs",
                    "group:armour_shield",
                }
            },

            title = S("Suit Up"),
            description = S("Equip every category of armour"),
            score = 20,
            vocation_list = {unilib.pkg.award_armourer.vocation_name},
        })

    end

end
