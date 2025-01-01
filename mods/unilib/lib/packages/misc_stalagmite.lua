---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_stalagmite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function on_place(itemstack, placer, pointed_thing)

    -- Allow placing the node only on floors
    local dir = core.dir_to_wallmounted(
        vector.subtract(pointed_thing.under, pointed_thing.above)
    )

    if dir == 1 then
        core.item_place(itemstack, placer, pointed_thing, 1)
    end

    return itemstack

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_stalagmite.init()

    return {
        description = "Selection of stalagmites",
        notes = "Use the \"meta_farlands_underground\" package to generate these stalagmites in" ..
                " ordinary stone caves",
        depends = "stone_ordinary",
    }

end

function unilib.pkg.misc_stalagmite.exec()

    for _, mini_list in pairs({
        {1, "mapgen:stalagmite0", nil},
        {2, nil,                  nil},
        {3, "mapgen:stalagmite2", 1.5},
        {4, "mapgen:stalagmite1", 2},
    }) do

        local i = mini_list[1]
        local orig_name = mini_list[2]
        local visual_scale = mini_list[3]

        unilib.register_node("unilib:misc_stalagmite_" .. i, orig_name, mode, {
            description = S("Stalagmite"),
            tiles = {"unilib_misc_stalactite_" .. i .. ".png^[transformFY"},
            groups = {crumbly = 1, oddly_breakable_by_hand = 1},
            sounds = unilib.global.sound_table.stone,

            drawtype = "plantlike",
            inventory_image = "unilib_misc_stalactite_" .. i .. ".png^[transformFY",
            is_ground_content = false,
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {
                    {-0.3, -0.2, -0.3, 0.3, 0.5, 0.3},
                },
            },
            sunlight_propagates = true,
            visual_scale = visual_scale,
            walkable = false,

            -- N.B. No .on_place() in original code
            on_place = on_place,
        })

    end

end
