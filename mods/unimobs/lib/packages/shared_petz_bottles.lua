---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_petz_bottles = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

-- Localise math functions (for speed)
local random = math.random

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function on_rightclick_mob_callback(self, clicker, itemstack, is_owner_flag)

    -- Adapted from petz.bottled()
    -- Captures the mob with the .bottled_name property in the corresponding bottle

    if not self.bottled_name then

        -- This override was not applied; apply the standard behaviour instead
        return false

    end

    -- Store the skin colour of the mob in the bottle's metadata, so that when the mob is removed
    --      from the bottle, its original colour can be restored
    local new_stack = ItemStack(self.bottled_name)
    local new_stack_meta = new_stack:get_meta()

    local old_stack_meta = unimobs.petz_api.capture_mob(self, clicker, false)
    -- N.B. Unlike the original code, the .generate_bottle() function above can't derive the name
    --      of the mob directly from the name of the bottle, so it must be stored in metadata
    new_stack_meta:set_string("mob_name", self.name)
    -- N.B. Fix for bug in original code (the retrieved value of "mob_texture_num" is usually 0)
--  new_stack_meta:set_int("mob_texture_num", old_stack_meta:get_int("mob_texture_num"))
    local mob_texture_num = old_stack_meta:get_int("mob_texture_num")
    if mob_texture_num == 0 then
        mob_texture_num = self.mob_texture_num
    end

    new_stack_meta:set_int("mob_texture_num", mob_texture_num)

    local inv = clicker:get_inventory()
    if inv:room_for_item("main", new_stack) then

        inv:add_item("main", new_stack)
        if inv:contains_item("main", ItemStack("unilib:vessel_bottle_glass_empty 1")) then
            inv:remove_item("main", "unilib:vessel_bottle_glass_empty")
        else
            inv:remove_item("main", "vessels:glass_bottle")
        end

    else

        core.add_item(clicker:get_pos(), new_stack)

    end

    -- Do not apply the standard behaviour
    return true

end

---------------------------------------------------------------------------------------------------
-- Shared function
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_petz_bottles.generate_bottle(data_table)

    -- Adapted from petz/petz/misc/items.lua
    -- Creates a bottle with the specified insect placed inside
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "moth"
    --      orig_name (str): e.g. "petz:bottle_moth"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Moth in a Glass Bottle"
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Insect in a Glass Bottle")

    local full_name = "unilib:vessel_bottle_glass_with_" .. part_name

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = description,
        tiles = {"unilib_vessel_bottle_glass_with_" .. part_name .. ".png"},
        groups = {oddly_breakable_by_hand = 1},
        sounds = unilib.global.sound_table.glass,

        drawtype = "plantlike",
        drop = "",
        inventory_image = "unilib_vessel_bottle_glass_with_" .. part_name .. "_inv.png",
        light_source = unilib.constant.light_max - 1,
        param2 = 50,
        paramtype = "light",
        paramtype2 = "glasslikeliquidlevel",
        selection_box = {
            type = "fixed",
            fixed = { -0.25, -0.5, -0.25, 0.25, 0.4, 0.25 },
        },
        stack_max = 1,
        sunlight_propagates = true,
        use_texture_alpha = "blend",
        walkable = false,

        after_place_node = function(pos, placer, itemstack, pointed_thing)

            local meta_itemstack = itemstack:get_meta()
            local meta = core.get_meta(pos)

            local placer_name = ""
            if core.is_player(placer) then
                placer_name = placer:get_player_name()
            end

            meta:set_string("owner", placer_name)
            meta:set_string("mob_name", meta_itemstack:get_string("mob_name"))
            meta:set_int("mob_texture_num", meta_itemstack:get_int("mob_texture_num"))

        end,

        on_destruct = function(pos)

            local meta = core.get_meta(pos)

            local mob_name = meta:get_string("mob_name")
            local mob_texture_num = meta:get_int("mob_texture_num")

            local ent_obj = core.add_entity(
                pos, mob_name, "{owner = " .. meta:get_string("owner") .. ", tamed = true}"
            )

            if ent_obj and mob_texture_num then

                local luaent = ent_obj:get_luaentity()
                if mob_texture_num == 0 then
                    mob_texture_num = random(1, #luaent.textures)
                end

                -- N.B. Fix for bug in original code (without this line, a released butterfly will
                --      suddenly change colour upon death)
                luaent.mob_texture_num = mob_texture_num

                local prop_table = {}
                prop_table.textures = {luaent.textures[mob_texture_num]}
                ent_obj:set_properties(prop_table)

            end

        end,
    })

    return full_name

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_petz_bottles.init()

    return {
        description = "Shared functions for insects in bottles (from petz)",
    }

end

function unilib.pkg.shared_petz_bottles.exec()

    -- Override the standard behaviour when a mob is right-clicked while wielding an empty glass
    --      bottle (both the unilib and minetest_game versions are supported)
    unimobs.petz_api.register_rightclick_override(
        "unilib:vessel_bottle_glass_empty", on_rightclick_mob_callback
    )

    unimobs.petz_api.register_rightclick_override(
        "vessels:glass_bottle", on_rightclick_mob_callback
    )

end
