---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights_extras
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_super_with_spotlight = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.morelights_extras.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_light(block_name)

    local orig_name
    if block_name == "unilib:stone_ordinary_block" then
        orig_name = "morelights_extras:stone_block"
    elseif block_name == "unilib:stone_sandstone_ordinary_block" then
        orig_name = "morelights_extras:sandstone_block"
    end

    local full_name = block_name .. "_with_spotlight"
    local def_table = core.registered_nodes[block_name]

    unilib.register_node(full_name, orig_name, mode, {
        -- From morelights_extras:stone_block
        description = unilib.utils.brackets(S("Stone Spotlight"), def_table.description),
        tiles = {def_table.tiles[1] .. "^unilib_light_spotlight.png"},
        groups = {cracky = 2, handy = 1, oddly_breakable_by_hand = 3},
        sounds = unilib.global.sound_table.glass,

        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        light_source = 12,
        paramtype = "light",
    })
    unilib.register_craft({
        -- From morelights_extras:stone_block
        output = full_name,
        recipe = {
            {"", "unilib:pane_glass_ordinary_flat", ""},
            {"", "unilib:light_bulb_normal", ""},
            {"", block_name, ""},
        },
    })

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_super_with_spotlight.init()

    return {
        description = "Stones with spotlights",
        depends = {"light_bulb_normal", "pane_glass_ordinary"},
    }

end

function unilib.pkg.stone_super_with_spotlight.exec()

    --[[
    unilib.register_node("unilib:light_block_stone", "morelights_extras:stone_block", mode, {
        -- From morelights_extras:stone_block
        description = S("Stone Lamp"),
        tiles = {"unilib_stone_ordinary_block.png^unilib_light_block_overlay.png"},
        groups = {cracky = 2, handy = 1, oddly_breakable_by_hand = 3},
        sounds = unilib.global.sound_table.glass,

        light_source = 12,
        paramtype = "light",
    })
    unilib.register_craft({
        -- From morelights_extras:stone_block
        output = "unilib:light_block_stone",
        recipe = {
            {"", "unilib:pane_glass_ordinary_flat", ""},
            {"", "unilib:light_bulb_normal", ""},
            {"", "unilib:stone_ordinary_block", ""},
        },
    })
    ]]--

    --[[
    unilib.register_node(
        -- From morelights_extras:stone_block
        "unilib:light_block_sandstone",
        "morelights_extras:sandstone_block",
        mode,
        {
            description = S("Sandstone Lamp"),
            tiles = {"unilib_stone_sandstone_ordinary_block.png^unilib_light_block_overlay.png"},
            groups = {cracky = 2, handy = 1, oddly_breakable_by_hand = 3},
            sounds = unilib.global.sound_table.glass,

            light_source = 12,
            paramtype = "light",
        }
    )
    unilib.register_craft({
        -- From morelights_extras:stone_block
        output = "unilib:light_block_sandstone",
        recipe = {
            {"", "unilib:pane_glass_ordinary_flat", ""},
            {"", "unilib:light_bulb_normal", ""},
            {"", "unilib:stone_sandstone_ordinary_block", ""},
        },
    })
    ]]--

    for stone_type, _ in pairs(unilib.global.super_stone_table) do

        local block_name = "unilib:stone_" .. stone_type .. "_block"
        if core.registered_nodes[block_name] ~= nil then
            do_light(block_name)
        end

    end

end
