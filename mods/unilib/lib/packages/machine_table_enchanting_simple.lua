---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.machine_table_enchanting_simple = {}

local S = unilib.intllib
local FS = function(...) return core.formspec_escape(S(...)) end
local mode = unilib.global.imported_mod_table.xdecor.add_mode

-- Cost in mese crystal(s) for each enchantment
local mese_cost_min = 1
local mese_cost_max = 3
-- The cost of the next enchantment (not visible to the player)
local mese_cost_next = math.random(mese_cost_min, mese_cost_max)

-- Magnitude of each enchantment, increased by the presence of bookshelves within two blocks of the
--      enchantment table (unlike in Minecraft, no air gap is required)
local enchantment_obj = {
    -- Durability (original mod improvement = 1.2)
    uses     = {1.1, 1.2, 1.3, 1.4},
    -- Efficiency (original mod improvement = 0.1)
    times    = {0.05, 0.1, 0.15, 0.2},
    -- Sharpness (original mod improvement = 1)
    damages  = {0.5, 1, 1.5, 2},
}

-- A value in the range 1-4:
--  1 - no neighbouring bookshelves
--  2 - up to 5 bookshelves
--  3 - up to 10 bookshelves
--  4 - up to 15 bookshelves
local current_bookshelf_level = 1
-- The "glow" on an enchanted tool is handle by an overlay texture whose opacity is the bookshelf
--      level, multiplied by this factor (therefore, a value in the range 25-100). Used only when
--      unilib.setting.xdecor_glow_flag is false
local glow_factor = 25

-- N.B. Tweaked the position of buttons in the formspec, to stop them overwriting the background
--[[
local enchant_button_list = {
    "image_button[3.9,0.85;4,0.92;bg_btn.png;fast;" .. FS("Efficiency") .. "]" ..
    "image_button[3.9,1.77;4,1.12;bg_btn.png;durable;" .. FS("Durability") .. "]",
    "image_button[3.9,2.9;4,0.92;bg_btn.png;sharp;" .. FS("Sharpness") .. "]",
}
]]--
local enchant_button_list = {
    "image_button[3.9,0.7;4,0.8;unilib_machine_table_enchanting_simple_button.png;fast;" ..
            FS("Efficiency") .. "]" ..
    "image_button[3.9,1.78;4,0.8;unilib_machine_table_enchanting_simple_button.png;durable;" ..
            FS("Durability") .. "]",
    "image_button[3.9,2.85;4,0.8;unilib_machine_table_enchanting_simple_button.png;sharp;" ..
            FS("Sharpness") .. "]",
}

---------------------------------------------------------------------------------------------------
-- Local functions (misc)
---------------------------------------------------------------------------------------------------

local function to_percent(orig_value, final_value)

    return math.abs(math.ceil(((final_value - orig_value) / orig_value) * 100))

end

---------------------------------------------------------------------------------------------------
-- Local functions (register tools)
---------------------------------------------------------------------------------------------------

function enchantment_obj:get_tooltip(enchant, orig_caps_table, fleshy, bookshelf_level)

    -- Was enchanting:get_tooltip()
    --
    -- Args:
    --      enchant (str): e.g. "fast"
    --      orig_caps_table (table): Original tool's .tool_capabilities table
    --      fleshy (int): e.g. 4

    local bonus_table = {durable = 0, efficiency = 0, damages = 0}

    if orig_caps_table then

        -- durable
        bonus_table.durable = to_percent(
            orig_caps_table.uses,
            orig_caps_table.uses * enchantment_obj["uses"][bookshelf_level]
        )

        -- fast
        local sum_caps_times = 0
        for i = 1, #orig_caps_table.times do
            sum_caps_times = sum_caps_times + orig_caps_table.times[i]
        end

        local average_caps_time = sum_caps_times / #orig_caps_table.times
        bonus_table.efficiency = to_percent(
            average_caps_time,
            average_caps_time - enchantment_obj["times"][bookshelf_level]
        )

    end

    if fleshy then

        -- sharp
        bonus_table.damages = to_percent(
            fleshy,
            fleshy + enchantment_obj["damages"][bookshelf_level]
        )

    end

    local specs_table = {
        durable = {"#00baff", " (+" .. bonus_table.durable .. "%)"},
        fast    = {"#74ff49", " (+" .. bonus_table.efficiency .. "%)"},
        sharp   = {"#ffff00", " (+" .. bonus_table.damages .. "%)"},
    }

    local description_table = {
        fast = S("Efficiency"),
        durable = S("Durability"),
        sharp = S("Sharpness"),
    }

    return core.colorize and core.colorize(
        specs_table[enchant][1],
        "\n" .. description_table[enchant] .. specs_table[enchant][2]
    ) or "\n" .. description_table[enchant] .. specs_table[enchant][2]

