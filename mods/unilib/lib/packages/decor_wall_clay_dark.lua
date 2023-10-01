---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    abriglass
-- Code:    MIT
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_wall_clay_dark = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.abriglass.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_wall_clay_dark.init()

    return {
        description = "Decorative dark clay wall",
        depends = {"clay_ordinary", "dye_basic"},
    }

end

function unilib.pkg.decor_wall_clay_dark.exec()

    local c_clay = "unilib:clay_ordinary_lump"

    unilib.register_node("unilib:decor_wall_clay_dark", "abriglass:oneway_wall_dark", mode, {
        -- From abriglass:oneway_wall_dark
        description = S("Decorative Dark Clay Wall"),
        tiles = {"unilib_decor_wall_clay_dark.png"},
        groups = {cracky = 3},
        -- (no sounds)

        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From abriglass:oneway_wall_dark
        output = "unilib:decor_wall_clay_dark 2",
        recipe = {
            {c_clay, c_clay, c_clay},
            {c_clay, "unilib:dye_black", c_clay},
            {c_clay, c_clay, c_clay},
        },
    })

end
