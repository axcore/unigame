---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic/technic_worldgen
-- Code:    LGPL 2.0
-- Media:   unknown
--
-- From:    technic
-- Code:    LGPL 2.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_uranium = {}

local S = unilib.intllib
local technic_add_mode = unilib.global.imported_mod_table.technic.add_mode
local worldgen_add_mode = unilib.global.imported_mod_table.technic_worldgen.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_uranium.init()

    return {
        description = "Uranium",
    }

end

function unilib.pkg.metal_uranium.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "uranium",
        description = S("Uranium"),

        hardness = 1,
    })

    unilib.register_craftitem(
        -- From technic:uranium_lump
        "unilib:metal_uranium_lump",
        "technic:uranium_lump",
        worldgen_add_mode,
        {
            description = S("Uranium Lump"),
            inventory_image = "unilib_metal_uranium_lump.png",
        }
    )

    -- Technic's uranium ingot is transmogrified into a 0.7% fissile uranium ingot. If unilib
    --      creates its own uranium ingot, then the original technic version can't be refined (and
    --      thus nuclear power is not available to the player)
    -- Thus, only create unilib powders/ingots/blocks if technic is not loaded
    if core.get_modpath("technic") ~= nil then

        unilib.register_craft({
            -- From unilib:metal_uranium_ingot
            type = "cooking",
            output = "technic:uranium_ingot",
            recipe = "unilib:metal_uranium_lump",
        })

    else

        unilib.register_metal_powder({
            -- From technic:uranium_dust. Creates unilib:metal_uranium_powder
            part_name = "uranium",
            orig_name = "technic:uranium_dust",

            replace_mode = technic_add_mode,
            description = S("Uranium Powder"),
        })

        unilib.register_craftitem(
            -- From unilib:metal_uranium_ingot
            "unilib:metal_uranium_ingot",
            "technic:uranium_ingot",
            worldgen_add_mode,
            {
                description = S("Uranium Ingot"),
                inventory_image = "unilib_metal_uranium_ingot.png",
                -- N.B. metal_ingot = 1 not in original code
                groups = {metal_ingot = 1, uranium_ingot = 1},
            }
        )
        unilib.register_craft({
            -- From unilib:metal_uranium_ingot
            type = "cooking",
            output = "unilib:metal_uranium_ingot",
            recipe = "unilib:metal_uranium_lump",
        })
        unilib.register_craft({
            -- From unilib:metal_uranium_ingot
            output = "unilib:metal_uranium_ingot 9",
            recipe = {
                {"unilib:metal_uranium_block"},
            },
        })

        unilib.register_node(
            -- From technic:uranium_block
            "unilib:metal_uranium_block",
            "technic:uranium_block",
            worldgen_add_mode,
            {
                description = S("Uranium Block"),
                tiles = {"unilib_metal_uranium_block.png"},
                groups = {cracky = 1, level = 2, radioactive = 2, uranium_block = 1},
                sounds = unilib.global.sound_table.stone,

                -- N.B. is_ground_content not in original code
                is_ground_content = false,
            }
        )
        unilib.register_craft_3x3({
            -- From technic:uranium_block
            output = "unilib:metal_uranium_block",
            ingredient = "unilib:metal_uranium_ingot",
        })
        unilib.register_stairs("unilib:metal_uranium_block")
        unilib.register_carvings("unilib:metal_uranium_block", {
            millwork_flag = true,
        })

        if unilib.setting.squeezed_metal_flag then

            unilib.register_node("unilib:metal_uranium_block_compressed", nil, worldgen_add_mode, {
                -- Original to unilib
                description = S("Compressed Uranium Block"),
                tiles = {"unilib_metal_uranium_block_compressed.png"},
                groups = {cracky = 1, level = 3},
                sounds = unilib.global.sound_table.metal,

                is_ground_content = false,
                stack_max = unilib.global.squeezed_stack_max,
            })
            unilib.misc.set_compressed_metal_recipes("uranium")

        end

    end

end
