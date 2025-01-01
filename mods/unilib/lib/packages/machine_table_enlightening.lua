---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.machine_table_enlightening = {}

local S = unilib.intllib
local FS = function(...) return core.formspec_escape(S(...)) end
local mode = unilib.global.imported_mod_table.unilib.add_mode

-- Cost in mese crystal(s) for each enlightenment
local mese_cost_min = 1
local mese_cost_max = 3
-- The cost of the next enlightenment (not visible to the player)
local mese_cost_next = math.random(mese_cost_min, mese_cost_max)

-- A value in the range 1-4:
--  1 - no neighbouring lava sources
--  2 - up to 5 lava sources
--  3 - up to 10 lava sources
--  4 - up to 15 lava sources
local current_lava_level = 1
-- The "glow" on an enlightened tool is handle by an overlay texture whose opacity is the lava
--      level, multiplied by this factor (therefore, a value in the range 25-100). Used only when
--      unilib.setting.xdecor_glow_flag is false
local glow_factor = 25
-- Partial hints for each level of enlightenment, visible in descriptions
local hint_list = ({S("glowing faintly"), S("glowing dimly"), S("glowing"), S("glowing strongly")})

---------------------------------------------------------------------------------------------------
-- Local functions (register tools)
---------------------------------------------------------------------------------------------------

local function register_tool(full_name)

    -- Original to unilib; adapted from xdecor, enchanting:register_tools()

    local def_table = core.registered_tools[full_name]
    if not def_table then
        return
    end

    for lava_level = 1, 4 do

        local adj_full_name = full_name .. "_enlightened_" .. lava_level
        local adj_def_table = unilib.utils.clone_simple_table(def_table)

        if def_table.original_description ~= nil then

            adj_def_table.description = unilib.utils.brackets(
                def_table.original_description, hint_list[lava_level]
            )

            adj_def_table.original_description = def_table.original_description

        else

            adj_def_table.description = unilib.utils.brackets(
                def_table.description, hint_list[lava_level]
            )

        end

        adj_def_table.groups = table.copy(def_table.groups)
        adj_def_table.groups.not_in_creative_inventory = 1

        if unilib.setting.xdecor_glow_flag then

            -- Original xdecor glow (the same for all tools)
            adj_def_table.inventory_image = def_table.inventory_image .. "^[colorize:red:50"
            if def_table.groups.shovel ~= nil then

                -- (Shovel wield images are rotated)
                adj_def_table.wield_image = def_table.wield_image ..
                        "^[colorize:red:50^[transformR90"

            end

        else

            -- unilib's original glow (only the metal "glows", and the glow intensity varies)
            local opacity = tostring(lava_level * glow_factor)
            -- Many tools use a texture with a consistent shape, in which case we can use a standard
            --      overlay texture (e.g. "unilib_tool_axe_enlightened_overlay.png") to create the
            --      "enlightened" effect
            -- Some tools have their own unique shapes. In thses cases, unilib provides special
            --      overlay textures, one for each tool (e.g. "unilib_tool_spear_adamantite.png"
            --      from xtraores uses the special overlay
            --      "unilib_tool_spear_adamantite_enlightened_overlay.png")
            local special_overlay
            if def_table.inventory_image then

                local _, filename, ext = unilib.utils.split_path(def_table.inventory_image)
                special_overlay = filename .. "_enlightened_overlay" ..ext

            end

            if special_overlay and unilib.utils.is_texture(special_overlay) then

                adj_def_table.inventory_image = def_table.inventory_image .. "^(" ..
                        special_overlay .. "^[opacity:" .. opacity .. ")"
                if def_table.groups.shovel ~= nil then

                    -- (Shovel wield images are rotated)
                    adj_def_table.wield_image = def_table.wield_image .. "^(" .. special_overlay ..
                            "^[opacity:" .. opacity .. "^[transformR90)"

                end

            -- Chainsaws have the "axe" group (as well as "chainsaw"), and drills have the "pickaxe"
            --      group (as well as "drill"), so they must be checked first
            elseif def_table.groups.chainsaw ~= nil then

                adj_def_table.inventory_image = def_table.inventory_image ..
                        "^(unilib_tool_chainsaw_enlightened_overlay.png^[opacity:" .. opacity .. ")"

            elseif def_table.groups.drill ~= nil then

                adj_def_table.inventory_image = def_table.inventory_image ..
                        "^(unilib_tool_drill_enlightened_overlay.png^[opacity:" .. opacity .. ")"

            elseif def_table.groups.axe ~= nil then

                adj_def_table.inventory_image = def_table.inventory_image ..
                        "^(unilib_tool_axe_enlightened_overlay.png^[opacity:" .. opacity .. ")"

            elseif def_table.groups.hoe ~= nil then

                adj_def_table.inventory_image = def_table.inventory_image ..
                        "^(unilib_tool_hoe_enlightened_overlay.png^[opacity:" .. opacity .. ")"

            elseif def_table.groups.pickaxe ~= nil then

                adj_def_table.inventory_image = def_table.inventory_image ..
                        "^(unilib_tool_pick_enlightened_overlay.png^[opacity:" .. opacity .. ")"

            elseif def_table.groups.scythe ~= nil then

                adj_def_table.inventory_image = def_table.inventory_image ..
                        "^(unilib_tool_scythe_enlightened_overlay.png^[opacity:" .. opacity .. ")"

            elseif def_table.groups.sickle ~= nil then

                adj_def_table.inventory_image = def_table.inventory_image ..
                        "^(unilib_tool_sickle_enlightened_overlay.png^[opacity:" .. opacity .. ")"

            elseif def_table.groups.shovel ~= nil then

                adj_def_table.inventory_image = def_table.inventory_image ..
                        "^(unilib_tool_shovel_enlightened_overlay.png^[opacity:" .. opacity .. ")"
                -- (Shovel wield images are rotated)
                adj_def_table.wield_image = def_table.wield_image ..
                        "^(unilib_tool_shovel_enlightened_overlay.png^[opacity:" .. opacity ..
                        "^[transformR90)"

            elseif def_table.groups.spear ~= nil then

                adj_def_table.inventory_image = def_table.inventory_image ..
                        "^(unilib_tool_spear_enlightened_overlay.png^[opacity:" .. opacity .. ")"

            elseif def_table.groups.sword ~= nil then

                adj_def_table.inventory_image = def_table.inventory_image ..
                        "^(unilib_tool_sword_enlightened_overlay.png^[opacity:" .. opacity .. ")"

            end

        end

        if lava_level == 1 then
            adj_def_table.light_source = 3
        elseif lava_level == 2 then
            adj_def_table.light_source = 6
        elseif lava_level == 3 then
            adj_def_table.light_source = 9
        else
            adj_def_table.light_source = 12
        end

        adj_def_table.after_use = unilib.tools.after_use

        unilib.register_tool(adj_full_name, nil, mode, adj_def_table)
        unilib.tools.apply_toolranks(adj_full_name, def_table.tool_type)

    end

