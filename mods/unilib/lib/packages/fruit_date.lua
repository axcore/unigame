---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.fruit_date = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moretrees.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fruit_date.init()

    return {
        description = "Dates",
        optional = "dye_basic",
    }

end

function unilib.pkg.fruit_date.exec()

    -- (The hanging variety grows on date palm trees, and drops the standard variety as a craftitem
    --      in random quantities)
    unilib.register_node("unilib:fruit_date_hanging", "moretrees:dates_f4", mode, {
        -- From moretrees:dates_f4
        description = S("Hanging Dates"),
        tiles = {"unilib_fruit_date_hanging.png"},
        groups = {dig_immediate = 3, flammable = 2, fleshy = 3},
        sounds = unilib.global.sound_table.node,

        drawtype = "plantlike",
        -- N.B. Replaced strange .drop in original code, with a simplified version
        --[[
        drop = {
            items = {
                {items = {"unilib:fruit_date"}},
                {items = {"unilib:fruit_date"}},
                {items = {"unilib:fruit_date"}},
                {items = {"unilib:fruit_date"}},
                {items = {"unilib:fruit_date"}, rarity = 2},
                {items = {"unilib:fruit_date"}, rarity = 2},
                {items = {"unilib:fruit_date"}, rarity = 2},
                {items = {"unilib:fruit_date"}, rarity = 2},
                {items = {"unilib:fruit_date"}, rarity = 5},
                {items = {"unilib:fruit_date"}, rarity = 5},
                {items = {"unilib:fruit_date"}, rarity = 5},
                {items = {"unilib:fruit_date"}, rarity = 5},
                {items = {"unilib:fruit_date"}, rarity = 20},
                {items = {"unilib:fruit_date"}, rarity = 20},
                {items = {"unilib:fruit_date"}, rarity = 20},
                {items = {"unilib:fruit_date"}, rarity = 20},
            },
        },
        ]]--
        drop = {
            items = {
                {items = {"unilib:fruit_date 4"}},
                {items = {"unilib:fruit_date 8"}, rarity = 2},
                {items = {"unilib:fruit_date 12"}, rarity = 5},
                {items = {"unilib:fruit_date 16"}, rarity = 20},
            },
        },
        inventory_image = "unilib_fruit_date_hanging.png^[transformR0",
        -- N.B. is_ground_content = false not in original code; added to match other fruit
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.3, -0.3, 0.3, 3.5, 0.3}
        },
        sunlight_propagates = true,
        visual_scale = 2,
        walkable = false,
        wield_image = "unilib_fruit_date_hanging.png^[transformR90",
    })

    unilib.register_craftitem("unilib:fruit_date", "moretrees:date", mode, {
        -- From moretrees:date
        description = S("Date"),
        inventory_image = "unilib_fruit_date.png",
        -- N.B. No groups in original code
        groups = {food_date = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:fruit_date", 1),
    })
    if unilib.setting.dye_from_fruit_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_red",
            recipe = {
                {"unilib:fruit_date"},
            },
        })

    end

    unilib.register_juice({
        ingredient = "unilib:fruit_date",
        juice_description = S("Date"),
        juice_type = "date",
        rgb = "#862619",

        orig_flag = false,
    })

    -- N.B. No call to unilib.register_regrowing_fruit(), due to non-standard tree code

end
