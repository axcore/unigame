---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.container_gourd_bottle = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.earthbuild.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function is_owner(pos, name)

    local owner = core.get_meta(pos):get_string("owner")
    if owner == "" or owner == name or core.check_player_privs(name, "protection_bypass") then
        return true
    end

    return false

end

local function get_storage_formspec(pos)

    local formspec ="size[8,6]" ..
            "list[current_name;main;3.5,0.3;8,2]" ..
            "list[current_player;main;0,1.85;8,1]" ..
            "list[current_player;main;0,3.08;8,3;8]" ..
            "listring[current_name;main]" ..
            "listring[current_player;main]"

    return formspec

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.container_gourd_bottle.init()

    return {
        description = "Bottle gourd (as a container)",
    }

end

function unilib.pkg.container_gourd_bottle.exec()

    local def_table = {
        description = S("Bottle Gourd Container"),
        tiles = {
            "unilib_container_gourd_bottle_top.png",
            "unilib_container_gourd_bottle_bottom.png",
            "unilib_container_gourd_bottle.png",
            "unilib_container_gourd_bottle.png",
            "unilib_container_gourd_bottle.png",
            "unilib_container_gourd_bottle.png",
        },
        groups = {dig_immediate = 3},
        sounds = unilib.global.sound_table.wood,

        drawtype = "nodebox",
        -- N.B. Removed inventory_image from original code
--      inventory_image = "unilib_container_gourd_bottle.png",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.25, -0.5, -0.25, 0.25, -0.0, 0.25},
            },
        },
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.25, -0.5, -0.25, 0.25, -0.0, 0.25},
            },
        },
        use_texture_alpha = "clip",
        wield_image = "unilib_container_gourd_bottle.png",

        allow_metadata_inventory_move = function(
            pos, from_list, from_index, to_list, to_index, count, player
        )
            if is_owner(pos, player:get_player_name()) then
                return count
            end

            return 0

        end,

        allow_metadata_inventory_put = function(pos, listname, index, stack, player)

--              if is_owner(pos, player:get_player_name()) and
--                      not string.match(stack:get_name(), "backpacks:") then
            if is_owner(pos, player:get_player_name()) then
                return stack:get_count()
            end

            return 0

        end,

        allow_metadata_inventory_take = function(pos, listname, index, stack, player)

            if is_owner(pos, player:get_player_name()) then
                return stack:get_count()
            end

            return 0

        end,

        can_dig = function(pos, player)

            local inv = core.get_meta(pos):get_inventory()
            local name = ""
            if player then
                name = player:get_player_name()
            end

            return is_owner(pos, name) and inv:is_empty("main")

        end,

        on_blast = function() end,

        on_construct = function(pos)

            local meta = core.get_meta(pos)
            meta:set_string("formspec", get_storage_formspec(pos, 8, 2))
            local inv = meta:get_inventory()
            inv:set_size("main", 1 * 1)
            meta:set_string("infotext", S("Bottle Gourd Container"))

        end,

        --[[
        on_metadata_inventory_move = function(
            pos, from_list, from_index, to_list, to_index, count, player
        )
            -- N.B. This callback and its log message not in original code
            unilib.utils.log(
                "action",
                player:get_player_name() .. " moves items in bottle gourd at " ..
                        core.pos_to_string(pos)
            )

        end,

        on_metadata_inventory_put = function(pos, listname, index, stack, player)

            -- N.B. This callback and its log message not in original code
            unilib.utils.log(
                "action",
                player:get_player_name() .. " moves items to bottle gourd at " ..
                        core.pos_to_string(pos)
            )

        end,

        on_metadata_inventory_take = function(pos, listname, index, stack, player)

            -- N.B. This callback and its log message not in original code
            unilib.utils.log(
                "action",
                player:get_player_name() .. " takes items from bottle gourd at " ..
                        core.pos_to_string(pos)
            )

        end,
        ]]--
    }

    unilib.utils.set_inventory_action_loggers(def_table, "bottle gourd")
    unilib.register_node(
        -- From earthbuild:bottlegourd_container
        "unilib:container_gourd_bottle",
        "earthbuild:bottlegourd_container",
        mode,
        def_table
    )

    -- N.B. Original code used an intermediate crafting stage with a bottlegourd cup; here, that
    --      intermediate stage (and its cup) is omitted
    unilib.register_craft({
        -- From earthbuild:bottlegourd_container
        output = "unilib:container_gourd_bottle",
        recipe = {
            {"unilib:produce_gourd_bottle_harvest", "unilib:produce_gourd_bottle_harvest"},
            {"unilib:produce_gourd_bottle_harvest", "unilib:produce_gourd_bottle_harvest"},
        },
    })
    unilib.register_craft({
        -- From earthbuild:bottlegourd_container
        type = "fuel",
        recipe = "unilib:container_gourd_bottle",
        burntime = 1,
    })

end
