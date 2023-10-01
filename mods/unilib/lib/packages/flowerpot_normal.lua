---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    flowerpot
-- Code:    LGPLv2.1
-- Media:   CC-BY-SA-3.0/Public Domain
---------------------------------------------------------------------------------------------------

unilib.pkg.flowerpot_normal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.flowerpot.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_tile(def_table)

    -- Adapted from flowerpot/init.lua, get_tile()

    local tile = def_table.tiles[1]
    if type (tile) == "table" then
        return tile.name
    else
        return tile
    end

end

local function insert_flower(pos, node, clicker, itemstack, pointed_thing)

    -- Adapted from flowerpot/init.lua, flowerpot_on_rightclick()
    -- When an empty normal flowerpot is right-clicked with a compatible flower, swaps the empty
    --      flowerpot for a full one

    if clicker and not minetest.check_player_privs(clicker, "protection_bypass") then

        local name = clicker:get_player_name()
        if minetest.is_protected(pos, name) then

            minetest.record_protection_violation(pos, name)
            return false

        end

    end

    local flower_name = itemstack:get_name()
    if not flower_name then
        return false
    end

    local full_name = "unilib:flowerpot_normal_with_" .. unilib.get_item_name(flower_name)
    local def_table = minetest.registered_nodes[full_name]
    if def_table == nil then
        return itemstack
    end

    minetest.sound_play(def_table.sounds.place, {pos = pos})
    minetest.swap_node(pos, {name = full_name})
    if not minetest.settings:get_bool("creative_mode") then
        itemstack:take_item()
    end

    return itemstack

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flowerpot_normal.init()

    return {
        description = "Normal flowerpot",
        notes = "Compatible flowers can be placed in a pot by right-clicking the pot with the" ..
                " flower",
        depends = "brick_ordinary",
    }

end

function unilib.pkg.flowerpot_normal.exec()

    -- Create the empty flowerpot
    unilib.register_node("unilib:flowerpot_normal_empty", "flowerpot:empty", mode, {
        -- From flowerpot:empty
        description = S("Empty Normal Flowerpot"),
        tiles = {
            {name = "unilib_flowerpot_normal.png"},
            {name = "blank.png"},
            {name = "blank.png"},
        },
        groups = {attached_node = 1, cracky = 1, dig_immediate = 3, oddly_breakable_by_hand = 3},
        sounds = unilib.sound_table.node,

        collision_box = {
            type = "fixed",
            fixed = {-1/4, -1/2, -1/4, 1/4, -1/8, 1/4},
        },
        drawtype = "mesh",
        inventory_image = "unilib_flowerpot_normal_inv.png",
        mesh = "unilib_flowerpot_normal.obj",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-1/4, -1/2, -1/4, 1/4, -1/16, 1/4},
        },
        sunlight_propagates = true,
        use_texture_alpha = minetest.features.use_texture_alpha_string_modes and "clip" or true,
        wield_image = "unilib_flowerpot_normal_inv.png",

        on_rightclick = insert_flower,
    })
    unilib.register_craft({
        -- From flowerpot:empty
        output = "unilib:flowerpot_normal_empty",
        recipe = {
            {"unilib:brick_ordinary", "", "unilib:brick_ordinary"},
            {"", "unilib:brick_ordinary", ""},
        }
    })

end

function unilib.pkg.flowerpot_normal.post()

    -- Create flowerpots for every compatible flower/plant/etc
    for full_name, orig_name in pairs(unilib.flowerpot_compat_table) do

        local def_table = minetest.registered_nodes[full_name]
        if def_table == nil then
            return false
        end

        local item_name = unilib.get_item_name(def_table.name)
        local pot_orig_name = nil
        if orig_name ~= "" then
            pot_orig_name = "flowerpot:" .. orig_name:gsub(":", "_")
        end

        local img_list
        if def_table.drawtype == "plantlike" then
            img_list = {
                {name = "unilib_flowerpot_normal.png"},
                {name = get_tile(def_table)},
                {name = "blank.png"},
            }
        else
            img_list = {
                {name = "unilib_flowerpot_normal.png"},
                {name = "blank.png"},
                {name = get_tile(def_table)},
            }
        end

        unilib.register_node("unilib:flowerpot_normal_with_" .. item_name, pot_orig_name, mode, {
            -- From flowerpot:flowers_rose, etc. Creates
            --      unilib:flowerpot_normal_with_flower_rose_red, etc
            description = S("Normal Flowerpot with @1", def_table.description),
            tiles = img_list,
            groups = {
                attached_node = 1, not_in_creative_inventory = 1, oddly_breakable_by_hand = 1,
                snappy = 3,
            },
            sounds = unilib.sound_table.node,

            collision_box = {
                type = "fixed",
                fixed = {-1/4, -1/2, -1/4, 1/4, -1/8, 1/4},
            },
            drawtype = "mesh",
            drop = {
                max_items = 2,
                items = {
                    {
                        items = {"unilib:flowerpot_normal_empty", full_name},
                        rarity = 1,
                    },
                }
            },
            flowerpot_plantname = full_name,
            -- N.B. light_source not in original code; the flowerpot should glow with the same
            --      luminosity as its flower
            light_source = def_table.light_source,
            mesh = "unilib_flowerpot_normal.obj",
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-1/4, -1/2, -1/4, 1/4, 7/16, 1/4},
            },
            sunlight_propagates = true,
            use_texture_alpha = minetest.features.use_texture_alpha_string_modes and
                    "clip" or true,

            on_dig = function(pos, node, digger)

                minetest.set_node(pos, {name = "unilib:flowerpot_normal_empty"})
                local def = minetest.registered_nodes[node.name]
                minetest.add_item(pos, full_name)

            end,
        })

    end

end
