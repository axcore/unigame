---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.flowerpot_clay = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flowerpot_clay.init()

    return {
        description = "Clay flowerpot",
        notes = "Unlike normal flowerpots, clay flowerpots only accept a few types of flower," ..
                " and can be crafted in the crafting grid",
        depends = "brick_ordinary",
    }

end

function unilib.pkg.flowerpot_clay.post()

    local flower_table = {
        dandelion_white = "potted_dandelion_white",
        dandelion_yellow = "potted_dandelion_yellow",
        geranium_blue = "potted_geranium",
        rose_red = "potted_rose",
        tulip_orange = "potted_tulip",
        viola_purple = "potted_viola",
    }

    for part_name, orig_name in pairs(flower_table) do

        if unilib.global.pkg_executed_table["flower_" .. part_name] ~= nil then

            local pot_name = "unilib:flowerpot_clay_" .. part_name
            local flower_name = "unilib:flower_" .. part_name
            local img = "unilib_flowerpot_clay_" .. part_name .. ".png"
            local def_table = core.registered_nodes[flower_name]

            if def_table then

                unilib.register_node(pot_name, "xdecor:potted_" .. orig_name, mode, {
                    -- From xdecor:potted_dandelion_white, etc. Creates
                    --      unilib:flowerpot_clay_flower_dandelion_white, etc
                    description = S("Clay Flowerpot with @1", def_table.description),
                    tiles = {img},
                    groups = {flammable = 3, flower = 1, plant = 1, snappy = 3},
                    sounds = unilib.global.sound_table.leaves,

                    drawtype = "plantlike",
                    inventory_image = img,
                    -- N.B. is_ground_content = false not in original code
                    is_ground_content = false,
                    paramtype = "light",
                    selection_box = {
                        type = "fixed",
                        fixed = {-0.5, -0.5, -0.5, 0.5, -0.2, 0.5},
                    },
                    sunlight_propagates = true,
                    walkable = false,
                })
                unilib.register_craft({
                    -- From xdecor:potted_dandelion_white, etc
                    output = pot_name,
                    recipe = {
                        {"unilib:brick_ordinary", flower_name, "unilib:brick_ordinary"},
                        {"", "unilib:brick_ordinary", ""},
                    },
                })

            end

        end

    end

end
