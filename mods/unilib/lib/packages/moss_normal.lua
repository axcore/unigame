---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/trunks
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.moss_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.trunks.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function place_func(pos)

    local on_ground = {x = pos.x, y = pos.y + 1, z = pos.z}
    local moss_type = math.random(1, 21)
    local rot = math.random(1, 4)

    -- (1 in 21 chance of placing moss with fungus)
    if moss_type == 1 then
        core.swap_node(on_ground, {name = "unilib:moss_normal_with_fungus_" .. rot, param2 = 1})
    else
        core.swap_node(on_ground, {name = "unilib:moss_normal_" .. rot, param2 = 1})
    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.moss_normal.init()

    return {
        description = "Normal moss",
    }

end

function unilib.pkg.moss_normal.exec()

    for i = 1, 4 do

        local orig_i = i - 1

        -- N.B. moss = 1 not in original code
        local group_table = {attached_node = 1, flammable = 3, moss = 1, snappy = 3}
        if i > 1 then
            group_table.not_in_creative_inventory = 1
        end

        local moss_img = "unilib_moss_normal.png"
        local fungus_img = "unilib_moss_normal_with_fungus.png"
        local transform = ""
        if i > 1 then
            transform = "^[transformR" .. (orig_i * 90)
        end

        local cbox = {
            type = "wallmounted",
            wall_top = {-1/2,  1/2, -1/2,    1/2,  15/32, 1/2},
            wall_bottom = {-1/2, -1/2, -1/2,    1/2, -15/32, 1/2},
            wall_side = {-1/2, -1/2, -1/2, -15/32,    1/2, 1/2},
        }

        unilib.register_node("unilib:moss_normal_" .. i, "trunks:moss_plain_" .. orig_i, mode, {
            -- From trunks:moss_plain_0, etc
            description = S("Normal Moss"),
            tiles = {moss_img .. transform},
            groups = group_table,
            sounds = unilib.global.sound_table.leaves,

            buildable_to = true,
            drawtype = "nodebox",
            drop = "unilib:moss_normal_1",
            inventory_image = moss_img,
            node_box = cbox,
            paramtype = "light",
            paramtype2 = "wallmounted",
            sunlight_propagates = true,
            use_texture_alpha = "clip",
            walkable = false,
            wield_image = moss_img,
        })

        unilib.register_node(
            -- From trunks:moss_with_fungus_0, etc
            "unilib:moss_normal_with_fungus_" .. i,
            "trunks:moss_with_fungus_" .. orig_i,
            mode,
            {
                description = S("Normal Moss with Fungus"),
                tiles = {fungus_img .. transform},
                groups = group_table,
                sounds = unilib.global.sound_table.leaves,

                buildable_to = true,
                drawtype = "nodebox",
                drop = "unilib:moss_normal_with_fungus_1",
                inventory_image = fungus_img,
                node_box = cbox,
                paramtype = "light",
                paramtype2 = "wallmounted",
                sunlight_propagates = true,
                use_texture_alpha = "clip",
                walkable = false,
                wield_image = fungus_img,
            }
        )

    end

    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_moss_normal_on_ground"
        part_name = "moss_normal_on_ground",
        convert_func = place_func,
        replace_mode = mode,

        generic_def_table = {
            fill_ratio = unilib.utils.convert_biome_lib({
                rarity = 79,
                plantlife_limit = -0.9,
            }),
        },
    })

end
