---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unimobs
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.admin_tool_mob_spawner = {}

local S = unimobs.intllib
local F = core.formspec_escape
local FS = function(...) return F(S(...)) end
local mode = unilib.global.imported_mod_table.unimobs.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_mob_str()

    local str = ""

    for _, mob_type in ipairs(unimobs.petz_global.mob_list) do

        if str ~= "" then
            str = str .. ","
        end

        str = str .. mob_type .. " / " .. unimobs.petz_global.mob_table[mob_type]["description"]

    end

    return str

end

local function get_skin_str(meta)

    local str = ""

    local mob_index = meta:get_int("mob_index")
    local mob_type = unimobs.petz_global.mob_list[mob_index]
    if mob_type == nil then
        return str
    end

    local skin_init_list = unimobs.petz_global.mob_table[mob_type]["skin_init_list"]

    if skin_init_list then

        for _, mini_list in ipairs(skin_init_list) do

            if str ~= "" then
                str = str .. ","
            end

            str = str .. mini_list[1] .. " / " .. mini_list[2]
            if mini_list[3] == 0 then
                str = str .. " (" .. S("mutation") .. ")"
            end

        end

    end

    return str

end

local function get_formspec(itemstack)

    local meta = itemstack:get_meta()

    local formspec = "size[8,7.5]" ..
        "image[0,0;1,1;unilib_admin_tool_mob_spawner.png;]" ..
        "label[1,0.25;" .. FS("Admin mob spawner") .. "]" ..
        "label[0,1.25;" .. FS("Select a mob") .. ":]" ..
        "textlist[2,1.25;5.75,2.5;mob_list;" .. get_mob_str() .. ";" ..
            meta:get_int("mob_index") .. "]" ..
        "label[0,4;" .. FS("Select a skin") .. ":]" ..
        "textlist[2,4;5.75,2.5;skin_list;" .. FS("random skin") .. "," ..
            get_skin_str(meta) .. ";" .. meta:get_int("skin_index") .. "]" ..
        "label[0,6.85;" .. FS("Select a gender") .. ":]" ..
        "dropdown[2,6.75;2.5,1;gender_list;" .. FS("Random") .. "," .. FS("Male") .. "," ..
            FS("Female") .. ";" .. meta:get_int("gender_index") .. ";true]" ..
        "checkbox[4.75,6.65;is_tamed;" .. FS("Tamed if possible") .. ";" ..
            meta:get_string("is_tamed") .. "]"

    return formspec

end

local function configure_tool(itemstack, user, pointed_thing)

    -- Called when the player right-clicks a node, while wielding this tool
    -- Open the formspec

    local meta = itemstack:get_meta()
    if meta:get_string("is_initialised") == "" then

        -- On first use, initialise metadata
        meta:set_string("is_initialised", "true")

        -- Formspec selections
        meta:set_int("mob_index", 1)
        meta:set_int("skin_index", 1)
        -- 1 = random, 2 = male, 3 = female
        meta:set_int("gender_index", 1)
        meta:set_string("is_tamed", "true")

        user:set_wielded_item(itemstack)

    end

    core.show_formspec(
        user:get_player_name(),
        "unilib:formspec_admin_tool_mob_spawner",
        get_formspec(itemstack)
    )

end

