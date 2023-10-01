---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.override_ethereal_coral = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.override_ethereal_coral.init()

    return {
        description = "Overrides corals so \"special\" shovels can pick them up intact",
    }

end

function unilib.pkg.override_ethereal_coral.post()

    -- Corals tweaked only by unilib, for consistency
    -- This list (and the one above) contain all suitable corals in unilib v0.14.0
    for _, item_name in pairs({
        "coral_block_blue",
        "coral_block_brown",
        "coral_block_bubble",
        "coral_block_bubble_skeleton",
        "coral_block_crimson",
        "coral_block_fire",
        "coral_block_fire_skeleton",
        "coral_block_green",
        "coral_block_horn",
        "coral_block_horn_skeleton",
        "coral_block_orange",
        "coral_block_pink",
        "coral_block_red",
        "coral_block_rose",
        "coral_block_rose_skeleton",
        "coral_block_skeleton",
        "coral_block_tangerine",
        "coral_block_tube",
        "coral_block_tube_skeleton",
        "coral_block_violet",
        "coral_block_yellow",
        "coral_brain",
        "coral_cauliflower_brown",
        "coral_cauliflower_green",
        "coral_cauliflower_pink",
        "coral_cluster_green",
        "coral_cluster_orange",
        "coral_cluster_purple",
        "coral_growing_black",
        "coral_growing_blue",
        "coral_growing_brown",
        "coral_growing_cyan",
        "coral_growing_green",
        "coral_growing_green_dark",
        "coral_growing_grey",
        "coral_growing_grey_dark",
        "coral_growing_magenta",
        "coral_growing_orange",
        "coral_growing_pink",
        "coral_growing_red",
        "coral_growing_violet",
        "coral_growing_white",
        "coral_growing_yellow",
        "coral_hammer",
        "coral_pillar_blue",
        "coral_pillar_brown",
        "coral_pillar_cyan",
        "coral_pillar_green",
        "coral_pillar_orange",
        "coral_pillar_purple",
        "coral_pillar_red",
        "coral_pillar_yellow",
        "coral_rooted_blue",
        "coral_rooted_blue_glow",
        "coral_rooted_bubble",
        "coral_rooted_bubble_skeleton",
        "coral_rooted_cyan",
        "coral_rooted_fire",
        "coral_rooted_fire_skeleton",
        "coral_rooted_green",
        "coral_rooted_green_glow",
        "coral_rooted_horn",
        "coral_rooted_horn_skeleton",
        "coral_rooted_orange",
        "coral_rooted_orange_glow",
        "coral_rooted_pink",
        "coral_rooted_pink_big",
        "coral_rooted_pink_glow",
        "coral_rooted_red",
        "coral_rooted_rose",
        "coral_rooted_rose_skeleton",
        "coral_rooted_spider",
        "coral_rooted_spider_skeleton",
        "coral_rooted_tube",
        "coral_rooted_tube_skeleton",
        "coral_seafan_white",
        "coral_seawhip_blue",
        "coral_seawhip_crimson",
        "coral_seawhip_green",
        "coral_seawhip_red",
        "coral_seawhip_yellow",
        "coral_sponge",
        "coral_staghorn_blue",
        "coral_staghorn_pink",
        "coral_staghorn_purple",
        "coral_staghorn_yellow",
    }) do
        local full_name = "unilib:" .. item_name

        if minetest.registered_nodes[full_name] ~= nil then
            unilib.override_item(full_name, {groups = {crumbly = 3}})
        end

    end

end