end

---------------------------------------------------------------------------------------------------
-- Local functions (enlighten tools)
---------------------------------------------------------------------------------------------------

local function set_formspec(pos)

    -- Original to unilib

    local pick_img
    if unilib.setting.xdecor_glow_flag then

        pick_img = "unilib_tool_pick_steel.png^[colorize:red:50"

    else

        pick_img = "unilib_tool_pick_steel.png" ..
                "^(unilib_tool_pick_enlightened_overlay.png^[opacity:" .. glow_factor * 3 .. ")"

    end

    local meta = core.get_meta(pos)
    local formspec = "size[8,7.5]" ..
            "label[0,0;" .. FS("Enlightening Table") .. "]" ..
            "image[1,1;1,1;unilib_tool_pick_steel.png]" ..
            "list[current_name;tool;2,1;1,1;]" ..
            "image[1,2;1,1;unilib_mineral_mese_crystal.png]" ..
            "list[current_name;mese;2,2;1,1;]" ..
            "button[3.5,1.5;1,1;press;>>]" ..
            "image[5,1.5;1,1;" .. pick_img .. "]" ..
            "list[current_name;output;6,1.5;1,1;]" ..
            "list[current_player;main;0,3.5;8,4;]" ..
            "listring[current_player;main]" ..
            "listring[current_name;tool]" ..
            "listring[current_player;main]" ..
            "listring[current_name;mese]" ..
            "listring[current_player;main]" ..
            "listring[current_name;output]" ..
            "listring[current_player;main]"

    meta:set_string("formspec", formspec)

end

