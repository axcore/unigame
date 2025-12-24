---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.container_present_christmas = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.container_present_christmas.init()

    return {
        description = "Christmas present",
        depends = {"container_chest_ordinary", "dye_basic", "shared_petz_chests"},
    }

end

function unilib.pkg.container_present_christmas.exec()

    local c_paper = "unilib:item_paper_ordinary"

    unilib.pkg.shared_petz_chests.register_chest({
        -- From petz:christmas_present, etc. Creates unilib:container_present_christmas
        part_name = "present_christmas",
        orig_name_list = {"petz:christmas_present", "petz:christmas_present_open"},
        def_table = {
            description = S("Christmas Present"),
            tiles = {
                "unilib_container_present_christmas_top.png",
                "unilib_container_present_christmas_top.png",
                "unilib_container_present_christmas_side.png",
                "unilib_container_present_christmas_side.png",
                "unilib_container_present_christmas_front.png",
                "unilib_container_present_christmas_inside.png"
            },
            groups = {choppy = 2, oddly_breakable_by_hand = 2},
            sounds = unilib.global.sound_table.wood,

            sound_close = "unilib_chest_close",
            sound_open = "unilib_chest_open",
            stack_max = 1,
        },

        replace_mode = mode,
    })
    unilib.register_craft({
        -- From petz:christmas_present
        type = "shaped",
        output = "unilib:container_present_christmas",
        recipe = {
            {c_paper, c_paper, c_paper},
            {"unilib:dye_red", "unilib:container_chest_ordinary", "unilib:dye_yellow"},
            {c_paper, c_paper, c_paper},
        },
    })

end
