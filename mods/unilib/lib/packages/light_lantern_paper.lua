---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.light_lantern_paper = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_lantern_paper.init()

    return {
        description = "Paper lantern",
        notes = "Uses an ABM to generate a glow",
        depends = {"item_paper_ordinary", "torch_ordinary"},
    }

end

function unilib.pkg.light_lantern_paper.exec()

    local c_paper = "unilib:item_paper_ordinary"

    unilib.register_node("unilib:light_lantern_paper", "decoblocks:paper_lantern", mode, {
        -- From farlands, decoblocks:paper_lantern
        description = S("Paper Lantern"),
        tiles = {
            "unilib_light_lantern_paper_top.png",
            "unilib_light_lantern_paper_top.png",
            "unilib_light_lantern_paper.png",
        },
        groups = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 3, snappy = 2, wool = 1},
        sounds = unilib.global.sound_table.node,

        is_ground_content = false,
        light_source = 13,
        paramtype = "light",
    })
    unilib.register_craft({
        -- From farlands, decoblocks:paper_lantern
        output = "unilib:light_lantern_paper",
        recipe = {
            {"group:wood", c_paper, "group:wood"},
            {c_paper, "unilib:torch_ordinary", c_paper},
            {"group:wood", c_paper, "group:wood"},
        },
    })

    unilib.register_abm({
        -- From farlands, decoblocks:paper_lantern
        label = "Paper lantern particles [light_lantern_paper]",
        nodenames = {"unilib:light_lantern_paper"},

        chance = 1,
        interval = 5,

        action = function(pos, node)

            core.add_particle({
                acceleration = {x = 0, y = 0, z = 0},
                animation = {
                    type = "vertical_frames",
                    aspect_w = 32,
                    aspect_h = 32,
                    length = 2.00,
                },
                collisiondetection = false,
                collisionremoval = false,
                expirationtime = 5,
                glow = 9,
                pos = {x = pos.x, y = pos.y, z = pos.z},
                size = 25,
                texture = "unilib_light_lantern_glow.png",
                velocity = {x = 0, y = 0, z = 0},
                vertical = true,
            })

        end,
    })

end
