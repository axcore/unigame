---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    snow
-- Code:    GPL 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_frozen = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.snow.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_frozen.init()

    return {
        description = "Frozen flowers",
        at_least_one = {
            "flower_chrysanthemum_green",
            "flower_dandelion_white",
            "flower_dandelion_yellow",
            "flower_geranium_blue",
            "flower_rose_red",
            "flower_tulip_black",
            "flower_tulip_orange",
            "flower_viola_purple",
        },
    }

end

function unilib.pkg.flower_frozen.exec()

    local flower_table = {
        flower_chrysanthemum_green = "",
        flower_dandelion_white = "dandelion_white",
        flower_dandelion_yellow = "dandelion_yellow",
        flower_geranium_blue = "geranium",
        flower_rose_red = "rose",
        flower_tulip_black = "",
        flower_tulip_orange = "tulip",
        flower_viola_purple = "viola",
    }

    for pkg_name, orig_part_name in pairs(flower_table) do

        if unilib.global.pkg_executed_table[pkg_name] ~= nil then

            local def_table = core.registered_nodes["unilib:" .. pkg_name]

            local full_name = def_table.name .. "_frozen"
            local orig_name = nil
            if orig_part_name ~= "" then
                orig_name = "snow:flower_" .. orig_part_name
            end

            unilib.register_node(full_name, orig_name, mode, {
                -- From snow:flower_rose, etc
                -- (no description)
                tiles = {"unilib_" .. pkg_name .. "_frozen.png"},
                -- N.B. not_in_creative_inventory not in original code (added here for clarity)
                groups = {attached_node = 1, not_in_creative_inventory = 1, snappy = 3},
                sounds = unilib.global.sound_table.leaves,

                drawtype = "plantlike",
                drop = "",
                paramtype = "light",
                paramtype2 = "degrotate",
                selection_box = def_table.selection_box,
                sunlight_propagates = true,
                walkable = false,
            })
            -- (not compatible with flowerpots)

            unilib.register_decoration_generic("snow_" .. pkg_name, {
                -- Original to unilib
                deco_type = "simple",
                decoration = full_name,

                fill_ratio = 0.005,
                sidelen = 16,
            })

        end

    end

end
