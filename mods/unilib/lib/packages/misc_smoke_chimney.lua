---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_smoke_chimney = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_smoke_chimney.init()

    return {
        description = "Chimney smoke",
        notes = "This is a purely decorative item, not used by any of the grills",
        depends = "torch_ordinary",
    }

end

function unilib.pkg.misc_smoke_chimney.exec()

    unilib.register_node("unilib:misc_smoke_chimney", "bbq:chimney_smoke", mode, {
        -- From bbq:chimney_smoke
        description = S("Chimney Smoke"),
        tiles = {
            {
                image = "unilib_misc_smoke_chimney_animated.png",
                backface_culling = false,
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 1.5,
                },
            },

        },
        groups = {attached_node = 1, dig_immediate = 3},
        -- (no sounds)

        drawtype = "plantlike",
        inventory_image = "unilib_misc_smoke_chimney.png",
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,
        -- N.B. Not in original code
        walkable = false,
        wield_image = "unilib_misc_smoke_chimney.png",
    })
    unilib.register_craft({
        -- From bbq:chimney_smoke
        output = "unilib:misc_smoke_chimney",
        recipe = {
            {"", "group:wood", ""},
            {"", "group:wood", ""},
            {"", "unilib:torch_ordinary", ""}
        }
    })

end
