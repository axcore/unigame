---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    valleys_c
-- Code:    GPL 3.0/BSD/WTFPL
-- Media:   GPL 3.0/BSD/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_stalactite_small = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.valleys_c.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_register(data_table)

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name
    local img = data_table.img

    local alpha = data_table.alpha or nil
    local description = data_table.description or S("Stalactite")
    local drop = data_table.drop or "unilib:misc_stalactite_small_normal"
    local output = data_table.output or "unilib:stone_ordinary_cobble"

    local full_name = "unilib:misc_stalactite_small_" .. part_name

    unilib.register_node(full_name, "valleys_c:" .. orig_name, mode, {
        description = description,
        tiles = {img},
        groups = {cracky = 3, rock = 1},
        sounds = unilib.sound_table.stone,

        drawtype = "nodebox",
        drop = drop,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.07, 0.0, -0.07, 0.07, 0.5, 0.07},
                {-0.04, -0.25, -0.04, 0.04, 0.0, 0.04},
                {-0.02, -0.5, -0.02, 0.02, 0.25, 0.02},
            },
        },
        paramtype = "light",
        use_texture_alpha = alpha,
        walkable = false,
    })
    -- (Allow conversion to cobble, to get them out of the inventory. Original code used a 3x3 grid)
    unilib.register_craft({
        output = output,
        recipe = {
            {full_name, full_name},
            {full_name, full_name},
        },
    })

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_stalactite_small.init()

    return {
        description = "Small stalactites",
        optional = {"ice_ordinary", "stone_ordinary"},
    }

end

function unilib.pkg.misc_stalactite_small.exec()

    -- From valleys_c:stalactite. Creates unilib:misc_stalactite_small_normal
    do_register({
        part_name = "normal",
        orig_name = "stalactite",
        img = "unilib_stone_ordinary.png",

        description = S("Small Normal Stalactite"),
    })

    -- From valleys_c:stalactite_slimy. Creates unilib:misc_stalactite_small_slimy
    do_register({
        part_name = "slimy",
        orig_name = "stalactite_slimy",
        img = "unilib_stone_ordinary.png^unilib_algae_overlay.png",

        description = S("Small Slimy Stalactite"),
    })

    -- From valleys_c:stalactite_mossy. Creates unilib:misc_stalactite_small_mossy
    do_register({
        part_name = "mossy",
        orig_name = "stalactite_mossy",
        img = "unilib_stone_ordinary.png^unilib_moss_cavern_overlay.png",

        description = S("Small Mossy Stalactite"),
    })

    if unilib.pkg_executed_table["ice_ordinary"] ~= nil then

        -- From valleys_c:icicle_down. Creates unilib:misc_stalactite_small_icy
        do_register({
            part_name = "icy",
            orig_name = "icicle_down",
            img = "unilib_ice_thin.png",

            alpha = "clip",
            description = S("Small Icy Stalactite"),
            drop = "unilib:ice_ordinary",
            output = "unilib:ice_ordinary",
        })

    end

end
