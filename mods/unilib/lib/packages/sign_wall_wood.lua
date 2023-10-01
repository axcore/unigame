---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.sign_wall_wood = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sign_wall_wood.init()

    return {
        description = "Wooden wall sign",
    }

end

function unilib.pkg.sign_wall_wood.exec()

    unilib.register_wall_sign({
        -- From default:sign_wall_wood. Creates unilib:sign_wall_wood
        part_name = "wood",
        orig_name = "default:sign_wall_wood",

        replace_mode = mode,
        description = S("Wooden Wall Sign"),
        group_table = {attached_node = 1, choppy = 2, flammable = 2, oddly_breakable_by_hand = 3},
        sound_name = "wood",
    })
    if not unilib.mtgame_tweak_flag then

        unilib.register_craft({
            -- From default:sign_wall_wood
            output = "unilib:sign_wall_wood 3",
            recipe = {
                {"group:wood", "group:wood", "group:wood"},
                {"group:wood", "group:wood", "group:wood"},
                {"", "group:stick", ""},
            },
        })

    else

        unilib.register_craft({
            -- From moreblocks/redefinitions.lua
            output = "unilib:sign_wall_wood 4",
            recipe = {
                {"group:wood", "group:wood", "group:wood"},
                {"group:wood", "group:wood", "group:wood"},
                {"", "group:stick", ""},
            },
        })

    end
    unilib.register_craft({
        -- From default:sign_wall_wood
        type = "fuel",
        recipe = "unilib:sign_wall_wood",
        burntime = 10,
    })

end
