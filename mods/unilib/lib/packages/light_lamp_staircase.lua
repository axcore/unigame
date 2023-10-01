---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights_extras
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.light_lamp_staircase = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.morelights_extras.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_lamp_staircase.init()

    return {
        description = "Staircase light",
        notes = "Can be placed on stairs",
        depends = {"light_bulb_normal", "metal_steel"},
        optional = "shared_screwdriver",
    }

end

function unilib.pkg.light_lamp_staircase.exec()

    unilib.register_node("unilib:light_lamp_staircase", "morelights_extras:stairlight", mode, {
        -- From morelights_extras:stairlight
        description = unilib.hint(S("Staircase Light"), S("place on stairs")),
        tiles = {"unilib_pole_metal_dark.png"},
        groups = {attached_node = 1, cracky = 2, handy = 1, oddly_breakable_by_hand = 3},
        sounds = unilib.sound_table.glass,

        drawtype = "nodebox",
        inventory_image = "unilib_light_lamp_staircase_inv.png",
        light_source = 10,
        overlay_tiles = {
            "", "unilib_light_lamp_staircase.png", "", "", "unilib_light_lamp_staircase.png",
        },
        node_box = {
            type = "fixed",
            fixed = {-1/4, -13/16, -1/16, 1/4, -11/16, 0},
        },
        node_placement_prediction = "",
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-1/4, -13/16, -1/16, 1/4, -11/16, 0},
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_light_lamp_staircase_inv.png",

        on_place = function(itemstack, placer, pointed_thing)

            if pointed_thing.type ~= "node" then
                return itemstack
            end

            -- See builtin/game/item.lua
            local node = minetest.get_node(pointed_thing.under)

            if placer and not placer:get_player_control().sneak then

                local def = minetest.registered_nodes[node.name]
                if def and def.on_rightclick then

                    return def.on_rightclick(
                        pointed_thing.under, node, placer, itemstack, pointed_thing
                    ) or itemstack

                end

            end

            if node.param2 < 4 and string.find(node.name, "_stair_simple$") then

                -- Set "above" to the node actually above the stair, since that's where the node is
                --      placed
                pointed_thing.above = vector.add(pointed_thing.under, vector.new(0, 1, 0))
                return minetest.item_place_node(itemstack, placer, pointed_thing, node.param2)

            end

            return itemstack

        end,

    })
    unilib.register_craft({
        -- From morelights_extras:stairlight
        output = "unilib:light_lamp_staircase",
        recipe = {
            {"unilib:metal_steel_ingot", "unilib:light_bulb_normal", "unilib:metal_steel_ingot"},
        }
    })
    if unilib.pkg_executed_table["shared_screwdriver"] ~= nil then

        unilib.override_item("unilib:light_lamp_staircase", {
            on_rotate = unilib.pkg.shared_screwdriver.rotate_simple,
        })

    end

end
