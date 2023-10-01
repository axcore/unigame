---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cheese
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED / CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.container_cheese_rack_stone = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cheese.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.container_cheese_rack_stone.init()

    return {
        description = "Stone cheese rack",
        notes = "Place a cheese rack in a dark place, then place curd inside it. After a period" ..
                " of time, a cheese is produced",
        depends = {"shared_cheese_rack", "stone_ordinary"},
    }

end

function unilib.pkg.container_cheese_rack_stone.exec()

    unilib.pkg.shared_cheese_rack.register_cheese_rack({
        -- From cheese:stone_cheese_rack_empty, etc. Creates
        --      unilib:container_cheese_rack_stone_empty, etc
        part_name = "stone",
        orig_part_name = "stone_cheese_rack",
        cheese_list = {"asiago", "gouda", "monteray_jack", "toma"},
        ingredient = "unilib:stone_ordinary",

        replace_mode = mode,
        age_time = 45.0,
        description = S("Stone Cheese Rack"),
        img = "unilib_stone_ordinary.png",
        wood_flag = false,
    })

end
