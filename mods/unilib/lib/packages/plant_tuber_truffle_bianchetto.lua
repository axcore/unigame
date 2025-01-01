---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nsspf
-- Code:    LGPL
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_tuber_truffle_bianchetto = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.nsspf.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_tuber_truffle_bianchetto.init()

    return {
        description = "Bianchetto truffle",
        depends = {"dirt_ordinary", "shared_nsspf", "tree_aspen"},
    }

end

function unilib.pkg.plant_tuber_truffle_bianchetto.exec()

    unilib.pkg.shared_nsspf.register_truffle({
        -- Code original to unilib, replacing an ABM in the original code. From
        --      nsspf:tuber_borchii, creates unilib:plant_tuber_truffle_bianchetto and
        --      unilib:dirt_ordinary_with_mycelium_bianchetto
        wall_name = "unilib:tree_aspen_trunk",
        part_name = "bianchetto",
        orig_name = "nsspf:tuber_borchii",
        surface_list = {"unilib:dirt_ordinary_with_turf"},

        replace_mode = mode,
        description = S("Bianchetto Truffle"),
        eat = 12,
        sci_name = "Tuber borchii",
    })
    -- (not compatible with flowerpots)

end
