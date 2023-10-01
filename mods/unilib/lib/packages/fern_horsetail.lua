---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/ferns
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.fern_horsetail = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ferns.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fern_horsetail.init()

    return {
        description = "Horsetail fern",
        notes = "Four varieties of horsetail fern that are not interchangeable. The \"young\"" ..
                " variety is edible",
        optional = "dye_basic",
    }

end

function unilib.pkg.fern_horsetail.exec()

    local fern_list = {}

    for i, mini_list in ipairs({
        {"young", S("Young Horsetail Fern"), {-0.15, -1/2, -0.15, 0.15, -1/16, 0.15}},
        {"small", S("Small Horsetail Fern"), {-0.15, -1/2, -0.15, 0.15, -1/16, 0.15}},
        {"medium", S("Medium Horsetail Fern"), {-0.15, -1/2, -0.15, 0.15, -1/16, 0.15}},
        {"large", S("Large Horsetail Fern"), {-0.15, -1/2, -0.15, 0.15, -1/16, 0.15}}
    }) do

        local full_name = "unilib:fern_horsetail_" .. mini_list[1]
        local orig_name = "ferns:horsetail_0" .. tostring(i)

        local group_table, node_drop, node_img, node_on_use
        -- N.B. flora = 1 not in original code
        group_table = {attached_node = 1, flammable = 2, flora = 1, horsetail = 1, snappy = 3}
        node_img = "unilib_fern_horsetail_" .. mini_list[1] .. ".png"
        if mini_list[1] == "young" then

            node_drop = "unilib:fern_horsetail_young"
            node_on_use = unilib.cuisine_eat_on_use("unilib:fern_horsetail_young", 1)
            -- N.B. no food_fern in original code
            group_table.food_fern = 1

        end

        unilib.register_node(full_name, orig_name, mode, {
            -- From ferns:horsetail_01, etc
            description = unilib.annotate(mini_list[2], "Equisetum arvense"),
            tiles = {node_img},
            groups = group_table,
            sounds = unilib.sound_table.leaves,

            buildable_to = true,
            drawtype = "plantlike",
            drop = node_drop,
            inventory_image = node_img,
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = mini_list[3],
            },
            walkable = false,

            on_use = node_on_use,
        })
        -- (not compatible with flowerpots)

        table.insert(fern_list, full_name)

    end

    if unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- From ferns:horsetail_01, etc
            type = "shapeless",
            output = "unilib:dye_green",
            recipe = {
                "group:horsetail",
            },
        })

    end

    unilib.register_decoration("ferns_fern_horsetail", {
        deco_type = "simple",
        decoration = fern_list,

        fill_ratio = unilib.biome_lib_fill_ratio,
    })

end
