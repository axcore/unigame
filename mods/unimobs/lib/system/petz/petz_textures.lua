---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- petz_textures.lua
--      Shared API functions from the petz/petz mod
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

-- List of dye colours, compiled during the first call to unimobs.petz_api.get_colour_group()
local colour_list = nil
-- Table to convert minetest_game/unilib dye colours to the equivalent CSS Color Module Level 4,
--      when required (we also switch some colours which aren't quite right)
local convert_table = {
    green = "lawngreen",
    green_dark = "darkgreen",               -- From unilib
        dark_green = "darkgreen",           -- From minetest_game

    grey = "grey",
    grey_dark = "#2A2A2A",                  -- From unilib
        dark_grey = "#2A2A2A",              -- From minetest_game

    brown = "saddlebrown",
    orange = "orangered",
    pink = "hotpink",
    violet = "purple",
}
-- Alpha value used in unimobs.petz_api.colourise_mob(). Original code used a value of 125
local alpha = 160

-- Table of mob types, and the override callbacks to call when composing a mob's skin texture (via a
--      call to unimobs.petz_api.compose_skin_texture()
-- Table in the form
--      override_table[mob_type] = list_of_callbacks
-- Each callback should either return a texture (as a string), or nil. If not nil, that texture is
--      used as the basis for the skin, and no more override callbacks are called. If nil, the next
--      override callback in the list is called. If all callbacks in the list return nil, or if no
--      override callbacks are specified at all, then a default texture is used as the basis for a
--      skin, over which overlay textures may be placed
local override_table = {}

---------------------------------------------------------------------------------------------------
-- Shared API functions (original to unimobs)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.compile_texture_list(mob_type, skin_init_list)

    -- Original to unimobs
    -- Called by various mob packages, in order to produce a simple list of textures, to be used in
    --      the unilib.register_entity() call (as the .initial_properties.textures field)
    -- "skin_init_list" is a list of mini-lists, each in the form
    --      { skin_type, skin_name, relative_probability }
    -- ...for example,
    --      { "brown", S("Brown"), 1 }

    local simple_list = {}

    for _, mini_list in ipairs(skin_init_list) do
        table.insert(simple_list, "unilib_mob_" .. mob_type .. "_" .. mini_list[1] .. ".png")
    end

    return simple_list

end

function unimobs.petz_api.register_texture_override(mob_type, callback)

    -- Original to unimobs
    -- Called by any package which wants to override the default skin

    if override_table[mob_type] == nil then
        override_table[mob_type] = { callback }
    else
        table.insert(override_table[mob_type], callback)
    end

end

function unimobs.petz_api.get_skin_description(self)

    -- Original to unimobs
    -- Get a displayable description of the specified mob's current skin, or an empty string on
    --      failure

    local skin_init_list
    if self.petz_compat_flag then
        skin_init_list = unimobs.petz_global.mob_table[self.mob_type]["skin_init_list"]
    end

    if not skin_init_list or not self.mob_texture_num then
        return ""
    end

    -- Mini-list in the form
    --      { skin_type, displayable_skin_name, relative_probability }
    local mini_list = skin_init_list[self.mob_texture_num]
    if mini_list[2] then
        return mini_list[2]
    else
        return mini_list[1] or ""
    end

end

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/petz/api/api_colorize.lua)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.colourise_mob(self, colour)

    -- From petz.colorize()
    -- Can be called by any code in order to colourise a mob; commonly called when sheep are
    --      colourised using dye
    -- This function expects that two special textures for the specified mob exist, in the form
    --      "unilib_mob_MOBTYPE_bg.png" and "unilib_mob_MOBTYPE_overlay.png" (where MOBTYPE matches
    --      self.mob_type)
    -- "colour" is a Minetest ColorString. Use the unimobs.petz_api.get_colour_group() function to
    --      obtain the ColorString associated with an item, such as a dye

    local bg_img = "unilib_mob_" .. self.mob_type .. "_bg.png"
    local overlay_img = "(unilib_mob_" .. self.mob_type .. "_overlay.png" ..
            "^[colorize:" .. colour .. ":" .. alpha .. ")"

    unimobs.petz_api.set_mob_properties(self, {textures = {bg_img .. "^" .. overlay_img}})
    self.modified_colour = unimobs.mobkit_api.add_mob_memory(self, "modified_colour", colour)

