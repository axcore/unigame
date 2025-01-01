---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_fibre_hemp = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_fibre_hemp.init()

    return {
        description = "Hemp fibre",
        depends = "liquid_water_ordinary",
        optional = "liquid_water_river",
        at_least_one = {"item_paper_ordinary", "item_string_ordinary"},
    }

end

function unilib.pkg.item_fibre_hemp.exec()

    unilib.register_craftitem("unilib:item_fibre_hemp", "farming:hemp_fibre", mode, {
        -- From farming:hemp_fibre
        description = S("Hemp Fibre"),
        inventory_image = "unilib_item_fibre_hemp.png"
    })
    if unilib.global.pkg_executed_table["item_paper_ordinary"] ~= nil then

        unilib.register_craft({
            -- From farming:hemp_fibre
            output = "unilib:item_paper_ordinary 3",
            recipe = {
                {"unilib:item_fibre_hemp", "unilib:item_fibre_hemp", "unilib:item_fibre_hemp"},
            },
        })

    end
    if unilib.global.pkg_executed_table["item_string_ordinary"] ~= nil then

        -- N.B. In original code, this code block is labelled "string", which is a much more
        --      sensible output than cotton (especially considering the paper recipe above)
        --[[
        unilib.register_craft({
            -- From farming:hemp_fibre
            output = "unilib:crop_cotton_harvest 3",
            recipe = {
                {"unilib:item_fibre_hemp"},
                {"unilib:item_fibre_hemp"},
                {"unilib:item_fibre_hemp"},
            },
        })
        ]]--
        unilib.register_craft({
            -- From farming:hemp_fibre
            output = "unilib:item_string_ordinary 3",
            recipe = {
                {"unilib:item_fibre_hemp"},
                {"unilib:item_fibre_hemp"},
                {"unilib:item_fibre_hemp"},
            },
        })

    end

    unilib.register_node("unilib:item_fibre_hemp_block", "farming:hemp_block", mode, {
        -- From farming:hemp_block
        description = S("Hemp Block"),
        tiles = {"unilib_item_fibre_hemp_block.png"},
        groups = {flammable = 2, oddly_breakable_by_hand = 1, snappy = 1},

        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        paramtype = "light",
    })
    unilib.register_craft_3x3({
        -- From farming:hemp_block
        output = "unilib:item_fibre_hemp_block",
        ingredient = "unilib:item_fibre_hemp",
    })
    unilib.register_stairs("unilib:item_fibre_hemp_block")

end

function unilib.pkg.item_fibre_hemp.post()

    local c_leaf = "unilib:crop_hemp_harvest"

    for bucket_type, _ in pairs(unilib.global.generic_bucket_table) do

        local c_ordinary_bucket = "unilib:" .. bucket_type .. "_with_water_ordinary"
        local c_river_bucket = "unilib:" .. bucket_type .. "_with_water_river"
        local c_empty_bucket = "unilib:" .. bucket_type .. "_empty"

        unilib.register_craft({
            -- From farming:hemp_fibre
            output = "unilib:item_fibre_hemp 8",
            recipe = {
                {c_leaf, c_leaf, c_leaf},
                {c_leaf, c_ordinary_bucket, c_leaf},
                {c_leaf, c_leaf, c_leaf},
            },
            replacements = {
                {c_ordinary_bucket, c_empty_bucket},
            },
        })

        if unilib.global.pkg_executed_table["liquid_water_river"] ~= nil then

            -- (Filter ordinary water into river water)
            unilib.register_craft({
                -- From farming:hemp_fibre
                output = c_river_bucket,
                recipe = {
                    {"unilib:item_fibre_hemp"},
                    {"unilib:item_fibre_hemp"},
                    {c_ordinary_bucket},
                },
            })

        end

    end

end
