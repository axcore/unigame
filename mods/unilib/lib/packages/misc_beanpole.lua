---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_beanpole = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_beanpole.init()

    return {
        description = "Beanpole",
        depends = "item_stick_ordinary",
    }

end

function unilib.pkg.misc_beanpole.exec()

    unilib.register_node("unilib:misc_beanpole", "farming:beanpole", mode, {
        -- From farming:beanpole
        description = unilib.utils.hint(
            S("Beanpole"), S("place on soil before planting green beans")
        ),
        tiles = {"unilib_misc_beanpole.png"},
        groups = {attached_node = 1, flammable = 2, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        drop = "unilib:misc_beanpole",
        inventory_image = "unilib_misc_beanpole.png",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
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

            local under = core.get_node(pt.under)

            -- Return if any of the nodes are not registered
            if not core.registered_nodes[under.name] then
                return
            end

            -- Is the player right-clicking on something that has a custom on_place set?
            local def = core.registered_nodes[under.name]
            if def and def.on_rightclick then
                return def.on_rightclick(pt.under, under, placer, itemstack, pt)
            end

            if core.is_protected(pt.above, placer:get_player_name()) then
                return
            end

            local nodename = under.name

            if core.get_item_group(nodename, "soil") < 2 then
                return
            end

            local top = {
                x = pointed_thing.above.x,
                y = pointed_thing.above.y + 1,
                z = pointed_thing.above.z
            }

            nodename = core.get_node(top).name
            if nodename ~= "air" then
                return
            end

            core.set_node(pointed_thing.above, {name = "unilib:misc_beanpole"})

            if not unilib.utils.is_creative(placer:get_player_name()) then
                itemstack:take_item()
            end

            return itemstack

        end
    })
    unilib.register_craft({
        -- From farming:beanpole
        output = "unilib:misc_beanpole",
        recipe = {
            {"", "", ""},
            {"unilib:item_stick_ordinary", "", "unilib:item_stick_ordinary"},
            {"unilib:item_stick_ordinary", "", "unilib:item_stick_ordinary"},
        },
    })
    unilib.register_craft({
        -- From farming:beanpole
        type = "fuel",
        recipe = "unilib:misc_beanpole",
        burntime = 10,
    })
    unilib.tools.register_no_scythe("unilib:misc_beanpole")

end
