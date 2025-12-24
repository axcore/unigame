---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_ball_square = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_ball_square.init()

    return {
        description = "Square balls for playing fetch (and other compatible mobs)",
        notes = "Left-click while wielding the ball to throw it; if it lands near one of your" ..
                " tamed dogs, the dog will bring back the ball in its mouth. If the dog doesn't" ..
                " drop the ball, you can right-click the ball (not the dog) to retrieve it",
        depends = {"item_string_ordinary", "shared_petz_balls", "wool_basic"},
    }

end

function unilib.pkg.item_ball_square.exec()

    unilib.pkg.shared_petz_balls.do_register({
        -- From petz:square_ball, petz:ent_square_ball
        part_name = "beach",
        orig_name = "petz:square_ball",

        replace_mode = mode,
        description = S("Square Beach Ball"),
    })
    unilib.register_craft({
        -- From petz:square_ball
        type = "shaped",
        output = "unilib:item_ball_square_beach",
        recipe = {
            {"unilib:wool_blue", "unilib:wool_white", "unilib:wool_red"},
            {"unilib:wool_white", "unilib:item_string_ordinary", "unilib:wool_white"},
            {"unilib:wool_yellow", "unilib:wool_white", "unilib:wool_white"},
        },
    })

    unilib.pkg.shared_petz_balls.do_register({
        -- Original to unimobs (using an unused texture from petz)
        part_name = "basketball",
        orig_name = nil,

        replace_mode = mode,
        description = S("Square Basketball"),
    })
    unilib.register_craft({
        -- Original to unimobs
        type = "shaped",
        output = "unilib:item_ball_square_basketball",
        recipe = {
            {"unilib:wool_orange", "unilib:wool_orange", "unilib:wool_black"},
            {"unilib:wool_orange", "unilib:item_string_ordinary", "unilib:wool_orange"},
            {"unilib:wool_black", "unilib:wool_orange", "unilib:wool_orange"},
        },
    })

    unilib.pkg.shared_petz_balls.do_register({
        -- Original to unimobs (using an unused texture from petz)
        part_name = "football",
        orig_name = nil,

        replace_mode = mode,
        description = S("Square Football"),
    })
    unilib.register_craft({
        -- Original to unimobs
        type = "shaped",
        output = "unilib:item_ball_square_football",
        recipe = {
            {"unilib:wool_black", "unilib:wool_white", "unilib:wool_black"},
            {"unilib:wool_white", "unilib:item_string_ordinary", "unilib:wool_white"},
            {"unilib:wool_black", "unilib:wool_white", "unilib:wool_black"},
        },
    })

end
