---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.fruit_apple_golden = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

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
        sounds = unilib.sound_table.leaves,

        drawtype = "plantlike",
        drop = "unilib:fruit_apple_golden",
        inventory_image = "unilib_fruit_apple_golden.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.2, -0.37, -0.2, 0.2, 0.31, 0.2}
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_fruit_apple_golden.png",

        after_place_node = function(pos, placer, itemstack)

            if placer:is_player() then
                minetest.set_node(pos, {name = "unilib:fruit_apple_golden", param2 = 1})
            end

        end,

        -- N.B. To preserve the original code, let's assume that the player never gets sick of
        --      eating golden apples (i.e. never added to player's cuisine history)
        on_use = function(itemstack, user, pointed_thing)

            if user then

                user:set_hp(20)
                return minetest.do_item_eat(2, nil, itemstack, user, pointed_thing)

            end

        end,
    })
    if unilib.dye_from_fruit_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

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

    unilib.setup_regrowing_fruit({
        fruit_name = "unilib:fruit_apple_golden",

        replace_mode = mode,
        leaves_list = {"unilib:tree_healing_leaves"},
        pkg_list = {"tree_healing"},
    })

end
