---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_stalactite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function on_place(itemstack, placer, pointed_thing)

    -- Allow placing the node only on ceilings
    local dir = core.dir_to_wallmounted(
        vector.subtract(pointed_thing.under, pointed_thing.above)
    )

    if dir == 0 then
        core.item_place(itemstack, placer, pointed_thing, 1)
    end

    return itemstack

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_stalactite.init()

    return {
        description = "Selection of stalactites",
        notes = "Use the \"meta_farlands_underground\" package to generate these stalactites in" ..
                " ordinary stone caves",
        depends = "stone_ordinary",
    }

end

function unilib.pkg.misc_stalactite.exec()

    for i, orig_name in ipairs({
        "mapgen:stalagtite",
        "mapgen:stalagtite1",
        "mapgen:stalagtite2",
        "mapgen:stalagtite3",
    }) do

        unilib.register_node("unilib:misc_stalactite_" .. i, orig_name, mode, {
            description = S("Stalactite"),
            tiles = {"unilib_misc_stalactite_" .. i .. ".png"},
            groups = {crumbly = 1, oddly_breakable_by_hand = 1},
            sounds = unilib.global.sound_table.stone,

            drawtype = "plantlike",
            inventory_image = "unilib_misc_stalactite_" .. i .. ".png",
            is_ground_content = false,
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {
                    {-0.3, -0.2, -0.3, 0.3, 0.5, 0.3},
                },
            },
            sunlight_propagates = true,
            walkable = false,

            -- N.B. No .on_place() in original code
            on_place = on_place,
        })

    end

end
