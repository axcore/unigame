---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.clay_antipodean = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clay_antipodean.init()

    return {
        description = "Antipodean clay",
        notes = "The original code overrides clay from default, but unilib uses a separate node." ..
                " Unlike ordinary clay, this node does not drop lumps of clay, and plants can" ..
                " grow on it",
        depends = "clay_ordinary",
        optional = "dye_basic",
    }

end

function unilib.pkg.clay_antipodean.exec()

    unilib.register_node("unilib:clay_antipodean", nil, mode, {
        -- From aotearoa, default:clay
        description = S("Antipodean Clay"),
        tiles = {"unilib_clay_antipodean.png"},
        -- N.B. clay = 1 not in original code
        groups = {clay = 1, crumbly = 3, soil = 1},
        sounds = unilib.global.sound_table.dirt,
    })
    if unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- From aotearoa, default:clay
            type = "cooking",
            output = "unilib:dye_white 4",
            recipe = "unilib:clay_antipodean",
        })

    end

end
