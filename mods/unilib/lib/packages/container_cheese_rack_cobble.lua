---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cheese
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED / CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.container_cheese_rack_cobble = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cheese.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.container_cheese_rack_cobble.init()

    return {
        description = "Cobblestone cheese rack",
        notes = "Place a cheese rack in a dark place, then place curd inside it. After a period" ..
                " of time, a cheese is produced",
        depends = {"shared_cheese_rack", "stone_ordinary"},
    }

end

function unilib.pkg.container_cheese_rack_cobble.exec()

    unilib.pkg.shared_cheese_rack.register_cheese_rack({
        -- From cheese:mossy_cheese_rack_empty, etc. Creates
        --      unilib:container_cheese_rack_cobble_empty, etc
        part_name = "cobble",
        orig_part_name = "mossy_cheese_rack",
        cheese_list = {"brie", "gorgonzola", "stilton", "stracchino"},
        ingredient = "unilib:stone_ordinary_cobble",

        replace_mode = mode,
        age_time = 30.0,
        description = S("Cobblestone Cheese Rack"),
        img = "unilib_stone_ordinary_cobble.png",
        wood_flag = false,
    })

end
