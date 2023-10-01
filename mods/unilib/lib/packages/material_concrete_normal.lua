---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cement
-- Code:    GPLv3.0
-- Media:   GPLv3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.material_concrete_normal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cement.add_mode

-- Table converting colours used in the basic colour set (used by the "dye_basic" package and
--      several others) into a palette index
local dye_table = {
--  ["unilib:dye_white"]        = 0,
    ["unilib:dye_grey"]         = 1,
    ["unilib:dye_grey_dark"]    = 2,
    ["unilib:dye_black"]        = 3,
    ["unilib:dye_blue"]         = 4,
    ["unilib:dye_cyan"]         = 5,
    ["unilib:dye_green"]        = 6,
    ["unilib:dye_green_dark"]   = 7,
    ["unilib:dye_yellow"]       = 8,
    ["unilib:dye_orange"]       = 9,
    ["unilib:dye_brown"]        = 10,
    ["unilib:dye_red"]          = 11,
    ["unilib:dye_pink"]         = 12,
    ["unilib:dye_magenta"]      = 13,
    ["unilib:dye_violet"]       = 14,
    ["unilib:dye_white"]        = 15,
}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local do_colourise = function(pos, node, puncher, pointed_thing)

    -- Colourise concretes when punched with dye

    local name = puncher:get_wielded_item():get_name()
    if minetest.registered_items[name].groups.dye ~= nil then

        local index = dye_table[name] or false
        if index ~= false then

            -- (Departure from original code - punching the node with something other than dye
            --      should not be a protection violation)
            local player_name = puncher:get_player_name()
            if minetest.is_protected(pos, player_name) then

                minetest.record_protection_violation(pos, player_name)
                return

            end

            local node = minetest.get_node(pos)
            node.param2 = index
            minetest.set_node(pos, node)

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.material_concrete_normal.init()

    return {
        description = "Normal concrete",
        notes = "Rough concrete is created when wet cement dries. Using a sander creates smooth" ..
                " concrete. If the basic dye set is available, punching rough or smooth concrete" ..
                " with a dye colourises it (without consuming the dye)",
        depends = "material_cement_normal",
        optional = "dye_basic",
    }

end

function unilib.pkg.material_concrete_normal.exec()

    local dry_img = "unilib_sand_ordinary.png^(default_gravel.png^[opacity:128)"
    local wet_img = "(" .. dry_img .. ")^[colorize:#000000:60"
    local hard_img = "(" .. wet_img .. ")^[brighten"
    local sanded_img = "(unilib_sand_ordinary.png^(unilib_stone_sandstone_ordinary.png" ..
            "^[opacity:128)^[brighten)"

    unilib.register_node("unilib:material_concrete_normal_rough", "cement:hard", mode, {
        -- From cement:hard
        description = S("Rough Normal Concrete"),
        tiles = {hard_img},
        -- N.B. concrete = 1 not in original code; added to match concrete from basic_materials
        groups = {concrete = 1, cracky = 2},
        sounds = unilib.sound_table.stone,

        drawtype = "color",
        is_ground_content = false,
        palette = "unilib_material_concrete_palette.png",
        paramtype2 = "color",

        on_punch = function(pos, node, puncher, pointed_thing)
            do_colourise(pos, node, puncher, pointed_thing)
        end
    })

    unilib.register_node("unilib:material_concrete_normal_smooth", "cement:sanded", mode, {
        -- From cement:sanded
        description = S("Smooth Normal Concrete"),
        tiles = {sanded_img},
        -- N.B. concrete = 1 not in original code; added to match concrete from basic_materials
        groups = {concrete = 1, cracky = 2},
        sounds = unilib.sound_table.stone,

        drawtype = "color",
        is_ground_content = false,
        palette = "unilib_material_concrete_palette.png",
        paramtype2 = "color",

        on_punch = function(pos, node, puncher, pointed_thing)
            do_colourise(pos, node, puncher, pointed_thing)
        end
    })

    unilib.register_abm({
        -- From cement/init.lua
        label = "Converts wet cement to concrete [material_concrete_normal]",
        nodenames = {"unilib:material_cement_normal_wet"},

        catch_up = true,
        chance = 3,
        interval = 10,

        action = function(pos, node)

            local near_ordinary = minetest.find_node_near(
                pos, 1, {"unilib:liquid_water_ordinary_source"}
            )

            -- N.B. Only responds to ordinary water in the original code
            local near_river = minetest.find_node_near(
                pos, 1, {"unilib:liquid_water_river_source"}
            )

            if near_ordinary == nil and near_river == nil then
                minetest.set_node(pos, { name = "unilib:material_concrete_normal_rough"})
            end

        end,
    })

end
