---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_torch
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_match_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_torch.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_match_ordinary.init()

    return {
        description = "Ordinary match",
        notes = "Use matches to ignite unlit torches. Replaces the original mod's coal powder" ..
                " which clashes with unilib:mineral_coal_powder, which may or may not be" ..
                " available, depending on whether the technic mod is loaded",
        depends = {"item_stick_ordinary", "mineral_coal", "torch_ordinary"},
    }

end

function unilib.pkg.item_match_ordinary.exec()

    unilib.register_craftitem("unilib:item_match_ordinary", "real_torch:coal_powder", mode, {
        -- Code from real_torch:coal_powder. Original texture
        description = S("Ordinary Match"),
        inventory_image = "unilib_item_match_ordinary.png",

        on_use = function(itemstack, user, pointed_thing)

            -- Punch unlit torches with matches to reignite them
            if not pointed_thing or pointed_thing.type ~= "node" then
                return
            end

            local pos = pointed_thing.under
            local node = minetest.get_node(pos)
            local adj_flag = false

            if node.name == "unilib:torch_unlit" then

                node.name = "unilib:torch_ordinary"
                adj_flag = true

            elseif node.name == "unilib:torch_unlit_wall" then

                node.name = "unilib:torch_ordinary_wall"
                adj_flag = true

            elseif node.name == "unilib:torch_unlit_ceiling" then

                node.name = "unilib:torch_ordinary_ceiling"
                adj_flag = true

            end

            if adj_flag then

                minetest.set_node(pos, {name = node.name, param2 = node.param2})

                if not unilib.is_creative(user:get_player_name()) then
                    itemstack:take_item()
                end
            end

            -- N.B. Sound file exists in original mod, but not code to use it
            minetest.sound_play(
                "unilib_ignite_torch",
                {pos = pos, gain = 0.1, max_hear_distance = 10},
                true
            )

            return itemstack

        end,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:item_match_ordinary 6",
        recipe = {
            {"unilib:mineral_coal_lump", "unilib:item_stick_ordinary"},
        },
    })
    unilib.register_craft({
        -- From real_torch:coal_powder
        output = "unilib:torch_ordinary",
        recipe = {
            {"unilib:torch_unlit", "unilib:item_match_ordinary"},
        },
    })

end