end

function enchantment_obj:register_tools(data_table)

    -- Was enchanting:register_tools()

    for tool_type, _ in pairs(data_table.tool_table) do

        for _, material in pairs(data_table.material_list) do

            local tool_name = "unilib:tool_" .. tool_type .. "_" .. material
            local tool_def_table = core.registered_tools[tool_name]
            if not tool_def_table then
                break
            end

            for _, enchant in pairs(data_table.tool_table[tool_type]["enchant_list"]) do

                for bookshelf_level = 1, 4 do

                    -- N.B. In the original code, the enchanted tool didn't inherit groups from its
                    --      parent unenchanted tool
                    local group_table = table.copy(tool_def_table.groups)
                    group_table.not_in_creative_inventory = 1

                    local toolcap_def_table = tool_def_table.tool_capabilities
                    if toolcap_def_table then

                        local original_damage_groups = toolcap_def_table.damage_groups
                        local original_groupcaps = toolcap_def_table.groupcaps
                        local groupcaps = table.copy(original_groupcaps)
                        local fleshy = original_damage_groups.fleshy
                        local full_punch_interval = toolcap_def_table.full_punch_interval
                        local max_drop_level = toolcap_def_table.max_drop_level
                        local group = next(original_groupcaps)

                        if enchant == "durable" then

                            groupcaps[group].uses = math.ceil(
                                original_groupcaps[group].uses *
                                enchantment_obj["uses"][bookshelf_level]
                            )

                        elseif enchant == "fast" then

                            for i, time in pairs(original_groupcaps[group].times) do

                                groupcaps[group].times[i] =
                                        time - enchantment_obj["times"][bookshelf_level]

                            end

                        elseif enchant == "sharp" then

                            fleshy = fleshy + enchantment_obj["damages"][bookshelf_level]

                        end

                        local inventory_image, wield_image
                        if unilib.setting.xdecor_glow_flag then

                            -- Original xdecor glow (the same for all tools)
                            inventory_image =
                                    tool_def_table.inventory_image .. "^[colorize:violet:50"
                            if tool_def_table.groups.shovel ~= nil then

                                -- (Shovel wield images are rotated)
                                wield_image = tool_def_table.wield_image ..
                                        "^[colorize:violet:50^[transformR90"

                            end

                        else

                            -- unilib's original glow (only the metal "glows", and the glow
                            --      intensity varies)
                            local opacity = tostring(bookshelf_level * glow_factor)
                            -- Many tools use a texture with a consistent shape, in which case we
                            --      can use a standard overlay texture (e.g.
                            --      "unilib_tool_axe_enchanted_overlay.png") to create the
                            --      "enchanted" effect
                            -- Some tools have their own unique shapes. In thses cases, unilib
                            --      provides special overlay textures, one for each tool (e.g.
                            --      "unilib_tool_spear_adamantite.png" from xtraores uses the
                            --      special overlay
                            --      "unilib_tool_spear_adamantite_enchanted_overlay.png")
                            local special_overlay
                            if tool_def_table.inventory_image then

                                local _, filename, ext =
                                        unilib.utils.split_path(tool_def_table.inventory_image)
                                special_overlay = filename .. "_enchanted_overlay" ..ext

                            end

                            if special_overlay and unilib.utils.is_texture(special_overlay) then

                                inventory_image = tool_def_table.inventory_image .. "^(" ..
                                        special_overlay .. "^[opacity:" .. opacity .. ")"
                                if tool_def_table.groups.shovel ~= nil then

                                    -- (Shovel wield images are rotated)
                                    wield_image = tool_def_table.wield_image .. "^(" ..
                                            special_overlay .. "^[opacity:" .. opacity ..
                                            "^[transformR90)"

                                end

                            elseif tool_def_table.groups.axe ~= nil then

                                inventory_image = tool_def_table.inventory_image ..
                                        "^(unilib_tool_axe_enchanted_overlay.png^[opacity:" ..
                                        opacity .. ")"

                            elseif tool_def_table.groups.pickaxe ~= nil then

                                inventory_image = tool_def_table.inventory_image ..
                                        "^(unilib_tool_pick_enchanted_overlay.png^[opacity:" ..
                                        opacity .. ")"

                            elseif tool_def_table.groups.shovel ~= nil then

                                inventory_image = tool_def_table.inventory_image ..
                                        "^(unilib_tool_shovel_enchanted_overlay.png^[opacity:" ..
                                        opacity .. ")"
                                -- (Shovel wield images are rotated)
                                wield_image = tool_def_table.wield_image ..
                                        "^(unilib_tool_shovel_enchanted_overlay.png^[opacity:" ..
                                        opacity .. "^[transformR90)"

                            elseif tool_def_table.groups.sword ~= nil then

                                inventory_image = tool_def_table.inventory_image ..
                                        "^(unilib_tool_sword_enchanted_overlay.png^[opacity:" ..
                                        opacity .. ")"

                            end

                        end

                        local adj_tool_name = tool_name .. "_enchanted_" .. enchant .. "_" ..
                                bookshelf_level

                        local description, original_description
                        if tool_def_table.original_description ~= nil then

                            description = tool_def_table.original_description
                            original_description = tool_def_table.description

                        else

                            description = tool_def_table.description

                        end

                        unilib.register_tool(adj_tool_name, nil, mode, {
                            description = S(
                                "@1 @2",
                                unilib.utils.brackets(description, S("enchanted")),
                                self:get_tooltip(
                                    enchant, original_groupcaps[group], fleshy, bookshelf_level
                                )
                            ),
                            inventory_image = inventory_image,
                            groups = group_table,
                            sound = tool_def_table.sound,

                            original_description = original_description,

                            tool_capabilities = {
                                damage_groups = {fleshy = fleshy},
                                full_punch_interval = full_punch_interval,
                                groupcaps = groupcaps,
                                max_drop_level = max_drop_level,
                            },

                            wield_image = wield_image,

                            after_use = unilib.tools.after_use,
                        })
                        unilib.tools.apply_toolranks(adj_tool_name, tool_def_table.tool_type)

                    end

                end

            end

        end

    end

