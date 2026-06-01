---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.potion_antidote_poison = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.potion_antidote_poison.init()

    return {
        description = "Poison antidote",
        notes = "General antidote for the poisoning effect triggered when the hunger effect is" ..
                " enabled, and the player eats something with a negative satiation value. This" ..
                " antidote is designed to be suitable for a wide range of remix combinations",
        depends = "vessel_bottle_glass_empty",
        suggested = {
            "food_blueberries",                 -- group:fruit_blueberry_ordinary
            "fruit_apple",                      -- group:food_apple
        },
    }

end

function unilib.pkg.potion_antidote_poison.exec()

    local c_apple = "group:food_apple"
    local c_berry = "group:food_blueberries"

    unilib.register_craftitem("unilib:potion_antidote_poison", nil, mode, {
        -- Original to unilib
        description = S("Poison Antidote"),
        inventory_image = "unilib_potion_antidote_poison.png",
        groups = {antidote = 1},

        on_use = function(itemstack, user, pointed_thing)

            if user then

                if unilib.setting.hunger_enable_flag then
                    unilib.stamina.set_poisoned(user, false)
                end

                core.sound_play(
                    "unilib_drink_potion",
                    {pos = pos, gain = 1.0, max_hear_distance = 16},
                    true
                )

                -- Take potion and return empty bottle
                itemstack:take_item()

                local inv = user:get_inventory()
                if inv:room_for_item("main", {name = "unilib:vessel_bottle_glass_empty"}) then
                    user:get_inventory():add_item("main", "unilib:vessel_bottle_glass_empty")
                else
                    core.add_item(user:get_pos(), {name = "unilib:vessel_bottle_glass_empty"})
                end

                return itemstack

            end

        end,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:potion_antidote_poison",
        recipe = {
            {c_berry, c_apple, c_berry},
            {c_berry, c_apple, c_berry},
            {"", "unilib:vessel_bottle_glass_empty", ""},
        },
    })

end
