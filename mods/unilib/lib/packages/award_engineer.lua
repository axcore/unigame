---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.award_engineer = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

unilib.pkg.award_engineer.vocation_name = "unilib_engineer"

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.award_engineer.init()

    return {
        description = "Awards for technic, pipewords, mesecons, digilines and digtrons" ..
                " (\"Engineer\")",
    }

end

function unilib.pkg.award_engineer.post()

    -- Sanity check -------------------------------------------------------------------------------

    if not unilib.setting.awards_enable_flag or not core.get_modpath("technic") then
        return
    end

    -- Vocations ----------------------------------------------------------------------------------

    -- Assumes technic (830), pipeworks (300) and mesecons (380), total 1510
    local score_list = {10, 20, 50, 100, 200, 300, 400, 600, 800, 1000, 1200, 1400}
    -- Assumes technic, pipeworks, mesecons, digilines (60) and digtrons (130), total 1700
--  local score_list = {10, 20, 50, 100, 200, 300, 400, 600, 800, 1000, 1300, 1600}

    unilib.awards.register_vocation({
        name = unilib.pkg.award_engineer.vocation_name,

        title = S("Engineer"),
        description = S("Become an expert in technic, pipeworks, mesecons and digilines"),
        icon = "unilib_award_vocation_engineer.png",
        level_list = {
            {title = S("Assembly Required"), score = score_list[1]},
            {title = S("Wire We Doing This?"), score = score_list[2]},
            {title = S("Current Events"), score = score_list[3]},
            {title = S("Shockingly Inefficient"), score = score_list[4]},
            {title = S("Factory Reset Required"), score = score_list[5]},
            {title = S("Pipe Dreams"), score = score_list[6]},
            {title = S("Power Struggle"), score = score_list[7]},
            {title = S("Circuit Breaker"), score = score_list[8]},
            {title = S("Tech Support Hotline"), score = score_list[9]},
            {title = S("Automation Nation"), score = score_list[10]},
            {title = S("Built a Factory to Craft a Stick"), score = score_list[11]},
            {title = S("Certified Lag Engineer"), score = score_list[12]},
        },
    })

    -- Achievements -------------------------------------------------------------------------------

    -- Combination achievements
    local cable_list = {"technic:lv_cable", "technic:mv_cable", "technic:hv_cable"}
    local digger_list = {"digtron:digger", "digtron:dual_digger", "digtron:dual_soft_digger", "digtron:intermittent_digger", "digtron:intermittent_soft_digger", "digtron:soft_digger"}
    local gate_list = {"mesecons_gates:and_off", "mesecons_gates:diode_off", "mesecons_gates:nand_off", "mesecons_gates:nor_off", "mesecons_gates:not_off", "mesecons_gates:or_off", "mesecons_gates:xor_off"}
    local injector_list = {"pipeworks:filter", "pipeworks:mese_filter", "pipeworks:digiline_filter", "pipeworks:digiline:filter"}
    local insulated_list = {"mesecons_insulated:insulated_off", "mesecons_extrawires:corner_off", "mesecons_extrawires:crossover_off", "mesecons_extrawires:doublecorner_00", "mesecons_extrawires:tjunction_off"}
    local wire_list = {"mesecons:wire_00000000_off", "mesecons_extrawires:vertical_off"}

    for i, mini_list in ipairs({
        -- digilines
        {"digiline_1", gate_list, "unilib_place", S("Amateur Digiline Installer"), S("Place 25 digilines"), 10, 25},
        {"digiline_2", gate_list, "unilib_place", S("Skilled Digiline Installer"), S("Place 225 digilines"), 20, 225},
        -- digtrons
        {"digger_1", digger_list, "unilib_craft", S("Amateur Auto-Digger"), S("Craft 5 digtron digger heads"), 10, 5},
        {"digger_2", digger_list, "unilib_craft", S("Skilled Auto-Digger"), S("Craft 50 digtron digger heads"), 20, 50},
        -- mesecons
        {"gate_1", gate_list, "unilib_place", S("Amateur Logician"), S("Place 30 logic gates"), 10, 30},
        {"gate_2", gate_list, "unilib_place", S("Skilled Logician"), S("Place 300 logic gates"), 20, 300},
        {"insulated_1", insulated_list, "unilib_place", S("Amateur Insulator"), S("Place 30 insulated wires"), 10, 30},
        {"insulated_2", insulated_list, "unilib_place", S("Skilled Insulator"), S("Place 300 insulated wires"), 20, 300},
        {"mesecon_1", wire_list, "unilib_place", S("Amateur Mesecon Installer"), S("Place 20 mesecon wires"), 10, 20},
        {"mesecon_2", wire_list, "unilib_place", S("Novice Mesecon Installer"), S("Place 100 mesecon wires"), 10, 100},
        {"mesecon_3", wire_list, "unilib_place", S("Skilled Mesecon Installer"), S("Place 500 mesecon wires"), 20, 500},
        {"mesecon_4", wire_list, "unilib_place", S("Veteran Mesecon Installer"), S("Place 2500 mesecon wires"), 30, 2500},
        -- pipeworks (machines)
        {"autocraft_1", "pipeworks:autocrafter", "unilib_place", S("Amateur Lazybones"), S("Place 6 autocrafters"), 10, 6},
        {"autocraft_2", "pipeworks:autocrafter", "unilib_place", S("Skilled Lazybones"), S("Place 60 autocrafters"), 20, 60},
        {"breaker_1", "pipeworks:nodebreaker_off", "unilib_place", S("Amateur Node Breaker"), S("Place 10 node breakers"), 10, 10},
        {"breaker_2", "pipeworks:nodebreaker_off", "unilib_place", S("Novice Node Breaker"), S("Place 100 node breakers"), 20, 100},
        {"breaker_3", "pipeworks:nodebreaker_off", "unilib_place", S("Skilled Node Breaker"), S("Place 500 node breakers"), 30, 500},
        {"deployer_1", "pipeworks:deployer_off", "unilib_place", S("Amateur Node Deployer"), S("Place 5 deployers"), 10, 5},
        {"deployer_2", "pipeworks:deployer_off", "unilib_place", S("Skilled Node Deployer"), S("Place 50 deployers"), 20, 50},
        {"dispenser_1", "pipeworks:dispenser_off", "unilib_place", S("Amateur Dispenser"), S("Place 5 dispensers"), 10, 5},
        {"dispenser_2", "pipeworks:dispenser_off", "unilib_place", S("Skilled Dispenser"), S("Place 50 dispensers"), 20, 50},
        {"injector_1", injector_list, "unilib_place", S("Amateur Injector"), S("Place 8 filter-injectors"), 10, 8},
        {"injector_2", injector_list, "unilib_place", S("Skilled Injector"), S("Place 80 filter-injectors"), 20, 80},
        -- pipeworks (tubes)
        {"tube_1", "pipeworks:tube_1", "unilib_place", S("Amateur Tube Installer"), S("Place 100 ordinary tubes"), 10, 100},
        {"tube_2", "pipeworks:tube_1", "unilib_place", S("Skilled Tube Installer"), S("Place 1000 ordinary tubes"), 20, 1000},
        {"tube_3", "pipeworks:tube_1", "unilib_place", S("Veteran Tube installer"), S("Place 10,000 ordinary tubes"), 30, 10000},
        -- technic
        {"cable_1", cable_list, "unilib_place", S("Amateur Cable Installer"), S("Place 20 technic cables"), 10, 20},
        {"cable_2", cable_list, "unilib_place", S("Novice Cable Installer"), S("Place 100 technic cables"), 10, 100},
        {"cable_3", cable_list, "unilib_place", S("Skilled Cable Installer"), S("Place 500 technic cables"), 20, 500},
        {"cable_4", cable_list, "unilib_place", S("Veteran Cable Installer"), S("Place 2500 technic cables"), 30, 2500},
        {"uranium_1", "technic:uranium_fuel", "unilib_craft", S("Amateur Uranium Refiner"), S("Craft 3 uranium fuel"), 10, 3},
        {"uranium_2", "technic:uranium_fuel", "unilib_craft", S("Novice Uranium Refiner"), S("Craft 9 uranium fuel"), 20, 9},
        {"uranium_3", "technic:uranium_fuel", "unilib_craft", S("Skilled Uranium Refiner"), S("Craft 27 uranium fuel"), 30, 27},
        {"uranium_4", "technic:uranium_fuel", "unilib_craft", S("Veteran Uranium Refiner"), S("Craft 81 uranium fuel"), 40, 81},
        {"uranium_5", "technic:uranium_fuel", "unilib_craft", S("Master Uranium Refiner"), S("Craft 243 uranium fuel"), 50, 243},
        {"uranium_6", "technic:uranium_fuel", "unilib_craft", S("Elite Uranium Refiner"), S("Craft 729 uranium fuel"), 100, 729},
    }) do

        if unilib.awards.check_argument(mini_list[2]) then

            unilib.awards.register_achievement({
                name = "unilib_engineer_comb_" .. mini_list[1],
                trigger_table = {
                    prototype = mini_list[3],
                    target = mini_list[7],
                    item_list = unilib.utils.convert_to_list(mini_list[2]),
                },

                title = mini_list[4],
                description = mini_list[5],
                score = mini_list[6],
                vocation_list = {unilib.pkg.award_engineer.vocation_name},
            })

        end

    end

    -- Selective achievements
    local alloy_furnace_list = {"technic:coal_alloy_furnace", "technic:lv_alloy_furnace", "technic:mv_alloy_furnace"}
    local array_list = {"technic:solar_array_lv", "technic:solar_array_mv", "technic:solar_array_hv"}
    local battery_list = {"technic:lv_battery_box0", "technic:mv_battery_box0", "technic:hv_battery_box0"}
    local chest_copper_list = {"technic:copper_chest", "technic:copper_locked_chest"}
    local chest_gold_list = {"technic:gold_chest", "technic:gold_locked_chest"}
    local chest_iron_list = {"technic:iron_chest", "technic:iron_locked_chest"}
    local chest_mithril_list = {"technic:mithril_chest", "technic:mithril_locked_chest"}
    local chest_silver_list = {"technic:silver_chest", "technic:silver_locked_chest"}
    local compressor_list = {"technic:lv_compressor", "technic:mv_compressor"}
    local constructor_list = {"technic:constructor_mk1_off", "technic:constructor_mk2_off", "technic:constructor_mk3_off"}
    local drill_list = {"technic:mining_drill", "technic:mining_drill_mk2", "technic:mining_drill_mk3"}
    local elec_furnace_list = {"technic:lv_electric_furnace", "technic:mv_electric_furnace"}
    local extractor_list = {"technic:lv_extractor", "technic:mv_extractor"}
    local generator_list = {"technic:lv_generator", "technic:mv_generator", "technic:hv_generator"}
    local grinder_list = {"technic:lv_grinder", "technic:mv_grinder"}
    local laser_list = {"technic:laser_mk1", "technic:laser_mk2", "technic:laser_mk3"}
    local movestone_list = {"mesecons_movestones:movestone", "mesecons_movestones:movestone_vertical"}
    local piston_list = {"mesecons_pistons:piston_normal_off", "mesecons_pistons:piston_sticky_off"}
    local plate_list = {"mesecons_pressureplates:pressure_plate_wood_off", "mesecons_pressureplates:pressure_plate_stone_off"}
    local sticky_movestone_list = {"mesecons_movestones:sticky_movestone", "mesecons_movestones:sticky_movestone_vertical"}
    local transformer_list = {"technic:lv_transformer", "technic:mv_transformer", "technic:hv_transformer"}

    local lightstone_list = {}
    for _, colour in ipairs({"blue", "cyan", "darkgray", "gray", "green", "magenta", "orange", "pink", "red", "violet", "white", "yellow"}) do
        table.insert(lightstone_list, "mesecons_lightstone:lightstone_" .. colour .. "_off")
    end

    for i, mini_list in ipairs({
        -- digilines
        {"lcd", "digilines:lcd", "unilib_craft", S("Lightly-Competent Displaymaker"), S("Craft 4 digilines LCDs"), 10, 4},
        {"lightsensor", "digilines:lightsensor", "unilib_craft", S("Overly Sensitive"), S("Craft a digiline lightsensor"), 10, 1},
        {"rtc", "digilines:rtc", "unilib_craft", S("Time Will Tell"), S("Craft a digiline RTC"), 10, 1},

        -- digtrons
        {"auto_controller", "digtron:auto_controller", "unilib_craft", S("Control Freak"), S("Craft a digtron automatic control module"), 10, 1},
        {"builder", "digtron:builder", "unilib_craft", S("Block by Block"), S("Craft 4 digtron builder modules"), 10, 4},
        {"combined_storage", "digtron:combined_storage", "unilib_craft", S("Hoard Mode Enabled"), S("Craft 4 digtron combined storage"), 10, 4},
        {"controller", "digtron:controller", "unilib_craft", S("Toggle Jockey"), S("Craft a digtron control module"), 10, 1},
        {"empty_crate", "digtron:empty_crate", "unilib_craft", S("Crate Expectations"), S("Craft a digtron crate"), 10, 1},
        {"empty_locked_crate", "digtron:empty_locked_crate", "unilib_craft", S("The Crate Escape"), S("Craft a digtron locked crate"), 10, 1},
        {"fuelstore", "digtron:fuelstore", "unilib_craft", S("Boxed-In"), S("Craft 4 digtron fuel storage"), 10, 4},
        {"inventory", "digtron:inventory", "unilib_craft", S("Crafting in Bulk"), S("Craft 4 inventory storage"), 10, 4},
        {"light", "digtron:light", "unilib_craft", S("Bright is Right"), S("Craft 2 digtron lights"), 10, 2},
        {"structure", "digtron:structure", "unilib_craft", S("Block Jock"), S("Craft 4 digtron structures"), 10, 4},

        -- mesecons (machines)
        {"fpga", "mesecons_fpga:fpga0000", "unilib_craft", S("What the Heck Is an FPGA"), S("Craft 2 FPGAs"), 10, 2},
        {"hydro_turbine", "mesecons_hydroturbine:hydro_turbine_off", "unilib_craft", S("Spin to Win"), S("Craft 4 water turbines"), 10, 4},
        {"lamp", "mesecons_lamp:lamp_off", "unilib_craft", S("Glow-Getter"), S("Craft 9 mesecon lamps"), 10, 9},
        {"luacontroller", "mesecons_luacontroller:luacontroller0000", "unilib_craft", S("Control Yourself"), S("Craft 4 Luacontrollers"), 10, 4},
        {"microcontroller", "mesecons_microcontroller:microcontroller0000", "unilib_craft", S("Micro Manager"), S("Craft 2 mesecon microcontrollers"), 10, 2},
        {"movestone", movestone_list, "unilib_craft", S("Move It or Lose It"), S("Craft 4 movestones"), 10, 4},
        {"movestone_sticky", sticky_movestone_list, "unilib_craft", S("Sticky Situation"), S("Craft 4 sticky movestones"), 10, 4},
        {"node_detector", "mesecons_detector:node_detector_off", "unilib_craft", S("Node to Joy"), S("Craft 2 node detectors"), 10, 2},
        {"object_detector", "mesecons_detector:object_detector_off", "unilib_craft", S("What's That, Then?"), S("Craft 2 object detectors"), 10, 2},
        {"piston", piston_list, "unilib_craft", S("Piston Impossible"), S("Craft 4 pistons"), 10, 4},
        {"programmer", "mesecons_fpga:programmer", "unilib_craft", S("Code Blooded"), S("Craft an FPGA programmer"), 10, 1},
        {"switch", "mesecons_switch:mesecon_switch_off", "unilib_craft", S("Flip Out"), S("Craft 2 mesecon switches"), 10, 2},
        -- mesecons (misc)
        {"block_sticky", "mesecons_stickyblocks:sticky_block_all", "unilib_craft", S("Adhesion Artist"), S("Craft 4 sticky blocks"), 10, 4},
        {"button", "mesecons_button:button_off", "unilib_craft", S("Pressed for Success"), S("Craft 4 mesecon buttons"), 10, 4},
        {"delayer", "mesecons_delayer:delayer_off_1", "unilib_craft", S("Pro Crastinator"), S("Craft a mesecon delayer"), 10, 1},
        {"ghoststone", "mesecons_random:ghoststone", "unilib_craft", S("Phantom Shifter"), S("Craft 8 ghoststones"), 10, 8},
        {"lever", "mesecons_walllever:wall_lever_off", "unilib_craft", S("Leveraged Assets"), S("Craft 4 wall levers"), 10, 4},
        {"lightstone", lightstone_list, "unilib_craft", S("Lighten Up"), S("Craft 12 mesecon lightstones"), 10, 12},
        {"noteblock", "mesecons_noteblock:noteblock", "unilib_craft", S("Block 'n' Roll"), S("Craft a noteblock"), 10, 1},
        {"plant_blinky", "mesecons_blinkyplant:blinky_plant", "unilib_craft", S("Blink and You'll Miss It"), S("Craft 7 blinky plants"), 10, 7},
        {"plant_power", "mesecons_powerplant:power_plant", "unilib_craft", S("No Off Switch"), S("Craft 7 power plant"), 10, 7},
        {"plate_pressure", plate_list, "unilib_craft", S("Step Right Up"), S("Craft 12 pressure plates"), 10, 12},
        {"removestone", "mesecons_random:removestone", "unilib_craft", S("Stone Alone"), S("Craft 8 removestones"), 10, 8},
        {"solar", "mesecons_solarpanelx:solar_panel_off", "unilib_craft", S("Solar Flair"), S("Craft a mesecon solar panel"), 10, 1},
        {"torch", "mesecons_torch:mesecon_torch_on", "unilib_craft", S("Flash Point"), S("Craft 8 mesecon torches"), 10, 8},

        -- pipeworks (machines)
        {"trashcan", "pipeworks:trashcan", "unilib_place", S("Bin There, Done That"), S("Place a trash can"), 10, 1},
        -- pipeworks (tubes)
        {"tube_detecting", "pipeworks:detector_tube_off_1", "unilib_place", S("Sense and Sensibility"), S("Place 125 detecting pneumatic tubes"), 10, 125},
        {"tube_lua", "pipeworks:lua_tube000000", "unilib_place", S("Code Conduit"), S("Place 125 lua-controlled tubes"), 10, 125},
        {"tube_oneway", "pipeworks:one_way_tube", "unilib_place", S("One Way or Another"), S("Place 125 one-way tubes"), 10, 125},
        {"tube_sorting", "pipeworks:mese_tube_000000", "unilib_place", S("Sorted Out"), S("Place 125 sorting pneumatic tubes"), 10, 125},
        {"tube_teleport", "pipeworks:teleport_tube_1", "unilib_place", S("Pipe Dream"), S("Place 125 teleporting pneumatic tubes"), 10, 125},
        {"tube_vacuum", "pipeworks:sand_tube_1", "unilib_place", S("Suck-o-Matic"), S("Place 125 vacuuming pneumatic tubes"), 10, 125},

        -- technic (machines)
        {"array_solar", array_list, "unilib_craft", S("Watt's Up"), S("Craft 3 solar arrays"), 10, 3},
        {"box_battery", battery_list, "unilib_craft", S("Box of Shocks"), S("Craft 5 battery boxes"), 10, 5},
        {"centrifuge", "technic:mv_centrifuge", "unilib_craft", S("Spin Doctor"), S("Craft a centrifuge"), 10, 1},
        {"cnc", "technic:cnc", "unilib_craft", S("Block to Basics"), S("Craft a CNC machine"), 10, 1},
        {"compressor", compressor_list, "unilib_craft", S("Heavy-Duty Hugger"), S("Craft a compressor"), 10, 1},
        {"constructor", constructor_list, "unilib_craft", S("Power Builder"), S("Craft a constructor"), 10, 1},
        {"converter", "technic:supply_converter", "unilib_craft", S("Be the Change You Want to See"), S("Craft a supply converter"), 10, 1},
        {"extractor", extractor_list, "unilib_craft", S("Siphon It Up"), S("Craft an extractor"), 10, 1},
        {"freezer", "technic:mv_freezer", "unilib_craft", S("Freeze Frame"), S("Craft a technic freezer"), 10, 1},
        {"furnace_alloy", alloy_furnace_list, "unilib_craft", S("Smelter Skelter"), S("Craft an alloy furnace"), 10, 1},
        {"furnace_electric", elec_furnace_list, "unilib_craft", S("Ohm-Made Inferno"), S("Craft an electric furnace"), 10, 1},
        {"generator_fuel", generator_list, "unilib_craft", S("Power Trip"), S("Craft a fuel-fired generator"), 10, 1},
        {"generator_geothermal", "technic:geothermal", "unilib_craft", S("Hot Stuff"), S("Craft a geothermal generator"), 10, 1},
        {"generator_hydro", "technic:hydro_turbine", "unilib_craft", S("Water You Waiting For?"), S("Craft a hydro generator"), 10, 1},
        {"generator_solar", "technic:solar_panel", "unilib_craft", S("Amp It Up"), S("Craft a small solar generator"), 10, 1},
        {"grinder", grinder_list, "unilib_craft", S("Grind and Bear It"), S("Craft a grinder"), 10, 1},
        {"monitor", "technic:power_monitor", "unilib_craft", S("Peek Performance"), S("Craft a power monitor"), 10, 1},
        {"player", "technic:music_player", "unilib_craft", S("Bass Invader"), S("Craft a music player"), 10, 1},
        {"quarry", "technic:quarry", "unilib_craft", S("Diggin the Vibes"), S("Craft 10 HV quarries"), 10, 10},
        {"station_switching", "technic:switching_station", "unilib_craft", S("Route of All Evil"), S("Craft 3 switching stations"), 10, 3},
        {"workshop", "technic:tool_workshop", "unilib_craft", S("Hammered Out the Basics"), S("Craft a tool workshop"), 10, 1},
        -- technic (nuclear)
        {"core_nuclear", "technic:hv_nuclear_reactor_core", "unilib_craft", S("Core Blimey"), S("Craft a nuclear reactor core"), 30, 1},
        -- technic (tools)
        {"chainsaw", "technic:chainsaw", "unilib_craft", S("Saw It Coming"), S("Craft a chainsaw"), 10, 1},
        {"cleaner", "technic:vacuum", "unilib_craft", S("The Suck Stops Here"), S("Craft a vacuum cleaner"), 10, 1},
        {"drill", drill_list, "unilib_craft", S("Bit by Bit"), S("Craft 3 mining drills"), 10, 3},
        {"laser", laser_list, "unilib_craft", S("Laser-Focused"), S("Craft 3 mining lasers"), 10, 3},
        {"prospector", "technic:prospector", "unilib_craft", S("Prospect and Ye Shall Find"), S("Craft a prospector"), 10, 1},
        {"tap_tree", "technic:treetap", "unilib_craft", S("Tap That Sap"), S("Craft a tree tap"), 10, 1},
        -- technic (components)
        {"battery_re", "technic:battery", "unilib_craft", S("Mini but Mighty"), S("Craft 4 RE batteries"), 10, 4},
        {"casing", "technic:machine_casing", "unilib_craft", S("Case Closed"), S("Craft 6 machine casings"), 10, 6},
        {"crystal_green", "technic:green_energy_crystal", "unilib_craft", S("Crystal-Clear Power"), S("Craft a green energy crystal"), 10, 1},
        {"transformer", transformer_list, "unilib_craft", S("Watt the Flux?"), S("Craft 6 transformers"), 10, 6},
        {"unit_logic", "technic:control_logic_unit", "unilib_craft", S("Think Before You Link"), S("Craft 4 control logic units"), 10, 4},
        -- technic (chests)
        {"chest_iron", chest_iron_list, "unilib_craft", S("Chest to Impress I"), S("Craft 8 iron chests"), 20, 8},
        {"chest_copper", chest_copper_list, "unilib_craft", S("Chest to Impress II"), S("Craft 8 copper chests"), 20, 8},
        {"chest_silver", chest_silver_list, "unilib_craft", S("Chest to Impress III"), S("Craft 8 silver chests"), 20, 8},
        {"chest_gold", chest_gold_list, "unilib_craft", S("Chest to Impress IV"), S("Craft 8 gold chests"), 20, 8},
        {"chest_mithril", chest_mithril_list, "unilib_craft", S("Chest to Impress V"), S("Craft 8 mithril chests"), 20, 8},
        -- technic (misc)
        {"chernobylite", "technic:chernobylite_block", "unilib_place", S("I Can't Believe It's Not Uranium"), S("Place 92 chernobylite blocks"), 20, 92},
        {"ingot_mixed", "technic:mixed_metal_ingot", "unilib_craft", S("Alloy's Well That Ends Well"), S("Craft 50 mixed metal ingots"), 10, 50},
        {"injector_contained", "technic:injector", "unilib_craft", S("One-Shot Wonder"), S("Craft a self-contained injector"), 10, 1},
        {"lamp_lv", "technic:lv_lamp", "unilib_craft", S("Soft Glow"), S("Craft 10 LV lamps"), 10, 10},
        {"led_lv", "technic:lv_led", "unilib_craft", S("Diode of Destiny"), S("Craft 2 LV LEDs"), 10, 2},
    }) do

        if unilib.awards.check_argument(mini_list[2]) then

            unilib.awards.register_achievement({
                name = "unilib_engineer_select_" .. mini_list[1],
                trigger_table = {
                    prototype = mini_list[3],
                    target = mini_list[7],
                    item_list = unilib.utils.convert_to_list(mini_list[2]),
                },

                title = mini_list[4],
                description = mini_list[5],
                score = mini_list[6],
                vocation_list = {unilib.pkg.award_engineer.vocation_name},
            })

        end

    end

end
