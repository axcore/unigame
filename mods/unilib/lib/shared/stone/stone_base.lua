---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- stone_base.lua
--      Base API functions for stone types
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Base API functions for stone types
---------------------------------------------------------------------------------------------------

function unilib.stone._register_stone(data_table)

    -- Original to unilib
    -- Registers the stone type in a global variable
    --
    -- data_table compulsory fields:
    --      part_name (str): Stone nodes (smooth, block, brick, cobble etc) have a consistent naming
    --          system. All nodes from the same smooth stone share a common component, e.g. "aplite"
    --          from "unilib:stone_aplite", "unilib:stone_aplite_block", "unilib:stone_aplite_brick"
    --          etc
    --      description (str): A string used as the basis for the .description field in all
    --          derivative nodes, based on a description of the smooth stone (e.g. "Aplite")
    --
    -- data_table optional fields:
    --      basic_platform_flag (bool): If true, advtrains platforms for the smooth variant (only)
    --          of this stone type are created
    --      category (str): "intrusive" for igneous intrusive rocks, "extrusive" for igneous
    --          extrusive rocks, "sedimentary" for sedimentary rocks, "metamorphic" for metamorphic
    --          rocks, "clay_dirt" for clay/dirt stones like laterite, "other" for rocks that
    --          don't fit into those categories (usually because they are fictional, e.g. ordinary
    --          stone)
    --      colour (str): An RGB value like "#615E5D", representing a characteristic colour of this
    --          stone type; it can be used to create other nodes based on the stone type. If not
    --          specified, the characteristic colour of ordinary stone is used
    --      fictional_flag (bool): If true, this stone does not exist in reality. This
    --          classification applies in the broadest sense; ordinary stone from minetest_game
    --          is classified as fictional, but silver sandstone is not (because sandstone itself
    --          is not fictional)
    --      grinder_flag (bool): If true, technic grinder recipes are added for the smooth, cobble
    --          and compressed variants of this stone type
    --      grinder_powder (str): The grinder output, when using smooth stone as the input. If not
    --          specified or the output is not available, then "unilib:stone_ordinary_powder" is the
    --          output. Ignored if grinder_flag is false
    --      grinder_gravel (str): The grinder output, when using cobble/compressed cobble as the
    --          input. If not specified or the output is not available, then
    --          "unilib:gravel_ordinary" is the output. Ignored if grinder_flag is false
    --      hardness (int): Value in the range 1-5, corresponding to the PFAA classification:
    --          UNILIB  PFAA            CRACKY      NOTES
    --          1       weak            3           Default value. Digging usually produces rubble
    --          2       medium          2           Digging usually produces cobble
    --          3       strong          1           Digging usually produces cobble
    --          4       very strong     1           Digging usually produces smooth stone
    --          5       n/a             1           Digging usually produces smooth stone
    --          N.B. Hardness 5 is intended mostly for fictional stones, like obscurite, that need
    --              special handling
    --      hardness_real = value
    --          A hardness, also in the range 1-5, matching the real-world properties of a stone.
    --              The value is available to any code that wants to programmatically override each
    --              stone's default behaviour. In most cases, the values of .hardness and
    --              .hardness_real will be the same; when they differ, it is usually because the
    --              original mod's code has specified an unrealistic hardness
    --      moss_flag (bool): If true, the moss-growth ABM is applied to the cobble variant for this
    --          stone type
    --      no_smooth_flag = bool or nil
    --          If true, there is no smooth stone variant for this stone type
    --      platform_flag (bool): If true, advtrains platforms for the smooth, block and brick
    --          variants of this stone type are created. Ignored if .basic_platform_flag is true
    --      not_super_flag (bool): If true, this stone is not suitable for use as a super stone

    local part_name = data_table.part_name
    local description = data_table.description

    local basic_platform_flag = data_table.basic_platform_flag or false
    local category = data_table.category or "default"
    local colour = data_table.colour or "#615E5D"
    local fictional_flag = data_table.fictional_flag or false
    local grinder_flag = data_table.grinder_flag or false
    local grinder_powder = data_table.grinder_powder or nil
    local grinder_gravel = data_table.grinder_gravel or nil
    local hardness = data_table.hardness or 1
    local hardness_real = data_table.hardness_real or hardness
    local moss_flag = data_table.moss_flag or false
    local no_smooth_flag = data_table.no_smooth_flag or false
    local platform_flag = data_table.platform_flag or false
    local not_super_flag = data_table.not_super_flag or false

    -- Prepare the list of stone variants available to be used as train platforms
    -- (advtrains is called during the package consolidation stage to create these train plaform
    --      nodes)
    local platform_list = nil
    if platform_flag then

        platform_list = {
            "unilib:stone_" .. part_name,
            "unilib:stone_" .. part_name .. "_block",
            "unilib:stone_" .. part_name .. "_brick",
        }

    elseif basic_platform_flag then

        platform_list = {
            "unilib:stone_" .. part_name,
        }

    end

    -- Update global variables
    if not_super_flag then
        unilib.global.super_stone_table[part_name] = nil
    elseif unilib.global.super_stone_mode == "everything" then
        unilib.global.super_stone_table[part_name] = true
    end

    unilib.global.stone_table[part_name] = {
        part_name = part_name,
        description = description,

        category = category,
        colour = colour,
        fictional_flag = fictional_flag,
        grinder_flag = grinder_flag,
        grinder_powder = grinder_powder,
        grinder_gravel = grinder_gravel,
        hardness = hardness,
        hardness_real = hardness_real,
        moss_flag = moss_flag,
        no_smooth_flag = no_smooth_flag,
        platform_list = platform_list,
        super_flag = unilib.global.super_stone_table[part_name] or false,
    }

end
