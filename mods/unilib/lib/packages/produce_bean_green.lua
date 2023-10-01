---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.produce_bean_green = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.produce_bean_green.init()

    return {
        description = "Green beans",
        notes = "In order to grow green beans, place them on a beanpole",
        depends = "misc_beanpole",
        optional = "dye_basic",
    }

end

function unilib.pkg.produce_bean_green.exec()

    local orig_name_list = {}
    for i = 1, 5 do
        table.insert(orig_name_list, "farming:beans_" .. i)
    end

    unilib.register_produce_fredo({
        -- From farming:beans (creates unilib:produce_bean_green_harvest), farming:beans_1 etc
        --      (creates unilib:produce_bean_green_grow_1 etc)
        part_name = "bean_green",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "farming:beans",
        description = S("Green Beans"),

        replace_mode = mode,
        eat = 1,
        grow_group_table = {
            attached_node = 1, flammable = 3, growing = 1, not_in_creative_inventory = 1, plant = 1,
            snappy = 3,
        },
        grow_list = {
            {
                drop = {
                    items = {
                        {items = {"unilib:misc_beanpole"}, rarity = 1}
                    },
                },
                visual_scale = 1.90,
            },
            {
                drop = {
                    items = {
                        {items = {"unilib:misc_beanpole"}, rarity = 1}
                    },
                },
                visual_scale = 1.90,
            },
            {
                drop = {
                    items = {
                        {items = {"unilib:misc_beanpole"}, rarity = 1}
                    },
                },
                visual_scale = 1.90,
            },
            {
                drop = {
                    items = {
                        {items = {"unilib:misc_beanpole"}, rarity = 1}
                    },
                },
                visual_scale = 1.90,
            },
            {
                drop = {
                    items = {
                        {items = {"unilib:misc_beanpole"}, rarity = 1},
                        {items = {"unilib:produce_bean_green_harvest 3"}, rarity = 1},
                        {items = {"unilib:produce_bean_green_harvest 2"}, rarity = 2},
                        {items = {"unilib:produce_bean_green_harvest 2"}, rarity = 3},
                    },
                },
                visual_scale = 1.90,
            },
        },
        harvest_group_table = {flammable = 2, food_beans = 1, seed = 2},
    })

    unilib.override_item("unilib:produce_bean_green_harvest", {
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
            if placer and itemstack and def and def.on_rightclick then
                return def.on_rightclick(pt.under, under, placer, itemstack, pt)
            end

            -- Is the player planting crop?
            local name = placer and placer:get_player_name() or ""

            -- Check for protection
            if minetest.is_protected(pt.under, name) then
                return
            end

            -- Check if pointing at a beanpole
            if under.name ~= "unilib:misc_beanpole" then
                return
            end

            -- Add the node and remove 1 item from the itemstack
            minetest.set_node(pt.under, {name = "unilib:produce_bean_green_grow_1"})

            minetest.sound_play("unilib_place_node", {pos = pt.under, gain = 1.0})

            if placer or not unilib.is_creative(placer:get_player_name()) then

                itemstack:take_item()

                -- Check for refill
                if itemstack:get_count() == 0 then

                    minetest.after(
                        0.20,
                        unilib.refill_plant,
                        placer,
                        "unilib:produce_bean_green_harvest",
                        placer:get_wield_index()
                    )

                end

            end

            return itemstack

        end,
    })
    if unilib.dye_from_produce_flag and unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- From farming:beans
            output = "unilib:dye_green",
            recipe = {
                {"unilib:produce_bean_green_harvest"},
            },
        })

    end

    -- Wild bean bush (placed as a decoration, and the only natural source of green beans)
    unilib.register_node("unilib:produce_bean_green_wild", "farming:beanbush", mode, {
        -- From farming:beanbush
        -- (no description)
        tiles = {"unilib_produce_bean_green_wild.png"},
        groups = {
            attached_node = 1, flammable = 2, not_in_creative_inventory = 1, plant = 1, snappy = 3,
        },
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        drop = {
            items = {
                {items = {"unilib:produce_bean_green_harvest"}, rarity = 1},
                {items = {"unilib:produce_bean_green_harvest"}, rarity = 2},
                {items = {"unilib:produce_bean_green_harvest"}, rarity = 3},
            },
        },
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
    })

    unilib.register_decoration("farming_redo_produce_bean_green", {
        -- From farming_redo/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:produce_bean_green_wild",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.001,
            seed = 329,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

end
