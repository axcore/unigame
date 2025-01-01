---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- wield_view_base.lua
--      Set up the wield_view effect. Code adapted from 3d_armor/wieldview
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Standard transformation table, from wieldview/transform.lua
-- More items are added to the table in the setup code below
local transform_table = {
    ["unilib:item_screwdriver_ordinary"] = "R270",
    ["screwdriver:screwdriver"] = "R270",

    ["unilib:torch_ordinary"] = "R270",
    ["default:torch"] = "R270",

    ["unilib:vessel_bottle_glass_empty"] = "R270",
    ["vessels:glass_bottle"] = "R270",

    ["unilib:vessel_bottle_steel_empty"] = "R270",
    ["vessels:steel_bottle"] = "R270",

    ["unilib:vessel_glass_empty"] = "R270",
    ["vessels:drinking_glass"] = "R270",
}

-- Table of items currently wielded by each player
-- Was wieldview.wielded_item
local wielded_item_table = {}

-- Time since last wieldview update
local wieldview_time = 0

---------------------------------------------------------------------------------------------------
-- Local functions (from wieldview/get_texture.lua)
---------------------------------------------------------------------------------------------------

local function escape_texture(texturestring)

    -- https://github.com/minetest/minetest/blob/9fc018ded10225589d2559d24a5db739e891fb31/doc/lua_api.txt#L453-L462
    -- Store in a variable so we don't return both rvs of gsub
    local v = texturestring:gsub("%^", "\\^"):gsub(":", "\\:")
    return v

end

local function memoise(func)

    -- Memoise expensive function calls

    local func_table = {}

    return function(arg)

        if arg == nil then
            return func(arg)
        end

        local rv = func_table[arg]
        if not rv then

            rv = func(arg)
            func_table[arg] = rv

        end

        return rv

    end

end

local function is_vertical_frames(animation)

    return (
        animation.type == "vertical_frames" and
        animation.aspect_w and
        animation.aspect_h
    )

end

local function get_single_frame(animation, img_name)

    return ("[combine:%ix%i^[noalpha^[colorize:#FFF:255^[mask:%s"):format(
        animation.aspect_w,
        animation.aspect_h,
        img_name
    )

end

local function is_sheet_2d(animation)

    return (
        animation.type == "sheet_2d" and
        animation.frames_w and
        animation.frames_h
    )

end

local function get_sheet_2d(animation, img_name)

    return ("%s^[sheet:%ix%i:0,0"):format(
        img_name,
        animation.frames_w,
        animation.frames_h
    )

end

local get_image_from_tile = memoise(function(tile)

    if type(tile) == "string" then

        return tile

    elseif type(tile) == "table" then

        local img_name
        if type(tile.image) == "string" then
            img_name = tile.image
        elseif type(tile.name) == "string" then
            img_name = tile.name
        end

        if img_name then

            local animation = tile.animation
            if animation then

                if is_vertical_frames(animation) then
                    return get_single_frame(animation, img_name)
                elseif is_sheet_2d(animation) then
                    return get_sheet_2d(animation, img_name)
                end

            end

            return img_name

        end

    end

    return "blank.png"

end)

local function get_image_cube(tiles)

    if #tiles >= 6 then

        return core.inventorycube(
            get_image_from_tile(tiles[1] or "no_texture.png"),
            get_image_from_tile(tiles[6] or "no_texture.png"),
            get_image_from_tile(tiles[3] or "no_texture.png")
        )

    elseif #tiles == 5 then

        return core.inventorycube(
            get_image_from_tile(tiles[1] or "no_texture.png"),
            get_image_from_tile(tiles[5] or "no_texture.png"),
            get_image_from_tile(tiles[3] or "no_texture.png")
        )

    elseif #tiles == 4 then

        return core.inventorycube(
            get_image_from_tile(tiles[1] or "no_texture.png"),
            get_image_from_tile(tiles[4] or "no_texture.png"),
            get_image_from_tile(tiles[3] or "no_texture.png")
        )

    elseif #tiles == 3 then

        return core.inventorycube(
            get_image_from_tile(tiles[1] or "no_texture.png"),
            get_image_from_tile(tiles[3] or "no_texture.png"),
            get_image_from_tile(tiles[3] or "no_texture.png")
        )

    elseif #tiles == 2 then

        return core.inventorycube(
            get_image_from_tile(tiles[1] or "no_texture.png"),
            get_image_from_tile(tiles[2] or "no_texture.png"),
            get_image_from_tile(tiles[2] or "no_texture.png")
        )

    elseif #tiles == 1 then

        return core.inventorycube(
            get_image_from_tile(tiles[1] or "no_texture.png"),
            get_image_from_tile(tiles[1] or "no_texture.png"),
            get_image_from_tile(tiles[1] or "no_texture.png")
        )

    end

    return "blank.png"

end

local function is_normal_node(drawtype)

    return (
        drawtype == "normal" or
        drawtype == "allfaces" or
        drawtype == "allfaces_optional" or
        drawtype == "glasslike" or
        drawtype == "glasslike_framed" or
        drawtype == "glasslike_framed_optional" or
        drawtype == "liquid"
    )

end

