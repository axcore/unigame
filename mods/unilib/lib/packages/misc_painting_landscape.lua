---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_painting_landscape = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xdecor.add_mode

local node_box = {
    type = "wallmounted",
    wall_top = {-16/32, 7/32, -12/32, 16/32, 8/32, 12/32},
    wall_bottom = {-16/32, -8/32, -12/32, 16/32, -7/32, 12/32},
    wall_side = {-7/32, -12/32, -16/32, -8/32, 12/32, 16/32},
}

local selection_box = {
    type = "fixed",
    fixed = {-16/16, -8/16, -12/16, 16/16, -7/16, 12/16},
}

local painting_list = {
    {S("The Tower of Babel"), S("Pieter Bruegel the Elder")},
    {S("The Last Supper"), S("Leonardo da Vinci")},
    {S("The Creation of Adam"), S("Michelangelo")},
    {S("Going to Work"), S("L. S. Lowry")},
    {S("The Grand Canal, Venice"), S("J. M. W. Turner")},

    {S("Persistence of Memory"), S("Salvador Dali")},
    {S("The Basket of Apples"), S("Paul Cézanne")},
    {S("Whistler's Mother"), S("James Whistler")},
    {S("Seaport with the Embarkation of the Queen of Sheba"), S("Claude Lorrain")},
    {S("The Birth of Venus"), S("Sandro Botticelli")},

    {S("The Great Wave off Kanagawa"), S("Hokusai")},
    {S("The Beheading of John the Baptist"), S("Caravaggio")},
    {S("The Harvesters"), S("Pieter Bruegel the Elder")},
    {S("The Hay Wain"), S("John Constable")},
    {S("Starry Night"), S("Vincent van Gogh")},

    {S("A Meadow in The Mountains"), S("Vincent van Gogh")},
    {S("Maternity"), S("George Hitchcock")},
    {S("Japanese Footbridge"), S("Claude Monet")},
    {S("The Hunters in The Snow"), S("Pieter Bruegel the Elder")},
    {S("A Bar at the Folies-Bergère"), S("Édouard Manet")},
}

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_painting_landscape.init()

    return {
        description = "Landscape painting set",
        notes = "When placed, one of up to twenty paintings becomes visible at random",
        depends = "sign_wall_wood",
    }

end

function unilib.pkg.misc_painting_landscape.exec()

    unilib.register_node("unilib:misc_painting_landscape_1", nil, mode, {
        -- Adapted from xdecor:painting_1, but with a new painting
        description = S("Landscape Painting"),
        tiles = {"unilib_misc_painting_landscape_1.png", "unilib_misc_painting_frame_large.png"},
        groups = {attached_node = 1, choppy = 3, flammable = 2, oddly_breakable_by_hand = 2},
        sounds = unilib.global.sound_table.wood,

        collision_box = selection_box,
        drawtype = "nodebox",
        inventory_image = "unilib_misc_painting_landscape_inv.png",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = node_box,
        node_placement_prediction = "",
        paramtype = "light",
        paramtype2 = "wallmounted",
        selection_box = selection_box,
        sunlight_propagates = true,
        use_texture_alpha = "opaque",
        visual_scale = 2,
        wield_image = "unilib_misc_painting_landscape_inv.png",

        on_place = function(itemstack, placer, pointed_thing)

            -- (Compatibility with wooden display frames, etc)
            if unilib.misc.pointed_has_rightclick(itemstack, placer, pointed_thing) then
                return unilib.misc.pointed_use_rightclick(itemstack, placer, pointed_thing)
            end

            local num = math.random(unilib.setting.xdecor_painting_count)
            local leftover, pos = core.item_place_node(
                ItemStack("unilib:misc_painting_landscape_" .. num), placer, pointed_thing
            )

            -- N.B. Not in original code: check that the "attached_node = 1" didn't prevent the
            --      painting from being placed
            if pos == nil then
                return
            end

            if leftover:get_count() == 0 and not core.setting_getbool("creative_mode") then
                itemstack:take_item()
            end

            -- N.B. Painting attribution not included in original code
            if num <= 20 then

                local meta = core.get_meta(pos)
                meta:set_string(
                    "infotext", unilib.utils.brackets(painting_list[num][1], painting_list[num][2])
                )

            end

            return itemstack

        end,
    })
    unilib.register_craft({
        -- From xdecor:painting_1
        output = "unilib:misc_painting_landscape_1",
        recipe = {
            {"group:dye", "unilib:sign_wall_wood", "group:dye"},
        },
    })

    if unilib.setting.xdecor_painting_count > 1 then

        for i = 2, unilib.setting.xdecor_painting_count do

            unilib.register_node("unilib:misc_painting_landscape_" .. i, nil, mode, {
                -- Adapted from xdecor:painting_1, but with a new painting
                -- (no description)
                tiles = {
                    "unilib_misc_painting_landscape_" .. i .. ".png",
                    "unilib_misc_painting_frame_large.png",
                },
                groups = {
                    attached_node = 1,
                    choppy = 3,
                    flammable = 2,
                    not_in_creative_inventory = 1,
                    oddly_breakable_by_hand = 2,
                },
                sounds = unilib.global.sound_table.wood,

                collision_box = selection_box,
                drawtype = "nodebox",
                drop = "unilib:misc_painting_landscape_1",
                -- N.B. is_ground_content = false not in original code
                is_ground_content = false,
                node_box = node_box,
                paramtype = "light",
                paramtype2 = "wallmounted",
                selection_box = selection_box,
                sunlight_propagates = true,
                use_texture_alpha = "opaque",
                visual_scale = 2,
            })

        end

    end

end
