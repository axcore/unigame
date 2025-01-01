---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.opt_default = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.opt_default.init()

    return {
        description = "Optional stuff for the \"default\" remix",
    }

end

function unilib.pkg.opt_default.post()

    -- These "traditional" aliases are available to the player, if the remix includes this package

    core.register_alias_force("stone", "unilib:stone_ordinary")
    core.register_alias_force("stone_with_coal", "unilib:stone_ordinary_with_coal")
    core.register_alias_force("stone_with_iron", "unilib:stone_ordinary_with_iron")
    core.register_alias_force("dirt_with_grass", "unilib:dirt_ordinary_with_turf")
    core.register_alias_force("dirt_with_grass_footsteps",
            "unilib:dirt_ordinary_with_turf_and_footsteps")
    core.register_alias_force("dirt", "unilib:dirt_ordinary")
    core.register_alias_force("sand", "unilib:sand_ordinary")
    core.register_alias_force("gravel", "unilib:gravel_ordinary")
    core.register_alias_force("sandstone", "unilib:stone_sandstone_ordinary")
    core.register_alias_force("clay", "unilib:clay_ordinary")
    core.register_alias_force("brick", "unilib:brick_ordinary_block")
    core.register_alias_force("tree", "unilib:tree_apple_trunk")
    core.register_alias_force("jungletree", "unilib:tree_jungle_trunk")
    core.register_alias_force("junglegrass", "unilib:grass_jungle")
    core.register_alias_force("leaves", "unilib:tree_apple_leaves")
    core.register_alias_force("cactus", "unilib:plant_cactus_ordinary")
    core.register_alias_force("papyrus", "unilib:plant_papyrus_ordinary")
    core.register_alias_force("bookshelf", "unilib:furniture_shelf_bookshelf_apple")
    core.register_alias_force("glass", "unilib:glass_ordinary")
    core.register_alias_force("wooden_fence", "unilib:tree_apple_wood_fence")
    core.register_alias_force("rail", "carts:rail")
    core.register_alias_force("ladder", "unilib:ladder_wood_ordinary")
    core.register_alias_force("wood", "unilib:tree_apple_wood")
    core.register_alias_force("mese", "unilib:mineral_mese_block")
    core.register_alias_force("cloud", "unilib:misc_cloud_ordinary")
    core.register_alias_force("water_flowing", "unilib:liquid_water_ordinary_flowing")
    core.register_alias_force("water_source", "unilib:liquid_water_ordinary_source")
    core.register_alias_force("lava_flowing", "unilib:liquid_lava_ordinary_flowing")
    core.register_alias_force("lava_source", "unilib:liquid_lava_ordinary_source")
    core.register_alias_force("torch", "unilib:torch_ordinary")
    core.register_alias_force("sign_wall", "unilib:sign_wall_wood")
    core.register_alias_force("furnace", "unilib:machine_furnace_ordinary")
    core.register_alias_force("chest", "unilib:container_chest_ordinary")
    core.register_alias_force("locked_chest", "unilib:container_chest_ordinary_locked")
    core.register_alias_force("cobble", "unilib:stone_ordinary_cobble")
    core.register_alias_force("mossycobble", "unilib:stone_ordinary_cobble_mossy")
    core.register_alias_force("steelblock", "unilib:metal_steel_block")
    core.register_alias_force("sapling", "unilib:tree_apple_sapling")
    core.register_alias_force("apple", "unilib:fruit_apple")

    core.register_alias_force("WPick", "unilib:tool_pick_wood")
    core.register_alias_force("STPick", "unilib:tool_pick_stone")
    core.register_alias_force("SteelPick", "unilib:tool_pick_steel")
    core.register_alias_force("MesePick", "unilib:tool_pick_mese")
    core.register_alias_force("WShovel", "unilib:tool_shovel_wood")
    core.register_alias_force("STShovel", "unilib:tool_shovel_stone")
    core.register_alias_force("SteelShovel", "unilib:tool_shovel_steel")
    core.register_alias_force("WAxe", "unilib:tool_axe_wood")
    core.register_alias_force("STAxe", "unilib:tool_axe_stone")
    core.register_alias_force("SteelAxe", "unilib:tool_axe_steel")
    core.register_alias_force("WSword", "unilib:tool_sword_wood")
    core.register_alias_force("STSword", "unilib:tool_sword_stone")
    core.register_alias_force("SteelSword", "unilib:tool_sword_steel")

    core.register_alias_force("Stick", "unilib:item_stick_ordinary")
    core.register_alias_force("paper", "unilib:item_paper_ordinary")
    core.register_alias_force("book", "unilib:item_book_ordinary")
    core.register_alias_force("lump_of_coal", "unilib:mineral_coal_lump")
    core.register_alias_force("lump_of_iron", "unilib:metal_iron_lump")
    core.register_alias_force("lump_of_clay", "unilib:clay_ordinary_lump")
    core.register_alias_force("steel_ingot", "unilib:metal_steel_ingot")
    core.register_alias_force("clay_brick", "unilib:brick_ordinary")
    core.register_alias_force("snow", "unilib:snow_ordinary")

end
