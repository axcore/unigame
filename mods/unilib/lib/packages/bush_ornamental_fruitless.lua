---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/bushes_classic
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.bush_ornamental_fruitless = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bushes_classic.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.bush_ornamental_fruitless.init()

    return {
        description = "Fruitless ornamental bush",
        notes = "Fruitless bushes (and other bushes from plantlife/bushes_classic) can only" ..
                " be dug using a suitable tool, such as an axe",
        -- (The shared package provides the ordinary stick, used in the craft recipe below)
        depends = "shared_bushes_classic",
    }

end

function unilib.pkg.bush_ornamental_fruitless.exec()

    local c_stick = "unilib:item_stick_ordinary"

    unilib.register_node("unilib:item_basket", "bushes:basket_empty", mode, {
        -- From bushes:basket_empty
        description = S("Empty Basket"),
        tiles = {"unilib_item_basket.png"},
        groups = {dig_immediate = 3},
        -- (no sounds)

        drawtype = "mesh",
        mesh = "unilib_item_basket_empty.obj",
        paramtype = "light",
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From bushes:basket_empty
        output = "unilib:item_basket",
        recipe = {
            {c_stick, c_stick, c_stick},
            {"", c_stick, "" },
        },
    })

    unilib.pkg.shared_bushes_classic.register_bush({
        -- From bushes:fruitless_bush, provides unilib:bush_ornamental_fruitless
        part_name = "fruitless",
        orig_name = "bushes:fruitless_bush",

        description = S("Fruitless Ornamental Bush"),
    })

    -- Regrow berries (an ABM is required because of the use of metadata)
    -- N.B. removed references to group:potting_soil, which is from an unknown mod
    unilib.register_abm({
        label = "Regrow bush berries [bush_ornamental_fruitless]",
        nodenames = {"unilib:bush_ornamental_fruitless"},
--      neighbors = {"group:soil", "group:potting_soil"},
        neighbors = {"group:soil"},

        chance = 5,
        interval = 500,

        action = function(pos, node, active_object_count, active_object_count_wider)

            local meta = minetest.get_meta(pos)
            local bush_name = meta:get_string("bush_type")

            if bush_name and bush_name ~= "" then

                --[[
                local dirtpos = {x = pos.x, y = pos.y - 1, z = pos.z}
                local dirt = minetest.get_node(dirtpos)
                local is_soil = minetest.get_item_group(dirt.name, "soil") or
                        minetest.get_item_group(dirt.name, "potting_soil")

                if is_soil and (
                    dirt.name == "unilib:soil_ordinary_wet"
                    or dirt.name == "farming:soil_wet"
                    or math.random(1,3) == 1
                ) then
                    minetest.swap_node(pos, {name = "unilib:bush_ornamental_" .. bush_name})
                end
                ]]--

                local dirtpos = {x = pos.x, y = pos.y - 1, z = pos.z}
                local dirt = minetest.get_node(dirtpos)

                if minetest.get_item_group(dirt.name, "soil") and (
                    dirt.name == "unilib:soil_ordinary_wet"
                    or dirt.name == "farming:soil_wet"
                    or math.random(1,3) == 1
                ) then
                    minetest.swap_node(pos, {name = "unilib:bush_ornamental_" .. bush_name})
                end
            end
        end
    })

end
