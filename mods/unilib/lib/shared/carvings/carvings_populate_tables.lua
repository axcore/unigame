---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- carvings_populate_tables.lua
--      Populate global tables for carvings
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Populate global tables for carvings
---------------------------------------------------------------------------------------------------

unilib.global.carving_output_table = {
    -- From columnia
    _column_centre = 4,
    _column_top = 1,
    _column_bottom = 1,
    _column_crosslink = 1,
    _column_link = 4,
    _column_downlink = 4,
    -- From facade
    _facade_bannerstone = 1,
    _facade_bannerstone_corner = 1,
    _facade_centrestone = 1,
    _facade_column = 1,
    _facade_column_corner = 1,
    _facade_corbel = 1,
    _facade_corbel_corner = 1,
    _facade_corbel_corner_inner = 1,
    _facade_swirl = 1,
    _facade_swirl_corner = 1,
    _facade_fascia = 2,
    _facade_fascia_corner_inner = 1,
    _facade_fascia_corner_outer = 1,
    _facade_bricks_corner = 2,
    -- From mymillwork
    _mill_crownmould = 1,
    _mill_crownmould_corner_inner = 1,
    _mill_crownmould_corner_outer = 1,
    _mill_crownmould_beam = 1,
    _mill_column = 1,
    _mill_column_base = 1,
    _mill_column_half = 2,
    _mill_column_half_base = 2,
    _mill_column_half_base_beam = 1,
    _mill_column_quarter = 4,
    _mill_column_quarter_base = 4,
    _mill_column_quarter_base_board = 2,
    _mill_column_quarter_base_fancy = 2,
    _mill_ceiling = 6,
    _mill_ceiling_post = 4,
    _mill_beam = 2,
    _mill_beam_t = 2,
    _mill_ceiling_beam_t = 2,
    _mill_base = 8,
    _mill_base_corner_inner = 4,
    _mill_base_corner_outer = 10,
    _mill_base_fancy = 6,
    _mill_base_fancy_corner_inner = 3,
    _mill_base_fancy_corner_outer = 8,
    -- From farlands
    _farlands_arch = 1,
    _farlands_ledge = 1,
    _farlands_ledge_corner = 1,
    _farlands_rail = 1,
    _farlands_rail_corner = 1,
    _farlands_window = 1,
}
