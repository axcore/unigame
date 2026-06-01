---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.award_addict = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

unilib.pkg.award_addict.vocation_name = "unilib_addict"

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.award_addict.init()

    return {
        description = "Awards for unlocking the top level of many different vocations (\"Addict\")",
    }

end

function unilib.pkg.award_addict.post()

    -- Sanity check -------------------------------------------------------------------------------

    if not unilib.setting.awards_enable_flag then
        return
    end

    -- Sanity check -------------------------------------------------------------------------------

    if not unilib.setting.awards_enable_flag then
        return
    end

    -- Trigger prototypes -------------------------------------------------------------------------

    unilib.awards.register_trigger_prototype({
        name = "grinder_comb_vocation",
        trigger_type = "simple",
        hint_list = {"Unlock the top level in 1 vocation", "Unlock the top level in @1 vocations"},
        progress_list = {"Unlock the top level in 1 vocation", "Unlock the top level in @1/@2 vocations"},
    })

    -- Vocations ----------------------------------------------------------------------------------

    unilib.awards.register_vocation({
        name = unilib.pkg.award_addict.vocation_name,

        title = S("Addict"),
        description = S("Reach the top level in as many vocations as you can"),
        icon = "unilib_award_vocation_addict.png",
        level_list = {
            {title = S("A Name Spoken in Hushed Voices"), score = 70},
        },
    })

    -- Achievements -------------------------------------------------------------------------------

    -- Combination achievements
    -- N.B. unilib provides about 30 vocations; assume that at least 25 are available
    for i, mini_list in ipairs({
        {S("Amateur Grinder"), S("Unlock the top level in 1 vocation"), 10, 1},
        {S("Novice Grinder"), S("Unlock the top level in 2 vocations"), 10, 2},
        {S("Skilled Grinder"), S("Unlock the top level in 5 vocations"), 10, 5},
        {S("Veteran Grinder"), S("Unlock the top level in 10 vocations"), 10, 10},
        {S("Master Grinder"), S("Unlock the top level in 15 vocations"), 10, 15},
        {S("Grandmaster Grinder"), S("Unlock the top level in 20 vocations"), 10, 20},
        {S("Elite Grinder"), S("Unlock the top level in 25 vocations"), 10, 25},
    }) do

        unilib.awards.register_achievement({
            name = "unilib_grinder_comb_" .. i,
            trigger_table = {
                prototype = "grinder_comb_vocation",
                target = mini_list[4],
            },

            title = mini_list[1],
            description = mini_list[2],
            score = mini_list[3],
            vocation_list = {unilib.pkg.award_addict.vocation_name},
        })

    end

end
