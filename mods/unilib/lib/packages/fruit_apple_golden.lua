---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.fruit_apple_golden = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fruit_apple_golden.init()

    return {
        description = "Golden apple",
        notes = "Heals all ten hearts",
        optional = "dye_basic",
    }

end

function unilib.pkg.fruit_apple_golden.exec()

    unilib.register_node("unilib:fruit_apple_golden", "ethereal:golden_apple", mode, {
        -- From ethereal:golden_apple
        description = S("Golden Apple"),
        tiles = {"unilib_fruit_apple_golden.png"},
        groups = {dig_immediate = 3, fleshy = 3, leafdecay = 3, leafdecay_drop = 1},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_fruit_apple_golden.png",
        -- N.B. is_ground_content = false not in original code; added to match other fruit
        is_ground_content = false,
        paramtype = "light",
        place_param2 = 1,
        selection_box = {
            type = "fixed",
            fixed = {-0.2, -0.37, -0.2, 0.2, 0.31, 0.2}
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_fruit_apple_golden.png",

        -- N.B. No .after_place_node in original code
        after_place_node = function(pos, placer)

            if placer:is_player() then
                core.set_node(pos, {name = "unilib:fruit_apple_golden", param2 = 1})
            end

        end,

        -- N.B. To preserve the original code, let's assume that the player never gets sick of
        --      eating golden apples (i.e. never added to player's cuisine history)
        on_use = function(itemstack, user, pointed_thing)

            if user and pointed_thing and pointed_thing.type ~= "object" then

                user:set_hp(20)
                return core.do_item_eat(2, nil, itemstack, user, pointed_thing)

            end

        end,
    })
    if unilib.setting.dye_from_fruit_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:dye_yellow",
            recipe = {
                {"unilib:fruit_apple_golden"},
            },
        })

    end

end

function unilib.pkg.fruit_apple_golden.post()

    unilib.register_regrowing_fruit({
        fruit_name = "unilib:fruit_apple_golden",

        replace_mode = mode,
        leaves_list = {"unilib:tree_healing_leaves"},
        pkg_list = {"tree_healing"},
    })

end