local function on_receive_fields(pos, formname, fields, sender)

    -- Original to unilib; adapted from xdecor, enchanting.fields()

    if not fields.press then
        return
    end

    local inv = core.get_meta(pos):get_inventory()
    local tool = inv:get_stack("tool", 1)
    local mese = inv:get_stack("mese", 1)
    local output = inv:get_stack("output", 1)
    if output:get_count() ~= 0 then
        return
    end

    local orig_wear = tool:get_wear()
    local orig_table = tool:get_meta():to_table()

    local enlightened_name = tool:get_name() .. "_enlightened_" .. current_lava_level
    if mese:get_count() >= mese_cost_next and core.registered_tools[enlightened_name] then

        core.sound_play("unilib_machine_table_enchanting_simple", {
            to_player = sender:get_player_name(),
            gain = 0.8,
        })

        tool:replace(enlightened_name)
        tool:add_wear(orig_wear)
        -- Retain the old item's toolranks data...
        unilib.utils.clone_metadata(orig_table, tool)
        -- ...but reset the metadata description
        if unilib.setting.toolranks_enable_flag then
            unilib.tools.update_toolranks_description(tool)
        end

        mese:take_item(mese_cost_next)
        inv:set_stack("tool", 1, ItemStack(""))
        inv:set_stack("mese", 1, mese)
        inv:set_stack("output", 1, tool)

        -- The next enlightenment will have a different cost
        mese_cost_next = math.random(mese_cost_min, mese_cost_max)

    end

end

local function can_dig(pos)

    -- Original to unilib; adapted from xdecor, enchanting.dig()

    local inv = core.get_meta(pos):get_inventory()
    return inv:is_empty("tool") and inv:is_empty("mese") and inv:is_empty("output")

end

local function is_allowed(tool)

    -- Original to unilib; adapted from xdecor, allowed()

    if not tool then
        return
    end

    for item in pairs(core.registered_tools) do

        if item:find(tool .. "_enlightened") then
            return true
        end

    end

end

local function allow_metadata_inventory_put(_, listname, _, stack)

    -- Original to unilib; adapted from xdecor, enchanting.put()

    local stackname = stack:get_name()
    if listname == "mese" and (
        stackname == "unilib:mineral_mese_crystal" or stackname == "default:mese_crystal"
    ) then
        return stack:get_count()
    elseif listname == "tool" and is_allowed(stackname:match("[^:]+$")) then
        return 1
    end

    return 0

end

local function on_construct(pos)

    -- Original to unilib; adapted from xdecor, enchanting.construct()

    local meta = core.get_meta(pos)
    meta:set_string("infotext", S("Enlightening Table"))

    local inv = meta:get_inventory()
    inv:set_size("tool", 1)
    inv:set_size("mese", 1)
    inv:set_size("output", 1)

    set_formspec(pos)

    core.add_entity(
        {x = pos.x, y = pos.y + 0.85, z = pos.z},
        "unilib:entity_machine_table_enlightening"
    )

    local timer = core.get_node_timer(pos)
    timer:start(0.5)

end

local function on_destruct(pos)

    -- Original to unilib; adapted from xdecor, enchanting.destruct()

    for _, obj in pairs(core.get_objects_inside_radius(pos, 0.9)) do

        if obj and
                obj:get_luaentity() and
                obj:get_luaentity().name == "unilib:entity_machine_table_enlightening" then

            obj:remove()
            break

        end

    end

end

