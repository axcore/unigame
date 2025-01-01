---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.machine_renovation = {}

local S = unilib.intllib
local F = core.formspec_escape
local FS = function(...) return F(S(...)) end
local mode = unilib.global.imported_mod_table.unilib.add_mode

local max_stack = tonumber(core.settings:get("default_stack_max")) or 99

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_formspec(pos, description)

    local meta = core.get_meta(pos)
    local old = meta:get_string("old")
    local new = meta:get_string("new")

    return "size[8,7.5]" ..
            "label[0,0;" .. F(description) .. "]" ..
            "image[1,1;1,1;unilib_stone_ordinary_cobble.png]" ..
            "list[current_name;src;2,1;1,1;]" ..
            "label[3.2,1;" .. FS("Old items / items from other mods") .. "]" ..
            "style_type[label;font=italic]" ..
            "label[3.2,1.4;" .. F(old) .. "]" ..
            "image[1,2;1,1;unilib_stone_ordinary.png]" ..
            "list[current_name;dst;2,2;1,1;]" ..
            "style_type[label;font=normal]" ..
            "label[3.2,2;" .. FS("Corresponding unilib items") .. "]" ..
            "style_type[label;font=italic]" ..
            "label[3.2,2.4;" .. F(new) .. "]" ..
            "list[current_player;main;0,3.5;8,4;]" ..
            "listring[current_player;main]" ..
            "listring[current_name;dst]" ..
            "listring[current_player;main]" ..
            "listring[current_name;src]" ..
            "listring[current_player;main]"

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.machine_renovation.init()

    return {
        description = "Renovation machine",
        notes = "At no cost to the player, converts items from other mods into the corresponding" ..
                " unilib items (providing that the former has been aliased onto the latter)." ..
                " Also converts obsolete unilib items into the current version. The formspec" ..
                " displays the items names, allowing unknown items to be identified. Any" ..
                " metadata will be removed, so this machine should be used with care",
    }

end

function unilib.pkg.machine_renovation.exec()

    local c_ingot = "unilib:metal_steel_ingot"
    local description = S("Renovation Machine")

    unilib.register_node("unilib:machine_renovation", nil, mode, {
        -- Original to unilib
        description = description,
        tiles = {
            "unilib_machine_renovation.png",
            "unilib_machine_renovation.png",
            "unilib_machine_renovation_side.png",
            "unilib_machine_renovation_side.png",
            "unilib_machine_renovation_side.png",
            "unilib_machine_renovation_side.png",
        },
        groups = {cracky = 1},
        -- (no sounds)

        is_ground_content = false,

        can_dig = function(pos)

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()
            return inv:is_empty("dst") and inv:is_empty("src")

        end,

        on_construct = function(pos)

            local meta = core.get_meta(pos)
            meta:set_string("formspec", get_formspec(pos, description))
            meta:set_string("infotext", description)
            meta:set_string("old", "")
            meta:set_string("new", "")

            local inv = meta:get_inventory()
            inv:set_size("src", 1)
            inv:set_size("dst", 1)

        end,

        on_metadata_inventory_put = function(pos)

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()
            local stack = inv:get_stack("src", 1)

            local full_name = stack:get_name()
            meta:set_string("old", full_name)

            local convert_name = unilib.global.node_convert_table[full_name]
            if convert_name == nil then
                convert_name = unilib.global.mtgame_convert_table[full_name]
            end

            if convert_name == nil then

                meta:set_string("new", "")

            else

                local count = stack:get_count()
                local dstcount = inv:get_stack("dst",1):get_count()
                if dstcount < max_stack then

                    inv:add_item("dst", convert_name .. " " .. count)
                    inv:remove_item("src", stack)

                end

                meta:set_string("new", convert_name)

            end

            meta:set_string("formspec", get_formspec(pos, description))

        end,

        on_metadata_inventory_take = function(pos, listname, index, stack, player)

            local meta = core.get_meta(pos)
            meta:set_string("old", "")
            meta:set_string("new", "")
            meta:set_string("formspec", get_formspec(pos, description))

        end,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:machine_renovation",
        recipe = {
            {c_ingot, "group:wood", c_ingot},
            {"group:cobble", "group:soil", "group:cobble"},
            {c_ingot, "group:wood", c_ingot},
        },
    })

end
