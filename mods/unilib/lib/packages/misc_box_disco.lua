---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nbea
-- Code:    WTFPL
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_box_disco = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.nbea.add_mode

local sound_table = {}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function stop_sound(pos)

    local spos = minetest.hash_node_position(pos)
    if sound_table[spos]
        then minetest.sound_stop(sound_table[spos])
    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_box_disco.init()

    return {
        description = "Disco box",
        notes = "Plays disco sound effects when connected to a live mesecon circuit; otherwise," ..
                " it's just an inert box",
        depends = {"metal_copper", "metal_gold", "metal_steel"},
    }

end

function unilib.pkg.misc_box_disco.exec()

    local c_copper = "unilib:metal_copper_ingot"
    local c_gold = "unilib:metal_gold_ingot"
    local c_steel = "unilib:metal_steel_ingot"

    unilib.register_node("unilib:misc_box_disco", "nbea:nbox_009", mode, {
        -- From nbea:nbox_009
        description = S("Disco Box"),
        tiles = {"unilib_misc_box_disco.png"},
        groups = {cracky = 3},
        sounds = unilib.node_sound_metal_defaults({
            place = {name = "unilib_metal_footstep", gain = 0.5},
            dig = {name = "unilib_metal_footstep", gain = 1.0},
            dug = {name = "unilib_metal_footstep", gain = 1.0},
        }),

        drawtype = "nodebox",
        -- N.B. inventory_image removed from original code
--      inventory_image = "unilib_misc_box_disco.png",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                -- Top (Y+)
                {-0.0625, 0, -0.0625, 0.0625, 0.0625, 0.0625},
                {-0.125, 0.0625, -0.125, 0.125, 0.125, -0.0625},
                {-0.125, 0.0625, 0.0625, 0.125, 0.125, 0.125},
                {0.0625, 0.0625, -0.0625, 0.125, 0.125, 0.0625},
                {-0.125, 0.0625, -0.0625, -0.0625, 0.125, 0.0625},
                {0.125, 0.125, -0.1875, 0.1875, 0.1875, 0.1875},
                {-0.1875, 0.125, -0.1875, -0.125, 0.1875, 0.1875},
                {-0.125, 0.125, 0.125, 0.125, 0.1875, 0.1875},
                {-0.125, 0.125, -0.1875, 0.125, 0.1875, -0.125},
                {-0.25, 0.1875, 0.1875, 0.25, 0.25, 0.25},
                {-0.25, 0.1875, -0.25, 0.25, 0.25, -0.1875},
                {0.1875, 0.1875, -0.1875, 0.25, 0.25, 0.1875},
                {-0.25, 0.1875, -0.1875, -0.1875, 0.25, 0.1875},
                {-0.3125, 0.25, -0.3125, -0.25, 0.3125, 0.3125},
                {0.25, 0.25, -0.3125, 0.3125, 0.3125, 0.3125},
                {-0.25, 0.25, -0.3125, 0.25, 0.3125, -0.25},
                {-0.25, 0.25, 0.25, 0.25, 0.3125, 0.3125},
                {-0.375, 0.3125, 0.3125, 0.375, 0.375, 0.375},
                {-0.375, 0.3125, -0.375, 0.375, 0.375, -0.3125},
                {0.3125, 0.3125, -0.3125, 0.375, 0.375, 0.3125},
                {-0.375, 0.3125, -0.3125, -0.3125, 0.375, 0.3125},
                {-0.4375, 0.375, -0.4375, -0.375, 0.4375, 0.4375},
                {0.375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
                {-0.4375, 0.375, 0.375, 0.4375, 0.4375, 0.4375},
                {-0.375, 0.375, -0.4375, 0.375, 0.4375, -0.375},
                -- Bottom (Y-)
                {-0.0625, -0.0625, -0.0625, 0.0625, -0, 0.0625},
                {0.0625, -0.125, -0.125, 0.125, -0.0625, 0.125},
                {-0.125, -0.125, -0.125, -0.0625, -0.0625, 0.125},
                {-0.0625, -0.125, -0.125, 0.0625, -0.0625, -0.0625},
                {-0.0625, -0.125, 0.0625, 0.0625, -0.0625, 0.125},
                {-0.1875, -0.1875, -0.1875, 0.1875, -0.125, -0.125},
                {-0.1875, -0.1875, 0.125, 0.1875, -0.125, 0.1875},
                {-0.1875, -0.1875, -0.125, -0.125, -0.125, 0.125},
                {0.125, -0.1875, -0.125, 0.1875, -0.125, 0.125},
                {-0.25, -0.25, -0.25, -0.1875, -0.1875, 0.25},
                {0.1875, -0.25, -0.25, 0.25, -0.1875, 0.25},
                {-0.1875, -0.25, -0.25, 0.1875, -0.1875, -0.1875},
                {-0.1875, -0.25, 0.1875, 0.1875, -0.1875, 0.25},
                {-0.3125, -0.3125, 0.25, 0.3125, -0.25, 0.3125},
                {-0.3125, -0.3125, -0.3125, 0.3125, -0.25, -0.25},
                {0.25, -0.3125, -0.25, 0.3125, -0.25, 0.25},
                {-0.3125, -0.3125, -0.25, -0.25, -0.25, 0.25},
                {-0.375, -0.375, -0.375, -0.3125, -0.3125, 0.375},
                {0.3125, -0.375, -0.375, 0.375, -0.3125, 0.375},
                {-0.3125, -0.375, -0.375, 0.3125, -0.3125, -0.3125},
                {-0.3125, -0.375, 0.3125, 0.3125, -0.3125, 0.375},
                {-0.4375, -0.4375, 0.375, 0.4375, -0.375, 0.4375},
                {-0.4375, -0.4375, -0.4375, 0.4375, -0.375, -0.375},
                {-0.4375, -0.4375, -0.4375, -0.375, -0.375, 0.4375},
                {0.375, -0.4375, -0.375, 0.4375, -0.375, 0.375},
                -- Right (X+)
                {0, -0.0625, -0.0625, 0.0625, 0.0625, 0.0625},
                {0.0625, -0.125, -0.125, 0.125, 0.125, -0.0625},
                {0.0625, -0.125, 0.0625, 0.125, 0.125, 0.125},
                {0.0625, -0.125, -0.0625, 0.125, -0.0625, 0.0625},
                {0.0625, 0.0625, -0.0625, 0.125, 0.125, 0.0625},
                {0.125, -0.1875, -0.1875, 0.1875, -0.125, 0.1875},
                {0.125, 0.125, -0.1875, 0.1875, 0.1875, 0.1875},
                {0.125, -0.125, 0.125, 0.1875, 0.125, 0.1875},
                {0.125, -0.125, -0.1875, 0.1875, 0.125, -0.125},
                {0.1875, -0.25, 0.1875, 0.25, 0.25, 0.25},
                {0.1875, -0.25, -0.25, 0.25, 0.25, -0.1875},
                {0.1875, -0.25, -0.1875, 0.25, -0.1875, 0.1875},
                {0.1875, 0.1875, -0.1875, 0.25, 0.25, 0.1875},
                {0.25, 0.25, -0.3125, 0.3125, 0.3125, 0.3125},
                {0.25, -0.3125, -0.3125, 0.3125, -0.25, 0.3125},
                {0.25, -0.25, -0.3125, 0.3125, 0.25, -0.25},
                {0.25, -0.25, 0.25, 0.3125, 0.25, 0.3125},
                {0.3125, -0.375, 0.3125, 0.375, 0.375, 0.375},
                {0.3125, -0.375, -0.375, 0.375, 0.375, -0.3125},
                {0.3125, -0.375, -0.3125, 0.375, -0.3125, 0.3125},
                {0.3125, 0.3125, -0.3125, 0.375, 0.375, 0.3125},
                {0.375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
                {0.375, -0.4375, -0.4375, 0.4375, -0.375, 0.4375},
                {0.375, -0.4375, 0.375, 0.4375, 0.4375, 0.4375},
                {0.375, -0.375, -0.4375, 0.4375, 0.375, -0.375},
                -- Left (X-)
                {-0.0625, -0.0625, -0.0625, -0, 0.0625, 0.0625},
                {-0.125, -0.125, 0.0625, -0.0625, 0.125, 0.125},
                {-0.125, -0.125, -0.125, -0.0625, 0.125, -0.0625},
                {-0.125, -0.125, -0.0625, -0.0625, -0.0625, 0.0625},
                {-0.125, 0.0625, -0.0625, -0.0625, 0.125, 0.0625},
                {-0.1875, -0.1875, -0.1875, -0.125, -0.125, 0.1875},
                {-0.1875, 0.125, -0.1875, -0.125, 0.1875, 0.1875},
                {-0.1875, -0.125, -0.1875, -0.125, 0.125, -0.125},
                {-0.1875, -0.125, 0.125, -0.125, 0.125, 0.1875},
                {-0.25, -0.25, -0.25, -0.1875, 0.25, -0.1875},
                {-0.25, -0.25, 0.1875, -0.1875, 0.25, 0.25},
                {-0.25, -0.25, -0.1875, -0.1875, -0.1875, 0.1875},
                {-0.25, 0.1875, -0.1875, -0.1875, 0.25, 0.1875},
                {-0.3125, 0.25, -0.3125, -0.25, 0.3125, 0.3125},
                {-0.3125, -0.3125, -0.3125, -0.25, -0.25, 0.3125},
                {-0.3125, -0.25, 0.25, -0.25, 0.25, 0.3125},
                {-0.3125, -0.25, -0.3125, -0.25, 0.25, -0.25},
                {-0.375, -0.375, -0.375, -0.3125, 0.375, -0.3125},
                {-0.375, -0.375, 0.3125, -0.3125, 0.375, 0.375},
                {-0.375, -0.375, -0.3125, -0.3125, -0.3125, 0.3125},
                {-0.375, 0.3125, -0.3125, -0.3125, 0.375, 0.3125},
                {-0.4375, 0.375, -0.4375, -0.375, 0.4375, 0.4375},
                {-0.4375, -0.4375, -0.4375, -0.375, -0.375, 0.4375},
                {-0.4375, -0.4375, -0.4375, -0.375, 0.4375, -0.375},
                {-0.4375, -0.375, 0.375, -0.375, 0.375, 0.4375},
                -- Back (Z+)
                {-0.0625, -0.0625, 0, 0.0625, 0.0625, 0.0625},
                {0.0625, -0.125, 0.0625, 0.125, 0.125, 0.125},
                {-0.125, -0.125, 0.0625, -0.0625, 0.125, 0.125},
                {-0.0625, -0.125, 0.0625, 0.0625, -0.0625, 0.125},
                {-0.0625, 0.0625, 0.0625, 0.0625, 0.125, 0.125},
                {-0.1875, -0.1875, 0.125, 0.1875, -0.125, 0.1875},
                {-0.1875, 0.125, 0.125, 0.1875, 0.1875, 0.1875},
                {-0.1875, -0.125, 0.125, -0.125, 0.125, 0.1875},
                {0.125, -0.125, 0.125, 0.1875, 0.125, 0.1875},
                {-0.25, -0.25, 0.1875, -0.1875, 0.25, 0.25},
                {0.1875, -0.25, 0.1875, 0.25, 0.25, 0.25},
                {-0.1875, -0.25, 0.1875, 0.1875, -0.1875, 0.25},
                {-0.1875, 0.1875, 0.1875, 0.1875, 0.25, 0.25},
                {-0.3125, 0.25, 0.25, 0.3125, 0.3125, 0.3125},
                {-0.3125, -0.3125, 0.25, 0.3125, -0.25, 0.3125},
                {0.25, -0.25, 0.25, 0.3125, 0.25, 0.3125},
                {-0.3125, -0.25, 0.25, -0.25, 0.25, 0.3125},
                {-0.375, -0.375, 0.3125, -0.3125, 0.375, 0.375},
                {0.3125, -0.375, 0.3125, 0.375, 0.375, 0.375},
                {-0.3125, -0.375, 0.3125, 0.3125, -0.3125, 0.375},
                {-0.3125, 0.3125, 0.3125, 0.3125, 0.375, 0.375},
                {-0.4375, 0.375, 0.375, 0.4375, 0.4375, 0.4375},
                {-0.4375, -0.4375, 0.375, 0.4375, -0.375, 0.4375},
                {-0.4375, -0.4375, 0.375, -0.375, 0.4375, 0.4375},
                {0.375, -0.375, 0.375, 0.4375, 0.375, 0.4375},
                -- Front (Z-)
                {-0.0625, -0.0625, -0.0625, 0.0625, 0.0625, -0},
                {-0.125, -0.125, -0.125, -0.0625, 0.125, -0.0625},
                {0.0625, -0.125, -0.125, 0.125, 0.125, -0.0625},
                {-0.0625, -0.125, -0.125, 0.0625, -0.0625, -0.0625},
                {-0.0625, 0.0625, -0.125, 0.0625, 0.125, -0.0625},
                {-0.1875, -0.1875, -0.1875, 0.1875, -0.125, -0.125},
                {-0.1875, 0.125, -0.1875, 0.1875, 0.1875, -0.125},
                {0.125, -0.125, -0.1875, 0.1875, 0.125, -0.125},
                {-0.1875, -0.125, -0.1875, -0.125, 0.125, -0.125},
                {0.1875, -0.25, -0.25, 0.25, 0.25, -0.1875},
                {-0.25, -0.25, -0.25, -0.1875, 0.25, -0.1875},
                {-0.1875, -0.25, -0.25, 0.1875, -0.1875, -0.1875},
                {-0.1875, 0.1875, -0.25, 0.1875, 0.25, -0.1875},
                {-0.3125, 0.25, -0.3125, 0.3125, 0.3125, -0.25},
                {-0.3125, -0.3125, -0.3125, 0.3125, -0.25, -0.25},
                {-0.3125, -0.25, -0.3125, -0.25, 0.25, -0.25},
                {0.25, -0.25, -0.3125, 0.3125, 0.25, -0.25},
                {0.3125, -0.375, -0.375, 0.375, 0.375, -0.3125},
                {-0.375, -0.375, -0.375, -0.3125, 0.375, -0.3125},
                {-0.3125, -0.375, -0.375, 0.3125, -0.3125, -0.3125},
                {-0.3125, 0.3125, -0.375, 0.3125, 0.375, -0.3125},
                {-0.4375, 0.375, -0.4375, 0.4375, 0.4375, -0.375},
                {-0.4375, -0.4375, -0.4375, 0.4375, -0.375, -0.375},
                {0.375, -0.4375, -0.4375, 0.4375, 0.4375, -0.375},
                {-0.4375, -0.375, -0.4375, -0.375, 0.375, -0.375},
                -- Corner frame
                {-0.4375, 0.4375, 0.4375, 0.4375, 0.5, 0.5},
                {-0.4375, -0.5, 0.4375, 0.4375, -0.4375, 0.5},
                {-0.5, -0.5, 0.4375, -0.4375, 0.5, 0.5},
                {0.4375, -0.5, 0.4375, 0.5, 0.5, 0.5},
                {-0.5, 0.4375, -0.4375, -0.4375, 0.5, 0.4375},
                {-0.5, -0.5, -0.4375, -0.4375, -0.4375, 0.4375},
                {0.4375, 0.4375, -0.4375, 0.5, 0.5, 0.4375},
                {0.4375, -0.5, -0.4375, 0.5, -0.4375, 0.4375},
                {-0.5, 0.4375, -0.5, 0.5, 0.5, -0.4375},
                {-0.5, -0.5, -0.5, 0.5, -0.4375, -0.4375},
                {0.4375, -0.4375, -0.5, 0.5, 0.4375, -0.4375},
                {-0.5, -0.4375, -0.5, -0.4375, 0.4375, -0.4375},
            },
        },
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            },
        },
        sunlight_propagates = true,
        wield_image = "unilib_misc_box_disco.png",
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:misc_box_disco",
        recipe = {
            {c_steel, c_steel, c_steel},
            {c_copper, c_gold, c_copper},
            {c_steel, c_steel, c_steel},
        },
    })

    if minetest.get_modpath("mesecons") then

        unilib.override_item("unilib:misc_box_disco", {
            groups = {cracky = 3, mesecon = 1, mesecon_effector_off = 1},

            mesecons = {
                effector = {
                    state = mesecon.state.off,

                    action_on = function(pos, node)

                        minetest.swap_node(pos, {name = "unilib:misc_box_disco_on"})

                        local spos = minetest.hash_node_position(pos)
                        sound_table[spos] = minetest.sound_play(
                            "unilib_misc_box_disco",
                            {pos = pos, max_hear_distance = 10, gain = 1.25, loop = true}
                        )

                    end,
                },
            },

            on_construct = function(pos)
                stop_sound(pos)
            end,
        })

        unilib.register_node("unilib:misc_box_disco_on", "nbea:nbox_009_on", mode, {
            -- From nbea:nbox_009_on
            description = S("Disco Box"),
            tiles = {
                {
                    animation = {
                        type = "vertical_frames",
                        aspect_w = 16,
                        aspect_h = 16,
                        length = 3.0
                    },
                    backface_culling = false,
                    image = "unilib_misc_box_disco_animated.png",
                }
            },
            groups = {cracky = 3, mesecon = 1, not_in_creative_inventory = 1},
            sounds = unilib.node_sound_metal_defaults({
                place = {name = "unilib_metal_footstep", gain = 0.5},
                dig = {name = "unilib_metal_footstep", gain = 1.0},
                dug = {name = "unilib_metal_footstep", gain = 1.0},
            }),

            drawtype = "nodebox",
            drop = "unilib:misc_box_disco",
            is_ground_content = false,
            mesecons = {
                effector = {
                    state = mesecon.state.on,

                    action_off = function(pos, node)

                        stop_sound(pos)
                        minetest.swap_node(pos, {name = "unilib:misc_box_disco"})

                    end,
                },
            },
            node_box = {
                type = "fixed",
                fixed = {
                    -- Top (Y+)
                    {-0.0625, 0, -0.0625, 0.0625, 0.0625, 0.0625},
                    {-0.125, 0.0625, -0.125, 0.125, 0.125, -0.0625},
                    {-0.125, 0.0625, 0.0625, 0.125, 0.125, 0.125},
                    {0.0625, 0.0625, -0.0625, 0.125, 0.125, 0.0625},
                    {-0.125, 0.0625, -0.0625, -0.0625, 0.125, 0.0625},
                    {0.125, 0.125, -0.1875, 0.1875, 0.1875, 0.1875},
                    {-0.1875, 0.125, -0.1875, -0.125, 0.1875, 0.1875},
                    {-0.125, 0.125, 0.125, 0.125, 0.1875, 0.1875},
                    {-0.125, 0.125, -0.1875, 0.125, 0.1875, -0.125},
                    {-0.25, 0.1875, 0.1875, 0.25, 0.25, 0.25},
                    {-0.25, 0.1875, -0.25, 0.25, 0.25, -0.1875},
                    {0.1875, 0.1875, -0.1875, 0.25, 0.25, 0.1875},
                    {-0.25, 0.1875, -0.1875, -0.1875, 0.25, 0.1875},
                    {-0.3125, 0.25, -0.3125, -0.25, 0.3125, 0.3125},
                    {0.25, 0.25, -0.3125, 0.3125, 0.3125, 0.3125},
                    {-0.25, 0.25, -0.3125, 0.25, 0.3125, -0.25},
                    {-0.25, 0.25, 0.25, 0.25, 0.3125, 0.3125},
                    {-0.375, 0.3125, 0.3125, 0.375, 0.375, 0.375},
                    {-0.375, 0.3125, -0.375, 0.375, 0.375, -0.3125},
                    {0.3125, 0.3125, -0.3125, 0.375, 0.375, 0.3125},
                    {-0.375, 0.3125, -0.3125, -0.3125, 0.375, 0.3125},
                    {-0.4375, 0.375, -0.4375, -0.375, 0.4375, 0.4375},
                    {0.375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
                    {-0.4375, 0.375, 0.375, 0.4375, 0.4375, 0.4375},
                    {-0.375, 0.375, -0.4375, 0.375, 0.4375, -0.375},
                    -- Bottom (Y-)
                    {-0.0625, -0.0625, -0.0625, 0.0625, -0, 0.0625},
                    {0.0625, -0.125, -0.125, 0.125, -0.0625, 0.125},
                    {-0.125, -0.125, -0.125, -0.0625, -0.0625, 0.125},
                    {-0.0625, -0.125, -0.125, 0.0625, -0.0625, -0.0625},
                    {-0.0625, -0.125, 0.0625, 0.0625, -0.0625, 0.125},
                    {-0.1875, -0.1875, -0.1875, 0.1875, -0.125, -0.125},
                    {-0.1875, -0.1875, 0.125, 0.1875, -0.125, 0.1875},
                    {-0.1875, -0.1875, -0.125, -0.125, -0.125, 0.125},
                    {0.125, -0.1875, -0.125, 0.1875, -0.125, 0.125},
                    {-0.25, -0.25, -0.25, -0.1875, -0.1875, 0.25},
                    {0.1875, -0.25, -0.25, 0.25, -0.1875, 0.25},
                    {-0.1875, -0.25, -0.25, 0.1875, -0.1875, -0.1875},
                    {-0.1875, -0.25, 0.1875, 0.1875, -0.1875, 0.25},
                    {-0.3125, -0.3125, 0.25, 0.3125, -0.25, 0.3125},
                    {-0.3125, -0.3125, -0.3125, 0.3125, -0.25, -0.25},
                    {0.25, -0.3125, -0.25, 0.3125, -0.25, 0.25},
                    {-0.3125, -0.3125, -0.25, -0.25, -0.25, 0.25},
                    {-0.375, -0.375, -0.375, -0.3125, -0.3125, 0.375},
                    {0.3125, -0.375, -0.375, 0.375, -0.3125, 0.375},
                    {-0.3125, -0.375, -0.375, 0.3125, -0.3125, -0.3125},
                    {-0.3125, -0.375, 0.3125, 0.3125, -0.3125, 0.375},
                    {-0.4375, -0.4375, 0.375, 0.4375, -0.375, 0.4375},
                    {-0.4375, -0.4375, -0.4375, 0.4375, -0.375, -0.375},
                    {-0.4375, -0.4375, -0.4375, -0.375, -0.375, 0.4375},
                    {0.375, -0.4375, -0.375, 0.4375, -0.375, 0.375},
                    -- Right (X+)
                    {0, -0.0625, -0.0625, 0.0625, 0.0625, 0.0625},
                    {0.0625, -0.125, -0.125, 0.125, 0.125, -0.0625},
                    {0.0625, -0.125, 0.0625, 0.125, 0.125, 0.125},
                    {0.0625, -0.125, -0.0625, 0.125, -0.0625, 0.0625},
                    {0.0625, 0.0625, -0.0625, 0.125, 0.125, 0.0625},
                    {0.125, -0.1875, -0.1875, 0.1875, -0.125, 0.1875},
                    {0.125, 0.125, -0.1875, 0.1875, 0.1875, 0.1875},
                    {0.125, -0.125, 0.125, 0.1875, 0.125, 0.1875},
                    {0.125, -0.125, -0.1875, 0.1875, 0.125, -0.125},
                    {0.1875, -0.25, 0.1875, 0.25, 0.25, 0.25},
                    {0.1875, -0.25, -0.25, 0.25, 0.25, -0.1875},
                    {0.1875, -0.25, -0.1875, 0.25, -0.1875, 0.1875},
                    {0.1875, 0.1875, -0.1875, 0.25, 0.25, 0.1875},
                    {0.25, 0.25, -0.3125, 0.3125, 0.3125, 0.3125},
                    {0.25, -0.3125, -0.3125, 0.3125, -0.25, 0.3125},
                    {0.25, -0.25, -0.3125, 0.3125, 0.25, -0.25},
                    {0.25, -0.25, 0.25, 0.3125, 0.25, 0.3125},
                    {0.3125, -0.375, 0.3125, 0.375, 0.375, 0.375},
                    {0.3125, -0.375, -0.375, 0.375, 0.375, -0.3125},
                    {0.3125, -0.375, -0.3125, 0.375, -0.3125, 0.3125},
                    {0.3125, 0.3125, -0.3125, 0.375, 0.375, 0.3125},
                    {0.375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
                    {0.375, -0.4375, -0.4375, 0.4375, -0.375, 0.4375},
                    {0.375, -0.4375, 0.375, 0.4375, 0.4375, 0.4375},
                    {0.375, -0.375, -0.4375, 0.4375, 0.375, -0.375},
                    -- Left (X-)
                    {-0.0625, -0.0625, -0.0625, -0, 0.0625, 0.0625},
                    {-0.125, -0.125, 0.0625, -0.0625, 0.125, 0.125},
                    {-0.125, -0.125, -0.125, -0.0625, 0.125, -0.0625},
                    {-0.125, -0.125, -0.0625, -0.0625, -0.0625, 0.0625},
                    {-0.125, 0.0625, -0.0625, -0.0625, 0.125, 0.0625},
                    {-0.1875, -0.1875, -0.1875, -0.125, -0.125, 0.1875},
                    {-0.1875, 0.125, -0.1875, -0.125, 0.1875, 0.1875},
                    {-0.1875, -0.125, -0.1875, -0.125, 0.125, -0.125},
                    {-0.1875, -0.125, 0.125, -0.125, 0.125, 0.1875},
                    {-0.25, -0.25, -0.25, -0.1875, 0.25, -0.1875},
                    {-0.25, -0.25, 0.1875, -0.1875, 0.25, 0.25},
                    {-0.25, -0.25, -0.1875, -0.1875, -0.1875, 0.1875},
                    {-0.25, 0.1875, -0.1875, -0.1875, 0.25, 0.1875},
                    {-0.3125, 0.25, -0.3125, -0.25, 0.3125, 0.3125},
                    {-0.3125, -0.3125, -0.3125, -0.25, -0.25, 0.3125},
                    {-0.3125, -0.25, 0.25, -0.25, 0.25, 0.3125},
                    {-0.3125, -0.25, -0.3125, -0.25, 0.25, -0.25},
                    {-0.375, -0.375, -0.375, -0.3125, 0.375, -0.3125},
                    {-0.375, -0.375, 0.3125, -0.3125, 0.375, 0.375},
                    {-0.375, -0.375, -0.3125, -0.3125, -0.3125, 0.3125},
                    {-0.375, 0.3125, -0.3125, -0.3125, 0.375, 0.3125},
                    {-0.4375, 0.375, -0.4375, -0.375, 0.4375, 0.4375},
                    {-0.4375, -0.4375, -0.4375, -0.375, -0.375, 0.4375},
                    {-0.4375, -0.4375, -0.4375, -0.375, 0.4375, -0.375},
                    {-0.4375, -0.375, 0.375, -0.375, 0.375, 0.4375},
                    -- Back (Z+)
                    {-0.0625, -0.0625, 0, 0.0625, 0.0625, 0.0625},
                    {0.0625, -0.125, 0.0625, 0.125, 0.125, 0.125},
                    {-0.125, -0.125, 0.0625, -0.0625, 0.125, 0.125},
                    {-0.0625, -0.125, 0.0625, 0.0625, -0.0625, 0.125},
                    {-0.0625, 0.0625, 0.0625, 0.0625, 0.125, 0.125},
                    {-0.1875, -0.1875, 0.125, 0.1875, -0.125, 0.1875},
                    {-0.1875, 0.125, 0.125, 0.1875, 0.1875, 0.1875},
                    {-0.1875, -0.125, 0.125, -0.125, 0.125, 0.1875},
                    {0.125, -0.125, 0.125, 0.1875, 0.125, 0.1875},
                    {-0.25, -0.25, 0.1875, -0.1875, 0.25, 0.25},
                    {0.1875, -0.25, 0.1875, 0.25, 0.25, 0.25},
                    {-0.1875, -0.25, 0.1875, 0.1875, -0.1875, 0.25},
                    {-0.1875, 0.1875, 0.1875, 0.1875, 0.25, 0.25},
                    {-0.3125, 0.25, 0.25, 0.3125, 0.3125, 0.3125},
                    {-0.3125, -0.3125, 0.25, 0.3125, -0.25, 0.3125},
                    {0.25, -0.25, 0.25, 0.3125, 0.25, 0.3125},
                    {-0.3125, -0.25, 0.25, -0.25, 0.25, 0.3125},
                    {-0.375, -0.375, 0.3125, -0.3125, 0.375, 0.375},
                    {0.3125, -0.375, 0.3125, 0.375, 0.375, 0.375},
                    {-0.3125, -0.375, 0.3125, 0.3125, -0.3125, 0.375},
                    {-0.3125, 0.3125, 0.3125, 0.3125, 0.375, 0.375},
                    {-0.4375, 0.375, 0.375, 0.4375, 0.4375, 0.4375},
                    {-0.4375, -0.4375, 0.375, 0.4375, -0.375, 0.4375},
                    {-0.4375, -0.4375, 0.375, -0.375, 0.4375, 0.4375},
                    {0.375, -0.375, 0.375, 0.4375, 0.375, 0.4375},
                    -- Front (Z-)
                    {-0.0625, -0.0625, -0.0625, 0.0625, 0.0625, -0},
                    {-0.125, -0.125, -0.125, -0.0625, 0.125, -0.0625},
                    {0.0625, -0.125, -0.125, 0.125, 0.125, -0.0625},
                    {-0.0625, -0.125, -0.125, 0.0625, -0.0625, -0.0625},
                    {-0.0625, 0.0625, -0.125, 0.0625, 0.125, -0.0625},
                    {-0.1875, -0.1875, -0.1875, 0.1875, -0.125, -0.125},
                    {-0.1875, 0.125, -0.1875, 0.1875, 0.1875, -0.125},
                    {0.125, -0.125, -0.1875, 0.1875, 0.125, -0.125},
                    {-0.1875, -0.125, -0.1875, -0.125, 0.125, -0.125},
                    {0.1875, -0.25, -0.25, 0.25, 0.25, -0.1875},
                    {-0.25, -0.25, -0.25, -0.1875, 0.25, -0.1875},
                    {-0.1875, -0.25, -0.25, 0.1875, -0.1875, -0.1875},
                    {-0.1875, 0.1875, -0.25, 0.1875, 0.25, -0.1875},
                    {-0.3125, 0.25, -0.3125, 0.3125, 0.3125, -0.25},
                    {-0.3125, -0.3125, -0.3125, 0.3125, -0.25, -0.25},
                    {-0.3125, -0.25, -0.3125, -0.25, 0.25, -0.25},
                    {0.25, -0.25, -0.3125, 0.3125, 0.25, -0.25},
                    {0.3125, -0.375, -0.375, 0.375, 0.375, -0.3125},
                    {-0.375, -0.375, -0.375, -0.3125, 0.375, -0.3125},
                    {-0.3125, -0.375, -0.375, 0.3125, -0.3125, -0.3125},
                    {-0.3125, 0.3125, -0.375, 0.3125, 0.375, -0.3125},
                    {-0.4375, 0.375, -0.4375, 0.4375, 0.4375, -0.375},
                    {-0.4375, -0.4375, -0.4375, 0.4375, -0.375, -0.375},
                    {0.375, -0.4375, -0.4375, 0.4375, 0.4375, -0.375},
                    {-0.4375, -0.375, -0.4375, -0.375, 0.375, -0.375},
                    -- Corner frame
                    {-0.4375, 0.4375, 0.4375, 0.4375, 0.5, 0.5},
                    {-0.4375, -0.5, 0.4375, 0.4375, -0.4375, 0.5},
                    {-0.5, -0.5, 0.4375, -0.4375, 0.5, 0.5},
                    {0.4375, -0.5, 0.4375, 0.5, 0.5, 0.5},
                    {-0.5, 0.4375, -0.4375, -0.4375, 0.5, 0.4375},
                    {-0.5, -0.5, -0.4375, -0.4375, -0.4375, 0.4375},
                    {0.4375, 0.4375, -0.4375, 0.5, 0.5, 0.4375},
                    {0.4375, -0.5, -0.4375, 0.5, -0.4375, 0.4375},
                    {-0.5, 0.4375, -0.5, 0.5, 0.5, -0.4375},
                    {-0.5, -0.5, -0.5, 0.5, -0.4375, -0.4375},
                    {0.4375, -0.4375, -0.5, 0.5, 0.4375, -0.4375},
                    {-0.5, -0.4375, -0.5, -0.4375, 0.4375, -0.4375},
                },
            },
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
                },
            },
            sunlight_propagates = true,

            on_destruct = function(pos)
                stop_sound(pos)
            end,
        })

    end

end