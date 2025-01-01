---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.pane_lattice_papyrus_ornate = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.pane_lattice_papyrus_ornate.init()

    return {
        description = "Ornate papyrus lattice",
        depends = {"item_string_ordinary", "plant_papyrus_ordinary"},
    }

end

function unilib.pkg.pane_lattice_papyrus_ornate.exec()

    local c_papyrus = "unilib:plant_papyrus_ordinary"
    local c_string = "unilib:item_string_ordinary"
    local img = "unilib_pane_lattice_papyrus_ornate.png"

    local recipe_table = {
        {c_papyrus, c_string, c_papyrus},
        {c_papyrus, c_string, c_papyrus},
    }
    if unilib.setting.mtgame_tweak_flag then

        -- N.B. If allowed, tweak the original recipe so that it matches the one in the
        --      "pane_lattice_papyrus_simple" package
        recipe_table = {
            {c_papyrus, c_papyrus, c_papyrus},
            {c_papyrus, c_string,  c_papyrus},
            {c_papyrus, c_papyrus, c_papyrus},
        }

    end

    unilib.register_pane({
        -- From mtg_plus mod, xpanes:papyrus_flat. Creates unilib:pane_lattice_papyrus_ornate_flat,
        --      unilib:pane_lattice_papyrus_ornate_crossed
        part_name = "lattice_papyrus_ornate",
        orig_name = {nil, nil},
        def_table = {
            description = S("Ornate Papyrus Lattice"),
            textures = {img, img, img},
            groups = {choppy = 1, flammable = 2, snappy = 2},
            sounds = unilib.global.sound_table.leaves,

            inventory_image = img,
            recipe = recipe_table,
            wield_image = img,
        },

        replace_mode = mode,
    })
    unilib.register_craft({
        -- From mtg_plus mod, xpanes:papyrus_flat
        type = "fuel",
        recipe = "unilib:pane_lattice_papyrus_ornate_flat",
        burntime = 1,
    })


end
