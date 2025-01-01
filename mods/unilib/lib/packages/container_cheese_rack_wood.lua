---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cheese
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED / CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.container_cheese_rack_wood = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cheese.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.container_cheese_rack_wood.init()

    return {
        description = "Wooden cheese rack",
        notes = "Place a cheese rack in a dark place, then place curd inside it. After a period" ..
                " of time, a cheese is produced",
        depends = {"shared_cheese_rack", "tree_apple"},
    }

end

function unilib.pkg.container_cheese_rack_wood.exec()

    unilib.pkg.shared_cheese_rack.register_cheese_rack({
        -- From cheese:wooden_cheese_rack_empty, etc. Creates
        --      unilib:container_cheese_rack_wood_empty, etc
        part_name = "wood",
        orig_part_name = "wooden_cheese_rack",
        cheese_list = {"emmental", "fontal", "gruyere", "parmesan"},
        ingredient = "unilib:tree_apple_wood",

        replace_mode = mode,
        age_time = 55.0,
        description = S("Wooden Cheese Rack"),
        img = "unilib_tree_apple_wood.png",
        wood_flag = true,
    })

end
