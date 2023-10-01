---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_stove_pipe = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cottages.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_stove_pipe.init()

    return {
        description = "Decorative stove pipe",
        depends = "metal_steel",
    }

end

function unilib.pkg.misc_stove_pipe.exec()

    unilib.register_node("unilib:misc_stove_pipe", "cottages:stovepipe", mode, {
        -- From cottages:stovepipe
        description = S("Decorative Stove Pipe"),
        tiles = {"unilib_metal_steel_block.png"},
        groups = {choppy = 2, oddly_breakable_by_hand = 2, snappy = 2},
        -- N.B. no sounds in original code
        sounds = unilib.sound_table.metal,

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {0.20, -0.5, 0.20, 0.45, 0.5, 0.45},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {0.20, -0.5, 0.20, 0.45, 0.5, 0.45},
            },
        },
    })
    unilib.register_craft({
        -- From cottages:stovepipe
        output = "unilib:misc_stove_pipe 2",
        recipe = {
            {"unilib:metal_steel_ingot", "", "unilib:metal_steel_ingot"},
        }
    })

end
