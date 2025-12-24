---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_tank_fish = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

-- Table of fish that can be placed in the fish tank; the data is compiled below
-- Table in the form
--      compat_table[spawnegg_name] = {
--          mob_type = mob_type (e.g. "fish_clownfish")
--          skin_list = list_of_skins,
--      }
local compat_table = {}
-- If true, spritesheets for all skins are visible in the fish tank. If false, only the original
--      skin is visible (regardless of the skin of the fish actually placed there)
local all_skins_flag = true

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function remove_fish(pos)

    local obj_list = core.get_objects_inside_radius(pos, 0.5)
    if not obj_list then
        return
    end

    for _, obj in pairs(obj_list) do

        if obj and
                obj:get_luaentity() and
                obj:get_luaentity().groups and
                obj:get_luaentity().groups.fishtank then

            obj:remove()
            break

        end

    end

end

local function get_mob_data(itemstack_meta, mob_type)

    -- For spawn eggs from captured mobs, recover the mobs' static data (which includes its skin
    --      type and genetics)
    local staticdata = itemstack_meta:get_string("staticdata")
    if staticdata ~= "" then

        local static_data_table = core.deserialize(staticdata)
        local mob_texture_num = static_data_table.mob_texture_num
        if mob_texture_num ~= nil then

            local data_table = unimobs.petz_global.mob_table[mob_type]
            local mini_list = data_table.skin_init_list[mob_texture_num]
            local skin_type = mini_list[1]

            return skin_type, static_data_table

        end

    end

    -- For unused spawn eggs, we use the generic skin for this fish, as specified by the call to the
    --      fish package's shared function
    -- (Therefore, placing one type of fish in fish tanks always generates a fish with the same
    --      skin, unless the user has used a net to capture fish with other skins)
    local skin_type = compat_table["unilib:spawnegg_" .. mob_type]["skin_list"][1]
    -- (There is no staticdata to return)
    return skin_type

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_tank_fish.init()

    return {
        description = "Fish tank",
        notes = "Works with clownfish and tropical fish only. Use a net to retrieve a fish" ..
                " from the tank. If you had initially used a net to capture the fish (rather)" ..
                " than using a fresh spawn egg), then the fish's skin and genetics should be" ..
                " retained after retrieving the fish from its tank (unlike in the original code," ..
                " in which the fish tank always returned a fish with the same generic skin)",
        depends = "glass_ordinary",
        optional = {"item_net_animal", "item_net_bug", "mob_fish_clownfish", "mob_fish_tropical"},
    }

end

