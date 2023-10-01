---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/trunks
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_trunks_moss_normal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.trunks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_trunks_moss_normal.init()

    return {
        description = "Normal moss as decoration",
        depends = {"moss_normal", "dirt_ordinary"},
        optional = "fern_ordinary",
    }

end

function unilib.pkg.deco_trunks_moss_normal.exec()

    unilib.register_decoration_now("convert_moss_normal_on_ground", nil, {
        -- From trunks/generating.lua
        -- Completes decoration in package "moss_normal"
        place_on = "unilib:dirt_ordinary_with_turf",
        spawn_by = {
            "group:tree",
            "unilib:fern_ordinary_1",
            "unilib:fern_ordinary_2",
            "unilib:fern_ordinary_3",
        },
        y_max = 40,
        y_min = 1,
    })

end
