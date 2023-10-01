---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    more_coral
-- Code:    MIT
-- Media:   CC BY-SA
---------------------------------------------------------------------------------------------------

unilib.pkg.coral_growing_basic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.more_coral.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.coral_growing_basic.init()

    return {
        description = "Growing coral set (based on the basic 15 dye set)",
        notes = "Unlike the block corals from the packages derived from minetest_game, these" ..
                " corals grow (very slowly), and can be crafted",
        depends = {"coral_block_skeleton", "dye_basic"},
    }

end

function unilib.pkg.coral_growing_basic.exec()

    -- Basic growing coral set (based on the basic 15 dye set)
    local coral_list = {
        {"black",       "",             S("Black Growing Coral"),           "#0C0C0C"},
        {"blue",        "",             S("Blue Growing Coral"),            "#0000FF"},
        {"brown",       "",             S("Brown Growing Coral"),           "#A52A2A"},
        {"cyan",        "",             S("Cyan Growing Coral"),            "#00FFFF"},
        {"green",       "",             S("Green Growing Coral"),           "#008000"},
        {"green_dark",  "dark_green",   S("Dark Green Growing Coral"),      "#002600"},
        {"grey",        "",             S("Grey Growing Coral"),            "#808080"},
        {"grey_dark",   "dark_grey",    S("Dark Grey Growing Coral"),       "#3C3C3C"},
        {"magenta",     "",             S("Magenta Growing Coral"),         "#FF00FF"},
        {"orange",      "",             S("Orange Growing Coral"),          "#FFA500"},
        {"pink",        "",             S("Pink Growing Coral"),            "#FFC0CB"},
        {"red",         "",             S("Red Growing Coral"),             "#FF0000"},
        {"violet",      "",             S("Violet Growing Coral"),          "#EE82EE"},
        {"white",       "",             S("White Growing Coral"),           "#FFFFFF"},
        {"yellow",      "",             S("Yellow Growing Coral"),          "#FFFF00"},
    }

    for _, row_list in ipairs(coral_list) do

        local part_name = row_list[1]

        local orig_name = row_list[2]
        if orig_name == "" then
            orig_name = part_name
        end

        local description = row_list[3]
        local rgb = row_list[4]

        unilib.register_node(
            -- From more_coral:coral_black, etc. Creates unilib:coral_growing_black, etc
            "unilib:coral_growing_" .. part_name,
            "more_coral:coral_"..orig_name,
            mode,
            {
                description = description,
                tiles = {"unilib_coral_growing_base.png^[multiply:" .. rgb .. ":100"},
                -- N.B. growing_coral = 1 not in original code; it has been inserted so that the
                --      ABMs below act only on this coral
                groups = {coral = 1, cracky = 3, growing_coral = 1},
                sounds = unilib.sound_table.stone,

                drop = "unilib:coral_block_skeleton",
            }
        )
        unilib.register_craft({
            -- From more_coral:coral_black, etc
            type = "shapeless",
            output = "unilib:coral_growing_" .. part_name,
            recipe = {"unilib:coral_block_skeleton", "unilib:dye_" .. part_name},
        })

    end

    -- Growing coral dies when exposed to air
    unilib.register_abm({
        label = "Growing coral dies in air [coral_growing_basic]",
--      nodenames = {"group:coral"},
        nodenames = {"group:growing_coral"},
        neighbors = {"air"},

        catch_up = false,
        chance = 5,
        interval = 17,

        action = function(pos, node)
            minetest.set_node(pos, {name = "unilib:coral_block_skeleton"})
        end,
    })

    -- Growing coral spreads, but very slowly
    unilib.register_abm({
        label = "Growing coral [coral_growing_basic]",
--      nodenames = {"group:coral"},
        nodenames = {"group:growing_coral"},
        neighbors = {"group:water"},

        catch_up = false,
        chance = 25,
        interval = 500,

        action = function(pos, node)

            local posx = math.random(-1, 1)
            local posy = math.random(-1, 1)
            local posz = math.random(-1, 1)
            local new_pos = {x = pos.x + posx, y = pos.y + posy, z = pos.z + posz}
            local new_node = minetest.get_node(new_pos).name

            if minetest.get_item_group(new_node, "water") > 0 then
                minetest.set_node(new_pos, {name = node.name})
            end

       end,
    })

    -- Growing coral as decoration
    unilib.register_decoration("more_coral_coral_growing_basic", {
        deco_type = "simple",
        decoration = {
            "unilib:coral_growing_blue",
            "unilib:coral_growing_cyan",
            "unilib:coral_growing_green",
            "unilib:coral_growing_grey",
            "unilib:coral_growing_pink",
            "unilib:coral_growing_red",
            "unilib:coral_growing_violet",
            "unilib:coral_growing_yellow",
        },

        flags = "force_placement",
        noise_params = {
            octaves = 3,
            offset = -4,
            persist = 0.7,
            scale = 4,
            seed = 13854352,
            spread = {x = 50, y = 50, z = 50},
        },
        place_offset_y = -1,
        sidelen = 4,
    })

end