local get_wield_image = memoise(function(full_name)

    -- Was armor.get_wield_image()

    local stack = ItemStack(full_name)
    if stack:is_empty() then
        return "blank.png"
    end

    local def_table = stack:get_definition()
    if not def_table then
        return "unknown_item.png"
    end

    local meta = stack:get_meta()
    local colour = meta:get("colour") or def_table.colour or meta:get("color") or def_table.color
    local img = "blank.png"

    if def_table.wield_image and def_table.wield_image ~= "" then

        local parts_list = {def_table.wield_image}
        if colour then

            parts_list[#parts_list + 1] =
                    string.format("[colorize:%s:alpha", escape_texture(colour))

        end

        if def_table.wield_overlay then
            parts_list[#parts_list + 1] = def_table.wield_overlay
        end

        img = table.concat(parts_list, "^")

    elseif def_table.inventory_image and def_table.inventory_image ~= "" then

        local parts_list = {def_table.inventory_image}
        if colour then

            parts_list[#parts_list + 1] =
                    string.format("[colorize:%s:alpha", escape_texture(colour))

        end

        if def_table.inventory_overlay then
            parts_list[#parts_list + 1] = def_table.inventory_overlay
        end

        img = table.concat(parts_list, "^")

    elseif def_table.type == "node" then

        if def_table.drawtype == "nodebox" or def_table.drawtype == "mesh" then

            img = "blank.png"

        else

            local tiles = def_table.tiles
            if type(tiles) == "string" then

                img = get_image_from_tile(tiles)

            elseif type(tiles) == "table" then

                if is_normal_node(def_table.drawtype) and
                        unilib.setting.wield_view_node_tiles_flag then
                    img = get_image_cube(tiles)
                else
                    img = get_image_from_tile(tiles[1])
                end

            end

        end

    end

    return img

end)

---------------------------------------------------------------------------------------------------
-- Local functions (from wieldview/init.lua)
---------------------------------------------------------------------------------------------------

local function get_item_texture(full_name)

    -- Was wieldview.get_item_texture()

    local img = "blank.png"
    if full_name ~= "" then

        img = get_wield_image(full_name)

        -- Get item image transformation, first from the "wieldview_transform" group, then from the
        --      conversion table above
        -- Note from original mod:
        -- To apply a simple transformation to the item in hand, add the group "wieldview_transform"
        --      to the item definition. The group rating equals one of the numbers used for the
        --      [transform texture modifier of the Lua API
        local transform = core.get_item_group(full_name, "wieldview_transform")
        if transform == 0 then
            transform = transform_table[full_name]
        end

        if transform then

            -- This actually works with groups ratings because transform1, transform2, etc have
            --      meaning; and transform0 is used for identity, so it can be ignored
            img = img .. "^[transform" .. tostring(transform)

        end

    end

    return img

end

local function update_wielded_item(player)

    -- Was wieldview.update_wielded_item()

    if not player then
        return
    end

    local pname = player:get_player_name()
    local stack = player:get_wielded_item()
    local full_name = stack:get_name()
    if not full_name then
        return
    end

    if wielded_item_table[pname] then

        -- Notes from original mod (in README.txt):
        -- If you want to hide the wielded item you can add add an INT metadata to the player called
        --      "show_wielded_item" and set it to 2 (any other value will show the wielded item
        --      again)
        if player:get_meta():get_int("show_wielded_item") == 2 then
            full_name = ""
        end

        if wielded_item_table[pname] == full_name then
            return
        end

        unilib.armour.set_player_texture(pname, "wielditem",  get_item_texture(full_name))
        unilib.armour.update_player_visuals(player)

    end

    wielded_item_table[pname] = full_name

end

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

core.register_on_joinplayer(function(player)

    local pname = player:get_player_name()
    wielded_item_table[pname] = ""

    core.after(0, function(other_pname)

        local other_player = core.get_player_by_name(other_pname)
        if other_player then
            update_wielded_item(other_player)
        end

    end, pname)

end)

core.register_globalstep(function(dtime)

    wieldview_time = wieldview_time + dtime
    if wieldview_time > unilib.setting.wield_view_update_time  then

        for _,player in ipairs(core.get_connected_players()) do
            update_wielded_item(player)
        end

        wieldview_time = 0

    end

end)

-- Update the transform lookup table, after all packages have been loaded
core.after(0.2, function()

    local item_list = {}

    -- Add transformations for saplings
    -- The original code added only "default:sapling"
    for full_name, _ in pairs(unilib.global.sapling_table) do
        table.insert(item_list, full_name)
    end

    -- Add transformations for flowers
    -- unilib doesn't provide a universal flower table, but the list of flowerpot-compatible flowers
    --      is the next best thing
    -- The original code added only a few minetest_game flowers (and not even all of them)
    for full_name, _ in pairs(unilib.global.flowerpot_compat_table) do
        table.insert(item_list, full_name)
    end

    -- Add transformations for full and empty buckets
    -- The original code added only a few minetest_game buckets (and not even all of them)
    for full_name, _ in pairs(unilib.global.empty_bucket_table) do
        table.insert(item_list, full_name)
    end

    for full_name, _ in pairs(unilib.global.full_bucket_table) do
        table.insert(item_list, full_name)
    end

    -- Apply the transformations
    for _, full_name in pairs(item_list) do

        transform_table[full_name] = "R270"
        if unilib.global.node_deconvert_table[full_name] ~= nil then

            for _, orig_name in pairs(unilib.global.node_deconvert_table[full_name]) do
                transform_table[orig_name] = "R270"
            end

        elseif unilib.global.craftitem_deconvert_table[full_name] ~= nil then

            for _, orig_name in pairs(unilib.global.craftitem_deconvert_table[full_name]) do
                transform_table[orig_name] = "R270"
            end

        end

    end

end)
