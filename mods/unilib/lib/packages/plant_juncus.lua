---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/dryplants
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_juncus = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.dryplants.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function place_func(pos)

    -- Called by the ABM and the decorations defined below
    local juncus_type = math.random(2, 3)
    local right_here = {x = pos.x, y = pos.y + 1, z = pos.z}

    if core.get_node(right_here).name == "air" or
            core.get_node(right_here).name == "unilib:grass_jungle" then

        if juncus_type == 2 then
            core.swap_node(right_here, {name = "unilib:plant_juncus_brown"})
        else
            core.swap_node(right_here, {name = "unilib:plant_juncus_white"})
        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_juncus.init()

    return {
        description = "Juncus",
        optional = "grass_jungle",
    }

end

function unilib.pkg.plant_juncus.exec()

    -- Two varieties of juncus. Only the "white" version can appear in the player's inventory. When
    --      placed, it can be swapped for the "brown" version. Juncus plants placed as decorations
    --      can "grow" into the other version

    unilib.register_node("unilib:plant_juncus_white", "dryplants:juncus", mode, {
        -- From dryplants:juncus
        description = unilib.utils.annotate(S("Juncus"), "Juncus"),
        tiles = {"unilib_plant_juncus_white.png"},
        groups = {attached_node = 1, flammable = 2, flora = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_juncus_inv.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-7/16, -1/2, -7/16, 7/16, 0, 7/16},
        },
        visual_scale = math.sqrt(8),
        walkable = false,

        on_place = function(itemstack, placer, pointed_thing)

            local playername = placer:get_player_name()
            if core.is_protected(pointed_thing.above, playername) or
                    core.is_protected(pointed_thing.under, playername) then

                core.chat_send_player(playername, S("Someone else owns that spot"))
                return

            end

            local pos = pointed_thing.under
            local juncus_type = math.random(2, 3)
            local right_here = {x = pos.x, y = pos.y + 1, z = pos.z}
            if juncus_type == 2 then
                core.swap_node(right_here, {name = "unilib:plant_juncus_brown"})
            else
                core.swap_node(right_here, {name = "unilib:plant_juncus_white"})
            end

            if not core.setting_getbool("creative_mode") then
                itemstack:take_item()
            end

            return itemstack

        end,
    })
    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_plant_juncus_near_water"
        part_name = "plant_juncus_near_water",
        convert_func = place_func,
        replace_mode = mode,

        generic_def_table = {
            fill_ratio = unilib.utils.convert_biome_lib({
                rarity = 101 - 75,
                plantlife_limit = -0.9,
            }),
        },
    })
    unilib.register_decoration_convertable({
        -- Creates generic definition "convert_plant_juncus_on_sand"
        part_name = "plant_juncus_on_sand",
        convert_func = place_func,
        replace_mode = mode,

        generic_def_table = {
            fill_ratio = unilib.utils.convert_biome_lib({
                rarity = 101 - 75,
                plantlife_limit = -0.9,
            }),
        },
    })
    unilib.register_plant_in_pot("unilib:plant_juncus_white", "dryplants:juncus")

    unilib.register_node("unilib:plant_juncus_brown", "dryplants:juncus_02", mode, {
        -- From dryplants:juncus_02
        description = unilib.utils.annotate(S("Juncus"), "Juncus"),
        tiles = {"unilib_plant_juncus_brown.png"},
        groups = {
            attached_node = 1, flammable = 2, flora = 1, not_in_creative_inventory = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        drop = "unilib:plant_juncus_white",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-7/16, -1/2, -7/16, 7/16, 0, 7/16},
        },
        visual_scale = math.sqrt(8),
        walkable = false,
    })
    -- (not compatible with flowerpots)

end