end

---------------------------------------------------------------------------------------------------
-- Local functions (enchant tools)
---------------------------------------------------------------------------------------------------

local function set_formspec(pos, num)

    -- Was enchanting.formspec()

    local meta = core.get_meta(pos)
    local formspec = [[
        size[9,8.6;]
        no_prepend[]
        bgcolor[#080808BB;true]
        listcolors[#00000069;#5A5A5A;#141318;#30434C;#FFF]
        background9[0,0;9,9;unilib_machine_table_enchanting_simple_bg.png;6]
        list[context;tool;0.9,2.9;1,1;]
        list[context;mese;2,2.9;1,1;]
        list[current_player;main;0.55,4.5;8,4;]
        listring[current_player;main]
        listring[context;tool]
        listring[current_player;main]
        listring[context;mese]
        image[2,2.9;1,1;unilib_machine_table_enchanting_simple_layout.png]
        ]]
        .. "tooltip[sharp;" .. FS("Your weapon inflicts more damage") .. "]"
        .. "tooltip[durable;" .. FS("Your tool last longer") .. "]"
        .. "tooltip[fast;" .. FS("Your tool digs faster") .. "]"
        .. unilib.misc.get_hotbar_bg(0.55, 4.5)

    formspec = formspec .. (enchant_button_list[num] or "")
    meta:set_string("formspec", formspec)

end

local function on_put(pos, listname, _, stack)

    -- Was enchanting.on_put()

    if listname == "tool" then

        local stackname = stack:get_name()
        -- Axes/picks/shovels can increase durability/efficiency; swords can increase sharpness
        local tool_groups = {
            "axe, pick, shovel",
            "sword",
        }

        for idx, tools in ipairs(tool_groups) do

            if tools:find(stackname:match(":tool_(%w+)")) then
                set_formspec(pos, idx)
            end

        end

    end

end

local function on_receive_fields(pos, _, fields, sender)

    -- Was enchanting.fields()

    if not next(fields) or fields.quit then
        return
    end

    local inv = core.get_meta(pos):get_inventory()
    local tool = inv:get_stack("tool", 1)
    local mese = inv:get_stack("mese", 1)

    local orig_wear = tool:get_wear()
    local orig_table = tool:get_meta():to_table()
    -- (In the cloning code below, don't overwrite the replacement tool's description)
    if orig_table.fields then
        orig_table.fields.description = nil
    end

    local tool_name = tool:get_name()
    local mod_name = unilib.utils.get_mod_name(tool_name)
    local item_name = unilib.utils.get_item_name(tool_name)
    local enchanted_tool = (mod_name or "") .. ":" .. (item_name or "") .. "_enchanted_" ..
            next(fields) .. "_" .. current_bookshelf_level

    if mese:get_count() >= mese_cost_next and core.registered_tools[enchanted_tool] then

        core.sound_play("unilib_machine_table_enchanting_simple", {
            to_player = sender:get_player_name(),
            gain = 0.8,
        })

        tool:replace(enchanted_tool)
        tool:add_wear(orig_wear)
        -- Retain the old item's toolranks data...
        unilib.utils.clone_metadata(orig_table, tool)
        -- ...but reset the metadata description
        if unilib.setting.toolranks_enable_flag then
            unilib.tools.update_toolranks_description(tool)
        end

        mese:take_item(mese_cost_next)
        inv:set_stack("mese", 1, mese)
        inv:set_stack("tool", 1, tool)

        -- The next enchantment will have a different cost
        mese_cost_next = math.random(mese_cost_min, mese_cost_max)

    end

end

local function can_dig(pos)

    -- Was enchanting.dig()

    local inv = core.get_meta(pos):get_inventory()
    return inv:is_empty("tool") and inv:is_empty("mese")

end

local function is_allowed(tool)

    -- Was allowed()

    if not tool then
        return
    end

    for item in pairs(core.registered_tools) do

        if item:find(tool .. "_enchanted") then
            return true
        end

    end

end

local function allow_metadata_inventory_put(_, listname, _, stack)

    -- Was enchanting.put()

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

local function on_metadata_inventory_take(pos, listname)

    -- Was enchanting.on_take()

    if listname == "tool" then
        set_formspec(pos)
    end

end

local function on_construct(pos)

    -- Was enchanting.construct()

    local meta = core.get_meta(pos)
    meta:set_string("infotext", S("Simple Enchanting Table"))
    set_formspec(pos)

    local inv = meta:get_inventory()
    inv:set_size("tool", 1)
    inv:set_size("mese", 1)

    core.add_entity(
        {x = pos.x, y = pos.y + 0.85, z = pos.z},
        "unilib:entity_machine_table_enchanting_simple"
    )

    local timer = core.get_node_timer(pos)
    timer:start(0.5)

end

local function on_destruct(pos)

    -- Was enchanting.destruct()

    for _, obj in pairs(core.get_objects_inside_radius(pos, 0.9)) do

        if obj and
                obj:get_luaentity() and
                obj:get_luaentity().name == "unilib:entity_machine_table_enchanting_simple" then

            obj:remove()
            break

        end

    end

end

local function on_timer(pos)

    -- Was enchanting.timer()

    local minp = {x = pos.x - 2, y = pos.y,     z = pos.z - 2}
    local maxp = {x = pos.x + 2, y = pos.y + 1, z = pos.z + 2}

    local bookshelf_list = core.find_nodes_in_area(
        minp,
        maxp,
        {"group:bookshelf", "default:bookshelf"}
    )

    local bookshelf_count = #bookshelf_list
    if bookshelf_count == 0 then

        current_bookshelf_level = 1
        return true

    elseif bookshelf_count <= 5 then

        current_bookshelf_level = 2

    elseif bookshelf_count <= 10 then

        current_bookshelf_level = 3

    else

        current_bookshelf_level = 4

    end

    local bookshelf_pos = bookshelf_list[math.random(1, #bookshelf_list)]
    local x = pos.x - bookshelf_pos.x
    local y = bookshelf_pos.y - pos.y
    local z = pos.z - bookshelf_pos.z

    if tostring(x .. z):find(2) then

        core.add_particle({
            acceleration = {x = 0, y = -2.2, z = 0},
            expirationtime = 1,
            glow = 5,
            pos = bookshelf_pos,
            size = 1.5,
            texture = "unilib_machine_table_enchanting_simple_glyph_" ..
                    math.random(1, 18) .. ".png",
            velocity = {x = x, y = 2 - y, z = z},
        })

    end

    return true

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.machine_table_enchanting_simple.init()

    return {
        description = "Simple enchanting table",
        notes = "Use mese crystals to enchant a selection of simple tools. Each enchantment" ..
                " costs up to three crystals. Placing up to fifteen bookshelves around the able" ..
                " increases the magnitude of the enchantment (but no air gap is required). Note" ..
                " that toolranks, if enabled, don't apply to tools enchanted with this table." ..
                " Currently compatible with a selection of unilib axes, pickaxes, shovels and" ..
                " swords (but not tools from other mods)",
        depends = {"mineral_diamond", "mineral_mese", "stone_obsidian"},
        optional = {"furniture_shelf_bookshelf", "shared_screwdriver"},
    }

end

function unilib.pkg.machine_table_enchanting_simple.exec()

    local c_book = "unilib:item_book_ordinary"
    local c_diamond = "unilib:mineral_diamond_gem"
    local c_obsidian = "unilib:stone_obsidian"

    unilib.register_node(
        -- From xdecor:enchantment_table
        "unilib:machine_table_enchanting_simple",
        "xdecor:enchantment_table",
        mode,
        {
            description = S("Simple Enchanting Table"),
            tiles = {
                "unilib_machine_table_enchanting_simple_top.png",
                "unilib_machine_table_enchanting_simple_bottom.png",
                "unilib_machine_table_enchanting_simple_side.png",
                "unilib_machine_table_enchanting_simple_side.png",
                "unilib_machine_table_enchanting_simple_side.png",
                "unilib_machine_table_enchanting_simple_side.png",
            },
            groups = {cracky = 1, level = 1},
            sounds = unilib.global.sound_table.stone,

            -- N.B. is_ground_content = false not in original code
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

            on_metadata_inventory_put = on_put,

            on_metadata_inventory_take = on_metadata_inventory_take,

            on_receive_fields = on_receive_fields,

            on_timer = on_timer,
        }
    )
    unilib.register_craft({
        -- From xdecor:enchantment_table
        output = "unilib:machine_table_enchanting_simple",
        recipe = {
            {"", c_book, ""},
            {c_diamond, c_obsidian, c_diamond},
            {c_obsidian, c_obsidian, c_obsidian},
        },
    })

    if unilib.global.pkg_executed_table["shared_screwdriver"] ~= nil then

        unilib.override_item("unilib:machine_table_enchanting_simple", {
            on_rotate = unilib.pkg.shared_screwdriver.rotate_simple,
        })

    end

    unilib.register_entity("unilib:entity_machine_table_enchanting_simple", {
        -- From xdecor:book_open
        initial_properties = {
            collisionbox = {0},
            physical = false,
            static_save = false,
            textures = {"unilib_machine_table_enchanting_simple_book.png"},
            visual = "sprite",
            visual_size = {x = 0.75, y = 0.75},
        },
    })

    unilib.register_lbm({
        -- From /src/enchanting.lua
        label = "Recreate enchanting table book [machine_table_enchanting_simple]",
        name = "unilib:lbm_machine_table_enchanting_simple",
        nodenames = {"unilib:machine_table_enchanting_simple"},

        run_at_every_load = true,

        action = function(pos, node)

            local objs = core.get_objects_inside_radius(pos, 0.9)

            for _, obj in ipairs(objs) do

                local e = obj:get_luaentity()
                if e and e.name == "unilib:entity_machine_table_enchanting_simple" then
                    return
                end

            end

            core.add_entity(
                {x = pos.x, y = pos.y + 0.85, z = pos.z},
                "unilib:entity_machine_table_enchanting_simple"
            )

        end,
    })

end

function unilib.pkg.machine_table_enchanting_simple.post()

    -- As this is a simple enchantment table, then as in the original, only a selection of
    --      minetest_game tools can be enchanted
    enchantment_obj:register_tools({
        material_list = {"bronze", "diamond", "mese", "steel"},
        tool_table = {
            axe = {enchant_list = {"durable", "fast"}, desc = S("Axe")},
            pick = {enchant_list = {"durable", "fast"}, desc = S("Pickaxe")},
            shovel = {enchant_list = {"durable", "fast"}, desc = S("Shovel")},
            sword = {enchant_list = {"sharp"}, desc = S("Sword")},
        },
    })

end
