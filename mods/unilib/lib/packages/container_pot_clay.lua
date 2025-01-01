---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.container_pot_clay = {}

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

    local formspec ="size[8,7]" ..
            "list[current_name;main;0,0.3;8,2]" ..
            "list[current_player;main;0,2.85;8,1]" ..
            "list[current_player;main;0,4.08;8,3;8]" ..
            "listring[current_name;main]" ..
            "listring[current_player;main]"

    return formspec

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.container_pot_clay.init()

    return {
        description = "Clay storage pot",
    }

end

function unilib.pkg.container_pot_clay.exec()

    local c_lump = "unilib:clay_ordinary_lump"

    unilib.register_craftitem(
        -- From earthbuild:storage_pot_unfired
        "unilib:container_pot_clay_unfired",
        "earthbuild:storage_pot_unfired",
        mode,
        {
            description = S("Unfired Clay Storage Pot"),
            inventory_image = "unilib_container_pot_clay_unfired.png",
        }
    )
    unilib.register_craft({
        -- From earthbuild:storage_pot_unfired
        output = "unilib:container_pot_clay_unfired",
        recipe = {
            {c_lump, c_lump, c_lump},
            {c_lump, "", c_lump},
            {c_lump, c_lump, c_lump},
        },
    })
    unilib.register_craft({
        -- From earthbuild:storage_pot_unfired
        output = c_lump .. " 8",
        recipe = {
            {"unilib:container_pot_clay_unfired"},
        },
    })

    local def_table = {
        description = S("Clay Storage Pot"),
        tiles = {
            "unilib_container_pot_clay_top.png",
            "unilib_container_pot_clay_top.png",
            "unilib_container_pot_clay.png",
            "unilib_container_pot_clay.png",
            "unilib_container_pot_clay.png",
            "unilib_container_pot_clay.png",
        },
        groups = {oddly_breakable_by_hand = 3},
        sounds = unilib.global.sound_table.stone,

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.375, -0.5, -0.375, 0.375, -0.375, 0.375},
                {-0.375, 0.375, -0.375, 0.375, 0.5, 0.375},
                {-0.4375, -0.375, -0.4375, 0.4375, -0.25, 0.4375},
                {-0.4375, 0.25, -0.4375, 0.4375, 0.375, 0.4375},
                {-0.5, -0.25, -0.5, 0.5, 0.25, 0.5},
            },
        },
        paramtype = "light",

        allow_metadata_inventory_move = function(
            pos, from_list, from_index, to_list, to_index, count, player
        )
            if is_owner(pos, player:get_player_name()) then
                return count
            end

            return 0

        end,

        allow_metadata_inventory_put = function(pos, listname, index, stack, player)

--          if is_owner(pos, player:get_player_name()) and
--                  not string.match(stack:get_name(), "backpacks:") then
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
            inv:set_size("main", 8 * 3)
            meta:set_string("infotext", S("Clay Storage Pot"))

        end,

        --[[
        on_metadata_inventory_move = function(
            pos, from_list, from_index, to_list, to_index, count, player
        )
            -- N.B. This callback and its log message not in original code
            unilib.utils.log(
                "action",
                player:get_player_name() .. " moves items in clay storage pot at " ..
                        core.pos_to_string(pos)
            )

        end,

        on_metadata_inventory_put = function(pos, listname, index, stack, player)

            -- N.B. This callback and its log message not in original code
            unilib.utils.log(
                "action",
                player:get_player_name() .. " moves items to clay storage pot at " ..
                        core.pos_to_string(pos)
            )

        end,

        on_metadata_inventory_take = function(pos, listname, index, stack, player)

            -- N.B. This callback and its log message not in original code
            unilib.utils.log(
                "action",
                player:get_player_name() .. " takes items from clay storage pot at " ..
                        core.pos_to_string(pos)
            )

        end,
        ]]--
    }

    unilib.utils.set_inventory_action_loggers(def_table, "clay storage pot")
    unilib.register_node(
        -- From earthbuild:storage_pot
        "unilib:container_pot_clay", "earthbuild:storage_pot", mode, def_table
    )

    unilib.register_craft({
        -- From earthbuild:storage_pot
        type = "cooking",
        output = "unilib:container_pot_clay",
        recipe = "unilib:container_pot_clay_unfired",
        cooktime = 10,
    })

end
