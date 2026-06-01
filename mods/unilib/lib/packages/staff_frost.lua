---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    froststaff
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.staff_frost = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.froststaff.add_mode

local compat_list = {
    {"unilib:liquid_water_ordinary_source", "unilib:ice_ordinary"},
    {"unilib:liquid_water_ordinary_flowing", "unilib:ice_ordinary"},
        {"default:water_source", "unilib:ice_ordinary"},
        {"default:water_flowing", "unilib:ice_ordinary"},
    {"unilib:liquid_water_river_source", "unilib:ice_ordinary"},
    {"unilib:liquid_water_river_flowing", "unilib:ice_ordinary"},
        {"default:river_water_source", "unilib:ice_ordinary"},
        {"default:river_water_flowing", "unilib:ice_ordinary"},
    {"unilib:liquid_lava_ordinary_source", "unilib:stone_obsidian"},
    {"unilib:liquid_lava_ordinary_flowing", "unilib:stone_basalt_blue"},
        {"default:lava_source", "unilib:stone_obsidian"},
        {"default:lava_flowing", "unilib:stone_basalt_blue"},
    {"unilib:liquid_slime_black_source", "unilib:ice_ordinary"},
    {"unilib:liquid_slime_black_flowing", "unilib:ice_ordinary"},
    {"unilib:liquid_slime_green_source", "unilib:ice_ordinary"},
    {"unilib:liquid_slime_green_flowing", "unilib:ice_ordinary"},
    {"unilib:liquid_slime_red_source", "unilib:ice_ordinary"},
    {"unilib:liquid_slime_red_flowing", "unilib:ice_ordinary"},
    {"unilib:liquid_slime_purple_source", "unilib:ice_ordinary"},
    {"unilib:liquid_slime_purple_flowing", "unilib:ice_ordinary"},
}

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.staff_frost.do_register(liquid_name, solid_name)

    -- Original to unilib
    -- Can be used to extend the range of liquids with which the staff can be used; replacing the
    --      global variable in the original code, froststaff.nodes

    table.insert(compat_list, {liquid_name, solid_name})

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.staff_frost.init()

    return {
        description = "Staff of frost",
        depends = "ice_ordinary",
        optional = {
            "liquid_lava_ordinary",
            "liquid_water_ordinary",
            "liquid_water_river",
            "stone_basalt_blue",
            "stone_obsidian",
            "stone_slimestone_black_extra",
            "stone_slimestone_green_extra",
            "stone_slimestone_red_extra",
            "stone_slimestone_purple_extra",
        },
    }

end

function unilib.pkg.staff_frost.exec()

    unilib.register_tool("unilib:staff_frost", "froststaff:staff", mode, {
        -- From froststaff:staff
        description = S("Staff of Frost"),
        inventory_image = "unilib_staff_frost.png",
        sound = {breaks = "unilib_tool_breaks"},

        liquids_pointable = true,
        stack_max = 1,
        wield_image = "unilib_staff_frost.png",

        on_use = function(itemstack, user, pointed_thing)

            if pointed_thing.type ~= "node" then
                return
            end

            local pos = pointed_thing.under
            local pname = user:get_player_name()

            if core.is_protected(pos, pname) then

                core.record_protection_violation(pos, pname)
                return

            end

            local full_name = core.get_node(pos).name
            for _, mini_list in ipairs(compat_list) do

                if full_name == mini_list[1] then

                    core.swap_node(pos, {name = mini_list[2]})

                    if not unilib.utils.is_creative(pname) then
                        itemstack:add_wear(65535 / 149) -- 150 uses
                    end

                    return itemstack

                end

            end

        end,
    })

end

function unilib.pkg.staff_frost.post()

    for bucket_type, _ in pairs(unilib.global.generic_bucket_table) do

        local c_black_bucket = "unilib:" .. bucket_type .. "_with_slime_black"
        local c_green_bucket = "unilib:" .. bucket_type .. "_with_slime_green"
        local c_purple_bucket = "unilib:" .. bucket_type .. "_with_slime_purple"
        local c_red_bucket = "unilib:" .. bucket_type .. "_with_slime_red"
        local c_empty_bucket = "unilib:" .. bucket_type .. "_empty"

        unilib.register_craft({
            -- From froststaff:staff
            output = "unilib:staff_frost",
            recipe = {
                {c_black_bucket, "unilib:ice_ordinary", c_red_bucket},
                {c_green_bucket, "unilib:ice_ordinary", c_purple_bucket},
                {"", "unilib:ice_ordinary", ""},
            },
        })

    end

end