local function on_timer(pos)

    -- Original to unilib; adapted from xdecor, enchanting.timer()

    local minp = {x = pos.x - 2, y = pos.y - 1, z = pos.z - 2}
    local maxp = {x = pos.x + 2, y = pos.y,     z = pos.z + 2}

    local lava_list = core.find_nodes_in_area(
        minp,
        maxp,
        {
            "unilib:liquid_lava_cooling_source",
            "lib_materials:liquid_lava_cooling_source",
            "unilib:liquid_lava_ordinary_source",
            "default:lava_source",
        }
    )

    local lava_count = #lava_list
    if lava_count == 0 then

        current_lava_level = 1
        return true

    elseif lava_count <= 5 then

        current_lava_level = 2

    elseif lava_count <= 10 then

        current_lava_level = 3

    else

        current_lava_level = 4

    end

    local lava_pos = lava_list[math.random(1, #lava_list)]
    local x = pos.x - lava_pos.x
    local y = lava_pos.y - pos.y
    local z = pos.z - lava_pos.z

    if tostring(x .. z):find(2) then

        core.add_particle({
            acceleration = {x = 0, y = -2.2, z = 0},
            expirationtime = 1,
            glow = 5,
            pos = lava_pos,
            size = 1.5,
            texture = "unilib_crack_lava_overlay.png",
            velocity = {x = x, y = 2 - y, z = z},
        })

    end

    return true

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.machine_table_enlightening.init()

    return {
        description = "Enlightening table",
        notes = "Uses mese crystals to convert compatible tools into glowing versions of" ..
                " themselves. Each enlightenment costs up to three crystals. Placing up to" ..
                " fifteen lava sources around the table increases the magnitude of the glow (but" ..
                " no air gap is required; note that the sources can placed at the same" ..
                " horizontal level as the table, or just below it). Currently compatible with" ..
                " all unilib axes, chainsaws, drills, hoes, pickaxes, scythes, shovels, sickles," ..
                " spears and swords (but not tools from other mods)",
        depends = {"mineral_diamond", "mineral_mese", "stone_obsidian"},
        optional = {"liquid_lava_cooling", "liquid_lava_ordinary", "shared_screwdriver"},
    }

end

function unilib.pkg.machine_table_enlightening.exec()

    local c_diamond = "unilib:mineral_diamond_gem"
    local c_obsidian = "unilib:stone_obsidian"
    local c_torch = "unilib:torch_ordinary"

    unilib.register_node("unilib:machine_table_enlightening", nil, mode, {
        -- Original to unilib
        description = S("Enlightening Table"),
        tiles = {
            "unilib_machine_table_enlightening_top.png",
            "unilib_machine_table_enchanting_simple_bottom.png",
            "unilib_machine_table_enlightening_side.png",
            "unilib_machine_table_enlightening_side.png",
            "unilib_machine_table_enlightening_side.png",
            "unilib_machine_table_enlightening_side.png",
        },
        groups = {cracky = 1, level = 1},
        sounds = unilib.global.sound_table.stone,

        is_ground_content = false,
        light_source = 6,
        paramtype = "light",
        paramtype2 = "facedir",

        allow_metadata_inventory_move = function()
            return 0
        end,

        allow_metadata_inventory_put = allow_metadata_inventory_put,

        can_dig = can_dig,

        on_construct = on_construct,

        on_destruct = on_destruct,

        on_receive_fields = on_receive_fields,

        on_timer = on_timer,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:machine_table_enlightening",
        recipe = {
            {"", c_torch, ""},
            {c_diamond, c_obsidian, c_diamond},
            {c_obsidian, c_obsidian, c_obsidian},
        },
    })

    if unilib.global.pkg_executed_table["shared_screwdriver"] ~= nil then

        unilib.override_item("unilib:machine_table_enlightening", {
            on_rotate = unilib.pkg.shared_screwdriver.rotate_simple,
        })

    end

    unilib.register_entity("unilib:entity_machine_table_enlightening", {
        -- Original to unilib, adapted from xdecor:book_open
        initial_properties = {
            collisionbox = {0},
            physical = false,
            static_save = false,
            textures = {"unilib_bucket_steel_empty.png^unilib_bucket_lava_ordinary_overlay.png"},
            visual = "sprite",
            visual_size = {x = 0.75, y = 0.75},
        },
    })

    unilib.register_lbm({
        -- Original to unilib, adapted from the code in xdecor/src/enchanting.lua
        label = "Recreate enlightening table book [machine_table_enlightening]",
        name = "unilib:lbm_machine_table_enlightening",
        nodenames = {"unilib:machine_table_enlightening"},

        run_at_every_load = true,

        action = function(pos, node)

            local objs = core.get_objects_inside_radius(pos, 0.9)

            for _, obj in ipairs(objs) do

                local e = obj:get_luaentity()
                if e and e.name == "unilib:entity_machine_table_enlightening" then
                    return
                end

            end

            core.add_entity(
                {x = pos.x, y = pos.y + 0.85, z = pos.z},
                "unilib:entity_machine_table_enlightening"
            )

        end,
    })

end

function unilib.pkg.machine_table_enlightening.post()

    -- Note that we don't enlightend wooden/stone tools, but only ones crafted from metals and
    --      minerals
    for _, material in pairs({
        "adamantite", "bronze", "crystallite", "diamond", "emerald", "geminitium", "mese",
        "mithril", "ozymandium", "planexium", "rarium", "ruby", "sapphire", "silver", "steel",
        "sybilline", "tritonium", "unobtainium",
    }) do

        for _, tool in pairs({
            "axe", "chainsaw", "drill", "hoe", "pick", "scythe", "shovel", "sickle", "spear",
            "sword",
        }) do
            register_tool("unilib:tool_" .. tool .. "_" .. material)
        end

    end

end
