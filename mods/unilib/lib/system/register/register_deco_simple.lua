---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- register_deco_simple.lua
--      Register simple decorations
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Local storage for the decoration/ore seed offsets
local storage_random_seed_offset = unilib.utils.get_mod_attribute("storage_random_seed_offset")

---------------------------------------------------------------------------------------------------
-- Register simple decorations
---------------------------------------------------------------------------------------------------

function unilib.register._register_decoration_simple(def_table)

    -- Original to unilib
    -- Decoration-registration function for any code that wants to register a decoration directly
    -- Instead of calling core.register_decoration(), this function is called; it adds a unique name
    --      to the decoration, but otherwise makes no changes
    --
    -- Args:
    --      def_table (table): Usual definition table for a decoration. The .name property, if
    --          specified, is not overwritten

    if def_table.name == nil then

        if def_table.deco_type == "simple" then

            if type(def_table.decoration) == "table" then
                def_table.name = unilib.utils.get_unique_deco_name(def_table.decoration[1])
            else
                def_table.name = unilib.utils.get_unique_deco_name(def_table.decoration)
            end

        else

            local folder, file, ext = unilib.utils.split_path(def_table.schematic)
            def_table.name = unilib.utils.get_unique_deco_name(file)

        end

    end

    -- Check for valid heights, if required
    if unilib.setting.debug_check_heights_flag and
            not unilib.utils.check_heights(def_table.y_max, def_table.y_min) then

        unilib.utils.show_warning(
            "unilib.register_decoration_simple(): Invalid height values in decoration" ..
                    " registration",
            def_table.name,
            def_table.y_max,
            def_table.y_min
        )

    end

    -- When biome showcase mode is enabled, all decorations must spawn at all heights
    if unilib.setting.debug_biome_showcase_flag then

        def_table.y_max = unilib.constant.y_max
        def_table.y_min = unilib.constant.y_min

    end

    -- Apply the random seed offset, if required
    if def_table.noise_params ~= nil and def_table.noise_params.seed ~= nil then
        def_table.noise_params.seed = def_table.noise_params.seed + storage_random_seed_offset
    end

    -- If biome filters are enabled, and apply to all biomes specified by the decoration, then the
    --      decoration is not viable, and must not be registered
    def_table = unilib.register.check_biomes_in_decoration(def_table)
    if def_table == nil then
        return
    end

    -- The decoration definition is now ready to be registered with the engine
--  core.register_decoration(def_table)
    table.insert(unilib.global.deco_other_final_list, def_table)
    if def_table.name ~= nil then
        unilib.global.deco_name_check_table[def_table.name] = true
    end

end