end

function unimobs.petz_api.get_mob_colourisation(self)

    -- Original to unimobs
    -- An alternative to unimobs.petz_api.colourise_mob(), when we don't want to update the entity's
    --      colourised skin texture directly, but just retrieve it

    if not self.modified_colour then

        return nil

    else

        return "unilib_mob_" .. self.mob_type .. "_bg.png" ..
                "^(unilib_mob_" .. self.mob_type .. "_overlay.png" ..
                "^[colorize:" .. self.modified_colour .. ":" .. alpha .. ")"

    end

end

function unimobs.petz_api.get_colour_group(full_name)

    -- From petz.get_color_group()
    -- "full_name" is an item whose .groups field has a colour group such as "colour_red" or
    --      "colour_green_dark" (or the American equivalents, "color_red" and so on)
    -- "full_name" is usually a dye, but can be any other item with a colour_X/color_X group
    --
    -- Returns the colour of the first colour group found, e.g. "red", "green_dark" (or nil if the
    --      item has no colour group)

    -- On the first call to this function, compile a list of colours
    if colour_list == nil then
        colour_list = unilib.utils._compile_colour_list()
    end

    local match_colour
    for _, this_colour in ipairs(colour_list) do

        if core.get_item_group(full_name, "colour_" .. this_colour) > 0 or          -- unilib
                core.get_item_group(full_name, "color_" .. this_colour) > 0 then    -- minetest_game

            match_colour = this_colour
            break

        end

    end

    -- Convert a unilib/minetest_game dye colour to the equivalent in CSS Color Module Level 4
    --      (https://www.w3.org/TR/css-color-4/#named-color)
    if convert_table[match_colour] ~= nil then
        return convert_table[match_colour]
    else
        return match_colour
    end

end

function unimobs.petz_api.revert_mob_colourisation(self, img)

    -- Code adapted from parts of petz.lamb_wool_shave(), and moved to this new function
    -- Resets changes to the mob, made in an earlier call to unimobs.petz_api.colourise_mob(); the
    --      calling code must supply a replacement texture

    unimobs.petz_api.set_mob_properties(self, {textures = {img}})
    self.modified_colour = unimobs.mobkit_api.add_mob_memory(self, "modified_colour", nil)

end

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/petz/api/api_init_prop.lua)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.compose_skin_texture(self)

    -- From petz.compose_texture()
    -- Returns a texture to be used as the specified mob's skin. The texture may be the default one,
    --      or one supplied by an override function
    -- For mountable mobs, the returned texture will include overlays for the saddle and/or
    --      saddle-bag, when necessary

    local texture

    -- Process overrides specified by calls to unimobs.petz_api.register_texture_override()
    local callback_list = override_table[self.mob_type]
    if callback_list ~= nil then

        for _, callback in ipairs(callback_list) do

            texture = callback(self)
            if texture ~= nil then
                break
            end

        end

    end

    -- No override texture supplied, so use the default one
    if texture == nil then
        texture = self.textures[self.mob_texture_num]
    end

    -- Add overlays for saddles and/or saddle-bags, if require
    if self.is_mountable_flag then

        if self.saddle_name then

            texture = texture .. "^" .. unimobs.petz_api.get_saddle_overlay(
                self.saddle_name, self.mob_type
            )

        end

        if self.saddlebag_name then

            texture = texture .. "^" .. unimobs.petz_api.get_saddlebag_overlay(
                self.saddlebag_name, self.mob_type
            )

        end

    end

    return texture

end
