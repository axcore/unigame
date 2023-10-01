---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_trellis = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_trellis.init()

    return {
        description = "Trellis",
        depends = "item_stick_ordinary",
    }

end

function unilib.pkg.misc_trellis.exec()

    local c_stick = "unilib:item_stick_ordinary"

    unilib.register_node("unilib:misc_trellis", "farming:trellis", mode, {
        -- From farming:trellis
        description = unilib.hint(S("Trellis"), S("place on soil before planting grapes")),
        tiles = {"unilib_misc_trellis.png"},
        groups = {attached_node = 1, flammable = 2, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        drop = "unilib:misc_trellis",
        inventory_image = "unilib_misc_trellis.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
        },
        sunlight_propagates = true,
        visual_scale = 1.90,
        walkable = false,

        on_place = function(itemstack, placer, pointed_thing)

            local pt = pointed_thing

            -- Check if pointing at a node
            if not pt or pt.type ~= "node" then
                return
            end

            local under = minetest.get_node(pt.under)

            -- Return if any of the nodes are not registered
            if not minetest.registered_nodes[under.name] then
                return
            end

            -- Is the player right-clicking on something that has a custom on_place set?
            local def = minetest.registered_nodes[under.name]
            if def and def.on_rightclick then
                return def.on_rightclick(pt.under, under, placer, itemstack, pt)
            end

            if minetest.is_protected(pt.above, placer:get_player_name()) then
                return
            end

            local nodename = under.name

            if minetest.get_item_group(nodename, "soil") < 2 then
                return
            end

            local top = {
                x = pointed_thing.above.x,
                y = pointed_thing.above.y + 1,
                z = pointed_thing.above.z
            }

            nodename = minetest.get_node(top).name

            if nodename ~= "air" then
                return
            end

            minetest.set_node(pointed_thing.above, {name = "unilib:misc_trellis"})

            if not unilib.is_creative(placer:get_player_name()) then
                itemstack:take_item()
            end

            return itemstack

        end
    })
    unilib.register_craft({
        -- From farming:trellis
        output = "unilib:misc_trellis",
        recipe = {
            {c_stick, c_stick, c_stick},
            {c_stick, c_stick, c_stick},
            {c_stick, c_stick, c_stick},
        }
    })
    unilib.register_craft({
        -- From farming:trellis
        type = "fuel",
        recipe = "unilib:misc_trellis",
        burntime = 15,
    })
    unilib.register_tool_no_scythe("unilib:misc_trellis")

end