local function use_tool(itemstack, user, pointed_thing)

    -- Called when the player left-clicks a node, while wielding this tool
    -- After basic checks, places a mob at the clicked position

    local meta = itemstack:get_meta()

    -- Check global registries
    local mob_index = meta:get_int("mob_index")
    local mob_type = unimobs.petz_global.mob_list[mob_index]
    if not mob_type then
        return
    end

    local data_table = unimobs.petz_global.mob_table[mob_type]
    if not core.registered_entities[data_table.mob_name] then
        return
    end

    -- Retrieve data from meta
    local skin_index = meta:get_int("skin_index")
    local gender_index = meta:get_int("gender_index")
    local is_tamed = meta:get_string("is_tamed")

    -- Set the gender and skin directly by passing a serialised table to core.add_entity()
    --      (code in petz_init_prop.lua will check for it, and will not set random genders/skins
    --      as normal)
    local static_data_table = {}
    static_data_table.override_table = {}
    -- (skin_index = 1 corresponds to a random skin; skin_index = 2 corresponds to the mob's skin
    --      number 1)
    if skin_index > 1 then
        static_data_table.override_table.mob_texture_num = skin_index - 1
    end
    -- (For random genders, the .is_male flag's value must remain as nil)
    if gender_index == 2 then
        static_data_table.override_table.is_male_flag = true
    elseif gender_index == 3 then
        static_data_table.override_table.is_male_flag = false
    end

    -- Am I clicking on something with an existing .on_rightclick() function?
    local under_node = core.get_node(pointed_thing.under)
    local under_def_table = core.registered_nodes[under_node.name]
    if under_def_table and under_def_table.on_rightclick then

        return under_def_table.on_rightclick(
            pointed_thing.under, under_node, placer, itemstack
        )

    end

    -- Set the spawn position for the new mob
    local spawn_pos = pointed_thing.above
    if not spawn_pos then
        return
    end

    local corrected_spawn_pos =
            unimobs.petz_api.refine_spawn_position(mob_type, spawn_pos)
    if not corrected_spawn_pos then
        return
    end

    -- Spawn the mob
    local obj = core.add_entity(
        corrected_spawn_pos, data_table.mob_name, core.serialize(static_data_table)
    )
    if obj then

        local luaent = obj:get_luaentity()
        if luaent then

            -- Mark the mob as tamed, if necessary
            if not luaent.is_wild_flag and is_tamed == "true" then

                unimobs.kitz_api.set_mob_owner(luaent, user:get_player_name())
                unimobs.petz_api.update_tamagotchi_mob_after_tame(luaent)

            end

            -- Write logs, as unimobs.petz_api.spawn_mob() already does
            unilib.utils.log(
                "action",
                string.format(
                    "[unimobs] Spawned %s at %s using admin tool",
                    luaent.name,
                    unimobs.petz_api.pos_to_string(vector.round(obj:get_pos()))
                )
            )

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.admin_tool_mob_spawner.init()

    return {
        description = "Admin mob spawning tool",
        notes = "Spawns a mob (for debugging purposes)",
    }

end

function unilib.pkg.admin_tool_mob_spawner.exec()

    unilib.register_tool("unilib:admin_tool_mob_spawner", nil, mode, {
        -- Original to unimobs
        description = unilib.utils.hint(S("Admin Mob Spawner"), S("right-click to configure")),
        inventory_image = "unilib_admin_tool_mob_spawner.png",
        groups = {not_in_creative_inventory = unilib.globalshow_admin_item_group},
        -- (no sounds)

        -- It's OK to interact with water
        liquids_pointable = true,
        -- The replacer must store information, so only one can be stacked
        stack_max = 1,
        wield_image = "",
        wield_scale = {x = 1, y = 1, z = 1},

        on_place = function(itemstack, placer, pointed_thing)

            if placer ~= nil and pointed_thing ~= nil then
                configure_tool(itemstack, placer, pointed_thing)
            end

            return itemstack

        end,

        on_use = function(itemstack, user, pointed_thing)

            if user ~= nil and pointed_thing ~= nil and pointed_thing.type == "node" then
                use_tool(itemstack, user, pointed_thing)
            end

        end,
    })

    core.register_on_player_receive_fields(function(player, formname, fields)

        -- The player has interacted with our formspec
        if not formname or
                formname ~= "unilib:formspec_admin_tool_mob_spawner" or
                not fields then
            return false
        end

        local itemstack = player:get_wielded_item()
        local meta = itemstack:get_meta()

        if fields.mob_list then

            local event = core.explode_textlist_event(fields.mob_list)
            if event.type == "CHG" then

                meta:set_int("mob_index", event.index)
                meta:set_int("skin_index", 1)

            end

        elseif fields.skin_list then

            local event = core.explode_textlist_event(fields.skin_list)
            if event.type == "CHG" then
                meta:set_int("skin_index", event.index)
            end

        elseif fields.is_tamed then

            meta:set_string("is_tamed", fields.is_tamed)

        elseif fields.gender_list then

            meta:set_int("gender_index", fields.gender_list)

        else

            return true

        end

        -- (Because it's a tool, metadata is lost without this line)
        player:set_wielded_item(itemstack)

        -- (Selecting one checkbox deselects the others; redraw the formspec to make that visible)
        if not fields.quit then

            core.show_formspec(
                player:get_player_name(),
                "unilib:formspec_admin_tool_mob_spawner",
                get_formspec(itemstack)
            )

        end

        return true

    end)

end
