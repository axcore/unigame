---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.material_flax_roasted = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.material_flax_roasted.init()

    return {
        description = "Roasted flax",
        at_least_one = {
            {"crop_flax_brown", "crop_flax_golden"},
            {
                "crop_cotton",
                "item_paper_ordinary",
                "item_stick_ordinary",
                "rope_mining",
                "rope_normal",
                "rope_sturdy",
                "wool_basic",
            },
        },
        optional = {"stone_desert", "stone_ordinary"},
    }

end

function unilib.pkg.material_flax_roasted.exec()

    local c_flax = "unilib:material_flax_roasted"

    unilib.register_craftitem(c_flax, "cucina_vegana:flax_roasted", mode, {
        -- From cucina_vegana:flax_roasted
        description = S("Roasted Flax"),
        inventory_image = "unilib_material_flax_roasted.png",
        groups = {flammable = 1, string = 1},
    })
    if unilib.pkg_executed_table["crop_flax_brown"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = c_flax,
            recipe = "unilib:crop_flax_brown_harvest",
            cooktime = 10,
        })

    elseif unilib.pkg_executed_table["crop_flax_golden"] ~= nil then

        unilib.register_craft({
            -- From cucina_vegana:flax_roasted
            type = "cooking",
            output = c_flax,
            recipe = "unilib:crop_flax_golden_harvest",
            cooktime = 10,
        })

    end
    unilib.register_craft({
        -- From cucina_vegana:flax_roasted
        type = "fuel",
        recipe = c_flax,
        burntime = 7,
    })
    if unilib.pkg_executed_table["wool_basic"] ~= nil then

        unilib.register_craft({
            -- From cucina_vegana:flax_roasted
            output = "unilib:wool_white",
            recipe = {
                {c_flax, c_flax, c_flax},
                {c_flax, c_flax, c_flax},
            },
        })

    end
    if unilib.pkg_executed_table["crop_cotton"] ~= nil and
            unilib.pkg_executed_table["item_stick_ordinary"] ~= nil then

        unilib.register_craft({
            -- From cucina_vegana:flax_roasted
            output = "unilib:crop_cotton_harvest 2",
            recipe = {
                {c_flax, "unilib:item_stick_ordinary", c_flax},
            },
            replacements = {
                {"unilib:item_stick_ordinary", "unilib:item_stick_ordinary"},
            },
        })

    end
    if unilib.pkg_executed_table["rope_mining"] ~= nil then

        unilib.register_craft({
            -- From cucina_vegana:flax_roasted
            output = "unilib:rope_mining_segment",
            recipe = {
                {c_flax, c_flax},
                {c_flax, c_flax},
                {c_flax, c_flax},
            },
        })

        unilib.register_craft({
            -- From cucina_vegana:flax_roasted
            output = "unilib:rope_mining",
            recipe = {
                {c_flax},
                {c_flax},
            },
        })

    end
    if unilib.pkg_executed_table["rope_sturdy"] ~= nil then

        unilib.register_craft({
            -- From cucina_vegana:flax_roasted
            output = "unilib:rope_sturdy",
            recipe = {
                {c_flax, "", ""},
                {"", c_flax, ""},
                {"", "", c_flax},
            },
        })

    end
    if unilib.pkg_executed_table["rope_normal"] ~= nil then

        unilib.register_craft({
            -- From cucina_vegana:flax_roasted
            output = "unilib:rope_normal 3",
            recipe = {
                {c_flax},
                {c_flax},
                {c_flax},
            }
        })

    end

end

