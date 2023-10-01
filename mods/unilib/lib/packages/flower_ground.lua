---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_ground = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_flower(part_name, orig_name, description)

    -- N.B. Replaced original groups with standard flower groups
--  local group_table = {dig_immediate = 1, flammable = 1, flower = 1, snappy = 3}
    local group_table = {attached_node = 1, flammable = 1, flora = 1, flower = 1, snappy = 3}
    group_table["color_" .. part_name] = 1

    unilib.register_node("unilib:flower_ground_" .. part_name, orig_name, mode, {
        -- From farlands, flowers_plus/init.lua
        description = description,
        tiles = {"unilib_flower_ground_" .. part_name .. ".png"},
        groups = group_table,
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, -0.49, 0.5},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        use_texture_alpha = "clip",
    })
    -- (not compatible with flowerpots)

    unilib.register_decoration("farlands_flower_ground_" .. part_name, {
        -- Original to unilib
        deco_type = "simple",
        decoration = "unilib:flower_ground_" .. part_name,

        fill_ratio = 0.02,
        height = 1,
        sidelen = 16,
    })

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_ground.init()

    return {
        description = "Ground flowers",
    }

end

function unilib.pkg.flower_ground.exec()

    -- From flowers_plus:blue_ground_flower, creates unilib:flower_ground_blue
    do_flower("blue", "flowers_plus:blue_ground_flower", S("Blue Ground Flower"))
    -- From flowers_plus:pink_ground_flower, creates unilib:flower_ground_pink
    do_flower("pink", "flowers_plus:pink_ground_flower", S("Pink Ground Flower"))
    -- From flowers_plus:red_ground_flower, creates unilib:flower_ground_red
    do_flower("red", "flowers_plus:red_ground_flower", S("Red Ground Flower"))

end
