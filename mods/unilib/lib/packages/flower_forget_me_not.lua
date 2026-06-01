---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    elysflowers
-- Code:    GPL-3.0-or-later
-- Media:   CC-BY-4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_forget_me_not = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.elysflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_forget_me_not.init()

    return {
        description = "Forget-Me-Not",
    }

end

function unilib.pkg.flower_forget_me_not.exec()

    local full_name = "unilib:flower_forget_me_not"
    local orig_name = "elysflowers:forget_me_not"
    local img = "unilib_flower_forget_me_not.png"

    unilib.register_node(full_name, orig_name, mode, {
        -- From elysflowers:forget_me_not
        description = unilib.utils.annotate(S("Forget-Me-Not"), "Myosotis scorpiodies"),
        tiles = {img},
        -- N.B. Used standard unilib flower groups, rather than the extended set in original code
        groups = {
            attached_node = 1, color_blue = 1, colour_blue = 1, flammable = 1, flora = 1,
            flower = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        floodable = true,
        inventory_image = img,
        paramtype = "light",
        selection_box = {-0.35, -0.5, -0.35, 0.35, 0.40, 0.35},
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = img,
    })
    unilib.register_flower_in_pot(full_name, orig_name)

    unilib.register_decoration_generic("elysflowers_flower_forget_me_not", {
        -- From elysflowers/init.lua
        deco_type = "simple",
        decoration = full_name,

        noise_params    = {
            octaves = 2,
            offset = 0.00022,
            persist = 0.4,
            scale = 0.0029,
            seed = math.random(),
            spread = {x = 32, y = 32, z = 32},
        },
        rotation = "random",
        sidelen = 16,
    })

end
