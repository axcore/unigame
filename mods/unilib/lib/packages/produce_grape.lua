---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.produce_grape = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.produce_grape.init()

    return {
        description = "Grapes",
        notes = "In order to grow grapes, place them on a trellis",
        depends = "misc_trellis",
        optional = "dye_basic",
    }

end

function unilib.pkg.produce_grape.exec()

    local orig_name_list = {}
    for i = 1, 8 do
        table.insert(orig_name_list, "farming:grapes_" .. i)
    end

    unilib.register_produce_fredo({
        -- From farming:grapes (creates unilib:produce_grape_harvest), farming:grapes_1 etc (creates
        --      unilib:produce_grape_grow_1 etc)
        part_name = "grape",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "farming:grapes",
        description = S("Grapes"),

        replace_mode = mode,
        eat = 2,
        grow_group_table = {
            attached_node = 1, flammable = 3, growing = 1, not_in_creative_inventory = 1, plant = 1,
            snappy = 3,
        },
        grow_list = {
            {
                drop = {
                    items = {
                        {items = {"unilib:misc_trellis"}, rarity = 1}
                    },
                },
                visual_scale = 1.90,
            },
            {
                drop = {
                    items = {
                        {items = {"unilib:misc_trellis"}, rarity = 1}
                    },
                },
                visual_scale = 1.90,
            },
            {
                drop = {
                    items = {
                        {items = {"unilib:misc_trellis"}, rarity = 1}
                    },
                },
                visual_scale = 1.90,
            },
            {
                drop = {
                    items = {
                        {items = {"unilib:misc_trellis"}, rarity = 1}
                    },
                },
                visual_scale = 1.90,
            },
            {
                drop = {
                    items = {
                        {items = {"unilib:misc_trellis"}, rarity = 1}
                    },
                },
                visual_scale = 1.90,
            },
            {
                drop = {
                    items = {
                        {items = {"unilib:misc_trellis"}, rarity = 1}
                    },
                },
                visual_scale = 1.90,
            },
            {
                drop = {
                    items = {
                        {items = {"unilib:misc_trellis"}, rarity = 1}
                    },
                },
                visual_scale = 1.90,
            },
            {
                drop = {
                    items = {
                        {items = {"unilib:misc_trellis"}, rarity = 1},
                        {items = {"unilib:produce_grape_harvest 3"}, rarity = 1},
                        {items = {"unilib:produce_grape_harvest 1"}, rarity = 2},
                        {items = {"unilib:produce_grape_harvest 1"}, rarity = 3},
                    },
                },
                visual_scale = 1.90,
            },
        },
        harvest_group_table = {flammable = 3, food_grapes = 1, seed = 2},
    })

    unilib.override_item("unilib:produce_grape_harvest", {
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
            if placer and itemstack and def and def.on_rightclick then
                return def.on_rightclick(pt.under, under, placer, itemstack, pt)
            end

            -- Is the player planting crop?
            local name = placer and placer:get_player_name() or ""

            -- Check for protection
            if core.is_protected(pt.under, name) then
                return
            end

            -- Check if pointing at a trellis
            if under.name ~= "unilib:misc_trellis" then
                return
            end

            -- Add the node and remove 1 item from the itemstack
            core.set_node(pt.under, {name = "unilib:produce_grape_grow_1"})

            core.sound_play("unilib_place_node", {pos = pt.under, gain = 1.0})

            if placer or not unilib.utils.is_creative(placer:get_player_name()) then

                itemstack:take_item()

                -- Check for refill
                if itemstack:get_count() == 0 then

                    core.after(
                        0.20,
                        unilib.refill_plant,
                        placer,
                        "unilib:produce_grape_harvest",
                        placer:get_wield_index()
                    )

                end

            end

            return itemstack

        end,
    })
    if unilib.setting.dye_from_produce_flag and
            unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- From farming:beans
            output = "unilib:dye_violet",
            recipe = {
                {"unilib:produce_grape_harvest"},
            },
        })

    end

    -- Wild grape bush (placed as a decoration, and the only natural source of grapes)
    unilib.register_node("unilib:produce_grape_wild", "farming:grapebush", mode, {
        -- From farming:grapebush
        -- (no description)
        tiles = {"unilib_produce_grape_wild.png"},
        groups = {
            attached_node = 1, flammable = 2, not_in_creative_inventory = 1, plant = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        drop = {
            items = {
                {items = {"unilib:produce_grape_harvest"}, rarity = 1},
                {items = {"unilib:produce_grape_harvest"}, rarity = 2},
                {items = {"unilib:produce_grape_harvest"}, rarity = 3},
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

    unilib.register_juice({
        ingredient = "unilib:produce_grape_harvest",
        juice_description = S("Grape"),
        -- N.B. Original "drinks" mod used the juice type "grapes"
        juice_type = "grape",
        rgb = "#b20056",

        orig_flag = false,
    })

    unilib.register_decoration_generic("farming_redo_produce_grape", {
        -- From farming_redo/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:produce_grape_wild",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.002,
            seed = 578,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

end
