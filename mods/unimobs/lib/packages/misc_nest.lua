---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_nest = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

local cbox = {
    type = "fixed",
    fixed = {-0.25, -0.75, -0.25, 0.25, -0.25, 0.25},
}

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_nest.init()

    return {
        description = "Nest",
        notes = "Chicken and duck eggs can be placed in the nest, in order to hatch them." ..
                " Hens and ducks require an empty nest, in order to lay eggs",
        depends = "plant_papyrus_ordinary",
        at_least_one = {"egg_chicken_normal", "egg_duck_normal"},
    }

end

function unilib.pkg.misc_nest.exec()

    local c_papyrus = "unilib:plant_papyrus_ordinary"

    unilib.register_node("unilib:misc_nest", "petz:ducky_nest", mode, {
        -- From petz:ducky_nest
        description = S("Nest"),
        tiles = {"unilib_misc_nest.png"},
        groups = {bendy = 2, cracky = 1, snappy = 1},
        sounds = unilib.global.sound_table.wood,

        collision_box = cbox,
        drawtype = "mesh",
        inventory_image = "unilib_misc_nest_inv.png",
        mesh = "unilib_misc_nest.b3d",
        paramtype = "light",
        selection_box = cbox,
        visual_size = {x = 1.3, y = 1.3},
        wield_image = "unilib_misc_nest_inv.png",

        on_rightclick = function(pos, node, player, itemstack, pointed_thing)

            if player then

                -- Place suitable eggs in the nest
                local itemstack_name = itemstack:get_name()
                local egg_type

                if itemstack_name == "unilib:egg_duck_normal" then
                    egg_type = "duck_normal"
                elseif itemstack_name == "unilib:egg_chicken_normal" then
                    egg_type = "chicken_normal"
                end

                if egg_type then

                    itemstack:take_item()
                    player:set_wielded_item(itemstack)
                    core.set_node(pos, {name = "unilib:misc_nest_with_egg_" .. egg_type})
                    return itemstack

                end

            end

        end,
    })
    unilib.register_craft({
        -- From petz:ducky_nest
        type = "shaped",
        output = "unilib:misc_nest",
        recipe = {
            {"", "", ""},
            {"group:leaves", "", "group:leaves"},
            {c_papyrus, c_papyrus, c_papyrus},
        },
    })

    if unilib.global.pkg_executed_table["egg_chicken_normal"] ~= nil then

        unilib.register_node(
            -- From petz:chicken_nest_egg
            "unilib:misc_nest_with_egg_chicken_normal",
            "petz:chicken_nest_egg",
            mode,
            {
                description = S("Nest with Chicken Egg"),
                tiles = {"unilib_misc_nest_with_egg_chicken_normal.png"},
                -- N.B. not_in_creative_inventory = 1 not in original code
                groups = {bendy = 2, cracky = 1, not_in_creative_inventory = 1, snappy = 1},
                sounds = unilib.global.sound_table.wood,

                collision_box = cbox,
                drawtype = "mesh",
                inventory_image = "unilib_misc_nest_with_egg_chicken_normal_inv.png",
                mesh = "unilib_misc_nest_with_egg.b3d",
                paramtype = "light",
                selection_box = cbox,
                use_texture_alpha = "clip",
                visual_size = {x = 1.3, y = 1.3},
                wield_image = "unilib_misc_nest_with_egg_chicken_normal_inv.png",

                on_construct = function(pos)

                    -- Add a timer so that eggs placed in the nest will hatch
                    local timer = core.get_node_timer(pos)
                    local hatch_egg_interval = unimobs.petz_setting.hatch_egg_interval
                    timer:start(unimobs.petz_api.get_random_interval(hatch_egg_interval))

                end,

                on_rightclick = function(pos, node, player, itemstack, pointed_thing)

                    -- Extract the egg
                    itemstack = unimobs.petz_api.extract_egg_from_nest(
                        pos, player, itemstack, "unilib:egg_chicken_normal", "unilib:misc_nest"
                    )

                    return itemstack

                end,

                on_timer = function(pos)

                    if not core.registered_entities["unilib:mob_chicken_chicklet"] then
                        return
                    end

                    local pos_above = {x = pos.x, y = pos.y + 1, z = pos.z}
                    local obj = core.add_entity(pos_above, "unilib:mob_chicken_chicklet")
                    if obj then

                        local luaent = obj:get_luaentity()
                        luaent.is_baby_flag = unimobs.mobkit_api.add_mob_memory(
                            luaent, "is_baby_flag", true
                        )
                        luaent.baby_growth_time = unimobs.mobkit_api.add_mob_memory(
                            luaent, "baby_growth_time", 0
                        )
                        core.set_node(pos, {name = "unilib:misc_nest"})

                    end

                    return true

                end,
            }
        )
        unilib.register_craft({
            -- From petz:chicken_nest_egg
            type = "shaped",
            output = "unilib:misc_nest_with_egg_chicken_normal",
            recipe = {
                {"", "", ""},
                {"group:leaves", "unilib:egg_chicken_normal", "group:leaves"},
                {c_papyrus, c_papyrus, c_papyrus},
            }
        })

    end

    if unilib.global.pkg_executed_table["egg_duck_normal"] ~= nil then

        unilib.register_node("unilib:misc_nest_with_egg_duck_normal", "petz:ducky_nest_egg", mode, {
            -- From petz:ducky_nest_egg
            description = S("Nest with Duck Egg"),
            tiles = {"unilib_misc_nest_with_egg_duck_normal.png"},
            -- N.B. not_in_creative_inventory = 1 not in original code
            groups = {bendy = 2, cracky = 1, not_in_creative_inventory = 1, snappy = 1},
            sounds = unilib.global.sound_table.wood,

            collision_box = cbox,
            drawtype = "mesh",
            inventory_image = "unilib_misc_nest_with_egg_duck_normal_inv.png",
            mesh = "unilib_misc_nest_with_egg.b3d",
            paramtype = "light",
            selection_box = cbox,
            use_texture_alpha = "clip",
            visual_size = {x = 1.3, y = 1.3},
            wield_image = "unilib_misc_nest_with_egg_duck_normal_inv.png",

            on_construct = function(pos)

                -- Add a timer so that eggs placed in the nest will hatch
                local timer = core.get_node_timer(pos)
                local hatch_egg_interval = unimobs.petz_setting.hatch_egg_interval
                timer:start(unimobs.petz_api.get_random_interval(hatch_egg_interval))

            end,

            on_rightclick = function(pos, node, player, itemstack, pointed_thing)

                -- Extract the egg
                itemstack = unimobs.petz_api.extract_egg_from_nest(
                    pos, player, itemstack, "unilib:egg_duck_normal", "unilib:misc_nest"
                )

                return itemstack

            end,

            on_timer = function(pos)

                if not core.registered_entities["unilib:mob_duck_normal"] then
                    return
                end

                local pos_above = {x = pos.x, y = pos.y + 1, z = pos.z}
                core.add_entity(pos_above, "unilib:mob_duck_normal")
                core.set_node(pos, {name = "unilib:misc_nest"})
                return true

            end,
        })
        unilib.register_craft({
            -- From petz:ducky_nest_egg
            type = "shaped",
            output = "unilib:misc_nest_with_egg_duck_normal",
            recipe = {
                {"", "", ""},
                {"group:leaves", "unilib:egg_duck_normal", "group:leaves"},
                {c_papyrus, c_papyrus, c_papyrus},
            },
        })

    end

end
