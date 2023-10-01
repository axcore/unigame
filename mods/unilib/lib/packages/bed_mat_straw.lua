---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.bed_mat_straw = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cottages.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.bed_mat_straw.init()

    return {
        description = "Decorative straw mat",
        notes = "A decorative bed (does not advance the game time, as a real bed does)",
        depends = {"crop_wheat", "shared_cottages", "stone_ordinary"},
        optional = "misc_straw_ordinary",
    }

end

function unilib.pkg.bed_mat_straw.exec()

    -- Notes from cottages:
    -- An even simpler from of bed - usually for animals
    -- This, and unilib:bed_mat_sleeping, are nodeboxes not wallmounted, as that makes it easier
    --      to replace beds with straw mats
    unilib.register_node("unilib:bed_mat_straw", "cottages:straw_mat", mode, {
        -- From cottages:straw_mat
        description = S("Decorative Straw Mat"),
        tiles = {"unilib_misc_straw_ordinary.png"},
        groups = {flammable = 3, hay = 3, oddly_breakable_by_hand = 2, snappy = 2},
        sounds = unilib.sound_table.leaves,

        drawtype = "nodebox",
        -- N.B. Removed ,so that this item and "unilib:misc_hay_ordinary_pile" are rotated the same
        --      way in the player's inventory
--      inventory_image = "unilib_misc_straw_ordinary.png",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.48, -0.5, -0.48, 0.48, -0.45, 0.48},
            },
        },
        paramtype = 'light',
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.48, -0.5, -0.48, 0.48, -0.25, 0.48},
            }
        },
        sunlight_propagates = true,
        walkable = false,
        wield_image = "unilib_misc_straw_ordinary.png",

        on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)

            return unilib.pkg.shared_cottages.sleep_in_bed(
                pos, node, clicker, itemstack, pointed_thing
            )

        end
    })
    unilib.register_craft({
        -- From cottages:straw_mat
        output = "unilib:bed_mat_straw 6",
        recipe = {
            {"unilib:stone_ordinary", "", ""},
            {"unilib:crop_wheat_harvest", "unilib:crop_wheat_harvest", "unilib:crop_wheat_harvest"},
        },
        replacements = {
            {"unilib:stone_ordinary", "unilib:crop_wheat_seed 3"},
        },
    })
    if unilib.pkg_executed_table["misc_straw_ordinary"] ~= nil then

        unilib.register_craft({
            -- From cottages:straw_mat
            output = "unilib:misc_straw_ordinary_bale",
            recipe = {
                {"unilib:bed_mat_straw"},
                {"unilib:bed_mat_straw"},
                {"unilib:bed_mat_straw"},
            },
        })
        unilib.register_craft({
            -- From cottages:straw_mat
            output = "unilib:bed_mat_straw 3",
            recipe = {
                {"unilib:misc_straw_ordinary_bale"},
            },
        })

    end

end
