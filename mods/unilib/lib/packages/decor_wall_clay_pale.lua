---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    abriglass
-- Code:    MIT
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_wall_clay_pale = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.abriglass.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_wall_clay_pale.init()

    return {
        description = "Decorative pale clay wall",
        depends = {"clay_ordinary", "dye_basic"},
    }

end

function unilib.pkg.decor_wall_clay_pale.exec()

    local c_clay = "unilib:clay_ordinary_lump"

    unilib.register_node("unilib:decor_wall_clay_pale", "abriglass:oneway_wall_pale", mode, {
        -- From abriglass:oneway_wall_pale
        description = S("Decorative Pale Clay Wall"),
        tiles = {"unilib_decor_wall_clay_dark.png^[colorize:#E6E6FA:200"},
        groups = {cracky = 3},
        -- (no sounds)

        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From abriglass:oneway_wall_pale
        output = "unilib:decor_wall_clay_pale 2",
        recipe = {
            {c_clay, c_clay, c_clay},
            {c_clay, "unilib:dye_white", c_clay},
            {c_clay, c_clay, c_clay},
        },
    })

end
