---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    farming
-- Code:    MIT
-- Media:   CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.grass_jungle = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.grass_jungle.init()

    return {
        description = "Jungle grass",
        notes = "Occasionally drops cotton seeds",
        -- Occasionally drop cotton and/or white rice seeds
        optional = {"crop_cotton", "crop_rice_white"},
    }

end

function unilib.pkg.grass_jungle.exec()

    local img = "unilib_grass_jungle.png"
    -- (farming_redo provides a nicer texture)
    if unilib.setting.mtgame_tweak_flag then
        img = "unilib_grass_jungle_alt.png"
    end

    local full_name = "unilib:grass_jungle"
    local drop = full_name
    if unilib.setting.disable_grass_drop_flag then
        drop = ""
    end

    unilib.register_node(full_name, "default:junglegrass", mode, {
        -- From default:junglegrass
        description = S("Jungle Grass"),
        tiles = {img},
        -- N.B. jungle_grass = 1 not in original code; junglegrass = 1 retained for compatibility
        groups = {
            attached_node = 1, flammable = 1, flora = 1, grass = 1, jungle_grass = 1,
            junglegrass = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = img,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
        },
        sunlight_propagates = true,
        visual_scale = 1.69,
        walkable = false,
        waving = 1,
        wield_image = img,
    })
    unilib.register_craft({
        -- From default:junglegrass
        type = "fuel",
        recipe = full_name,
        burntime = 3,
    })
    -- (not compatible with flowerpots)

    unilib.register_decoration_generic("default_grass_jungle", {
        -- From default/mapgen.lua
        deco_type = "simple",
        decoration = full_name,

        fill_ratio = 0.1,
        sidelen = 80,
    })

end

function unilib.pkg.grass_jungle.post()

    -- Occasionally drop cotton and/or rice seeds
    if not unilib.setting.disable_grass_drop_flag then

        if unilib.global.pkg_executed_table["crop_cotton"] ~= nil and
                unilib.global.pkg_executed_table["crop_rice_white"] ~= nil then

            -- Adapted from farming_redo
            unilib.override_item("unilib:grass_jungle", {
                drop = {
                    max_items = 1,
                    items = {
                        {items = {"unilib:crop_cotton_seed"}, rarity = 8},
                        {items = {"unilib:crop_rice_white_seed"},rarity = 8},
                        {items = {"unilib:grass_jungle"}}
                    },
                },
            })

        elseif unilib.global.pkg_executed_table["crop_cotton"] ~= nil then

            -- In minetest_game, dropping cotton seeds was marked as deprecated (even though jungle
            --      grass producing cotton made no sense, jungle grass was the only plant available
            --      to be a source of cotton seeds)
            -- For compatibility, unilib retains it, but only if the "plant_cotton_wild" package has
            --      not been executed

            -- Adapted from minetest_game/farming
            if unilib.global.pkg_executed_table["plant_cotton_wild"] == nil then

                unilib.override_item("unilib:grass_jungle", {
                    drop = {
                        max_items = 1,
                        items = {
                            {items = {"unilib:crop_cotton_seed"}, rarity = 8},
                            {items = {"unilib:grass_jungle"}},
                        },
                    },
                })

            end

        elseif unilib.global.pkg_executed_table["crop_rice_white"] ~= nil then

            -- Original to unilib
            unilib.override_item("unilib:grass_jungle", {
                drop = {
                    max_items = 1,
                    items = {
                        {items = {"unilib:crop_rice_white_seed"}, rarity = 8},
                        {items = {"unilib:grass_jungle"}},
                    },
                },
            })

        end

    else

        if unilib.global.pkg_executed_table["crop_cotton"] ~= nil and
                unilib.global.pkg_executed_table["crop_rice_white"] ~= nil then

            -- Adapted from farming_redo
            unilib.override_item("unilib:grass_jungle", {
                drop = {
                    max_items = 1,
                    items = {
                        {items = {"unilib:crop_cotton_seed"}, rarity = 8},
                        {items = {"unilib:crop_rice_white_seed"}, rarity = 8},
--                      {items = {"unilib:grass_jungle"}}
                    },
                },
            })

        elseif unilib.global.pkg_executed_table["crop_cotton"] ~= nil then

            -- Adapted from minetest_game/farming
            if unilib.global.pkg_executed_table["plant_cotton_wild"] == nil then

                unilib.override_item("unilib:grass_jungle", {
                    drop = {
                        max_items = 1,
                        items = {
                            {items = {"unilib:crop_cotton_seed"}, rarity = 8},
--                          {items = {"unilib:grass_jungle"}},
                        },
                    },
                })

            end

        elseif unilib.global.pkg_executed_table["crop_rice_white"] ~= nil then

            -- Original to unilib

            unilib.override_item("unilib:grass_jungle", {
                drop = {
                    max_items = 1,
                    items = {
                        {items = {"unilib:crop_rice_white_seed"}, rarity = 8},
--                      {items = {"unilib:grass_jungle"}},
                    },
                },
            })

        end

    end

end
