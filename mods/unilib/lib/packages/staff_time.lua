---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    castle/orbs_of_time
-- Code:    MIT
-- Media:   CC-BY 3.0/CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.staff_time = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.orbs_of_time.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.staff_time.init()

    return {
        description = "Staffs of time",
        notes = "Changes the time of day when wielded. Each staff can be used up to eight times" ..
                " (unless in creative mode). For users with the correct privileges, the /day," ..
                " /night, /dawn and /dusk commands can also be used",
        depends = {"mineral_diamond", "mineral_mese", "stone_obsidian"},
    }

end

function unilib.pkg.staff_time.exec()

    local c_diamond = "unilib:mineral_diamond_gem"

    unilib.register_tool("unilib:staff_time_day", "orbs_of_time:orb_day", mode, {
        -- From orbs_of_time:orb_day
        description = S("Staff of Day"),
        tiles = {"unilib_staff_time_day.png"},
        -- (no groups)
        -- (no sounds)

        inventory_image = "unilib_staff_time_day.png",
        stack_max = 1,
        wield_image = "unilib_staff_time_day_inv.png",

        on_use = function(itemstack, user)

            minetest.sound_play("unilib_staff_time_ding", {pos = user:get_pos(), loop = false})
            minetest.set_timeofday(0.5)
            minetest.sound_play("unilib_staff_time_birds", {pos = user:get_pos(), loop = false})

            if not minetest.setting_getbool("creative_mode") then
                itemstack:add_wear(65535/8)
            end

            return itemstack

        end,
    })
    unilib.register_craft({
        -- From orbs_of_time:orb_day
        output = "unilib:staff_time_day",
        recipe = {
            {c_diamond, c_diamond, c_diamond},
            {c_diamond, "unilib:mineral_mese_crystal", c_diamond},
            {c_diamond, c_diamond, c_diamond},
        },
    })
    unilib.register_tool_no_repair(
        "unilib:staff_time_day", S("This staff is too exotic to be repaired")
    )

    unilib.register_tool("unilib:staff_time_night", "orbs_of_time:orb_night", mode, {
        -- From orbs_of_time:orb_night
        description = S("Staff of Night"),
        tiles = {"unilib_staff_time_night.png"},
        -- (no groups)
        -- (no sounds)

        inventory_image = "unilib_staff_time_night.png",
        stack_max = 1,
        wield_image = "unilib_staff_time_night_inv.png",

        on_use = function(itemstack, user)

            minetest.sound_play("unilib_staff_time_ding", {pos = user:get_pos(), loop = false})
            minetest.set_timeofday(0)
            minetest.sound_play("unilib_staff_time_owl", {pos = user:get_pos(), loop = false})

            if not minetest.setting_getbool("creative_mode") then
                itemstack:add_wear(65535/8)
            end

            return itemstack

        end,
    })
    unilib.register_craft({
        -- From orbs_of_time:orb_night
        output = "unilib:staff_time_night",
        recipe = {
            {c_diamond, c_diamond, c_diamond},
            {c_diamond, "unilib:stone_obsidian_shard", c_diamond},
            {c_diamond, c_diamond, c_diamond},
        },
    })
    unilib.register_tool_no_repair(
        "unilib:staff_time_night", S("This staff is too exotic to be repaired")
    )

    unilib.register_tool("unilib:staff_time_dawn", "orbs_of_time:orb_dawn", mode, {
        -- From orbs_of_time:orb_dawn
        description = S("Staff of Dawn"),
        tiles = {"unilib_staff_time_day.png"},
        -- (no groups)
        -- (no sounds)

        inventory_image = "unilib_staff_time_day.png^[lowpart:50:unilib_staff_time_night.png",
        stack_max = 1,
        wield_image = "unilib_staff_time_day_inv.png" ..
                "^[lowpart:75:unilib_staff_time_night_inv.png",

        on_use = function(itemstack, user)

            minetest.sound_play("unilib_staff_time_ding", {pos = user:get_pos(), loop = false})
            minetest.set_timeofday(0.2)
            minetest.sound_play("unilib_staff_time_birds", {pos = user:get_pos(), loop = false})

            if not minetest.setting_getbool("creative_mode") then
                itemstack:add_wear(65535/8)
            end

            return itemstack

        end,
    })
    unilib.register_craft({
        -- From orbs_of_time:orb_dawn
        output = "unilib:staff_time_dawn 2",
        recipe = {
            {"unilib:staff_time_day"},
            {"unilib:staff_time_night"},
        },
    })
    unilib.register_tool_no_repair(
        "unilib:staff_time_dawn", S("This staff is too exotic to be repaired")
    )

    unilib.register_tool("unilib:staff_time_dusk", "orbs_of_time:orb_dusk", mode, {
        -- From orbs_of_time:orb_dusk
        description = S("Staff of Dusk"),
        tiles = {"unilib_staff_time_night.png"},
        -- (no groups)
        -- (no sounds)

        inventory_image = "unilib_staff_time_night.png^[lowpart:50:unilib_staff_time_day.png",
        stack_max = 1,
        wield_image = "unilib_staff_time_night_inv.png" ..
                "^[lowpart:75:unilib_staff_time_day_inv.png",

        on_use = function(itemstack, user)

            minetest.sound_play("unilib_staff_time_ding", {pos = user:get_pos(), loop = false})
            minetest.set_timeofday(0.8)
            minetest.sound_play("unilib_staff_time_owl", {pos = user:get_pos(), loop = false})

            if not minetest.setting_getbool("creative_mode") then
                itemstack:add_wear(65535/8)
            end

            return itemstack

        end,
    })
    unilib.register_craft({
        -- From orbs_of_time:orb_dusk
        output = "unilib:staff_time_dusk 2",
        recipe = {
            {"unilib:staff_time_night"},
            {"unilib:staff_time_day"},
        },
    })
    unilib.register_tool_no_repair(
        "unilib:staff_time_dusk", S("This staff is too exotic to be repaired")
    )

end
