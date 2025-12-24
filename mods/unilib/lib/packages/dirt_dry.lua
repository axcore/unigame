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
---------------------------------------------------------------------------------------------------

unilib.pkg.dirt_dry = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.dirt_dry.init()

    return {
        description = "Dry (savanna) dirt",
        optional = "soil_arid",
    }

end

function unilib.pkg.dirt_dry.exec()

    unilib.register_fertile_dirt({
        -- From default:dry_dirt. Creates unilib:dirt_dry
        part_name = "dirt_dry",
        orig_name = "default:dry_dirt",
        def_table = {
            description = S("Savanna Dirt"),
            tiles = {"unilib_dirt_dry.png"},
            -- N.B. dry_dirt = 1 not in original code
            groups = {crumbly = 3, dry_dirt = 1, soil = 1},
            sounds = unilib.global.sound_table.dirt,

            is_ground_content = unilib.setting.caves_chop_dirt_flag,
        },

        replace_mode = mode,
        compressed_description = S("Compressed Savanna Dirt"),
        compressed_group_table = {crumbly = 2},
        dry_soil = "unilib:soil_arid",
        wet_soil = "unilib:soil_arid_wet",
    })

    -- Notes from default:
    -- Savanna bare dirt patches
    -- Must come before all savanna decorations that are placed on dry grass
    -- Noise is similar to long dry grass noise, but scale inverted, to appear where long dry grass
    --      is least dense and shortest
    unilib.register_decoration_generic("default_dirt_dry", {
        -- From default/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:dirt_dry",

        flags = "force_placement",
        noise_params = {
            octaves = 4,
            offset = -1.5,
            persist = 1.0,
            scale = -1.5,
            seed = 329,
            spread = {x = 200, y = 200, z = 200},
        },
        place_offset_y = -1,
        sidelen = 4,
    })

end
