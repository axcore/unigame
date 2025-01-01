---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_bbq = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bbq.add_mode

local cold_grill_table = {
    ["unilib:machine_grill_kettle"] = true,
    ["unilib:machine_grill_propane"] = true,
    ["unilib:machine_grill_propane_pro"] = true,
    ["unilib:machine_grill_smoker"] = true,
}

local hot_grill_table = {
    ["unilib:machine_grill_kettle_active"] = true,
    ["unilib:machine_grill_propane_active"] = true,
    ["unilib:machine_grill_propane_pro_active"] = true,
    ["unilib:machine_grill_smoker_active"] = true,
}

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_bbq.on_use_play_sound(sound, use_on_cold_flag)

    -- Utensils from the BBQ mod make a sound, when used on a suitable grill

    return function(itemstack, placer, pointed_thing)

        if not pointed_thing or pointed_thing.type ~= "node" then
            return
        end

        local under_pos = pointed_thing.under
        local under_node_name = core.get_node(under_pos).name

        if hot_grill_table[under_node_name] ~= nil or (
            use_on_cold_flag and cold_grill_table[under_node_name] ~= nil
        ) then

            core.sound_play(sound, {pos = under_pos, max_hear_distance = 10})
            return

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_bbq.init()

    return {
        description = "Shared functions for BBQ tools (from bbq)",
    }

end
