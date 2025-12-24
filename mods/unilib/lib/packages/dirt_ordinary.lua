---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    farming
-- Code:    MIT
-- Media:   CC BY-SA 3.0
--
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_ordinary = {}

local S = unilib.intllib
local default_add_mode = unilib.global.imported_mod_table.default.add_mode
local moreblocks_add_mode = unilib.global.imported_mod_table.moreblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_ordinary.init()

    return {
        description = "Ordinary dirt",
        optional = "soil_ordinary",
    }

end

function unilib.pkg.dirt_ordinary.exec()

    --[[
    unilib.register_node("unilib:dirt_ordinary", "default:dirt", default_add_mode, {
        -- From default:dirt
        description = S("Ordinary Dirt"),
        tiles = {"unilib_dirt_ordinary.png"},
        groups = {crumbly = 3, soil = 1},
        sounds = unilib.global.sound_table.dirt,
    })
    if unilib.global.pkg_executed_table["soil_ordinary"] ~= nil then

        unilib.override_item("unilib:dirt_ordinary", {
            soil = {
                base = "unilib:dirt_ordinary",
                dry = "unilib:soil_ordinary",
                wet = "unilib:soil_ordinary_wet",
            },
        })

    end
    ]]--
    unilib.register_fertile_dirt({
        -- From default:dirt. Creates unilib:dirt_ordinary
        part_name = "dirt_ordinary",
        orig_name = "default:dirt",
        def_table = {
            description = S("Ordinary Dirt"),
            tiles = {"unilib_dirt_ordinary.png"},
            groups = {crumbly = 3, soil = 1},
            sounds = unilib.global.sound_table.dirt,

            is_ground_content = unilib.setting.caves_chop_dirt_flag,
        },

        replace_mode = default_add_mode,
        compressed_description = nil,
        compressed_group_table = nil,
        dry_soil = "unilib:soil_ordinary",
        wet_soil = "unilib:soil_ordinary_wet",
    })
    if unilib.setting.squeezed_stone_flag and (
        moreblocks_add_mode ~= "defer" or not core.get_modpath("moreblocks")
    ) then

        unilib.register_node(
            -- From moreblocks:dirt_compressed
            "unilib:dirt_ordinary_compressed",
            "moreblocks:dirt_compressed",
            moreblocks_add_mode,
            {
                description = S("Compressed Ordinary Dirt"),
                tiles = {"unilib_dirt_ordinary_compressed.png"},
                -- N.B. compresseddirt = 1 not in original code; it matches the compressedstone
                --      group in some stone packages
                groups = {compresseddirt = 1, crumbly = 2},
                sounds = unilib.global.sound_table.dirt,

                is_ground_content = false,
                stack_max = unilib.global.squeezed_stack_max,
            }
        )
        -- From moreblocks:dirt_compressed
        unilib.misc.set_squeezed_recipes("unilib:dirt_ordinary", "unilib:dirt_ordinary_compressed")
        unilib.register_stairs("unilib:dirt_ordinary_compressed")

    end

end
