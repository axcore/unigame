---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unimobs
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.admin_tool_mob_investigator = {}

local S = unimobs.intllib
local F = core.formspec_escape
local FS = function(...) return F(S(...)) end
local mode = unilib.global.imported_mod_table.unimobs.add_mode

-- Table of players who currently have the formspec open, and the mob entity they're viewing
local player_table = {}
-- Widget colours, to match those in ../lib/system/petz/petz_formspecs.lua
local dark_bg_colour = "#222222"

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_hq_str(luaent)

    local str = ""

    for _, mini_table in ipairs(luaent.hqueue_list) do

        if str ~= "" then
            str = str .. ","
        end

        str = str .. mini_table.priority .. " " .. mini_table.name

    end

    return str

end

local function get_lq_str(luaent)

    local str = ""

    for _, mini_table in ipairs(luaent.lqueue_list) do

        if str ~= "" then
            str = str .. ","
        end

        str = str .. mini_table.name

    end

    return str

end

local function get_formspec(pname)

    local luaent = player_table[pname]
    if not luaent then
        return
    end

    local img
    if luaent.petz_compat_flag then
        img = "unilib_spawnegg_" .. luaent.mob_type .. ".png"
    else
        img = "unilib_admin_tool_mob_investigator.png"
    end

    local formspec = "size[8,6]" ..
        "box[0,0;0.85,1;" .. dark_bg_colour .. "]" ..
        "image[0.025,0.075;1,1;" .. img .. "]" ..
        "label[1.25,0.25;ID #" .. luaent._id .. "]" ..
        "button[6,0.05;1.95,1;refresh_btn;" .. FS("Refresh") .. "]" ..
        "label[0,1.25;" .. FS("High-level behaviour queue") .. "]" ..
        "textlist[0,1.8;3.75,3;hqb_list;" .. get_hq_str(luaent) .. "]" ..
        "label[4,1.25;" .. FS("Low-level behaviour queue") .. "]" ..
        "textlist[4,1.8;3.75,3;hqb_list;" .. get_lq_str(luaent) .. "]" ..
        "label[0,5;" .. FS("Internal status") .. "]" ..
        "box[0,5.5;3.75,0.5;" .. dark_bg_colour .. "]" ..
        "label[0.2,5.5;" .. ((luaent.petz_compat_flag and luaent.status) or FS("n/a")) .. "]" ..
        "label[4,5;" .. FS("Current animation") .. "]" ..
        "box[4,5.5;3.75,0.5;" .. dark_bg_colour .. "]" ..
        "label[4.2,5.5;" .. (luaent._anim or FS("n/a")) .. "]"

    return formspec

end

local function use_tool(user, luaent)

    -- Called when the player left-clicks a mob (or near a mob) while wielding this tool
    -- After basic checks, opens a formspec to show the mob's behaviour queues

    -- Basic checks. This tool will work on any unimobs mob, not just those using the petz API
    if not luaent or not unimobs.mobkit_api.is_object_alive(luaent.object) then
        return
    end

    local pname = user:get_player_name()
    player_table[pname] = luaent

    core.show_formspec(
        pname,
        "unilib:formspec_admin_tool_mob_investigator",
        get_formspec(pname)
    )

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.admin_tool_mob_investigator.init()

    return {
        description = "Admin mob investigation tool",
        notes = "Shows a mob's behaviour queues (for debugging purposes). Click a mob while" ..
                " wielding the tool; alternatively, click a nearby node or \"click\" the air." ..
                " This tool works on all unimobs creatures, not just those associated with the" ..
                " \"petz\" API",
    }

end

function unilib.pkg.admin_tool_mob_investigator.exec()

    unilib.register_tool("unilib:admin_tool_mob_investigator", nil, mode, {
        -- Original to unimobs
        description = S("Admin Mob Investigator"),
        inventory_image = "unilib_admin_tool_mob_investigator.png",
        groups = {not_in_creative_inventory = unilib.globalshow_admin_item_group},
        -- (no sounds)

        -- It's not OK to interact with water
        liquids_pointable = false,
        -- In common with other admin tools, forbid stacks
        stack_max = 1,
        wield_image = "",
        wield_scale = {x = 1, y = 1, z = 1},

        on_use = function(itemstack, user, pointed_thing)

            if user ~= nil and pointed_thing ~= nil then

                if pointed_thing.type == "object" then

                    use_tool(user, pointed_thing.ref:get_luaentity())

                elseif pointed_thing.type == "node" then

                    local closest_obj =
                            unimobs.mobkit_api.get_closest_entity_to_pos(pointed_thing.above)
                    if closest_obj then
                        use_tool(user, closest_obj:get_luaentity())
                    end

                elseif pointed_thing.type == "nothing" then

                    local closest_obj =
                            unimobs.mobkit_api.get_closest_entity_to_pos(user:get_pos())
                    if closest_obj then
                        use_tool(user, closest_obj:get_luaentity())
                    end

                end

            end

        end,
    })

    core.register_on_player_receive_fields(function(player, formname, fields)

        -- The player has interacted with our formspec
        if not formname or
                formname ~= "unilib:formspec_admin_tool_mob_investigator" or
                not fields then
            return false
        end

        local pname = player:get_player_name()

        if fields.refresh_btn then

            if player_table[pname] and unimobs.mobkit_api.is_object_alive(player_table[pname]) then

                core.show_formspec(
                    pname,
                    "unilib:formspec_admin_tool_mob_investigator",
                    get_formspec(pname)
                )

            end

        elseif fields.quit then

            player_table[pname] = nil

        end

        return true

    end)

    core.register_on_leaveplayer(function(player)
        player_table[player:get_player_name()] = nil
    end)

end
