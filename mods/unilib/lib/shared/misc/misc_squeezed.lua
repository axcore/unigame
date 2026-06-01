---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- misc_squeezed.lua
--      Set craft recipes for "squeezed" items (compressed/condensed stone, compressed dirt,
--          compacted leaves, etc)
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Set craft recipes for "squeezed" items (general)
---------------------------------------------------------------------------------------------------

function unilib.misc._set_squeezed_recipes(ingredient, squeezed_name)

    -- Original to unilib
    -- Set up craft recipes for "squeezed" items (compressed/condensed stone, compressed dirt,
    --      compacted leaves, etc)
    -- The recipes created depend on the technology available to the player
    --
    -- Args:
    --      ingredient (str): e.g. "unilib:stone_ordinary"
    --      squeezed_name (str): e.g. "unilib:stone_ordinary_compressed"

    if unilib.setting.squeezed_technic_flag and core.get_modpath("technic") ~= nil then

        if core.registered_nodes["technic:hv_compactor"] ~= nil then

            -- Some forks of the technic mod use a compressor, rather than a compactor, for this
            --      sort of thing
            technic.register_compactor_recipe({
                input = {ingredient .. " 8"},
                output = squeezed_name,
                time = 10,
            })
            unilib.register_craft({
                type = "shapeless",
                output = ingredient .. " 8",
                recipe = {squeezed_name},
            })

            return

        elseif core.registered_nodes["technic:hv_compressor"] ~= nil then

            -- The standard compressor is available
            technic.register_compressor_recipe({
                input = {ingredient .. " 8"},
                output = squeezed_name,
                time = 10,
            })
            unilib.register_craft({
                type = "shapeless",
                output = ingredient .. " 8",
                recipe = {squeezed_name},
            })

            return

        end

    end

    -- Otherwise, use simple crafting recipes
    unilib.register_craft_3x3({
        output = squeezed_name,
        ingredient = ingredient,
    })
    unilib.register_craft({
        output = ingredient .. " 9",
        recipe = {
            {squeezed_name},
        },
    })

end

---------------------------------------------------------------------------------------------------
-- Set craft recipes for "squeezed" items (specific)
---------------------------------------------------------------------------------------------------

function unilib.misc._set_compressed_metal_recipes(part_name)

    -- Original to unilib
    -- Sets up craft recipes for a compressed metal block, crafted from a metal block of the same
    --      type
    --
    -- Args:
    --      part_name (str): e.g. "unobtainium", used with "unilib:metal_unobtainium_block" and
    --          "unilib:metal_unobtainium_block_compressed"

    unilib.misc.set_squeezed_recipes(
        "unilib:metal_" .. part_name .. "_block",
        "unilib:metal_" .. part_name .. "_block_compressed"
    )

end