function unilib.pkg.material_flax_roasted.post()

    --[[
    local c_flax = "unilib:material_flax_roasted"

    if unilib.pkg_executed_table["item_paper_ordinary"] ~= nil then

        for bucket_type, _ in pairs(unilib.generic_bucket_table) do

            local c_empty_bucket = "unilib:" .. bucket_type .. "_empty"

            for _, bucket_name in pairs({
                "unilib:" .. bucket_type .. "_with_water_ordinary",
                "unilib:" .. bucket_type .. "_with_water_river",
            }) do
                unilib.register_craft({
                    -- From cucina_vegana:flax_roasted
                    output = "unilib:item_paper_ordinary 4",
                    recipe = {
                        {"group:smoothstone", c_flax, "group:smoothstone"},
                        {"group:smoothstone", c_flax, "group:smoothstone"},
                        {"", bucket_name, ""},
                    },
                    replacements = {
                        {"group:smoothstone", "group:smoothstone 4"},
                        {bucket_name, c_empty_bucket},
                    },
                })

                unilib.register_craft({
                    -- From cucina_vegana:flax_roasted
                    output = "unilib:item_paper_ordinary 4",
                    recipe = {
                        {"group:cobble", c_flax, "group:cobble"},
                        {"group:cobble", c_flax, "group:cobble"},
                        {"", bucket_name, ""},
                    },
                    replacements = {
                        {"group:cobble", "group:cobble 4"},
                        {bucket_name, c_empty_bucket},
                    },
                })

            end

        end

    end
    ]]--

    if unilib.pkg_executed_table["item_paper_ordinary"] ~= nil then

        local c_cobble = "unilib:stone_ordinary_cobble"
        local c_desert_cobble = "unilib:stone_desert_cobble"
        local c_flax = "unilib:material_flax_roasted"
        local c_stone = "unilib:stone_ordinary"
        local c_desert_stone = "unilib:stone_desert"

        for bucket_type, _ in pairs(unilib.generic_bucket_table) do

            local c_empty_bucket = "unilib:" .. bucket_type .. "_empty"

            for _, bucket_name in pairs({
                "unilib:" .. bucket_type .. "_with_water_ordinary",
                "unilib:" .. bucket_type .. "_with_water_river",
            }) do

                if unilib.pkg_executed_table["stone_ordinary"] ~= nil then

                    unilib.register_craft({
                        -- From cucina_vegana:flax_roasted
                        output = "unilib:item_paper_ordinary 4",
                        recipe = {
                            {c_stone, c_flax, c_stone},
                            {c_stone, c_flax, c_stone},
                            {"", bucket_name, ""},
                        },
                        replacements = {
                            {c_stone, c_stone .. " 4"},
                            {bucket_name, c_empty_bucket},
                        },
                    })

                    unilib.register_craft({
                        -- From cucina_vegana:flax_roasted
                        output = "unilib:item_paper_ordinary 4",
                        recipe = {
                            {c_cobble, c_flax, c_cobble},
                            {c_cobble, c_flax, c_cobble},
                            {"", bucket_name, ""},
                        },
                        replacements = {
                            {c_cobble, c_cobble .. " 4"},
                            {bucket_name, c_empty_bucket},
                        },
                    })

                end

                if unilib.pkg_executed_table["stone_desert"] ~= nil then

                    unilib.register_craft({
                        -- From cucina_vegana:flax_roasted
                        output = "unilib:item_paper_ordinary 4",
                        recipe = {
                            {c_desert_stone, c_flax, c_desert_stone},
                            {c_desert_stone, c_flax, c_desert_stone},
                            {"", bucket_name, ""},
                        },
                        replacements = {
                            {c_desert_stone, c_desert_stone .. " 4"},
                            {bucket_name, c_empty_bucket},
                        },
                    })

                    unilib.register_craft({
                        -- From cucina_vegana:flax_roasted
                        output = "unilib:item_paper_ordinary 4",
                        recipe = {
                            {c_desert_cobble, c_flax, c_desert_cobble},
                            {c_desert_cobble, c_flax, c_desert_cobble},
                            {"", bucket_name, ""},
                        },
                        replacements = {
                            {c_desert_cobble, c_desert_cobble .. " 4"},
                            {bucket_name, c_empty_bucket},
                        },
                    })

                end

            end

        end

    end

end
