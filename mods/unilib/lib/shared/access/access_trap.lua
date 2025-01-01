---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- access_trap.lua
--      Register store/glass traps
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

local stone_overlay_img = "unilib_trap_stone_box_overlay.png"
local glass_overlay_img = "unilib_trap_glass_box_overlay.png"
if unilib.setting.moreblocks_hidden_trap_flag then

    stone_overlay_img = "unilib_trap_stone_box_overlay_alt.png"
    glass_overlay_img = "unilib_trap_glass_box_overlay_alt.png"

end

---------------------------------------------------------------------------------------------------
-- Register stone traps
---------------------------------------------------------------------------------------------------

function unilib.access._register_stone_trap(data_table)

    -- Adapted from moreblocks/nodes.lua
    -- Creates a trap node using a specified stone ingredient
    --
    -- data_table compulsory fields:
    --      orig_name (str): e.g. "moreblocks:trap_stone"
    --      ingredient (str): e.g. "unilib:stone_ordinary"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      group_table (table or nil): If specified, the node definition's .groups field. If not
    --          specified, the ingredient's .groups field is used
    --
    -- Return values:
    --      The full_name of the new node, or an empty string if no trap was created

    local orig_name = data_table.orig_name
    local ingredient = data_table.ingredient

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local group_table = data_table.group_table or {}

    local full_name = ingredient .. "_trap"
    local def_table = core.registered_nodes[ingredient]

    if def_table == nil or unilib.global.pkg_executed_table["mineral_mese"] == nil then
        return
    end

    if group_table == nil then
        group_table = table.copy(def_table.groups)
    end

    unilib.register_node(full_name, orig_name, replace_mode, {
        -- From moreblocks:trap_stone
        description = unilib.utils.brackets(def_table.description, S("Trap")),
        tiles = {def_table.tiles[1] .. "^" .. stone_overlay_img},
        groups = group_table,
        sounds = unilib.global.sound_table.stone,

        drawtype = "glasslike_framed",
        is_ground_content = false,
        paramtype = "light",
        walkable = false,
    })
    unilib.register_craft({
        -- From moreblocks:trap_stone
        type = "shapeless",
        output = full_name,
        recipe = {"unilib:mineral_mese_crystal_fragment", ingredient},
    })

    return full_name

end

---------------------------------------------------------------------------------------------------
-- Register glass traps
---------------------------------------------------------------------------------------------------

function unilib.access._register_glass_trap(data_table)

    -- Adapted from moreblocks/nodes.lua
    -- Creates a trap node using a specified glass ingredient
    -- Note that this function assumes the ingredient's .tiles field contains textures in the same
    --      format as default:glass (in which the second texture is the "detail" overlay)
    --
    -- data_table compulsory fields:
    --      orig_name (str): e.g. "moreblocks:trap_glass"
    --      ingredient (str): e.g. "unilib:glass_ordinary"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      group_table (table or nil): If specified, the node definition's .groups field. If not
    --          specified, the ingredient's .groups field is used
    --
    -- Return values:
    --      The full_name of the new node, or an empty string if no trap was created

    local orig_name = data_table.orig_name
    local ingredient = data_table.ingredient

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local group_table = data_table.group_table or {}

    local full_name = ingredient .. "_trap"
    local def_table = core.registered_nodes[ingredient]

    if def_table == nil or unilib.global.pkg_executed_table["mineral_mese"] == nil then
        return
    end

    if group_table == nil then
        group_table = table.copy(def_table.groups)
    end

    unilib.register_node(full_name, orig_name, replace_mode, {
        -- From moreblocks:trap_glass
        description = unilib.utils.brackets(def_table.description, S("Trap")),
        tiles = {
            def_table.tiles[1] .. "^" .. glass_overlay_img,     -- e.g. unilib_glass_clean.png
            def_table.tiles[2],                                 -- e.g. unilib_glass_clean_detail
        },
        groups = group_table,
        sounds = unilib.global.sound_table.glass,

        drawtype = "glasslike_framed_optional",
        is_ground_content = false,
        paramtype = "light",
        sunlight_propagates = true,
        use_texture_alpha = "clip",
        walkable = false,
    })
    unilib.register_craft({
        -- From moreblocks:trap_glass
        type = "shapeless",
        output = full_name,
        recipe = {"unilib:mineral_mese_crystal_fragment", ingredient},
    })

    return full_name

end