function unilib.pkg.misc_tank_fish.exec()

    unilib.register_node("unilib:misc_tank_fish", "petz:fishtank", mode, {
        -- From petz:fishtank
        description = S("Fish Tank"),
        tiles = {"unilib_misc_tank_fish_top.png", "unilib_misc_tank_fish_bottom.png"},
        groups = {cracky = 1},
        sounds = unilib.global.sound_table.glass,

        drawtype = "glasslike_framed",
        inventory_image = "unilib_misc_tank_fish_inv.png",
        light_source = unilib.constant.light_max - 1,
        param2 = 50,
        paramtype = "light",
        paramtype2 = "glasslikeliquidlevel",
        special_tiles = {"unilib_misc_tank_fish_bottom.png"},
        sunlight_propagates = true,
        use_texture_alpha = "blend",
        walkable = true,

        after_place_node = function(pos, placer, itemstack)

            core.set_node(pos, {name = "unilib:misc_tank_fish", param2 = 1})
            local meta = core.get_meta(pos)
            meta:set_string("has_mob", "false")

        end,

        on_destruct = function(pos)

            local meta = core.get_meta(pos)
            local has_mob = meta:get_string("has_mob")
            local mob_name = meta:get_string("mob_name")

            if mob_name and has_mob == "true" then

                remove_fish(pos)
                core.add_entity(pos, mob_name)

            end

        end,

        on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)

            local tank_meta = core.get_meta(pos)
            local has_mob = tank_meta:get_string("has_mob")

            local itemstack_meta = itemstack:get_meta()
            local itemstack_name = itemstack:get_name()

            if compat_table[itemstack_name] ~= nil and has_mob == "false" then

                local mini_table = compat_table[itemstack_name]
                local mob_name = "unilib:mob_" .. mini_table.mob_type
                local skin_type, static_data_table =
                        get_mob_data(itemstack_meta, mini_table.mob_type)

                tank_meta:set_string("has_mob", "true")
                tank_meta:set_string("mob_name", mob_name)
                if static_data_table ~= nil then
                    tank_meta:set_string("mob_staticdata", core.serialize(static_data_table))
                end

                local sprite_entity = core.add_entity(
                    {x = pos.x, y = pos.y, z = pos.z},
                    mob_name .. "_" .. skin_type .. "_sprite_entity"
                )

                if sprite_entity then

                    sprite_entity:set_properties(
                        {textures = itemstack_meta:get_string("textures") .. "^[transformFX"}
                    )
                    sprite_entity:set_sprite({x = 0, y = 0}, 16, 1.0, false)

                    itemstack:take_item()
                    clicker:set_wielded_item(itemstack)

                end

            elseif (
                itemstack_name == "unilib:item_net_bug" or
                itemstack_name == "fireflies:bug_net" or
                itemstack_name == "unilib:item_net_animal" or
                itemstack_name == "mobs:net"
            ) and has_mob == "true" then

                local mob_name = tank_meta:get_string("mob_name")
                if mob_name then

                    local staticdata = tank_meta:get_string("mob_staticdata")

                    local new_stack = ItemStack(unimobs.global.spawnegg_lookup_table[mob_name])
                    local new_meta = new_stack:get_meta()
                    new_meta:set_string("staticdata", staticdata)

                    local inv = clicker:get_inventory()
                    if inv:room_for_item("main", new_stack) then

                        inv:add_item("main", new_stack)

                        remove_fish(pos)
                        tank_meta:set_string("has_mob", "false")
                        tank_meta:set_string("mob_name", "")
                        tank_meta:set_string("mob_staticdata", "")

                    end

                end

            end

            return itemstack

        end,
    })

end

function unilib.pkg.misc_tank_fish.post()

    local c_glass = "unilib:glass_ordinary"
    local c_tank = "unilib:misc_tank_fish"

    -- Generate craft recipes
    for bucket_type, _ in pairs(unilib.global.generic_bucket_table) do

        local c_water_bucket = "unilib:" .. bucket_type .. "_with_water_ordinary"
        local c_empty_bucket = "unilib:" .. bucket_type .. "_empty"

        unilib.register_craft({
            -- From petz:fishtank
            type = "shaped",
            output = c_tank,
            recipe = {
                {c_glass, c_glass, c_glass},
                {c_glass, c_water_bucket, c_glass},
                {c_glass, c_glass, c_glass},
            },
            replacements = {
                {c_water_bucket, c_empty_bucket},
            },
        })

    end

    -- Prepare a table of mobs and skins with which the fish tank is compatible (in the original
    --      code, the fish tank was capable of using spritesheets for just one skin from each mob)
    if unilib.global.pkg_executed_table["mob_fish_clownfish"] ~= nil then

        -- The call to .generate_spritesheets() returns a list of skins. The first skin in the list
        --      is the default one
        local skin_list =
                unilib.pkg.mob_fish_clownfish.generate_spritesheets(c_tank, all_skins_flag)
        if #skin_list > 0 then

            compat_table["unilib:spawnegg_fish_clownfish"] = {
                mob_type = "fish_clownfish",
                skin_list = skin_list,
            }

        end

    end

    if unilib.global.pkg_executed_table["mob_fish_clownfish"] ~= nil then

        local skin_list =
                unilib.pkg.mob_fish_tropical.generate_spritesheets(c_tank, all_skins_flag)
        if #skin_list > 0 then

            compat_table["unilib:spawnegg_fish_tropical"] = {
                mob_type = "fish_tropical",
                skin_list = skin_list,
            }

        end

    end

end
