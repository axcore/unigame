---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.award_killer = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

unilib.pkg.award_killer.vocation_name = "unilib_killer"

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function on_die(player, hp_change_table)

    if not unilib.utils.is_player(player) or
            hp_change_table == nil or
            hp_change_table.type == nil then
        return
    end

    -- N.B. "hp_change_table" is a Minetest PlayerHPChangeReason
    local reason = hp_change_table.type
    local pos = player:get_pos()

    -- Killed by another player
    if reason == "punch" and unilib.utils.is_player(hp_change_table.object) then

--      local victim_name = player:get_player_name()
--      local killer_name = hp_change_table.object:get_player_name()

        unilib.awards.handle_simple_trigger(player, "killer_comb_assassin", 1)

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.award_killer.init()

    return {
        description = "Awards for killing other players (\"Serial Killer\")",
        notes = "These awards are in their own package, rather than being in the" ..
                " \"award_warrior\" package, so that this package can be omitted in single-" ..
                "player worlds",
    }

end

function unilib.pkg.award_killer.post()

    -- Sanity check -------------------------------------------------------------------------------

    if not unilib.setting.awards_enable_flag or core.is_singleplayer() then
        return
    end

    -- Trigger prototypes -------------------------------------------------------------------------

    unilib.awards.register_trigger_prototype({
        name = "killer_comb_assassin",
        trigger_type = "simple",
        hint_list = {"Kill one player", "Kill @1 players"},
        progress_list = {"Kill one player", "Kill @1/@2 players"},
    })

    -- Trigger event callbacks --------------------------------------------------------------------

    core.register_on_dieplayer(function(player, hp_change_table)
        on_die(player, hp_change_table)
    end)

    -- Vocations ----------------------------------------------------------------------------------

    unilib.awards.register_vocation({
        name = unilib.pkg.award_killer.vocation_name,

        title = S("Serial Killer"),
        description = S("Kill all the other players - before they kill you!"),
        icon = "unilib_award_vocation_killer.png",
        level_list = {
            {title = S("Oops - Was That You?"), score = 10},
            {title = S("Respawn Tour Guide"), score = 30},
            {title = S("Loot Redistributor"), score = 50},
            {title = S("The Human Creeper"), score = 80},
            {title = S("Pantomime Villain"), score = 120},
        },
    })

    -- Achievements -------------------------------------------------------------------------------

    -- Combination achievements
    for i, mini_list in ipairs({
        {S("Amateur Assassin"), S("Kill 2 players"), 10, 2},
        {S("Aspiring Assassin"), S("Kill 5 players"), 10, 5},
        {S("Junior Assassin"), S("Kill 10 players"), 10, 10},
        {S("Novice Assassin"), S("Kill 15 players"), 10, 15},
        {S("Competent Assassin"), S("Kill 20 players"), 10, 20},
        {S("Skilled Assassin"), S("Kill 30 players"), 10, 30},
        {S("Seasoned Assassin"), S("Kill 50 players"), 10, 50},
        {S("Advanced Assassin"), S("Kill 100 players"), 10, 100},
        {S("Veteran Assassin"), S("Kill 200 players"), 10, 200},
        {S("Master Assassin"), S("Kill 300 players"), 10, 300},
        {S("Grandmaster Assassin"), S("Kill 500 players"), 10, 500},
        {S("Elite Assassin"), S("Kill 999 players"), 10, 999},
    }) do

        unilib.awards.register_achievement({
            name = "unilib_killer_comb_" .. i,
            trigger_table = {
                prototype = "killer_comb_assassin",
                target = mini_list[4],
            },

            title = mini_list[1],
            description = mini_list[2],
            score = mini_list[3],
            vocation_list = {unilib.pkg.award_killer.vocation_name},
        })

    end

end
