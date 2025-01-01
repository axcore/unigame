---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.produce_cocoa_jungle = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.produce_cocoa_jungle.init()

    return {
        description = "Jungle cocoa beans",
        notes = "In order to grow jungle cocoa beans, place them on a jungle tree trunk",
        depends = "tree_jungle",
        optional = "dye_basic",
    }

end

function unilib.pkg.produce_cocoa_jungle.exec()

    -- (Cannot use generic functions in ../lib/shared/farming/ for these items)

    unilib.register_craftitem("unilib:produce_cocoa_jungle_harvest", "farming:cocoa_beans", mode, {
        -- From farming:cocoa_beans
        description = S("Jungle Cocoa Beans"),
        inventory_image = "unilib_produce_cocoa_jungle_harvest.png",
        groups = {flammable = 2, food_cocoa = 1, seed = 2},

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
            if core.is_protected(pt.above, name) then
                return
            end

            -- Check if pointing at jungletree
            if under.name ~= "unilib:tree_jungle_trunk" or
                    core.get_node(pt.above).name ~= "air" then
                return
            end

            -- Add the node and remove 1 item from the itemstack
            core.set_node(pt.above, {name = "unilib:produce_cocoa_jungle_grow_1"})
            core.sound_play("unilib_place_node", {pos = pt.above, gain = 1.0})

            if placer or not unilib.utils.is_creative(placer:get_player_name()) then

                itemstack:take_item()

                -- Check for refill
                if itemstack:get_count() == 0 then

                    core.after(
                        0.20,
                        unilib.refill_plant,
                        placer,
                        "unilib:produce_cocoa_jungle_harvest",
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
            -- From farming:cocoa_beans
            -- N.B. Output 2 in original code
            output = "unilib:dye_brown",
            recipe = {
                {"unilib:produce_cocoa_jungle_harvest"},
            },
        })

    end

    local def_table = {
        -- N.B. no description in original code
        decription = S("Jungle Cocoa Pod (Growing)"),
        tiles = {"unilib_produce_cocoa_jungle_grow_1.png"},
        groups = {
            flammable = 2, growing = 1, leafdecay = 1, leafdecay_drop = 1,
            not_in_creative_inventory = 1, plant = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        drop = {},
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
        },
        walkable = false,

        growth_check = function(pos, node_name)

            if core.find_node_near(pos, 1, {"unilib:tree_jungle_trunk"}) then

                -- Can grow
                return false

            else

                -- Cannot grow
                return true

            end

        end,
    }

    -- Stage 1
    unilib.register_node(
        "unilib:produce_cocoa_jungle_grow_1", "farming:cocoa_1", mode, table.copy(def_table)
    )

    -- Stage 2
    def_table.tiles = {"unilib_produce_cocoa_jungle_grow_2.png"}
    unilib.register_node(
        "unilib:produce_cocoa_jungle_grow_2", "farming:cocoa_2", mode, table.copy(def_table)
    )

    -- Stage 3
    def_table.tiles = {"unilib_produce_cocoa_jungle_grow_3.png"}
    def_table.drop = {
        items = {
            {items = {"unilib:produce_cocoa_jungle_harvest 1"}, rarity = 1},
        },
    }
    unilib.register_node(
        "unilib:produce_cocoa_jungle_grow_3", "farming:cocoa_3", mode, table.copy(def_table)
    )

    -- Stage 4 (final)
    def_table.tiles = {"unilib_produce_cocoa_jungle_grow_4.png"}
    def_table.groups.growing = nil
    def_table.growth_check = nil
    def_table.drop = {
        items = {
            {items = {"unilib:produce_cocoa_jungle_harvest 2"}, rarity = 1},
            {items = {"unilib:produce_cocoa_jungle_harvest 1"}, rarity = 2},
            {items = {"unilib:produce_cocoa_jungle_harvest 1"}, rarity = 4},
        },
    }
    unilib.register_node(
        "unilib:produce_cocoa_jungle_grow_4", "farming:cocoa_4", mode, table.copy(def_table)
    )

    -- (Set growth code in ../lib/shared/farming/ in motion)
    unilib.farming.insert_into_grow_list({
        grow_name = "unilib:produce_cocoa_jungle_grow",
        harvest_full_name = "unilib:produce_cocoa_jungle_harvest",
        steps = 4,
    })

    -- Randomly add cocoa pods to jungle trees
    core.register_on_generated(function(minp, maxp)

        if maxp.y < 0 then
            return
        end

        local pos, dir

        local cocoa_list = core.find_nodes_in_area(minp, maxp, "unilib:tree_jungle_trunk")
        for n = 1, #cocoa_list do

            pos = cocoa_list[n]

            if core.find_node_near(pos, 1, {"unilib:tree_jungle_leaves"}) then

                dir = math.random(1, 80)

                if dir == 1 then
                    pos.x = pos.x + 1
                elseif dir == 2 then
                    pos.x = pos.x - 1
                elseif dir == 3 then
                    pos.z = pos.z + 1
                elseif dir == 4 then
                    pos.z = pos.z -1
                end

                if dir < 5 and
                        core.get_node(pos).name == "air" and
                        core.get_node_light(pos) > 12 then

                    core.swap_node(pos, {
                        name = "unilib:produce_cocoa_jungle_grow_" .. tostring(math.random(4))
                    })

                end

            end

        end

    end)

    -- Update global variables
    unilib.flora.register_growth_stages({
        base_name = "unilib:produce_cocoa_jungle_grow",
        mode = "produce",
        stage_max = 4,
    })

end
