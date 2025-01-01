---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.pane_barrier_paper = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.pane_barrier_paper.init()

    return {
        description = "Paper barrier",
        depends = "item_paper_ordinary",
    }

end

function unilib.pkg.pane_barrier_paper.exec()

    local c_paper = "unilib:item_paper_ordinary"
    local img = "unilib_pane_barrier_paper.png"

    unilib.register_pane({
        -- From mtg_plus mod, xpanes:paper_flat. Creates unilib:pane_barrier_paper_flat,
        --      unilib:pane_barrier_paper_crossed
        part_name = "barrier_paper",
        orig_name = {"xpanes:paper", "xpanes:paper_flat"},
        def_table = {
            description = S("Paper Barrier"),
            textures = {img, img, img},
            groups = {flammable = 4, snappy = 3},
            sounds = {
                footstep = {name = "unilib_paper_step", gain = 0.1, max_hear_distance = 7},
                place = {name = "unilib_paper_step", gain = 0.3, max_hear_distance = 13},
                dig = {name = "unilib_paper_dig", gain = 0.1, max_hear_distance = 11},
                dug = {name = "unilib_paper_dug", gain = 0.2, max_hear_distance = 13},
            },

            inventory_image = img,
            recipe = {
                {c_paper, c_paper, c_paper},
                {c_paper, c_paper, c_paper},
            },
            wield_image = img,
        },

        replace_mode = mode,
    })
    unilib.register_craft({
        -- From mtg_plus mod, xpanes:paper_flat
        type = "fuel",
        recipe = "unilib:pane_barrier_paper_flat",
        burntime = 1,
    })

end
