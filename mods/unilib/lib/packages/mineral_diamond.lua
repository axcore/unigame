---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_diamond = {}

local S = unilib.intllib
local default_add_mode = unilib.global.imported_mod_table.default.add_mode
local mtg_plus_add_mode = unilib.global.imported_mod_table.mtg_plus.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_diamond.init()

    return {
        description = "Diamond (as a mineral)",
        optional = {"machine_polishing", "metal_gold"},
    }

end

function unilib.pkg.mineral_diamond.exec()

    local no_lump_flag = true
    if unilib.setting.mtgame_tweak_flag and
            unilib.global.pkg_executed_table["machine_polishing"] ~= nil then
        no_lump_flag = false
    end

    unilib.register_mineral({
        -- Original to unilib
        part_name = "diamond",
        description = S("Diamond"),

        gem_flag = true,
        hardness = 3,
        no_lump_flag = no_lump_flag,
    })

    if unilib.setting.mtgame_tweak_flag and
            unilib.global.pkg_executed_table["machine_polishing"] ~= nil then

        -- (Dropped instead of the gem variant, if the polishing machine is available)
        unilib.register_craftitem("unilib:mineral_diamond_lump", nil, default_add_mode, {
            -- Original to unilib
            description = S("Diamond Lump"),
            inventory_image = "unilib_mineral_diamond_lump.png",
        })

    end

    unilib.register_craftitem("unilib:mineral_diamond_gem", "default:diamond", default_add_mode, {
        -- From default:diamond
        description = S("Diamond"),
        inventory_image = "unilib_mineral_diamond_gem.png",
    })
    unilib.register_craft({
        output = "unilib:mineral_diamond_gem 9",
        recipe = {
            {"unilib:mineral_diamond_block"},
        },
    })

    unilib.register_node("unilib:mineral_diamond_block", "default:diamondblock", default_add_mode, {
        -- From default:diamondblock
        description = S("Diamond Block"),
        tiles = {"unilib_mineral_diamond_block.png"},
        groups = {cracky = 1, level = 3},
        sounds = unilib.global.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From default:diamondblock
        output = "unilib:mineral_diamond_block",
        ingredient = "unilib:mineral_diamond_gem",
    })
    unilib.register_stairs("unilib:mineral_diamond_block")
    unilib.register_carvings("unilib:mineral_diamond_block", {
        millwork_flag = true,
    })

    if unilib.setting.mtgame_tweak_flag then

        local c_diamond = "unilib:mineral_diamond_gem"
        local c_gold = "unilib:metal_gold_ingot"

        if unilib.global.pkg_executed_table["metal_gold"] ~= nil then

            unilib.register_node(
                -- From mtg_plus:gold_diamond_block
                "unilib:mineral_diamond_block_gold",
                "mtg_plus:gold_diamond_block",
                mtg_plus_add_mode,
                {
                    description = S("Gold-Framed Diamond Block"),
                    tiles = {"unilib_mineral_diamond_block_gold.png"},
                    groups = {cracky = 1, level = 3},
                    sounds = unilib.global.sound_table.stone,

                    is_ground_content = false,
                }
            )
            unilib.register_craft({
                -- From mtg_plus:gold_diamond_block
                output = "unilib:mineral_diamond_block_gold",
                recipe = {
                    {c_gold, c_diamond, c_gold},
                    {c_diamond, c_diamond, c_diamond},
                    {c_gold, c_diamond, c_gold},
                },
            })

        end

        unilib.register_node(
            -- From mtg_plus:harddiamondblock
            "unilib:mineral_diamond_block_hard",
            "mtg_plus:harddiamondblock",
            mtg_plus_add_mode,
            {
                description = S("Hard Diamond Block"),
                tiles = {"unilib_mineral_diamond_block_hard.png"},
                groups = {cracky = 1, level = 4},
                sounds = unilib.global.sound_table.stone,

                is_ground_content = false,
            }
        )
        unilib.register_craft({
            -- From mtg_plus:harddiamondblock
            type = "shapeless",
            output = "unilib:mineral_diamond_block_hard",
            recipe = {"unilib:mineral_diamond_block", "unilib:mineral_diamond_block"},
        })

    end

end
