---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- flora_grow.lua
--      Register growth stages for various flora
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Register growth stages for various flora
---------------------------------------------------------------------------------------------------

function unilib.flora._register_growth_stages(data_table)

    -- Original to unilib
    -- Called for any crop, produce, grass or plant that has multiple numbered growth stages (e.g.
    --      "unilib:crop_wheat_grow_1" > "unilib:crop_wheat_grow_8")
    --
    -- data_table compulsory fields:
    --      base_name (str): e.g. "unilib:crop_wheat_grow"
    --      mode (str): A string representing the code that handles the growth:
    --          "mtgame" if the crop was created by a call to unilib.register_crop_mtgame()
    --          "fredo" if the crop was created by a call to unilib.register_crop_fredo()
    --          "produce" if the produce was created by a call to unilib.register_produce_fredo()
    --          "other" for other growing items, such as grasses (growth is handled by the calling
    --              code itself)
    --      stage_max (int): The total number of growth stages, e.g. 8

    for i = 1, data_table.stage_max do

        unilib.global.grow_stage_table[data_table.base_name .. "_" .. i] = {
            base_name = data_table.base_name,
            mode = data_table.mode,
            stage = i,
            stage_max = data_table.stage_max,
        }

    end

end
