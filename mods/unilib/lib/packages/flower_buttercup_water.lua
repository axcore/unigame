---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_buttercup_water = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_buttercup_water.init()

    return {
        description = "Water buttercup",
    }

end

function unilib.pkg.flower_buttercup_water.exec()

    local full_name = "unilib:flower_buttercup_water"

    unilib.register_node(full_name, "elysflowers:water_buttercup", mode, {
        -- From elysflowers:water_buttercup
        description = unilib.utils.annotate(S("Water Buttercup"), "Ranunculus aquatilis"),
        tiles = {
            "unilib_flower_buttercup_water_top.png",
            "unilib_flower_buttercup_water_bottom.png",
        },
        groups = {flammable = 1, plant = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "nodebox",
        floodable = true,
        inventory_image = "unilib_flower_buttercup_water_top.png",
        liquids_pointable = true,
        node_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -15/32, 0.5},
        },
        node_placement_prediction = "",
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-7/16, -0.5, -7/16, 7/16, -15/32, 7/16},
        },
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        walkable = false,
        waving = 3,
        wield_image = "unilib_flower_buttercup_water_top.png",

        on_place = function(itemstack, placer, pointed_thing)

            local pos = pointed_thing.above
            local below_node = core.get_node(pointed_thing.under)
            local below_def_table = core.registered_nodes[below_node.name]

            if below_def_table and below_def_table.on_rightclick then

                return below_def_table.on_rightclick(
                    pointed_thing.under, below_node, placer, itemstack, pointed_thing
                )

            elseif below_def_table and
                    below_def_table.liquidtype == "source" and
                    core.get_item_group(below_node.name, "water") > 0 then

                local pname = placer and placer:get_player_name() or ""
                if not unilib.utils.is_creative(pname) then

                    core.set_node(pos, {name = full_name, param2 = math.random(0, 3)})
                    if not core.is_creative_enabled(pname) then
                        itemstack:take_item()
                    end

                else

                    core.chat_send_player(player_name, S("Node is protected"))
                    core.record_protection_violation(pos, pname)

                end

            end

            return itemstack

        end,
    })
    -- N.B. Not compatible with flowerpots, even in original code

    unilib.register_decoration_generic("elysflowers_flower_buttercup_water", {
        -- From elysflowers/init.lua
        deco_type = "simple",
        decoration = full_name,

        flags = "place_center_x, place_center_z, liquid_surface",
        noise_params = {
            lacunarity = 0.406,
            octaves = 3,
            offset = 0.0241291,
            persist = 0.29,
            scale = 0.000417701,
            seed = math.random(),
            spread = {x = 32, y = 12, z = 32},
        },
        param2 = 0,
        param2_max = 3,
        rotation = "random",
        sidelen = 16,
    })

end
