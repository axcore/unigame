---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/bushes
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.bush_branching_shrub = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bushes.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.bush_branching_shrub.init()

    return {
        description = "Branching bush (as a shrub)",
        depends = {"bush_branching_yellow", "item_stick_ordinary", "shared_bushes"},
    }

end

function unilib.pkg.bush_branching_shrub.exec()

    unilib.register_node("unilib:bush_branching_shrub", "bushes:youngtree2_bottom", mode, {
        -- From bushes:youngtree2_bottom
        description = S("Branching Bush Shrub"),
        tiles = {"unilib_bush_branching_trunk.png"},
        -- N.B. no bush = 1 in original code
        groups = {attached_node = 1, bush = 1, flammable = 2, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "nodebox",
        drop = "unilib:item_stick_ordinary",
        inventory_image = "unilib_bush_branching_trunk_inv.png",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.0612, -0.500000, -0.500000, 0.0612, 0.500000, -0.375000},
            },
        },
        paramtype = "light",
        walkable = false,
        wield_image = "unilib_bush_branching_trunk_inv.png",
    })

    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_bush_branching_shrub"
        part_name = "bush_branching_shrub",
        convert_func = unilib.pkg.shared_bushes.grow_shrub,
        replace_mode = mode,

        generic_def_table = {
            fill_ratio = unilib.utils.convert_biome_lib({
                rarity = 100,
                rarity_fertility = 0.6,
                plantlife_limit = -0.5,
            }),
        },
    })

end
