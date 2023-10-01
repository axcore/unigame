---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_lily_flame = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_lily_flame.init()

    return {
        description = "Flame lily flower",
    }

end

function unilib.pkg.flower_lily_flame.exec()

    unilib.register_flower({
        -- From flowers_plus:flame_lily. Creates unilib:flower_lily_flame
        part_name = "lily_flame",
        orig_name = "flowers_plus:flame_lily",
        select_table = {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16},

        replace_mode = mode,
        deco_part_name = "farlands",
        description = S("Flame Lily"),
        fill_ratio = 0.02,
        group_table = {color_orange = 1, flammable = 1},
        sci_name = "Gloriosa superba",
    })

end
