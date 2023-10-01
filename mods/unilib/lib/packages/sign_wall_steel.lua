---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.sign_wall_steel = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sign_wall_steel.init()

    return {
        description = "Steel wall sign",
        depends = "metal_steel",
    }

end

function unilib.pkg.sign_wall_steel.exec()

    local c_ingot = "unilib:metal_steel_ingot"

    unilib.register_wall_sign({
        -- From default:sign_wall_steel. Creates unilib:sign_wall_steel
        part_name = "steel",
        orig_name = "default:sign_wall_steel",

        replace_mode = mode,
        description = S("Steel Wall Sign"),
        group_table = {attached_node = 1, cracky = 2},
        sound_name = "metal",
    })
    if not unilib.mtgame_tweak_flag then

        unilib.register_craft({
            -- From default:sign_wall_steel
            output = "unilib:sign_wall_steel 3",
            recipe = {
                {c_ingot, c_ingot, c_ingot},
                {c_ingot, c_ingot, c_ingot},
                {"", "group:stick", ""},
            },
        })

    else

        unilib.register_craft({
            -- From moreblocks/redefinitions.lua
            output = "unilib:sign_wall_steel 4",
            recipe = {
                {c_ingot, c_ingot, c_ingot},
                {c_ingot, c_ingot, c_ingot},
                {"", "group:stick", ""},
            },
        })

    end

end
