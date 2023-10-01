---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- stairs.lua
--      Set up shared functions for stairs
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Node box tables for most stair types (excluding for example some slabs and slopes)
local node_box_table = {
    simple = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
            {-0.5, 0, 0, 0.5, 0.5, 0.5},
        },
    },
    inner = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
            {-0.5, 0, 0, 0.5, 0.5, 0.5},
            {-0.5, 0, -0.5, 0, 0.5, 0},
        },
    },
    outer = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
            {-0.5, 0, 0, 0, 0.5, 0.5},
        },
    },
    simple_inverted = {
        type = "fixed",
        fixed = {
            {-0.5, 0, -0.5, 0.5, 0.5, 0.5},
            {-0.5, -0.5, 0, 0.5, 0, 0.5},
        },
    },
    simple_half = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0, 0, 0.5},
            {-0.5, 0, 0, 0, 0.5, 0.5},
        },
    },
    simple_half_inverted = {
        type = "fixed",
        fixed = {
            {-0.5, 0, -0.5, 0, 0.5, 0.5},
            {-0.5, -0.5, 0, 0, 0, 0.5},
        },
    },
    simple_half_right = {
        type = "fixed",
        fixed = {
            {0, -0.5, -0.5, 0.5, 0, 0.5},
            {0, 0, 0, 0.5, 0.5, 0.5},
        },
    },
    simple_half_right_inverted = {
        type = "fixed",
        fixed = {
            {0, 0, -0.5, 0.5, 0.5, 0.5},
            {0, -0.5, 0, 0.5, 0, 0.5},
        },
    },
    corner = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, 0, 0.5, 0.5, 0.5},
            {-0.5, -0.5, -0.5, 0, 0.5, 0},
        },
    },
    corner_half = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, 0, 0.5, 0, 0.5},
            {-0.5, -0.5, -0.5, 0, 0, 0},
        },
    },
    corner_half_inverted = {
        type = "fixed",
        fixed = {
            {-0.5, 0, 0, 0.5, 0.5, 0.5},
            {-0.5, 0, -0.5, 0, 0.5, 0},
        },
    },
    inner_inverted = {
        type = "fixed",
        fixed = {
            {-0.5, 0, -0.5, 0.5, 0.5, 0.5},
            {-0.5, -0.5, 0, 0.5, 0, 0.5},
            {-0.5, -0.5, -0.5, 0, 0, 0},
        },
    },
    outer_inverted = {
        type = "fixed",
        fixed = {
            {-0.5, 0, -0.5, 0.5, 0.5, 0.5},
            {-0.5, -0.5, 0, 0, 0, 0.5},
        },
    },
    tile = {
        type = "fixed",
        fixed = {-0.5, -0.5, 0, 0.5, 0.5, 0.5},
    },
    tile_quarter = {
        type = "fixed",
        fixed = {-0.5, -0.5, 0.25, 0.5, 0.5, 0.5},
    },
    tile_three_quarter = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.25, 0.5, 0.5, 0.5},
    },
    panel_bottom = {
        type = "fixed",
        fixed = {-0.5, -0.5, 0, 0.5, 0, 0.5},
    },
    panel_top = {
        type = "fixed",
        fixed = {-0.5, 0, 0, 0.5, 0.5, 0.5},
    },
    panel_vertical = {
        type = "fixed",
        fixed = {-0.5, -0.5, 0, 0, 0.5, 0.5},
    },
    micro_bottom = {
        type = "fixed",
        fixed = {-0.5, -0.5, 0, 0, 0, 0.5},
    },
    micro_top = {
        type = "fixed",
        fixed = {-0.5, 0, 0, 0, 0.5, 0.5},
    },
    micro_bottom_cut_eighth = {
        type = "fixed",
        fixed = {-0.5, -0.5, 0, 0, -0.4375, 0.5},
    },
    micro_bottom_cut_quarter = {
        type = "fixed",
        fixed = {-0.5, -0.5, 0, 0, -0.375, 0.5},
    },
    micro_bottom_cut_half = {
        type = "fixed",
        fixed = {-0.5, -0.5, 0, 0, -0.25, 0.5},
    },
    panel_vertical_sliced_eighth = {
        type = "fixed",
        fixed = {-0.5, -0.5, 0, 0, 0.4375, 0.5},
    },
    panel_vertical_sliced_quarter = {
        type = "fixed",
        fixed = {-0.5, -0.5, 0, 0, 0.375, 0.5},
    },
    panel_vertical_sliced_half = {
        type = "fixed",
        fixed = {-0.5, -0.5, 0, 0, 0.25, 0.5},
    },
    panel_bottom_cut_eighth = {
        type = "fixed",
        fixed = {-0.5, -0.5, 0, 0.5, -0.4375, 0.5},
    },
    panel_bottom_cut_quarter = {
        type = "fixed",
        fixed = {-0.5, -0.5, 0, 0.5, -0.375, 0.5},
    },
    panel_bottom_cut_half = {
        type = "fixed",
        fixed = {-0.5, -0.5, 0, 0.5, -0.25, 0.5},
    },
    tile_sliced_eighth = {
        type = "fixed",
        fixed = {-0.5, -0.5, 0, 0.5, 0.4375, 0.5},
    },
    tile_sliced_quarter = {
        type = "fixed",
        fixed = {-0.5, -0.5, 0, 0.5, 0.375, 0.5},
    },
    tile_sliced_half = {
        type = "fixed",
        fixed = {-0.5, -0.5, 0, 0.5, 0.25, 0.5},
    },
    slab_cut_eighth = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, ((1/16) - 0.5), 0.5},
    },
    slab_cut_quarter = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, ((2/16) - 0.5), 0.5},
    },
    slab_cut_half = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, ((4/16) - 0.5), 0.5},
    },
    slab_sliced_eighth = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, ((15/16) - 0.5), 0.5},
    },
    slab_sliced_quarter = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, ((14/16) - 0.5), 0.5},
    },
    slab_sliced_half = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, ((12/16) - 0.5), 0.5},
    },
    box_sided_two = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, -7/16, 7/16},
            {-0.5, -0.5, 7/16, 0.5, 0.5, 0.5},
        },
    },
    box_sided_three = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, -7/16},
            {-0.5, -0.5, -7/16, 0.5, -7/16, 7/16},
            {-0.5, -0.5, 7/16, 0.5, 0.5, 0.5},
        },
    },
    box_sided_three_corner = {
        type = "fixed",
        fixed = {
            {-7/16, -0.5, -0.5, 0.5, -7/16, 7/16},
            {-7/16, -0.5, 7/16, 0.5, 0.5, 0.5},
            {-0.5, -0.5, -0.5, -7/16, 0.5, 0.5},
        },
    },
    steps = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0, 0},
            {-0.5, 0, 0, 0.5, 0.5, 0.5},
        },
    },
    steps_sliced_eighth = {
        type = "fixed",
        fixed = {
            {-0.5, -0.0625, -0.5, 0.5, 0, 0},
            {-0.5, 0.4375, 0, 0.5, 0.5, 0.5},
        },
    },
    steps_sliced_quarter = {
        type = "fixed",
        fixed = {
            {-0.5, -0.125, -0.5, 0.5, 0, 0},
            {-0.5, 0.375, 0, 0.5, 0.5, 0.5},
        },
    },
    steps_sliced_half = {
        type = "fixed",
        fixed = {
            {-0.5, -0.25, -0.5, 0.5, 0, 0},
            {-0.5, 0.25, 0, 0.5, 0.5, 0.5},
        },
    },
    corner_roof = {
        type = "fixed",
        fixed = {
            {-1/2, 0, 0, 0, 1/2, 1/2},
            {0, -1/2, 0, 1/2, 0, 1/2},
            {-1/2, -1/2, -1/2, 0, 0, 0},
        },
    },
    corner_roof_inverted = {
        type = "fixed",
        fixed = {
            {-1/2, -1/2, 0, 0, 0, 1/2},
            {0, 0, 0, 1/2, 1/2, 1/2},
            {-1/2, 0, -1/2, 0, 1/2, 0},
        },
    },
    hole_murder = {
        type = "fixed",
        fixed = {
            {-8/16, -8/16, -8/16, -4/16, 8/16, 8/16},
            {4/16, -8/16, -8/16, 8/16, 8/16, 8/16},
            {-4/16, -8/16, -8/16, 4/16, 8/16, -4/16},
            {-4/16, -8/16, 8/16, 4/16, 8/16, 4/16},
        },
    },
    hole_machicolation = {
        type = "fixed",
        fixed = {
            {-0.5, 0, -0.5, 0.5, 0.5, 0},
            {-0.5, -0.5, 0, -0.25, 0.5, 0.5},
            {0.25, -0.5, 0, 0.5, 0.5, 0.5},
        },
    },
    pillar_bottom = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, -0.375, 0.5},
            {-0.375, -0.375, -0.375, 0.375, -0.125, 0.375},
            {-0.25, -0.125, -0.25, 0.25, 0.5, 0.25},
        },
    },
    pillar_bottom_half = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, 0, 0.5, -0.375, 0.5},
            {-0.375, -0.375, 0.125, 0.375, -0.125, 0.5},
            {-0.25, -0.125, 0.25, 0.25, 0.5, 0.5},
        },
    },
    pillar_top = {
        type = "fixed",
        fixed = {
            {-0.5, 0.3125, -0.5, 0.5, 0.5, 0.5},
            {-0.375, 0.0625, -0.375, 0.375, 0.3125, 0.375},
            {-0.25, -0.5, -0.25, 0.25, 0.0625, 0.25},
        },
    },
    pillar_top_half = {
        type = "fixed",
        fixed = {
            {-0.5, 0.3125, 0, 0.5, 0.5, 0.5},
            {-0.375, 0.0625, 0.125, 0.375, 0.3125, 0.5},
            {-0.25, -0.5, 0.25, 0.25, 0.0625, 0.5},
        },
    },
    pillar_middle = {
        type = "fixed",
        fixed = {
            {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
        },
    },
    pillar_middle_half = {
        type = "fixed",
        fixed = {
            {-0.25, -0.5, 0.25, 0.25, 0.5, 0.5},
        },
    },
    pillar_crossbrace = {
        type = "connected",
        fixed = {-0.25, 0.25, -0.25, 0.25, 0.5, 0.25},
        connect_front = {-0.25, 0.25, -0.75, 0.25, 0.5, -0.25},
        connect_left = {-0.25, 0.25, -0.25, -0.75, 0.5, 0.25},
        connect_back = {-0.25, 0.25, 0.25, 0.25, 0.5, 0.75},
        connect_right = {0.25, 0.25, -0.25, 0.75, 0.5, 0.25},
    },
    pillar_crossbrace_ext = {
        type = "fixed",
        fixed = {-1.25, 0.25, -0.25, 1.25, 0.5, 0.25},
    },
    slit = {
        type = "fixed",
        fixed = {
            {-0.5, -0.375, 0.5, -0.0625, 0.375, 0.3125},
            {0.0625, -0.375, 0.5, 0.5, 0.375, 0.3125},
            {-0.5, 0.375, 0.5, 0.5, 0.5, 0.3125},
            {-0.5, -0.5, 0.5, 0.5, -0.375, 0.3125},
            {0.25, -0.5, 0.3125, 0.5, 0.5, 0.125},
            {-0.5, -0.5, 0.3125, -0.25, 0.5, 0.125},
        },
    },
    slit_cross = {
        type = "fixed",
        fixed = {
            {-0.5, -0.125, 0.5, -0.0625, 0.375, 0.3125},
            {0.0625, -0.125, 0.5, 0.5, 0.375, 0.3125},
            {-0.5, 0.375, 0.5, 0.5, 0.5, 0.3125},
            {-0.5, -0.5, 0.5, 0.5, -0.375, 0.3125},
            {0.0625, -0.375, 0.5, 0.5, -0.25, 0.3125},
            {-0.5, -0.375, 0.5, -0.0625, -0.25, 0.3125},
            {-0.5, -0.25, 0.5, -0.1875, -0.125, 0.3125},
            {0.1875, -0.25, 0.5, 0.5, -0.125, 0.3125},
            {0.25, -0.5, 0.3125, 0.5, 0.5, 0.125},
            {-0.5, -0.5, 0.3125, -0.25, 0.5, 0.125},
        },
    },
    slit_hole = {
        type = "fixed",
        fixed = {
            {-0.5, -0.375, 0.5, -0.125, 0.375, 0.3125},
            {0.125, -0.375, 0.5, 0.5, 0.375, 0.3125},
            {-0.5, -0.5, 0.5, 0.5, -0.375, 0.3125},
            {0.0625, -0.125, 0.5, 0.125, 0.375, 0.3125},
            {-0.125, -0.125, 0.5, -0.0625, 0.375, 0.3125},
            {-0.5, 0.375, 0.5, 0.5, 0.5, 0.3125},
            {0.25, -0.5, 0.3125, 0.5, 0.5, 0.125},
            {-0.5, -0.5, 0.3125, -0.25, 0.5, 0.125},
        },
    },
    slit_embrasure = {
        type = "fixed",
        fixed = {
            {-0.25, -0.5, 0.375, -0.125, 0.5, 0.5},
            {0.125, -0.5, 0.375, 0.25, 0.5, 0.5},
            {0.25, -0.5, 0.25, 0.5, 0.5, 0.5},
            {0.375, -0.5, 0.125, 0.5, 0.5, 0.25},
            {-0.5, -0.5, 0.25, -0.25, 0.5, 0.5},
            {-0.5, -0.5, 0.125, -0.375, 0.5, 0.25},
        },
    },
    arch_simple = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, -0.4375, 0.5, 0.5},
            {-0.4375, -0.25, -0.5, -0.375, 0.5, 0.5},
            {-0.375, -0.0625, -0.5, -0.3125, 0.5, 0.5},
            {-0.3125, 0, -0.5, -0.25, 0.5, 0.5},
            {-0.25, 0.125, -0.5, -0.1875, 0.5, 0.5},
            {-0.1875, 0.1875, -0.5, -0.125, 0.5, 0.5},
            {-0.125, 0.25, -0.5, 0, 0.5, 0.5},
            {0, 0.3125, -0.5, 0.0625, 0.5, 0.5},
            {0.0625, 0.375, -0.5, 0.25, 0.5, 0.5},
            {0.25, 0.4375, -0.5, 0.5, 0.5, 0.5},
        },
    },
    arch_outer = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.5, -0.4375, 0.5, 0.4375},
            {-0.5, -0.25, 0.5, -0.375, 0.5, 0.375},
            {-0.5, -0.0625, 0.5, -0.3125, 0.5, 0.3125},
            {-0.5, 0, 0.5, -0.25, 0.5, 0.25},
            {-0.5, 0.125, 0.5, -0.1875, 0.5, 0.1875},
            {-0.5, 0.1875, 0.5, -0.125, 0.5, 0.125},
            {-0.5, 0.25, 0.5, 0, 0.5, 0},
            {-0.5, 0.3125, 0.5, 0.0625, 0.5, -0.0625},
            {-0.5, 0.375, 0.5, 0.25, 0.5, -0.25},
            {-0.5, 0.4375, 0.5, 0.5, 0.5, -0.5},
        },
    },
    arch_inner = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.5, -0.4375, 0.5, -0.5},
            {-0.5, -0.5, 0.5, 0.5, 0.5, 0.4375},
            {-0.5, -0.25, 0.5, -0.375, 0.5, -0.5},
            {-0.5, -0.25, 0.5, 0.5, 0.5, 0.375},
            {-0.5, -0.0625, 0.5, -0.3125, 0.5, -0.5},
            {-0.5, -0.0625, 0.5, 0.5, 0.5, 0.3125},
            {-0.5, 0, 0.5, -0.25, 0.5, -0.5},
            {-0.5, 0, 0.5, 0.5, 0.5, 0.25},
            {-0.5, 0.125, 0.5, -0.1875, 0.5, -0.5},
            {-0.5, 0.125, 0.5, 0.5, 0.5, 0.1875},
            {-0.5, 0.1875, 0.5, -0.125, 0.5, -0.5},
            {-0.5, 0.1875, 0.5, 0.5, 0.5, 0.125},
            {-0.5, 0.25, 0.5, 0, 0.5, -0.5},
            {-0.5, 0.25, 0.5, 0.5, 0.5, 0},
            {-0.5, 0.3125, 0.5, 0.0625, 0.5, -0.5},
            {-0.5, 0.3125, 0.5, 0.5, 0.5, -0.0625},
            {-0.5, 0.375, 0.5, 0.25, 0.5, -0.5},
            {-0.5, 0.375, 0.5, 0.5, 0.5, -0.25},
            {-0.5, 0.4375, 0.5, 0.5, 0.5, -0.5},
        },
    },
}

-- Collision/selection box tables from moreblocks/stairsplus/defs.lua
local selection_box_table = {
    slope = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
            {-0.5, -0.25, -0.25, 0.5, 0, 0.5},
            {-0.5, 0, 0, 0.5, 0.25, 0.5},
            {-0.5, 0.25, 0.25, 0.5, 0.5, 0.5},
        }
    },
    slope_half = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, -0.375, 0.5},
            {-0.5, -0.375, -0.25, 0.5, -0.25, 0.5},
            {-0.5, -0.25, 0, 0.5, -0.125, 0.5},
            {-0.5, -0.125, 0.25, 0.5, 0, 0.5},
        }
    },
    slope_half_raised = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.125, 0.5},
            {-0.5, 0.125, -0.25, 0.5, 0.25, 0.5},
            {-0.5, 0.25, 0, 0.5, 0.375, 0.5},
            {-0.5, 0.375, 0.25, 0.5, 0.5, 0.5},
        }
    },
    slope_inner = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
            {-0.5, -0.5, -0.25, 0.5, 0, 0.5},
            {-0.5, -0.5, -0.5, 0.25, 0, 0.5},
            {-0.5, 0, -0.5, 0, 0.25, 0.5},
            {-0.5, 0, 0, 0.5, 0.25, 0.5},
            {-0.5, 0.25, 0.25, 0.5, 0.5, 0.5},
            {-0.5, 0.25, -0.5, -0.25, 0.5, 0.5},
        }
    },
    slope_inner_half = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, -0.375, 0.5},
            {-0.5, -0.375, -0.25, 0.5, -0.25, 0.5},
            {-0.5, -0.375, -0.5, 0.25, -0.25, 0.5},
            {-0.5, -0.25, -0.5, 0, -0.125, 0.5},
            {-0.5, -0.25, 0, 0.5, -0.125, 0.5},
            {-0.5, -0.125, 0.25, 0.5, 0, 0.5},
            {-0.5, -0.125, -0.5, -0.25, 0, 0.5},
        }
    },
    slope_inner_half_raised = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.125, 0.5},
            {-0.5, 0.125, -0.25, 0.5, 0.25, 0.5},
            {-0.5, 0.125, -0.5, 0.25, 0.25, 0.5},
            {-0.5, 0.25, -0.5, 0, 0.375, 0.5},
            {-0.5, 0.25, 0, 0.5, 0.375, 0.5},
            {-0.5, 0.375, 0.25, 0.5, 0.5, 0.5},
            {-0.5, 0.375, -0.5, -0.25, 0.5, 0.5},
        }
    },
    slope_outer = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
            {-0.5, -0.25, -0.25, 0.25, 0, 0.5},
            {-0.5, 0, 0, 0, 0.25, 0.5},
            {-0.5, 0.25, 0.25, -0.25, 0.5, 0.5},
        }
    },
    slope_outer_half = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, -0.375, 0.5},
            {-0.5, -0.375, -0.25, 0.25, -0.25, 0.5},
            {-0.5, -0.25, 0, 0, -0.125, 0.5},
            {-0.5, -0.125, 0.25, -0.25, 0, 0.5},
        }
    },
    slope_outer_half_raised = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.125, 0.5},
            {-0.5, 0.125, -0.25, 0.25, 0.25, 0.5},
            {-0.5, 0.25, 0, 0, 0.375, 0.5},
            {-0.5, 0.375, 0.25, -0.25, 0.5, 0.5},
        }
    },
}

-- Tables used by node rotation code from moreblocks
local wall_right_dirmap = {9, 18, 7, 12}
local wall_left_dirmap = {11, 16, 5, 14}
local ceil_dirmap = {20, 23, 22, 21}

---------------------------------------------------------------------------------------------------
-- Populate global variables
---------------------------------------------------------------------------------------------------

unilib.stair_cost_table = {
    _stair_simple = 6,
    _stair_inner = 7,
    _stair_outer = 5,
    _stair_slab = 4,
    _stair_simple_inverted = 6,
    _stair_simple_half = 3,
    _stair_simple_half_inverted = 3,
    _stair_simple_half_right = 3,
    _stair_simple_half_right_inverted = 3,
    _stair_corner = 6,
    _stair_corner_half = 3,
    _stair_corner_half_inverted = 3,
    _stair_inner_inverted = 7,
    _stair_outer_inverted = 5,
    _stair_slab_inverted = 4,
    _stair_slab_quarter = 2,
    _stair_slab_quarter_inverted = 2,
    _stair_slab_three_quarter = 6,
    _stair_slab_three_quarter_inverted = 6,
    _stair_tile = 4,
    _stair_tile_quarter = 2,
    _stair_tile_three_quarter = 6,
    _stair_panel_bottom = 2,
    _stair_panel_top = 2,
    _stair_panel_vertical = 2,
    _stair_micro_bottom = 1,
    _stair_micro_top = 1,
    _stair_micro_bottom_cut_eighth = 1,
    _stair_micro_bottom_cut_quarter = 1,
    _stair_micro_bottom_cut_half = 1,
    _stair_panel_vertical_sliced_eighth = 2,
    _stair_panel_vertical_sliced_quarter = 2,
    _stair_panel_vertical_sliced_half = 2,
    _stair_panel_bottom_cut_eighth = 1,
    _stair_panel_bottom_cut_quarter = 1,
    _stair_panel_bottom_cut_half = 1,
    _stair_tile_sliced_eighth = 4,
    _stair_tile_sliced_quarter = 4,
    _stair_tile_sliced_half = 3,
    _stair_slab_cut_eighth = 1,
    _stair_slab_cut_quarter = 1,
    _stair_slab_cut_half = 2,
    _stair_slab_sliced_eighth = 8,
    _stair_slab_sliced_quarter = 7,
    _stair_slab_sliced_half = 6,
    _stair_box_sided_two = 1,
    _stair_box_sided_three_corner = 2,
    _stair_box_sided_three = 2,
    _stair_slope = 4,
    _stair_slope_half = 2,
    _stair_slope_half_raised = 6,
    _stair_slope_inner = 7,
    _stair_slope_inner_half = 3,
    _stair_slope_inner_half_raised = 7,
    _stair_slope_inner_cut = 7,
    _stair_slope_inner_cut_half = 4,
    _stair_slope_inner_cut_half_raised = 8,
    _stair_slope_outer = 3,
    _stair_slope_outer_half = 2,
    _stair_slope_outer_half_raised = 6,
    _stair_slope_outer_cut = 2,
    _stair_slope_outer_cut_half = 1,
    _stair_slope_outer_cut_half_raised = 3,
    _stair_slope_cut = 4,
    _stair_steps = 4,
    _stair_steps_sliced_eighth = 1,
    _stair_steps_sliced_quarter = 1,
    _stair_steps_sliced_half = 2,
    _stair_corner_roof = 2,
    _stair_corner_roof_inverted = 2,
    _stair_hole_murder = 4,
    _stair_hole_machicolation = 4,
    _stair_pillar_bottom = 5,
    _stair_pillar_bottom_half = 2,
    _stair_pillar_top = 5,
    _stair_pillar_top_half = 2,
    _stair_pillar_middle = 6,
    _stair_pillar_middle_half = 3,
    _stair_pillar_crossbrace = 5,
    _stair_pillar_crossbrace_ext = 5,
    _stair_slit = 3,
    _stair_slit_cross = 3,
    _stair_slit_hole = 3,
    _stair_slit_embrasure = 3,
    _stair_arch_simple = 5,
    _stair_arch_outer = 7,
    _stair_arch_inner = 3,
}

unilib.stair_ordered_table = {
    -- The Mark I saw, everything from minetest_game/stairs
    {"_stair_simple", "_stair_inner", "_stair_outer", "_stair_slab"},
    -- The Mark II saw, everything from stairs_redo
    {
        "_stair_simple",
        "_stair_inner",
        "_stair_outer",
        "_stair_slab",
        "_stair_slope",
        "_stair_slope_inner",
        "_stair_slope_outer",
    },
    -- The Mark III saw, everything from stairsplus
    {
        "_stair_simple",
        "_stair_inner",
        "_stair_outer",
        "_stair_slab",
        "_stair_simple_inverted",
        "_stair_simple_half",
        "_stair_simple_half_inverted",
        "_stair_simple_half_right",
        "_stair_simple_half_right_inverted",
        "_stair_corner",
        "_stair_corner_half",
        "_stair_corner_half_inverted",
        "_stair_inner_inverted",
        "_stair_outer_inverted",
        "_stair_slab_inverted",
        "_stair_slab_quarter",
        "_stair_slab_quarter_inverted",
        "_stair_slab_three_quarter",
        "_stair_slab_three_quarter_inverted",
        "_stair_tile",
        "_stair_tile_quarter",
        "_stair_tile_three_quarter",
        "_stair_panel_bottom",
        "_stair_panel_top",
        "_stair_panel_vertical",
        "_stair_micro_bottom",
        "_stair_micro_top",
    },
    -- The Mark IV saw, everything from moreblocks
    {
        "_stair_micro_bottom_cut_eighth",
        "_stair_panel_bottom_cut_eighth",
        "_stair_micro_bottom_cut_quarter",
        "_stair_panel_bottom_cut_quarter",
        "_stair_micro_bottom_cut_half",
        "_stair_panel_bottom_cut_half",
        "_stair_micro_bottom",
        "_stair_panel_bottom",

        "_stair_panel_vertical_sliced_half",
        "_stair_tile_sliced_half",
        "_stair_panel_vertical_sliced_quarter",
        "_stair_tile_sliced_quarter",
        "_stair_panel_vertical_sliced_eighth",
        "_stair_tile_sliced_eighth",
        "_stair_outer",
        "_stair_simple",

        "_stair_inner",
        "_stair_slab_cut_eighth",
        "_stair_slab_cut_quarter",
        "_stair_slab_cut_half",
        "_stair_slab",
        "_stair_slab_sliced_half",
        "_stair_slab_sliced_quarter",
        "_stair_slab_sliced_eighth",

        "_stair_box_sided_two",
        "_stair_box_sided_three_corner",
        "_stair_box_sided_three",
        "_stair_simple_half",
        "_stair_steps_sliced_eighth",
        "_stair_steps_sliced_quarter",
        "_stair_steps_sliced_half",
        "_stair_steps",

        "_stair_slope",
        "_stair_slope_half",
        "_stair_slope_half_raised",
        "_stair_slope_inner",
        "_stair_slope_inner_half",
        "_stair_slope_inner_half_raised",
        "_stair_slope_inner_cut",
        "_stair_slope_inner_cut_half",

        "_stair_slope_inner_cut_half_raised",
        "_stair_slope_outer",
        "_stair_slope_outer_half",
        "_stair_slope_outer_half_raised",
        "_stair_slope_outer_cut",
        "_stair_slope_outer_cut_half",
        "_stair_slope_outer_cut_half_raised",
        "_stair_slope_cut",
    },
    -- A hypothetical Mark V saw, containing all stair types not produced by one of the machines
    --      above (note that they all have an individual craft recipe, so a saw is not a
    --      requirement in these cases)
    --[[
    {
        -- From plantlife/trunks
        "_stair_corner_roof",
        "_stair_corner_roof_inverted",
        -- From castle/castle_masonry/
        "_stair_hole_murder",
        "_stair_hole_machicolation",
        "_stair_pillar_bottom",
        "_stair_pillar_bottom_half",
        "_stair_pillar_top",
        "_stair_pillar_top_half",
        "_stair_pillar_middle",
        "_stair_pillar_middle_half",
        "_stair_pillar_crossbrace",
        "_stair_pillar_crossbrace_ext",
        "_stair_slit",
        "_stair_slit_cross",
        "_stair_slit_hole",
        "_stair_slit_embrasure",
        -- From pkarcs/pkarcs
        "_stair_arch_simple",
        "_stair_arch_outer",
        "_stair_arch_inner",
    },
    ]]--
}

---------------------------------------------------------------------------------------------------
-- Local functions (imported from minetest_game/stairs and moreblocks, and then optimised)
---------------------------------------------------------------------------------------------------

local function warn_if_exists(adj_full_name)

    -- Adapted from stairs/init.lua

    if minetest.registered_nodes[adj_full_name] then

        unilib.show_warning(
            "../lib/shared/stairs.lua, warn_if_exists(): Overwriting stairs node", adj_full_name
        )

    end

end

local function rotate_and_place(itemstack, placer, pointed_thing)

    -- Adapted from stairs/init.lua

    local p0 = pointed_thing.under
    local p1 = pointed_thing.above
    local param2 = 0

    if placer then

        local placer_pos = placer:get_pos()
        if placer_pos then
            param2 = minetest.dir_to_facedir(vector.subtract(p1, placer_pos))
        end

        local finepos = minetest.pointed_thing_to_face_pos(placer, pointed_thing)
        local fpos = finepos.y % 1

        if p0.y - 1 == p1.y or
                (fpos > 0 and fpos < 0.5) or
                (fpos < -0.5 and fpos > -0.999999999) then

            param2 = param2 + 20
            if param2 == 21 then
                param2 = 23
            elseif param2 == 23 then
                param2 = 21
            end

        end

    end

    return minetest.item_place(itemstack, placer, pointed_thing, param2)

end

local function rotate_and_place_advanced(itemstack, placer, pointed_thing)

    -- Adapted from moreblocks/stairsplus/common.lua
    --
    -- Notes from moreblocks:
    -- Extends the standad rotate_node placement so that it takes into account the side (top/bottom
    --      or left/right) of the face being pointed at
    -- As with the standard rotate_node, sneak can be used to force the perpendicular placement
    --      (wall placement on floor/ceiling, floor/ceiling placement on walls)
    -- Additionally, the aux / sprint / special key can be used to place the node as if from the
    --      opposite side
    --
    -- When placing a node next to one of the same category (e.g. slab to slab or stair to stair),
    --      the default placement (regardless of sneak) is to copy the under node's param2, flipping
    --      if placed above or below it. The aux key disables this behaviour

    local sneak = placer and placer:get_player_control().sneak
    local aux = placer and placer:get_player_control().aux1

    -- Stair categories for what we are placing, and what we are placing against (e.g. "simple",
    --      "slope", "panel" or an empty strings for non-stair nodes)
    local place_cat = unilib.extract_stair_category(itemstack:get_name())
    local under = pointed_thing.under
    local under_node = minetest.get_node(under)
    local under_cat = unilib.extract_stair_category(under_node.name)
    local same_cat = place_cat == under_cat

    -- Standard (floor) facedir, also used for sneak placement against the lower half of the wall
    local p2 = placer and minetest.dir_to_facedir(placer:get_look_dir()) or 0

    -- Check which face and which quadrant we are interested in
    -- This is used both to check if we're handling parallel placement in the same-category case,
    --      and in general for sneak placement
    local face_pos = minetest.pointed_thing_to_face_pos(placer, pointed_thing)
    local face_off = vector.subtract(face_pos, under)

    -- We cannot trust face_off to tell us the correct direction if the under node has a
    --      non-standard shape, so use the distance between under and above
    local wallmounted = minetest.dir_to_wallmounted(vector.subtract(pointed_thing.above, under))

    if same_cat and not aux then

        p2 = under_node.param2
        -- Flip if placing above or below an upright or upside-down node
        -- Notes from moreblocks:
        -- TODO should we also flip when placing next to a side-mounted node?
        if wallmounted < 2 then

            if p2 < 4 then

                p2 = (p2 + 2) % 4
                p2 = ceil_dirmap[p2 + 1]

            elseif p2 > 19 then

                p2 = ceil_dirmap[p2 - 19] - 20
                p2 = (p2 + 2) % 4

            end

        end

    else

        -- For same-cat placement, aux is used to disable param2 copying
        if same_cat then
            aux = not aux
        end

        local remap = nil

        -- Standard placement against the wall
        local use_wallmap = (wallmounted > 1 and not sneak) or (wallmounted < 2 and sneak)

        -- Standard placement against the ceiling, or sneak placement against the upper half of the
        --      wall
        local use_ceilmap = wallmounted == 1 and not sneak
        use_ceilmap = use_ceilmap or (wallmounted > 1 and sneak and face_off.y > 0)

        if use_wallmap then

            local left = (p2 == 0 and face_off.x < 0) or

                (p2 == 1 and face_off.z > 0) or
                (p2 == 2 and face_off.x > 0) or
                (p2 == 3 and face_off.z < 0)

            if aux then
                left = not left
            end

            remap = left and wall_left_dirmap or wall_right_dirmap

        elseif use_ceilmap then

            remap = ceil_dirmap

        end

        if aux then
            p2 = (p2 + 2) % 4
        end

        if remap then
            p2 = remap[p2 + 1]
        end

    end

    return minetest.item_place(itemstack, placer, pointed_thing, p2)

end

local function rotate_and_place_arch(itemstack, placer, pointed_thing)

    -- Adapted from pkarcs/pkarcs/init.lua

    -- N.B. p1 / p0 are inverted, compared to rotate_and_place()
    local p1 = pointed_thing.under
    local p0 = pointed_thing.above
    local param2 = 0

    if placer then

        local placer_pos = placer:get_pos()
        if placer_pos then
            param2 = minetest.dir_to_facedir(vector.subtract(p1, placer_pos))
        end

        local finepos = minetest.pointed_thing_to_face_pos(placer, pointed_thing)
        local fpos = finepos.y % 1

        if p0.y - 1 == p1.y or
                (fpos > 0 and fpos < 0.5) or
                (fpos < -0.5 and fpos > -0.999999999) then

            param2 = param2 + 20
            if param2 == 21 then
                param2 = 23
            elseif param2 == 23 then
                param2 = 21
            end

        end

        -- "num_rot" is number of possible "rotations" (4 = up down left right)
        local num_rot = 4
        local rot = param2 % num_rot
        local wall = math.floor(param2 / num_rot)
        if rot >= 3 then
            rot = 0
        else
            rot = rot + 1
        end

        param2 = (wall * num_rot) + rot

    end

    return minetest.item_place(itemstack, placer, pointed_thing, param2)

end

local function prepare_stair(
    full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc, show_flag,
    draw_data_table, optional_table
)
    -- Adapted from stairs/init.lua
    --
    -- Args:
    --      full_name (str): "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --      data_table (table): The table described in unilib.register_stairs()
    --      adj_part_name (str): e.g. "_stair_simple"
    --      adj_full_name (str): e.g. "unilib:stone_ordinary_stair_simple"
    --      adj_desc (str): e.g. "Ordinary Stone (Simple Stair")
    --      show_flag (bool): Set to true if the stair is to be shown in the creative inventory,
    --          false (or nil) if it is to be hidden
    --      draw_data_table (table): Table describing the shape of the stair, in one of two formats
    --          (described below)
    --      optional_table (table): Table of optional key-value pairs, unique to this stair type.
    --          Recognised keys are:
    --              .arch_flag (bool): Set to true for arches, in which special rotate-and-place
    --                  code is needed, ignoring other rotate-and-place settings
    --              .crossbrace_flag (bool): Set to true if the "crossbrace_connectable" group
    --                  should be set, false (or nil) if not
    --              .no_advanced_rotation_flag (bool): Set to true if the stair should not be
    --                  rotated when placed, as it usually would be, false (or nil) if not. Set to
    --                  true in stair types from the plantlife modpack
    --              .slab_flag (bool): Set to true for slabs, false (or nil) for everything else
    --              .slab_img_flag (bool): Set to true for slabs and other suitable stair types for
    --                  which a special list of textures can be used (when available), false (or
    --                  nil) for everything else

    if optional_table == nil then
        optional_table = {}
    end

    -- (Some original nodes provide a special list of textures for slabs and related stairs)
    local source_img_list = {}
    local stair_img_list = {}
    if optional_table.slab_img_flag and data_table.slab_img_list ~= nil then
        source_img_list = data_table.slab_img_list
    else
        source_img_list = def_table.tiles
    end

    if not optional_table.slab_flag then

        -- For non-slabs, set backface culling and world-aligned textures
        for i, img in ipairs(source_img_list) do

            if type(img) == "string" then

                stair_img_list[i] = {
                    name = img,
                    backface_culling = true,
                }

                if not data_table.img_rotate_flag then
                    stair_img_list[i].align_style = "world"
                end

            else

                stair_img_list[i] = table.copy(img)
                if stair_img_list[i].backface_culling == nil then
                    stair_img_list[i].backface_culling = true
                end

                if not data_table.img_rotate_flag and stair_img_list[i].align_style == nil then
                    stair_img_list[i].align_style = "world"
                end

            end

        end

    else

        -- For slabs, set world-aligned textures (but not backface culling)
        for i, img in ipairs(source_img_list) do

            if type(img) == "string" then

                stair_img_list[i] = {
                    name = img,
                }

                if not data_table.img_rotate_flag then
                    stair_img_list[i].align_style = "world"
                end

            else

                stair_img_list[i] = table.copy(img)
                if not data_table.img_rotate_flag and img.align_style == nil then
                    stair_img_list[i].align_style = "world"
                end

            end

        end

    end

    -- Update the original node's groups field
    local adj_group_table = table.copy(def_table.groups)

    adj_group_table.stair = 1
    -- e.g. "stair_slab = 1"
    adj_group_table[string.sub(adj_part_name, 2)] = 1
    -- e.g. "wood_stair_slab = 1"
    if data_table.group_type ~= nil then
        adj_group_table[data_table.group_type .. adj_part_name] = 1
    end

    if not show_flag then
        adj_group_table.not_in_creative_inventory = 1
    else
        adj_group_table.not_in_creative_inventory = nil
    end

    -- (Crossbrace-connecting pillars from castle/castle_masonry)
    if optional_table.crossbrace_flag then
        adj_group_table.crossbrace = 1
    end

    -- Basic check
    warn_if_exists(adj_full_name)

    -- Prepare to register the node (the function is a simplified version of
    --      unilib.register_node() )
    -- Note that the definition table is based on the one in the stairs mod, not the stairsplus or
    --      moreblocks mods (which are slightly different). All unilib stairs use a definition in
    --      this style
    local adj_def_table = {}
    if optional_table.arch_flag then

        adj_def_table = {
            description = adj_desc,
            tiles = stair_img_list,
            groups = adj_group_table,
            sounds = def_table.sounds,

            is_ground_content = false,
            paramtype = "light",
            paramtype2 = "facedir",
            use_texture_alpha = def_table and def_table.use_texture_alpha,

            on_place = function(itemstack, placer, pointed_thing)

                if pointed_thing.type ~= "node" then
                    return itemstack
                else
                    return rotate_and_place_arch(itemstack, placer, pointed_thing)
                end

            end,
        }

    elseif optional_table.slab_flag then

        adj_def_table = {
            description = adj_desc,
            tiles = stair_img_list,
            groups = adj_group_table,
            sounds = def_table.sounds,

            drawtype = "nodebox",
            is_ground_content = false,
            node_box = {
                type = "fixed",
                fixed = draw_data_table,
            },
            paramtype = "light",
            paramtype2 = "facedir",
            use_texture_alpha = def_table and def_table.use_texture_alpha,

            on_place = function(itemstack, placer, pointed_thing)

                local under = minetest.get_node(pointed_thing.under)
                local wield_item = itemstack:get_name()
                local player_name = placer and placer:get_player_name() or ""

                if under and (
                    under.name:find("_stair_slab") or       -- unilib stair nodes
                    under.name:find("stairs:slab") or
                    under.name:find("stairsplus:slab") or
                    under.name:find("moreblocks:slab")
                ) then
                    -- Place slab using under node orientation
                    local dir = minetest.dir_to_facedir(
                        vector.subtract(pointed_thing.above, pointed_thing.under),
                        true
                    )

                    local p2 = under.param2

                    if p2 >= 20 and dir == 8 then

                        -- Placing a slab on an upside down slab should make it right-side up
                        p2 = p2 - 20

                    elseif p2 <= 3 and dir == 4 then

                        -- Same for the opposite case: slab below normal slab
                        p2 = p2 + 20

                    end

                    -- Else attempt to place node with proper param2
                    minetest.item_place_node(ItemStack(wield_item), placer, pointed_thing, p2)
                    if not unilib.is_creative(player_name) then
                        itemstack:take_item()
                    end

                    return itemstack

                else

                    if not unilib.advanced_stair_rotation_flag or
                            optional_table.no_advanced_rotation_flag then
                        return rotate_and_place(itemstack, placer, pointed_thing)
                    else
                        return rotate_and_place_advanced(itemstack, placer, pointed_thing)
                    end

                end

            end,
        }

    else

        -- Everything except arches and slabs
        adj_def_table = {
            description = adj_desc,
            tiles = stair_img_list,
            groups = adj_group_table,
            sounds = def_table.sounds,

            is_ground_content = false,
            paramtype = "light",
            paramtype2 = "facedir",
            use_texture_alpha = def_table and def_table.use_texture_alpha,

            on_place = function(itemstack, placer, pointed_thing)

                if pointed_thing.type ~= "node" then
                    return itemstack
                end

                if not unilib.advanced_stair_rotation_flag or
                        optional_table.no_advanced_rotation_flag then
                    return rotate_and_place(itemstack, placer, pointed_thing)
                else
                    return rotate_and_place_advanced(itemstack, placer, pointed_thing)
                end

            end,
        }

    end

    -- Smooth stone drops cobblestone (etc)
    if unilib.convert_stairs_on_drop_flag and data_table.drop_name ~= nil then
        adj_def_table.drop = data_table.drop_name .. adj_part_name
    end

    -- Light from light sources is reduced by volume, up to half the original
    if def_table.light_source ~= nil and def_table.light_source > 0 then

        if not unilib.reduce_stair_light_flag then

            adj_def_table.light_source = def_table.light_source

        else

            adj_def_table.light_source =
                def_table.light_source * (0.5 + (unilib.stair_cost_table[adj_part_name] / 16))

        end

    end

    if def_table.sunlight_propagates ~= nil then
        adj_def_table.sunlight_propagates = def_table.sunlight_propogates
    end

    -- Apply the moreblocks fix for glass stairs that are difficult to see (if required)
    if data_table.glass_flag and #adj_def_table.tiles > 1 then
        adj_def_table.tiles = {def_table.tiles[1]}
    end

    if not optional_table.slab_flag then

        -- For non-slab nodes, draw_data_table contains either this:
        --      {
        --          node_box = {
        --              type = "fixed",
        --              fixed = FIXED_TABLE,
        --          },
        --      }
        -- ...or this:
        --      {
        --          mesh = "moreblocks_slope_cut.obj",
        --          collision_box = FIXED_TABLE,
        --          selection_box = FIXED_TABLE,
        --      }
        if draw_data_table["node_box"] ~= nil then

            adj_def_table.drawtype = "nodebox"
            adj_def_table.node_box = draw_data_table.node_box

        else

            adj_def_table.drawtype = "mesh"
            for k, v in pairs(draw_data_table) do
                adj_def_table[k] = v
            end

        end

    end

    -- Register the node
    unilib.register_node_stair_variant(adj_full_name, adj_def_table)
    -- Update global variables
    unilib.stair_deconvert_table[adj_full_name] = full_name
    if unilib.stair_convert_table[full_name] == nil then
        unilib.stair_convert_table[full_name] = {adj_full_name}
    else
        table.insert(unilib.stair_convert_table[full_name], adj_full_name)
    end

end

local function create_fuel_recipe(full_name, adj_full_name, factor)

    -- Adapted from stairs/init.lua

    local base_burn_time = minetest.get_craft_result({
        method = "fuel",
        width = 1,
        items = {full_name}
    }).time

    if base_burn_time > 0 then

        unilib.register_craft({
            type = "fuel",
            recipe = adj_full_name,
            burntime = math.floor(base_burn_time * factor),
        })

    end

end

local function create_cook_recipe(ingredient_name, cooked_name, stair_name)

    -- Adapted from stairsplus/init.lua

    -- If "cooked_name" is not nil, then it is the smooth stone (or similar node) corresponding to
    --      the cobblestone (or similar node) "ingredient_name"
    -- "stair_name" is added to the end of both names to create a stair node, e.g. "_stair_simple"

    if cooked_name ~= nil then

        unilib.register_craft({
            type = "cooking",
            output = cooked_name .. stair_name,
            recipe = ingredient_name .. stair_name,
        })

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions (extract the stair type/category)
---------------------------------------------------------------------------------------------------

function unilib.extract_stair_type(adj_full_name)

    -- Original to unilib
    -- Returns the stair type (a key in unilib.stair_cost_table)
    --
    -- Args:
    --      adj_full_name (str): A stair node created by this file, e.g.
    --          "unilib:stone_ordinary_stair_simple"
    --
    -- Return values:
    --      The stair type, e.g. "_stair_simple", or an empty string if it's not a stair node

    -- Get the node from which the stair was constructed. e.g. "unilib:stone_ordinary"
    local full_name = unilib.stair_deconvert_table[adj_full_name]

    -- Extract the stair type
    if full_name == nil then
        return ""
    else
        return string.sub(adj_full_name, (#full_name + 1), -1)
    end

end

function unilib.extract_stair_category(adj_full_name)

    -- Original to unilib
    -- Returns the stair category (the second component of the stair type, i.e. one of the strings
    --      "simple", "corner", "inner", "outer", "slab", "tile", "panel", "micro", "box", "slope"
    --      or "steps"
    --
    -- Args:
    --      adj_full_name (str): A stair node created by this file, e.g.
    --          "unilib:stone_ordinary_stair_simple"
    --
    -- Return values:
    --      The stair category, or an empty string if it's not a stair node

    -- Get the node from which the stair was constructed. e.g. "unilib:stone_ordinary"
    local full_name = unilib.stair_deconvert_table[adj_full_name]

    -- Extract the stair category
    if full_name == nil then

        return ""

    else

        -- The stair type is in the form "_stair_CATEGORY_component_component..."
        local stair_category = string.sub(adj_full_name, (#full_name + 8), -1)
        local pos = stair_category:find("_") or 0
        if pos == 0 then

            -- e.g. stair type is "_stair_simple", so after "_stair_" there are no underlines to
            --      find
            return stair_category

        else

            -- e.g. stair type is "_micro_bottom_cut_eighth"
            return string.sub(stair_category, 1, pos - 1)
        end

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions (functions to register multiple types of stair)
---------------------------------------------------------------------------------------------------

function unilib.register_stairs(full_name, data_table)

    -- Original to unilib
    -- Most code will call this function to create all available stair types for a node
    --
    -- Other functions below are the direct equivalents of minetest_game/stairs functions, and can
    --      be called directly, if needed (for example, when only a node in the shape of a slab is
    --      to be created). None of them check Minetest settings, so the calling code must do that
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --
    -- Optional args:
    --      data_table (table or nil): If specified, contains any of the fields:
    --          .basic_flag (bool): If true, only stairs from minetest_game/stairs are created. If
    --              unilib.add_stairs_plantlife_flag is true, then stairs from plantlife are also
    --              created
    --          .cooked_name (str): If specified, "full_name" is a cobblestone (or similar node)
    --              that can be cooked to produce the node "cooked_name". All derivative stair nodes
    --              can be cooked in the same way
    --          .drop_name (str): If specified, "full_name" is a smooth stone (or similar node) that
    --              produces the node "drop_name" when dug. All derivative stair nodes can be dug in
    --              the same way
    --          .glass_flag (bool): If true, the moreblocks system for cut glass applies: the top
    --              texture is used for all sides of the stair node (which makes them easier to
    --              see). Note that this might not apply to all glass nodes (it does not apply, for
    --              example, to ordinary and obsidian glass from default)
    --          .group_type (str): If specified, used to give each stair node a group that
    --              identifies both the stair type and the node type. For example, tree packages
    --              should call this function with the .group_type "wood", in which case stair
    --              nodes are created with the groups "wood_stair_simple = 1", "wood_stair_slab = 1"
    --              and so on. Thus, other nodes can use "group:wood_stair_simple",
    --              "group:wood_stair_slab" in their craft recipes. Any value is acceptable; unilib
    --              code routinely uses the values "wood" (for tree planks), and "smooth", "block",
    --              "brick", "cobble", "mossy_cobble" and "rubble" (for stone nodes)
    --          .img_rotate_flag (bool): If true, when the stair node is rotated, its textures are
    --              rotated too. If false (or unspecified), when the stair node is rotated, its
    --              textures are kept aligned with the world. Thus, nodes with non-symmetrical
    --              textures (such as unilib:stone_ordinary_brick and most other brick nodes) should
    --              specify this flag
    --          .slab_img_list (list): List of textures to use for slabs. If not specified, the
    --              textures of the original node are used

    -- (Any of unilib.add_stairs_basic_flag, .add_stairs_stairs_redo_flag,
    --      .add_stairs_stairsplus_flag or .add_stairs_moreblocks_flag are true)
    if unilib.add_stairs_any_flag then

        local def_table = minetest.registered_nodes[full_name]
        if def_table == nil then

            return unilib.show_error(
                string.format(
                    ".unilib.register_stairs(): cannot add stairs because \"%s\" is not a" ..
                            " registered node",
                    full_name
                )
            )

        elseif def_table.groups ~= nil then

            -- Stairs made from soils must not be used to grow crops, etc
            def_table.groups.soil = nil

        end

        if data_table == nil then
            data_table = {}
        end

        unilib.register_stairs_all(
            full_name,
            unilib.get_item_name(full_name),
            def_table,
            data_table
        )

    end

end

function unilib.register_stairs_all(full_name, item_name, def_table, data_table)

    -- Adapted from stairs/init.lua, stairs.register_stair_and_slab() and
    --      my_register_stair_and_slab()
    -- This function should only be called as a direct replacement for those functions, when that is
    --      necessary; in almost all circumstances, it's better to call unilib.register_stairs()
    --      instead
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      item_name (str): e.g. "stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()

    -- Create stair nodes derived from "full_name"
    if unilib.add_stairs_basic_flag or
            unilib.add_stairs_stairs_redo_flag or
            unilib.add_stairs_stairsplus_flag or
            unilib.add_stairs_moreblocks_flag then

        unilib.register_stairs_simple(full_name, def_table, data_table)
        unilib.register_stairs_inner(full_name, def_table, data_table)
        unilib.register_stairs_outer(full_name, def_table, data_table)
        unilib.register_stairs_slab(full_name, def_table, data_table)

    end

    if unilib.add_stairs_plantlife_flag then

        unilib.register_stairs_corner_roof(full_name, def_table, data_table)
        unilib.register_stairs_corner_roof_inverted(full_name, def_table, data_table)

    end

    if data_table.basic_flag then
        return
    end

    if unilib.add_stairs_stairsplus_flag or unilib.add_stairs_moreblocks_flag then

        unilib.register_stairs_simple_half(full_name, def_table, data_table)
        unilib.register_stairs_simple_half_right(full_name, def_table, data_table)
        unilib.register_stairs_panel_bottom(full_name, def_table, data_table)
        unilib.register_stairs_micro_bottom(full_name, def_table, data_table)

    end

    if unilib.add_stairs_stairsplus_flag then

        unilib.register_stairs_simple_inverted(full_name, def_table, data_table)
        unilib.register_stairs_simple_half_inverted(full_name, def_table, data_table)
        unilib.register_stairs_simple_half_right_inverted(full_name, def_table, data_table)
        unilib.register_stairs_corner(full_name, def_table, data_table)
        unilib.register_stairs_corner_half(full_name, def_table, data_table)
        unilib.register_stairs_corner_half_inverted(full_name, def_table, data_table)
        unilib.register_stairs_inner_inverted(full_name, def_table, data_table)
        unilib.register_stairs_outer_inverted(full_name, def_table, data_table)
        unilib.register_stairs_slab_inverted(full_name, def_table, data_table)
        unilib.register_stairs_slab_quarter(full_name, def_table, data_table)
        unilib.register_stairs_slab_quarter_inverted(full_name, def_table, data_table)
        unilib.register_stairs_slab_three_quarter(full_name, def_table, data_table)
        unilib.register_stairs_slab_three_quarter_inverted(full_name, def_table, data_table)
        unilib.register_stairs_tile(full_name, def_table, data_table)
        unilib.register_stairs_tile_quarter(full_name, def_table, data_table)
        unilib.register_stairs_tile_three_quarter(full_name, def_table, data_table)
        unilib.register_stairs_panel_top(full_name, def_table, data_table)
        unilib.register_stairs_panel_vertical(full_name, def_table, data_table)
        unilib.register_stairs_micro_top(full_name, def_table, data_table)

    end

    if unilib.add_stairs_stairs_redo_flag then

        unilib.register_stairs_slope(full_name, def_table, data_table)
        unilib.register_stairs_slope_inner(full_name, def_table, data_table)
        unilib.register_stairs_slope_outer(full_name, def_table, data_table)

    end

    if unilib.add_stairs_moreblocks_flag then

        unilib.register_stairs_micro_bottom_cut_eighth(full_name, def_table, data_table)
        unilib.register_stairs_micro_bottom_cut_quarter(full_name, def_table, data_table)
        unilib.register_stairs_micro_bottom_cut_half(full_name, def_table, data_table)
        unilib.register_stairs_panel_vertical_sliced_eighth(full_name, def_table, data_table)
        unilib.register_stairs_panel_vertical_sliced_quarter(full_name, def_table, data_table)
        unilib.register_stairs_panel_vertical_sliced_half(full_name, def_table, data_table)
        unilib.register_stairs_panel_bottom_cut_eighth(full_name, def_table, data_table)
        unilib.register_stairs_panel_bottom_cut_quarter(full_name, def_table, data_table)
        unilib.register_stairs_panel_bottom_cut_half(full_name, def_table, data_table)
        unilib.register_stairs_tile_sliced_eighth(full_name, def_table, data_table)
        unilib.register_stairs_tile_sliced_quarter(full_name, def_table, data_table)
        unilib.register_stairs_tile_sliced_half(full_name, def_table, data_table)
        unilib.register_stairs_slab_cut_eighth(full_name, def_table, data_table)
        unilib.register_stairs_slab_cut_quarter(full_name, def_table, data_table)
        unilib.register_stairs_slab_cut_half(full_name, def_table, data_table)
        unilib.register_stairs_slab_sliced_eighth(full_name, def_table, data_table)
        unilib.register_stairs_slab_sliced_quarter(full_name, def_table, data_table)
        unilib.register_stairs_slab_sliced_half(full_name, def_table, data_table)
        unilib.register_stairs_box_sided_two(full_name, def_table, data_table)
        unilib.register_stairs_box_sided_three(full_name, def_table, data_table)
        unilib.register_stairs_box_sided_three_corner(full_name, def_table, data_table)
        unilib.register_stairs_slope_half(full_name, def_table, data_table)
        unilib.register_stairs_slope_half_raised(full_name, def_table, data_table)
        unilib.register_stairs_slope_inner_half(full_name, def_table, data_table)
        unilib.register_stairs_slope_inner_half_raised(full_name, def_table, data_table)
        unilib.register_stairs_slope_inner_cut(full_name, def_table, data_table)
        unilib.register_stairs_slope_inner_cut_half(full_name, def_table, data_table)
        unilib.register_stairs_slope_inner_cut_half_raised(full_name, def_table, data_table)
        unilib.register_stairs_slope_outer_half(full_name, def_table, data_table)
        unilib.register_stairs_slope_outer_half_raised(full_name, def_table, data_table)
        unilib.register_stairs_slope_outer_cut(full_name, def_table, data_table)
        unilib.register_stairs_slope_outer_cut_half(full_name, def_table, data_table)
        unilib.register_stairs_slope_outer_cut_half_raised(full_name, def_table, data_table)
        unilib.register_stairs_slope_cut(full_name, def_table, data_table)
        unilib.register_stairs_steps(full_name, def_table, data_table)
        unilib.register_stairs_steps_sliced_eighth(full_name, def_table, data_table)
        unilib.register_stairs_steps_sliced_quarter(full_name, def_table, data_table)
        unilib.register_stairs_steps_sliced_half(full_name, def_table, data_table)

    end

    if unilib.add_stairs_castle_flag then

        unilib.register_stairs_hole_murder(full_name, def_table, data_table)
        unilib.register_stairs_hole_machicolation(full_name, def_table, data_table)
        unilib.register_stairs_pillar_bottom(full_name, def_table, data_table)
        unilib.register_stairs_pillar_bottom_half(full_name, def_table, data_table)
        unilib.register_stairs_pillar_top(full_name, def_table, data_table)
        unilib.register_stairs_pillar_top_half(full_name, def_table, data_table)
        unilib.register_stairs_pillar_middle(full_name, def_table, data_table)
        unilib.register_stairs_pillar_middle_half(full_name, def_table, data_table)
        unilib.register_stairs_pillar_crossbrace(full_name, def_table, data_table)
        unilib.register_stairs_pillar_crossbrace_ext(full_name, def_table, data_table)
        unilib.register_stairs_slit(full_name, def_table, data_table)
        unilib.register_stairs_slit_cross(full_name, def_table, data_table)
        unilib.register_stairs_slit_hole(full_name, def_table, data_table)
        unilib.register_stairs_slit_embrasure(full_name, def_table, data_table)

    end

    if unilib.add_stairs_pkarcs_flag then

        unilib.register_stairs_arch_simple(full_name, def_table, data_table)
        unilib.register_stairs_arch_outer(full_name, def_table, data_table)
        unilib.register_stairs_arch_inner(full_name, def_table, data_table)

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions (imported from various stairs mods, and optimised)
---------------------------------------------------------------------------------------------------

function unilib.register_stairs_simple(full_name, def_table, data_table)

    -- Adapted from stairs/init.lua, stairs:stair_XXX
    -- Adapted from stairs_redo/init.lua, stairs:stair_XXX
    -- Adapted from stairsplus/stair.lua, stairsplus:stair_XXX
    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:stair_XXX
    -- Creates a simple stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_simple"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Simple stair"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_any_flag,
        {
            node_box = node_box_table.simple,
        },
        {slab_img_flag = true}
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 12/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From minetest_game/stairs)
    unilib.register_craft({
        output = adj_full_name .. " 8",
        recipe = {
            {"", "", full_name},
            {"", full_name, full_name},
            {full_name, full_name, full_name},
        },
    })
    unilib.register_craft({
        output = adj_full_name .. " 8",
        recipe = {
            {full_name, "", ""},
            {full_name, full_name, ""},
            {full_name, full_name, full_name},
        },
    })

    unilib.register_craft({
        output = full_name .. " 3",
        recipe = {
            {adj_full_name, adj_full_name},
            {adj_full_name, adj_full_name},
        },
    })

    if unilib.add_stairs_stairsplus_flag and not data_table.basic_flag then

        -- Adapted from stairsplus/stairs.lua

        unilib.register_craft({
            output = adj_full_name,
            recipe = {
                {full_name .. "_stair_simple_inverted"},
            },
        })

        unilib.register_craft({
            output = adj_full_name,
            recipe = {
                {full_name .. "_stair_simple_half", full_name .. "_stair_simple_half"},
            },
        })

        unilib.register_craft({
            output = adj_full_name,
            recipe = {
                {full_name .. "_stair_simple_half_right", full_name .. "_stair_simple_half_right"},
            },
        })

    end

    if unilib.add_stairs_moreblocks_flag and not data_table.basic_flag then

        -- Adapted from moreblocks/recipes.lua

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name,
            recipe = {full_name .. "_stair_panel_bottom", full_name .. "_stair_slab"},
        })

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name,
            recipe = {
                full_name .. "_stair_panel_bottom",
                full_name .. "_stair_panel_bottom",
                full_name .. "_stair_panel_bottom",
            },
        })

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name,
            recipe = {
                full_name .. "_stair_micro_bottom",
                full_name .. "_stair_micro_bottom",
                full_name .. "_stair_micro_bottom",
                full_name .. "_stair_micro_bottom",
                full_name .. "_stair_micro_bottom",
                full_name .. "_stair_micro_bottom",
            },
        })

    end

    return adj_full_name

end

function unilib.register_stairs_inner(full_name, def_table, data_table)

    -- Adapted from stairs/init.lua, stairs:stair_inner_XXX
    -- Adapted from stairs_redo/init.lua, stairs:stair_inner_XXX
    -- Adapted from stairsplus/corner.lua, stairsplus:corner_XXX_inner
    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:stair_XXX_inner
    -- Creates an inner stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_inner"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Inner stair"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_any_flag,
        {
            node_box = node_box_table.inner,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 14/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From minetest_game/stairs)
    unilib.register_craft({
        output = adj_full_name .. " 7",
        recipe = {
            {"", full_name, ""},
            {full_name, "", full_name},
            {full_name, full_name, full_name},
        },
    })

    if unilib.add_stairs_stairsplus_flag and not data_table.basic_flag then

        -- Adapted from stairsplus/stairs.lua

        unilib.register_craft({
            output = adj_full_name,
            recipe = {
                {full_name .. "_stair_micro_bottom", full_name .. "_stair_simple"},
            },
        })

        unilib.register_craft({
            output = adj_full_name,
            recipe = {
                {full_name .. "_stair_corner_half"},
                {full_name .. "_stair_slab"},
            },
        })

        unilib.register_craft({
            output = adj_full_name,
            recipe = {
                {full_name .. "_stair_inner_inverted"},
            },
        })

    end

    if unilib.add_stairs_moreblocks_flag and not data_table.basic_flag then

        -- Adapted from moreblocks/recipes.lua

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name,
            recipe = {
                full_name .. "_stair_micro_bottom",
                full_name .. "_stair_micro_bottom",
                full_name .. "_stair_micro_bottom",
                full_name .. "_stair_micro_bottom",
                full_name .. "_stair_micro_bottom",
                full_name .. "_stair_micro_bottom",
                full_name .. "_stair_micro_bottom",
            },
        })

    end

    return adj_full_name

end

function unilib.register_stairs_outer(full_name, def_table, data_table)

    -- Adapted from stairs/init.lua, stairs:stair_outer_XXX
    -- Adapted from stairs_redo/init.lua, stairs:stair_outer_XXX
    -- Adapted from stairsplus/corner.lua, stairsplus:corner_XXX_outer
    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:stair_XXX_outer
    -- Creates an outer stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_outer"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Outer stair"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_any_flag,
        {
            node_box = node_box_table.outer,
        },
        {slab_img_flag = true}
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 10/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From minetest_game/stairs)
    unilib.register_craft({
        output = adj_full_name .. " 6",
        recipe = {
            {"", full_name, ""},
            {full_name, full_name, full_name},
        },
    })

    if unilib.add_stairs_stairsplus_flag and not data_table.basic_flag then

        -- Adapted from stairsplus/stairs.lua

        unilib.register_craft({
            output = adj_full_name,
            recipe = {
                {full_name .. "_stair_micro_bottom"},
                {full_name .. "_stair_slab"},
            },
        })

        unilib.register_craft({
            output = adj_full_name,
            recipe = {
                {full_name .. "_stair_outer_inverted"},
            },
        })

    end

    if unilib.add_stairs_moreblocks_flag and not data_table.basic_flag then

        -- Adapted from moreblocks/recipes.lua

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name,
            recipe = {full_name .. "_stair_micro_bottom", full_name .. "_stair_slab"},
        })

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name,
            recipe = {
                full_name .. "_stair_micro_bottom",
                full_name .. "_stair_micro_bottom",
                full_name .. "_stair_micro_bottom",
                full_name .. "_stair_micro_bottom",
                full_name .. "_stair_micro_bottom",
            },
        })

    end

    return adj_full_name

end

function unilib.register_stairs_slab(full_name, def_table, data_table)

    -- Adapted from stairs/init.lua, stairs:slab_XXX
    -- Adapted from stairs_redo/init.lua, stairs:slab_XXX
    -- Adapted from stairsplus/slab.lua, stairsplus:slab_XXX
    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slab_XXX
    -- Creates a slab stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slab"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Slab"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_any_flag,
        {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
        {slab_flag = true, slab_img_flag = true}
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 8/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From minetest_game/stairs)
    unilib.register_craft({
        output = adj_full_name .. " 6",
        recipe = {
            {full_name, full_name, full_name},
        },
    })
    unilib.register_craft({
        output = full_name,
        recipe = {
            {adj_full_name},
            {adj_full_name},
        },
    })

    if unilib.add_stairs_stairsplus_flag and not data_table.basic_flag then

        -- Adapted from stairsplus/stairs.lua

        unilib.register_craft({
            output = adj_full_name,
            recipe = {
                {full_name .. "_stair_slab_inverted"},
            },
        })

        unilib.register_craft({
            output = full_name,
            recipe = {
                {full_name .. "_stair_slab_inverted"},
                {full_name .. "_stair_slab_inverted"},
            },
        })

        unilib.register_craft({
            output = adj_full_name,
            recipe = {
                {full_name .. "_stair_slab_quarter"},
                {full_name .. "_stair_slab_quarter"},
            },
        })

    end

    if unilib.add_stairs_moreblocks_flag and not data_table.basic_flag then

        -- Adapted from moreblocks/recipes.lua

        unilib.register_craft({
            output = adj_full_name .. " 6",
            recipe = {
                {full_name, full_name, full_name},
            },
        })

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name,
            recipe = {
                full_name .. "_stair_micro_bottom",
                full_name .. "_stair_micro_bottom",
                full_name .. "_stair_micro_bottom",
                full_name .. "_stair_micro_bottom",
            },
        })

        -- N.B. At the time of writing, the potential conflict described in
        --      https://github.com/minetest/minetest/issues/2881 does not appear to have been
        --      resolved, therefore we continue to use two recipes, rather than one shapeless recipe
        unilib.register_craft({
            output = adj_full_name,
            recipe = {
                {full_name .. "_stair_panel_bottom", full_name .. "_stair_panel_bottom"},
            },
        })

        unilib.register_craft({
            output = adj_full_name,
            recipe = {
                {full_name .. "_stair_panel_bottom"},
                {full_name .. "_stair_panel_bottom"},
            },
        })

        unilib.register_craft({
            type = "shapeless",
            output = full_name,
            recipe = {adj_full_name, adj_full_name},
        })

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name .. " 3",
            recipe = {full_name .. "_stair_simple", full_name .. "_stair_simple"},
        })

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name,
            recipe = {full_name .. "_stair_slab_cut_half", full_name .. "_stair_slab_cut_half"},
        })

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name,
            recipe = {
                full_name .. "_stair_slab_cut_quarter",
                full_name .. "_stair_slab_cut_quarter",
                full_name .. "_stair_slab_cut_quarter",
                full_name .. "_stair_slab_cut_quarter",
            },
        })

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name,
            recipe = {
                full_name .. "_stair_slab_cut_eighth",
                full_name .. "_stair_slab_cut_eighth",
                full_name .. "_stair_slab_cut_eighth",
                full_name .. "_stair_slab_cut_eighth",
                full_name .. "_stair_slab_cut_eighth",
                full_name .. "_stair_slab_cut_eighth",
                full_name .. "_stair_slab_cut_eighth",
                full_name .. "_stair_slab_cut_eighth",
            },
        })

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name,
            recipe = {full_name .. "_stair_slope_half", full_name .. "_stair_slope_half"},
        })

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name,
            recipe = {
                full_name .. "_stair_slope_outer_half",
                full_name .. "_stair_slope_outer_half",
            },
        })

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name,
            recipe = {
                full_name .. "_stair_slope_outer_cut_half",
                full_name .. "_stair_slope_outer_cut_half",
            },
        })

    end

    return adj_full_name

end

function unilib.register_stairs_simple_inverted(full_name, def_table, data_table)

    -- Adapted from stairsplus/stairs.lua, stairsplus:stair_XXX_inverted
    -- Creates an inverted simple stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_simple_inverted"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Inverted simple stair"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_stairsplus_flag,
        {
            node_box = node_box_table.simple_inverted,
        },
        {slab_img_flag = true}
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 12/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_simple"},
        },
    })

    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {
                full_name .. "_stair_simple_half_inverted",
                full_name .. "_stair_simple_half_inverted",
            },
        },
    })

    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {
                full_name .. "_stair_simple_half_right_inverted",
                full_name .. "_stair_simple_half_right_inverted",
            },
        },
    })

    return adj_full_name

end

function unilib.register_stairs_simple_half(full_name, def_table, data_table)

    -- Adapted from stairsplus/stairs.lua, stairsplus:stair_XXX_half
    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:stair_XXX_half
    -- Creates an half simple stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_simple_half"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Half simple stair"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_stairsplus_flag or unilib.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.simple_half,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 6/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name .. " 4",
        recipe = {
            {full_name .. "_stair_simple", full_name .. "_stair_simple"},
        },
    })

    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_simple_half_inverted"},
        },
    })

    unilib.register_craft({
        output = adj_full_name .. " 2",
        recipe = {
            {full_name .. "_stair_simple_half_right"},
            {full_name .. "_stair_simple_half_right"},
        },
    })

    if unilib.add_stairs_moreblocks_flag then

        -- Adapted from moreblocks/recipes.lua

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name,
            recipe = {
                full_name .. "_stair_micro_bottom",
                full_name .. "_stair_micro_bottom",
                full_name .. "_stair_micro_bottom",
            },
        })

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name,
            recipe = {full_name .. "_stair_panel_bottom", full_name .. "_stair_micro_bottom"},
        })

    end

    return adj_full_name

end

function unilib.register_stairs_simple_half_inverted(full_name, def_table, data_table)

    -- Adapted from stairsplus/stairs.lua, stairsplus:stair_XXX_half_inverted
    -- Creates an inverted half simple stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_simple_half_inverted"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Inverted half simple stair"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_stairsplus_flag,
        {
            node_box = node_box_table.simple_half_inverted,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 6/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name .. " 4",
        recipe = {
            {full_name .. "_stair_simple_inverted", full_name .. "_stair_simple_inverted"},
        },
    })

    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_simple_half"},
        },
    })

    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_simple_half_right"},
        },
    })

    unilib.register_craft({
        output = adj_full_name .. " 2",
        recipe = {
            {full_name .. "_stair_simple_half_right_inverted"},
            {full_name .. "_stair_simple_half_right_inverted"},
        },
    })

    return adj_full_name

end

function unilib.register_stairs_simple_half_right(full_name, def_table, data_table)

    -- Adapted from stairsplus/stairs.lua, stairsplus:stair_XXX_right_half
    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:stair_XXX_right_half
    -- Creates a right-half simple stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_simple_half_right"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Right-half simple stair"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_stairsplus_flag or unilib.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.simple_half_right,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 6/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name .. " 2",
        recipe = {
            {full_name .. "_stair_simple_half"},
            {full_name .. "_stair_simple_half"},
        },
    })

    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_simple_half_right_inverted"},
        },
    })

    if unilib.add_stairs_moreblocks_flag then

        -- Adapted from moreblocks/recipes.lua

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name,
            recipe = {full_name .. "_stair_simple_half"},
        })

    end

    return adj_full_name

end

function unilib.register_stairs_simple_half_right_inverted(full_name, def_table, data_table)

    -- Adapted from stairsplus/stairs.lua, stairsplus:stair_XXX_right_half_inverted
    -- Creates an inverted right-half simple stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_simple_half_right_inverted"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Inverted right-half simple stair"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_stairsplus_flag,
        {
            node_box = node_box_table.simple_half_right_inverted,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 6/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name .. " 2",
        recipe = {
            {full_name .. "_stair_simple_half_inverted"},
            {full_name .. "_stair_simple_half_inverted"},
        },
    })

    return adj_full_name

end

function unilib.register_stairs_corner(full_name, def_table, data_table)

    -- Adapted from stairsplus/corner.lua, stairsplus:corner_XXX
    -- Creates a corner stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_corner"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Corner stair"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_stairsplus_flag,
        {
            node_box = node_box_table.corner,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 12/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name .. " 8",
        recipe = {
            {full_name, full_name, full_name},
            {full_name, full_name, ""},
            {full_name, "", ""},
        },
    })
    unilib.register_craft({
        output = adj_full_name .. " 8",
        recipe = {
            {full_name, full_name, full_name},
            {"", full_name, full_name},
            {"", "", full_name},
        },
    })

    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_corner_half"},
            {full_name .. "_stair_corner_half"},
        },
    })

    unilib.register_craft({
        output = full_name .. "_stair_corner",
        recipe = {
            {full_name .. "_stair_corner_half_inverted"},
            {full_name .. "_stair_corner_half_inverted"},
        },
    })

    return adj_full_name

end

function unilib.register_stairs_corner_half(full_name, def_table, data_table)

    -- Adapted from stairsplus/corner.lua, stairsplus:corner_XXX_half
    -- Creates a half corner stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_corner_half"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Half corner stair"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_stairsplus_flag,
        {
            node_box = node_box_table.corner_half,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 6/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_micro_bottom"},
            {full_name .. "_stair_panel_bottom"},
        },
    })

    unilib.register_craft({
        output = adj_full_name .. " 2",
        recipe = {
            {full_name .. "_stair_corner"},
        },
    })

    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_corner_half_inverted"},
        },
    })

    return adj_full_name

end

function unilib.register_stairs_corner_half_inverted(full_name, def_table, data_table)

    -- Adapted from stairsplus/corner.lua, stairsplus:corner_XXX_half_inverted
    -- Creates an inverted half corner stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_corner_half_inverted"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Inverted half corner stair"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_stairsplus_flag,
        {
            node_box = node_box_table.corner_half_inverted,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 6/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_corner_half"},
        },
    })

    return adj_full_name

end

function unilib.register_stairs_inner_inverted(full_name, def_table, data_table)

    -- Adapted from stairsplus/corner.lua, stairsplus:corner_XXX_inner_inverted
    -- Creates an inverted inner stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_inner_inverted"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Inverted inner stair"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_stairsplus_flag,
        {
            node_box = node_box_table.inner_inverted,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 14/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_slab"},
            {full_name .. "_stair_corner_half"},
        },
    })

    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_inner"},
        },
    })

    return adj_full_name

end

function unilib.register_stairs_outer_inverted(full_name, def_table, data_table)

    -- Adapted from stairsplus/corner.lua, stairsplus:corner_XXX_outer_inverted
    -- Creates an inverted outer stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_outer_inverted"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Inverted outer stair"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_stairsplus_flag,
        {
            node_box = node_box_table.outer_inverted,
        },
        {slab_img_flag = true}
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 14/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_outer"},
        },
    })

    return adj_full_name

end

function unilib.register_stairs_slab_inverted(full_name, def_table, data_table)

    -- Adapted from stairsplus/slab.lua, stairsplus:slab_XXX_inverted
    -- Creates an inverted slab node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slab_inverted"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Inverted slab"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_stairsplus_flag,
        {-0.5, 0, -0.5, 0.5, 0.5, 0.5},
        {slab_flag = true, slab_img_flag = true}
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 8/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_slab"},
        },
    })

    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_slab_quarter_inverted"},
            {full_name .. "_stair_slab_quarter_inverted"},
        },
    })

    return adj_full_name

end

function unilib.register_stairs_slab_quarter(full_name, def_table, data_table)

    -- Adapted from stairsplus/slab.lua, stairsplus:slab_XXX_quarter
    -- N.B. This function and unilib.register_stairs_slab_cut_quarter() produce a node that looks
    --      the same, but which have different names. For consistency, both are available
    --
    -- Creates a quarter slab node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slab_quarter"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Quarter slab"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_stairsplus_flag,
        {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
        {slab_flag = true}
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 4/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_slab_quarter_inverted"},
        },
    })

    unilib.register_craft({
        output = full_name,
        recipe = {
            {full_name .. "_stair_slab_quarter"},
            {full_name .. "_stair_slab_quarter"},
            {full_name .. "_stair_slab_quarter"},
            {full_name .. "_stair_slab_quarter"},
        },
    })

    unilib.register_craft({
        output = adj_full_name .. " 6",
        recipe = {
            {full_name .. "_stair_slab_three_quarter"},
            {full_name .. "_stair_slab_three_quarter"},
        },
    })

    return adj_full_name

end

function unilib.register_stairs_slab_quarter_inverted(full_name, def_table, data_table)

    -- Adapted from stairsplus/slab.lua, stairsplus:slab_XXX_quarter_inverted
    -- Creates an inverted quarter slab node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slab_quarter_inverted"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Inverted quarter slab"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_stairsplus_flag,
        {-0.5, 0.25, -0.5, 0.5, 0.5, 0.5},
        {slab_flag = true}
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 4/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name .. " 6",
        recipe = {
            {
                full_name .. "_stair_slab_inverted",
                full_name .. "_stair_slab_inverted",
                full_name .. "_stair_slab_inverted",
            },
        },
    })

    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_slab_quarter"},
        },
    })

    return adj_full_name

end

function unilib.register_stairs_slab_three_quarter(full_name, def_table, data_table)

    -- Adapted from stairsplus/slab.lua, stairsplus:slab_XXX_three_quarter
    -- Creates a three-quarter slab node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slab_three_quarter"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Three-quarter slab"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_stairsplus_flag,
        {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
        {slab_flag = true}
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 12/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_slab_three_quarter_inverted"},
        },
    })

    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_slab_quarter"},
            {full_name .. "_stair_slab_quarter"},
            {full_name .. "_stair_slab_quarter"},
        },
    })

    return adj_full_name

end

function unilib.register_stairs_slab_three_quarter_inverted(full_name, def_table, data_table)

    -- Adapted from stairsplus/slab.lua, stairsplus:slab_XXX_three_quater_inverted
    -- Creates an inverted three-quarter slab node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slab_three_quarter_inverted"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Inverted three-quarter slab"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_stairsplus_flag,
        {-0.5, -0.25, -0.5, 0.5, 0.5, 0.5},
        {slab_flag = true}
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 12/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_slab_three_quarter"},
        },
    })

    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_slab_quarter_inverted"},
            {full_name .. "_stair_slab_quarter_inverted"},
            {full_name .. "_stair_slab_quarter_inverted"},
        },
    })

    return adj_full_name

end

function unilib.register_stairs_tile(full_name, def_table, data_table)

    -- Adapted from stairsplus/wall.lua, stairsplus:wall_XXX
    -- Creates a tile stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_tile"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Tile"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_stairsplus_flag,
        {
            node_box = node_box_table.tile,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 8/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name .. " 6",
        recipe = {
            {full_name},
            {full_name},
            {full_name},
        },
    })

    unilib.register_craft({
        output = full_name,
        recipe = {
            {full_name .. "_stair_tile", full_name .. "_stair_tile"},
        },
    })

    return adj_full_name

end

function unilib.register_stairs_tile_quarter(full_name, def_table, data_table)

    -- Adapted from stairsplus/wall.lua, stairsplus:wall_XXX_quarter
    -- Creates a quarter tile stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_tile_quarter"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Quarter tile"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_stairsplus_flag,
        {
            node_box = node_box_table.tile_quarter,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 4/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name .. " 6",
        recipe = {
            {full_name .. "_stair_slab", full_name .. "_stair_slab", full_name .. "_stair_slab"},
        },
    })

    unilib.register_craft({
        output = adj_full_name .. " 6",
        recipe = {
            {full_name .. "_stair_tile"},
            {full_name .. "_stair_tile"},
            {full_name .. "_stair_tile"},
        },
    })

    return adj_full_name

end

function unilib.register_stairs_tile_three_quarter(full_name, def_table, data_table)

    -- Adapted from stairsplus/wall.lua, stairsplus:wall_XXX_three_quarter
    -- Creates a three-quarter tile stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_tile_three_quarter"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Three-quarter tile"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_stairsplus_flag,
        {
            node_box = node_box_table.tile_three_quarter,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 12/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {
                full_name .. "_stair_tile_quarter",
                full_name .. "_stair_tile_quarter",
                full_name .. "_stair_tile_quarter",
            },
        },
    })

    return adj_full_name

end

function unilib.register_stairs_panel_bottom(full_name, def_table, data_table)

    -- Adapted from stairsplus/panel.lua, stairsplus:panel_XXX_bottom
    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:panel_XXX
    -- Creates a bottom panel stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_panel_bottom"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Bottom panel"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_stairsplus_flag or unilib.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.panel_bottom,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 4/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name .. " 8",
        recipe = {
            {full_name, full_name},
        },
    })

    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_panel_top"},
        },
    })

    unilib.register_craft({
        output = adj_full_name .. " 2",
        recipe = {
            {full_name .. "_stair_panel_vertical", full_name .. "_stair_panel_vertical"},
        },
    })

    if unilib.add_stairs_moreblocks_flag then

        -- Adapted from moreblocks/recipes.lua

        unilib.register_craft({
            output = adj_full_name .. " 12",
            recipe = {
                {full_name, ""},
                {full_name, full_name},
            },
        })

        unilib.register_craft({
            output = adj_full_name .. " 12",
            recipe = {
                {"", full_name},
                {full_name, full_name},
            },
        })

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name,
            recipe = {full_name .. "_stair_micro_bottom", full_name .. "_stair_micro_bottom"},
        })

        unilib.register_craft({
            type = "shapeless",
            output = full_name,
            recipe = {adj_full_name, adj_full_name, adj_full_name, adj_full_name},
        })

    end

    return adj_full_name

end

function unilib.register_stairs_panel_top(full_name, def_table, data_table)

    -- Adapted from stairsplus/panel.lua, stairsplus:panel_XXX_top
    -- Creates a top panel stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_panel_top"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Top panel"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_stairsplus_flag,
        {
            node_box = node_box_table.panel_top,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 4/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = full_name,
        recipe = {
            {adj_full_name, adj_full_name},
            {adj_full_name, adj_full_name},
        },
    })

    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_micro_bottom"},
        },
    })

    return adj_full_name

end

function unilib.register_stairs_panel_vertical(full_name, def_table, data_table)

    -- Adapted from stairsplus/panel.lua, stairsplus:panel_XXX_vertical
    -- Creates a vertical panel stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_panel_vertical"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Vertical panel"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_stairsplus_flag,
        {
            node_box = node_box_table.panel_vertical,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 4/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name .. " 8",
        recipe = {
            {full_name},
            {full_name},
        },
    })

    unilib.register_craft({
        output = full_name,
        recipe = {
            {adj_full_name, adj_full_name},
            {adj_full_name, adj_full_name},
        },
    })

    unilib.register_craft({
        output = adj_full_name .. " 2",
        recipe = {
            {full_name .. "_stair_panel_bottom"},
            {full_name .. "_stair_panel_bottom"},
        },
    })

    return adj_full_name

end

function unilib.register_stairs_micro_bottom(full_name, def_table, data_table)

    -- Adapted from stairsplus/micro.lua, stairplus:micro_XXX_bottom
    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:micro_XXX
    -- Creates a bottom microblock stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_micro_bottom"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Bottom microblock"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_stairsplus_flag or unilib.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.micro_bottom,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 2/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = full_name,
        recipe = {
            {adj_full_name, adj_full_name},
            {adj_full_name, adj_full_name},
        },
    })

    unilib.register_craft({
        output = adj_full_name .. " 8",
        recipe = {
            {"group:stick"},
            {full_name},
        },
    })

    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_micro_top"},
        },
    })

    unilib.register_craft({
        output = full_name,
        recipe = {
            {adj_full_name, adj_full_name, adj_full_name},
            {adj_full_name, "", adj_full_name},
            {adj_full_name, adj_full_name, adj_full_name},
        },
    })

    if unilib.add_stairs_moreblocks_flag then

        -- Adapted from moreblocks/recipes.lua

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name .. " 7",
            recipe = {full_name .. "_stair_inner"},
        })

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name .. " 6",
            recipe = {full_name .. "_stair_simple"},
        })

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name .. " 5",
            recipe = {full_name .. "_stair_outer"},
        })

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name .. " 4",
            recipe = {full_name .. "_stair_slab"},
        })

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name .. " 4",
            recipe = {full_name .. "_stair_steps"},
        })

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name .. " 3",
            recipe = {full_name .. "_stair_simple_half_right"},
        })

        unilib.register_craft({
            type = "shapeless",
            output = adj_full_name .. " 2",
            recipe = {full_name .. "_stair_panel_bottom"},
        })

        unilib.register_craft({
            type = "shapeless",
            output = full_name,
            recipe = {
                adj_full_name, adj_full_name, adj_full_name, adj_full_name,
                adj_full_name, adj_full_name, adj_full_name, adj_full_name,
            },
        })

    end

    return adj_full_name

end

function unilib.register_stairs_micro_top(full_name, def_table, data_table)

    -- Adapted from stairsplus/micro.lua, stairsplus:micro_XXX_top
    -- Creates a top micro stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_micro_top"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Top microblock"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_stairsplus_flag,
        {
            node_box = node_box_table.micro_top,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 2/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From stairsplus)
    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_micro_bottom"},
        },
    })

    unilib.register_craft({
        output = full_name,
        recipe = {
            {adj_full_name, adj_full_name, adj_full_name},
            {adj_full_name, "", adj_full_name},
            {adj_full_name, adj_full_name, adj_full_name},
        },
    })

    return adj_full_name

end

function unilib.register_stairs_micro_bottom_cut_eighth(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:micro_XXX_1
    -- Creates a cut microblock stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_micro_bottom_cut_eighth"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Bottom microblock 1/8 cut"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.micro_bottom_cut_eighth,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, (2/16) * (1/8))
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.register_stairs_micro_bottom_cut_quarter(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:micro_XXX_2
    -- Creates a cut microblock stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_micro_bottom_cut_quarter"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Bottom microblock 1/4 cut"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.micro_bottom_cut_quarter,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, (2/16) * (1/4))
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.register_stairs_micro_bottom_cut_half(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:micro_XXX_4
    -- Creates a cut microblock stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_micro_bottom_cut_half"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Bottom microblock 1/2 cut"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.micro_bottom_cut_half,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, (2/16) * (1/2))
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.register_stairs_panel_vertical_sliced_eighth(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:micro_XXX_15
    -- Creates a sliced vertical panel stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_panel_vertical_sliced_eighth"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Vertical panel 1/8 sliced"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.panel_vertical_sliced_eighth,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, (4/16) * (7/8))
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.register_stairs_panel_vertical_sliced_quarter(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:micro_XXX_14
    -- Creates a sliced vertical panel stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_panel_vertical_sliced_quarter"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Vertical panel 1/4 sliced"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.panel_vertical_sliced_quarter,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, (4/16) * (3/4))
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.register_stairs_panel_vertical_sliced_half(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:micro_XXX_12
    -- Creates a sliced vertical panel stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_panel_vertical_sliced_half"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Vertical panel 1/2 sliced"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.panel_vertical_sliced_half,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, (4/16) * (1/2))
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.register_stairs_panel_bottom_cut_eighth(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:panel_XXX_1
    -- Creates a cut bottom panel stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_panel_bottom_cut_eighth"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Bottom panel 1/8 cut"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.panel_bottom_cut_eighth,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, (4/16) * (1/8))
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.register_stairs_panel_bottom_cut_quarter(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:panel_XXX_2
    -- Creates a cut bottom panel stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_panel_bottom_cut_quarter"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Bottom panel 1/4 cut"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.panel_bottom_cut_quarter,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, (4/16) * (1/4))
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.register_stairs_panel_bottom_cut_half(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:panel_XXX_4
    -- Creates a cut bottom panel stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_panel_bottom_cut_half"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Bottom panel 1/2 cut"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.panel_bottom_cut_half,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, (4/16) * (1/2))
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.register_stairs_tile_sliced_eighth(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:panel_XXX_15
    -- Creates a sliced tile stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_tile_sliced_eighth"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Tile 1/8 sliced"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.tile_sliced_eighth,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, (4/16) * (7/8))
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.register_stairs_tile_sliced_quarter(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:panel_XXX_14
    -- Creates a sliced tile stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_tile_sliced_quarter"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Tile 1/4 sliced"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.tile_sliced_quarter,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, (4/16) * (3/4))
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.register_stairs_tile_sliced_half(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:panel_XXX_12
    -- Creates a sliced tile stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_tile_sliced_half"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Tile 1/2 sliced"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.tile_sliced_half,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, (4/16) * (1/2))
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.register_stairs_slab_cut_eighth(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slab_XXX_1
    -- Creates a cut slab stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slab_cut_eighth"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Slab 1/8 cut"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.slab_cut_eighth,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 1/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.register_stairs_slab_cut_quarter(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slab_XXX_2
    -- N.B. This function and unilib.register_stairs_slab_quarter() produce a node that looks the
    --      same, but which have different names. For consistency, both are available
    --
    -- Creates a cut slab stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slab_cut_quarter"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Slab 1/4 cut"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.slab_cut_quarter,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 2/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From moreblocks)
    unilib.register_craft({
        type = "shapeless",
        output = full_name,
        recipe = {
            adj_full_name, adj_full_name, adj_full_name, adj_full_name,
            adj_full_name, adj_full_name, adj_full_name, adj_full_name,
        },
    })

    unilib.register_craft({
        type = "shapeless",
        output = full_name,
        recipe = {full_name .. "_stair_slab_sliced_quarter", adj_full_name},
    })

    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {full_name .. "_stair_slab_cut_eighth", full_name .. "_stair_slab_cut_eighth"},
    })

    return adj_full_name

end

function unilib.register_stairs_slab_cut_half(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slab_XXX_quarter
    -- Creates a cut slab stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slab_cut_half"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Slab 1/2 cut"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.slab_cut_half,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 4/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From moreblocks)
    unilib.register_craft({
        type = "shapeless",
        output = full_name,
        recipe = {adj_full_name, adj_full_name, adj_full_name, adj_full_name},
    })

    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {full_name .. "_stair_slab_cut_quarter", full_name .. "_stair_slab_cut_quarter"},
    })

    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {
            full_name .. "_stair_slab_cut_eighth",
            full_name .. "_stair_slab_cut_eighth",
            full_name .. "_stair_slab_cut_eighth",
            full_name .. "_stair_slab_cut_eighth",
        },
    })

    return adj_full_name

end

function unilib.register_stairs_slab_sliced_eighth(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slab_XXX_15
    -- Creates a sliced slab stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slab_sliced_eighth"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Slab 1/8 sliced"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.slab_sliced_eighth,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 15/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From moreblocks)
    unilib.register_craft({
        type = "shapeless",
        output = full_name,
        recipe = {full_name .. "_stair_slab_sliced_eighth", full_name .. "_stair_slab_cut_eighth"},
    })

    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {full_name .. "_stair_slab_sliced_quarter", full_name .. "_stair_slab_cut_eighth"},
    })

    return adj_full_name

end

function unilib.register_stairs_slab_sliced_quarter(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slab_XXX_14
    -- Creates a sliced slab stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slab_sliced_quarter"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Slab 1/4 sliced"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.slab_sliced_quarter,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 14/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From moreblocks)
    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {full_name .. "_stair_slab_sliced_half", full_name .. "_stair_slab_cut_quarter"},
    })

    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {
            full_name .. "_stair_slab_cut_quarter",
            full_name .. "_stair_slab_cut_quarter",
            full_name .. "_stair_slab_cut_quarter",
            full_name .. "_stair_slab_cut_quarter",
            full_name .. "_stair_slab_cut_quarter",
            full_name .. "_stair_slab_cut_quarter",
            full_name .. "_stair_slab_cut_quarter",
        },
    })

    return adj_full_name

end

function unilib.register_stairs_slab_sliced_half(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slab_XXX_three_quarter
    -- Creates a sliced slab stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slab_sliced_half"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Slab 1/2 sliced"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.slab_sliced_half,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 12/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From moreblocks)
    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {full_name .. "_stair_slab", full_name .. "_stair_slab_cut_half"},
    })

    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {
            full_name .. "_stair_slab_cut_half",
            full_name .. "_stair_slab_cut_half",
            full_name .. "_stair_slab_cut_half",
        },
    })

    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {
            full_name .. "_stair_slab_cut_quarter",
            full_name .. "_stair_slab_cut_quarter",
            full_name .. "_stair_slab_cut_quarter",
            full_name .. "_stair_slab_cut_quarter",
            full_name .. "_stair_slab_cut_quarter",
            full_name .. "_stair_slab_cut_quarter",
        },
    })

    unilib.register_craft({
        type = "shapeless",
        output = full_name,
        recipe = {adj_full_name, adj_full_name},
    })

    return adj_full_name

end

function unilib.register_stairs_box_sided_two(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slab_XXX_two_sides
    -- Creates a three-sided box stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_box_sided_two"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Two-sided box"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.box_sided_two,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 2/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.register_stairs_box_sided_three(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slab_XXX_three_sides_u
    -- Creates a three-sided box stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_box_sided_three"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Three-sided box"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.box_sided_three,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 3/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.register_stairs_box_sided_three_corner(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slab_XXX_three_sides
    -- Creates a three-sided box stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_box_sided_three_corner"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Three-sided corner box"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.box_sided_three_corner,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 3/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.register_stairs_slope(full_name, def_table, data_table)

    -- Adapted from stairs_redo/init.lua, stairs:slope_XXX
    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slope_XXX
    -- Creates a slope stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slope"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Slope"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_stairs_redo_flag or unilib.show_stairs_moreblocks_flag,
        {
            mesh = "unilib_slope.obj",
            collision_box = selection_box_table.slope,
            selection_box = selection_box_table.slope,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 8/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From moreblocks)
    unilib.register_craft({
        type = "shapeless",
        output = full_name,
        recipe = {adj_full_name, adj_full_name},
    })

    return adj_full_name

end

function unilib.register_stairs_slope_half(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slope_XXX_half
    -- Creates a slope stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slope_half"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Half slope"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_moreblocks_flag,
        {
            mesh = "unilib_slope_half.obj",
            collision_box = selection_box_table.slope_half,
            selection_box = selection_box_table.slope_half,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 4/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From moreblocks)
    unilib.register_craft({
        type = "shapeless",
        output = full_name,
        recipe = {adj_full_name, full_name .. "_stair_slope_half_raised"},
    })

    unilib.register_craft({
        type = "shapeless",
        output = full_name,
        recipe = {adj_full_name, adj_full_name, adj_full_name, adj_full_name},
    })

    return adj_full_name

end

function unilib.register_stairs_slope_half_raised(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slope_XXX_half_raised
    -- Creates a slope stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slope_half_raised"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Raised half slope"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_moreblocks_flag,
        {
            mesh = "unilib_slope_half_raised.obj",
            collision_box = selection_box_table.slope_half_raised,
            selection_box = selection_box_table.slope_half_raised,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 12/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From moreblocks)
    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {
            full_name .. "_stair_slope_half",
            full_name .. "_stair_slope_half",
            full_name .. "_stair_slope_half",
        },
    })

    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {full_name .. "_stair_slab", full_name .. "_stair_slope_half"},
    })

    return adj_full_name

end

function unilib.register_stairs_slope_inner(full_name, def_table, data_table)

    -- Adapted from stairs_redo/init.lua, stairs:slope_XXX_inner
    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slope_XXX_inner
    -- Creates a slope stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slope_inner"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Inner slope"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_stairs_redo_flag or unilib.show_stairs_moreblocks_flag,
        {
            mesh = "unilib_slope_inner.obj",
            collision_box = selection_box_table.slope_inner,
            selection_box = selection_box_table.slope_inner,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 14/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.register_stairs_slope_inner_half(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slope_XXX_inner_half
    -- Creates a slope stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slope_inner_half"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Inner half slope"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_moreblocks_flag,
        {
            mesh = "unilib_slope_inner_half.obj",
            collision_box = selection_box_table.slope_inner_half,
            selection_box = selection_box_table.slope_inner_half,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 6/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From moreblocks)
    unilib.register_craft({
        type = "shapeless",
        output = full_name,
        recipe = {full_name .. "_stair_slope_outer_half_raised", adj_full_name},
    })

    return adj_full_name

end

function unilib.register_stairs_slope_inner_half_raised(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slope_XXX_inner_half_raised
    -- Creates a slope stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slope_inner_half_raised"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Raised inner half slope"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_moreblocks_flag,
        {
            mesh = "unilib_slope_inner_half_raised.obj",
            collision_box = selection_box_table.slope_inner_half_raised,
            selection_box = selection_box_table.slope_inner_half_raised,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 14/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From moreblocks)
    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {full_name .. "_stair_slab", full_name .. "_stair_slope_inner_half"},
    })

    return adj_full_name

end

function unilib.register_stairs_slope_inner_cut(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slope_XXX_inner_cut
    -- Creates a slope stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slope_inner_cut"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Cut inner slope"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_moreblocks_flag,
        {
            mesh = "unilib_slope_inner_cut.obj",
            collision_box = selection_box_table.slope_inner,
            selection_box = selection_box_table.slope_inner,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 14/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.register_stairs_slope_inner_cut_half(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slope_XXX_inner_cut_half
    -- Creates a slope stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slope_inner_cut_half"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Cut inner half slope"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_moreblocks_flag,
        {
            mesh = "unilib_slope_inner_cut_half.obj",
            collision_box = selection_box_table.slope_inner_half,
            selection_box = selection_box_table.slope_inner_half,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 8/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.register_stairs_slope_inner_cut_half_raised(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slope_XXX_inner_cut_half_raised
    -- Creates a slope stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slope_inner_cut_half_raised"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Raised cut inner half slope"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_moreblocks_flag,
        {
            mesh = "unilib_slope_inner_cut_half_raised.obj",
            collision_box = selection_box_table.slope_inner_half_raised,
            selection_box = selection_box_table.slope_inner_half_raised,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 16/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From moreblocks)
    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {full_name .. "_stair_slab", full_name .. "_stair_slope_inner_cut_half"},
    })

    return adj_full_name

end

function unilib.register_stairs_slope_outer(full_name, def_table, data_table)

    -- Adapted from stairs_redo/init.lua, stairs:slope_XXX_outer
    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slope_XXX_outer
    -- Creates a slope stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slope_outer"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Outer slope"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_stairs_redo_flag or unilib.show_stairs_moreblocks_flag,
        {
            mesh = "unilib_slope_outer.obj",
            collision_box = selection_box_table.slope_outer,
            selection_box = selection_box_table.slope_outer,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 6/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From moreblocks)
    unilib.register_craft({
        type = "shapeless",
        output = full_name,
        recipe = {adj_full_name, full_name .. "_stair_slope_inner"},
    })

    return adj_full_name

end

function unilib.register_stairs_slope_outer_half(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slope_XXX_outer_half
    -- Creates a slope stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slope_outer_half"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Outer half slope"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_moreblocks_flag,
        {
            mesh = "unilib_slope_outer_half.obj",
            collision_box = selection_box_table.slope_outer_half,
            selection_box = selection_box_table.slope_outer_half,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 4/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From moreblocks)
    unilib.register_craft({
        type = "shapeless",
        output = full_name,
        recipe = {adj_full_name, full_name .. "_stair_slope_inner_half_raised"},
    })

    return adj_full_name

end

function unilib.register_stairs_slope_outer_half_raised(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slope_XXX_outer_half_raised
    -- Creates a slope stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slope_outer_half_raised"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Raised outer half slope"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_moreblocks_flag,
        {
            mesh = "unilib_slope_outer_half_raised.obj",
            collision_box = selection_box_table.slope_outer_half_raised,
            selection_box = selection_box_table.slope_outer_half_raised,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 12/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From moreblocks)
    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {full_name .. "_stair_slab", full_name .. "_stair_slope_outer_half"},
    })

    return adj_full_name

end

function unilib.register_stairs_slope_outer_cut(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slope_XXX_outer_cut
    -- Creates a slope stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slope_outer_cut"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Cut outer slope"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_moreblocks_flag,
        {
            mesh = "unilib_slope_outer_cut.obj",
            collision_box = selection_box_table.slope_outer,
            selection_box = selection_box_table.slope_outer,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 4/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From moreblocks)
    unilib.register_craft({
        type = "shapeless",
        output = full_name,
        recipe = {adj_full_name, full_name .. "_stair_slope_inner_cut"},
    })

    return adj_full_name

end

function unilib.register_stairs_slope_outer_cut_half(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slope_XXX_outer_cut_half
    -- Creates a slope stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slope_outer_cut_half"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Cut outer half slope"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_moreblocks_flag,
        {
            mesh = "unilib_slope_outer_cut_half.obj",
            collision_box = selection_box_table.slope_outer_half,
            selection_box = selection_box_table.slope_outer_half,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 2/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From moreblocks)
    unilib.register_craft({
        type = "shapeless",
        output = full_name,
        recipe = {adj_full_name, full_name .. "_stair_slope_inner_cut_half_raised"},
    })

    return adj_full_name

end

function unilib.register_stairs_slope_outer_cut_half_raised(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slope_XXX_outer_cut_half_raised
    -- Creates a slope stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slope_outer_cut_half_raised"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Raised cut outer half slope"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_moreblocks_flag,
        {
            mesh = "unilib_slope_outer_cut_half_raised.obj",
            collision_box = selection_box_table.slope_outer_half_raised,
            selection_box = selection_box_table.slope_outer_half_raised,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 6/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.register_stairs_slope_cut(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slope_XXX_cut
    -- Creates a slope stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slope_cut"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Cut slope"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_moreblocks_flag,
        {
            mesh = "unilib_slope_cut.obj",
            collision_box = selection_box_table.slope_outer,
            selection_box = selection_box_table.slope_outer,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 8/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From moreblocks)
    unilib.register_craft({
        type = "shapeless",
        output = full_name,
        recipe = {adj_full_name, adj_full_name},
    })

    return adj_full_name

end

function unilib.register_stairs_steps(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slope_XXX_alt
    -- Creates a steps stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_steps"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Steps"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.steps,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 8/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From moreblocks)
    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_panel_bottom", ""},
            {"", full_name .. "_stair_panel_bottom"},
        },
    })

    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_panel_bottom", ""},
            {"", full_name .. "_stair_panel_bottom"},
        },
    })

    return adj_full_name

end

function unilib.register_stairs_steps_sliced_eighth(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slope_XXX_alt_1
    -- Creates a sliced steps stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_steps_sliced_eighth"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Steps 1/8 sliced"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.steps_sliced_eighth,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 2/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.register_stairs_steps_sliced_quarter(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slope_XXX_alt_2
    -- Creates a sliced steps stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_steps_sliced_quarter"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Steps 1/4 sliced"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.steps_sliced_quarter,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 2/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.register_stairs_steps_sliced_half(full_name, def_table, data_table)

    -- Adapted from moreblocks/stairsplus/defs.lua, stairplus:slope_XXX_alt_4
    -- Creates a sliced steps stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_steps_sliced_half"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Steps 1/2 sliced"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_moreblocks_flag,
        {
            node_box = node_box_table.steps_sliced_half,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 4/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    return adj_full_name

end

function unilib.register_stairs_corner_roof(full_name, def_table, data_table)

    -- Adapted from plantlife/trunks/nodes.lua, e.g. woodstuff:twigs_roof_corner
    -- Creates a roof corner stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_corner_roof"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Roof corner"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_plantlife_flag,
        {
            node_box = node_box_table.corner_roof,
        },
        {no_advanced_rotation_flag = true}
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 4/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From plantlife)
    unilib.register_craft({
        output = adj_full_name .. " 8",
        recipe = {
            {"", full_name, ""},
            {full_name, "", full_name},
        },
    })

    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_corner_roof_inverted"},
        },
    })

    return adj_full_name

end

function unilib.register_stairs_corner_roof_inverted(full_name, def_table, data_table)

    -- Adapted from plantlife/trunks/nodes.lua, e.g. woodstuff:twigs_roof_corner_2
    -- Creates an inverted roof corner stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_corner_roof_inverted"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Inverted roof corner"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_plantlife_flag,
        {
            node_box = node_box_table.corner_roof_inverted,
        },
        {no_advanced_rotation_flag = true}
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 4/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From plantlife)
    unilib.register_craft({
        output = adj_full_name .. " 8",
        recipe = {
            {full_name, "", full_name},
            {"", full_name, ""},
        },
    })

    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_stair_corner_roof"},
        },
    })

    return adj_full_name

end

function unilib.register_stairs_hole_murder(full_name, def_table, data_table)

    -- Adapted from castle/castle_masonry/murder_holes.lua, castle_masonry:hole_XXX
    -- Creates a murder hole stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_hole_murder"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Murder hole"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_castle_flag,
        {
            node_box = node_box_table.hole_murder,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 8/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From castle/castle_masonry)
    unilib.register_craft({
        output = adj_full_name .. " 4",
        recipe = {
            {"", full_name, ""},
            {full_name, "", full_name},
            {"", full_name, ""},
        },
    })

    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {full_name .. "_hole_machicolation"},
    })

    return adj_full_name

end

function unilib.register_stairs_hole_machicolation(full_name, def_table, data_table)

    -- Adapted from castle/castle_masonry/murder_holes.lua, castle_masonry:machicolation_XXX
    -- Creates a machicolation stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_hole_machicolation"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Machicolation"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_castle_flag,
        {
            node_box = node_box_table.hole_machicolation,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 8/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From castle/castle_masonry)
    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {full_name .. "_hole_murder"},
    })

    return adj_full_name

end

function unilib.register_stairs_pillar_bottom(full_name, def_table, data_table)

    -- Adapted from castle/castle_masonry/pillars.lua, castle_masonry:pillar_XXX_bottom
    -- Creates a pillar base stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_pillar_bottom"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Pillar base"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_castle_flag,
        {
            node_box = node_box_table.pillar_bottom,
        },
        {crossbrace_flag = true}
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 10/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From castle/castle_masonry)
    unilib.register_craft({
        output = adj_full_name .. " 4",
        recipe = {
            {"", full_name, ""},
            {"", full_name, ""},
            {full_name, full_name, full_name},
        },
    })

    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {full_name .. "_pillar_bottom_half", full_name .. "_pillar_bottom_half"},
    })

    return adj_full_name

end

function unilib.register_stairs_pillar_bottom_half(full_name, def_table, data_table)

    -- Adapted from castle/castle_masonry/pillars.lua, castle_masonry:pillar_XXX_bottom_half
    -- Creates a half pillar base stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_pillar_bottom_half"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Half pillar base"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_castle_flag,
        {
            node_box = node_box_table.pillar_bottom_half,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 5/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From castle/castle_masonry)
    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name .. " 2",
        recipe = {full_name .. "_pillar_bottom"},
    })

    return adj_full_name

end

function unilib.register_stairs_pillar_top(full_name, def_table, data_table)

    -- Adapted from castle/castle_masonry/pillars.lua, castle_masonry:pillar_XXX_top
    -- Creates a pillar top stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_pillar_top"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Pillar top"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_castle_flag,
        {
            node_box = node_box_table.pillar_top,
        },
        {crossbrace_flag = true}
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 10/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From castle/castle_masonry)
    unilib.register_craft({
        output = adj_full_name .. " 4",
        recipe = {
            {full_name, full_name, full_name},
            {"", full_name, ""},
            {"", full_name, ""},
        },
    })

    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {full_name .. "_pillar_top_half", full_name .. "_pillar_top_half"},
    })

    return adj_full_name

end

function unilib.register_stairs_pillar_top_half(full_name, def_table, data_table)

    -- Adapted from castle/castle_masonry/pillars.lua, castle_masonry:pillar_XXX_top_half
    -- Creates a half pillar top stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_pillar_top_half"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Half pillar top"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_castle_flag,
        {
            node_box = node_box_table.pillar_top_half,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 5/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From castle/castle_masonry)
    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name .. " 2",
        recipe = {full_name .. "_pillar_top"},
    })

    return adj_full_name

end

function unilib.register_stairs_pillar_middle(full_name, def_table, data_table)

    -- Adapted from castle/castle_masonry/pillars.lua, castle_masonry:pillar_XXX_middle
    -- Creates a pillar middle stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_pillar_middle"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Pillar middle"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_castle_flag,
        {
            node_box = node_box_table.pillar_middle,
        },
        {crossbrace_flag = true}
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 12/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From castle/castle_masonry)
    unilib.register_craft({
        output = adj_full_name .. " 4",
        recipe = {
            {full_name, full_name},
            {full_name, full_name},
            {full_name, full_name},
        },
    })

    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {full_name .. "_pillar_middle_half", full_name .. "_pillar_middle_half"},
    })

    return adj_full_name

end

function unilib.register_stairs_pillar_middle_half(full_name, def_table, data_table)

    -- Adapted from castle/castle_masonry/pillars.lua, castle_masonry:pillar_XXX_middle_half
    -- Creates a half pillar middle stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_pillar_middle_half"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Half pillar middle"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_castle_flag,
        {
            node_box = node_box_table.pillar_middle_half,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 6/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From castle/castle_masonry)
    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name .. " 2",
        recipe = {full_name .. "_pillar_middle"},
    })

    return adj_full_name

end

function unilib.register_stairs_pillar_crossbrace(full_name, def_table, data_table)

    -- Adapted from castle/castle_masonry/pillars.lua, castle_masonry:pillar_XXX_crossbrace
    -- Creates a pillar crossbrace stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_pillar_crossbrace"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Pillar crossbrace"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_castle_flag,
        {
            node_box = node_box_table.pillar_crossbrace,
        }
    )
    -- (Unusual step to make the crossbrace_connectable group work as intended)
    unilib.override_item(adj_full_name, {
        connects_to = {
            full_name .. "_pillar_crossbrace",
            full_name .. "_pillar_crossbrace_ext",
            "group:crossbrace_connectable",
        },
        connect_sides = {"front", "left", "back", "right"},
    })

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 10/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From castle/castle_masonry)
    unilib.register_craft({
        output = adj_full_name .. " 10",
        recipe = {
            {full_name, "", full_name},
            {"", full_name, ""},
            {full_name, "", full_name},
        },
    })

    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {full_name .. "_pillar_crossbrace_ext"},
    })

    return adj_full_name

end

function unilib.register_stairs_pillar_crossbrace_ext(full_name, def_table, data_table)

    -- Adapted from castle/castle_masonry/pillars.lua, castle_masonry:pillar_XXX_extended_crossbrace
    -- Creates a pillar extended crossbrace stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_pillar_crossbrace_ext"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Pillar extended crossbrace"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_castle_flag,
        {
            node_box = node_box_table.pillar_crossbrace_ext,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 10/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From castle/castle_masonry)
    unilib.register_craft({
        type = "shapeless",
        output = adj_full_name,
        recipe = {full_name .. "_pillar_crossbrace"},
    })

    return adj_full_name

end

function unilib.register_stairs_slit(full_name, def_table, data_table)

    -- Adapted from castle/castle_masonry/arrow_slits.lua, castle_masonry:arrowslit_XXX
    -- Creates an arrow slit stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slit"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Arrow slit"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_castle_flag,
        {
            node_box = node_box_table.slit,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 6/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From castle/castle_masonry)
    unilib.register_craft({
        output = adj_full_name .. " 6",
        recipe = {
            {full_name, "", full_name},
            {full_name, "", full_name},
            {full_name, "", full_name},
        },
    })

    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_slit_embrasure"},
        },
    })

    return adj_full_name

end

function unilib.register_stairs_slit_cross(full_name, def_table, data_table)

    -- Adapted from castle/castle_masonry/arrow_slits.lua, castle_masonry:arrowslit_XXX_cross
    -- Creates an arrow slit with cross stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slit_cross"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Arrow slit with cross"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_castle_flag,
        {
            node_box = node_box_table.slit_cross,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 6/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From castle/castle_masonry)
    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_slit"},
        },
    })

    return adj_full_name

end

function unilib.register_stairs_slit_hole(full_name, def_table, data_table)

    -- Adapted from castle/castle_masonry/arrow_slits.lua, castle_masonry:arrowslit_XXX_hole
    -- Creates an arrow slit with hole stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slit_hole"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Arrow slit with hole"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_castle_flag,
        {
            node_box = node_box_table.slit_hole,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 6/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From castle/castle_masonry)
    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_slit_cross"},
        },
    })

    return adj_full_name

end

function unilib.register_stairs_slit_embrasure(full_name, def_table, data_table)

    -- Adapted from castle/castle_masonry/arrow_slits.lua, castle_masonry:arrowslit_XXX_embrasure
    -- Creates an arrow slit with embrasure stair node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_slit_embrasure"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Arrow slit with embrasure"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_castle_flag,
        {
            node_box = node_box_table.slit_embrasure,
        }
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 6/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From castle/castle_masonry)
    unilib.register_craft({
        output = adj_full_name,
        recipe = {
            {full_name .. "_slit_hole"},
        },
    })

    return adj_full_name

end

function unilib.register_stairs_arch_simple(full_name, def_table, data_table)

    -- Adapted from pkarcs/pkarcs/init.lua, pkarcs:XXX_arc
    -- Creates a simple arch node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_arch_simple"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Simple arch"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_pkarcs_flag,
        {
            node_box = node_box_table.arch_simple,
        },
        {arch_flag = true}
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 5/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From castle/castle_masonry)
    unilib.register_craft({
        output = adj_full_name .. " 5",
        recipe = {
            {full_name, full_name, full_name},
            {full_name, "", ""},
            {full_name, "", ""},
        },
    })

    return adj_full_name

end

function unilib.register_stairs_arch_outer(full_name, def_table, data_table)

    -- Adapted from pkarcs/pkarcs/init.lua, pkarcs:XXX_outer_arc
    -- Creates an outer arch node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_arch_outer"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Outer arch"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_pkarcs_flag,
        {
            node_box = node_box_table.arch_outer,
        },
        {arch_flag = true}
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 7/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From castle/castle_masonry)
    -- N.B. Tweaked original recipe so it doesn't require a torch
    --[[
    unilib.register_craft({
        output = adj_full_name .. " 5",
        recipe = {
            {"group:torch", full_name, full_name},
            {full_name, "", ""},
            {full_name, "", ""},
        },
    })
    ]]--
    unilib.register_craft({
        output = adj_full_name .. " 4",
        recipe = {
            {"", full_name, full_name},
            {full_name, "", ""},
            {full_name, "", ""},
        },
    })

    return adj_full_name

end

function unilib.register_stairs_arch_inner(full_name, def_table, data_table)

    -- Adapted from pkarcs/pkarcs/init.lua, pkarcs:XXX_inner_arc
    -- Creates an inner arch node
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --      def_table (table): The specified node's definition table, to be modified by this
    --          function
    --
    -- Optional args:
    --      data_table (table): The table described in unilib.register_stairs()
    --
    -- Return values:
    --      The full_name of the new stair node

    local adj_part_name = "_stair_arch_inner"
    local adj_full_name = full_name .. adj_part_name
    local adj_desc = unilib.brackets(def_table.description, S("Inner arch"))

    -- Register the node
    prepare_stair(
        full_name, def_table, data_table, adj_part_name, adj_full_name, adj_desc,
        unilib.show_stairs_pkarcs_flag,
        {
            node_box = node_box_table.arch_inner,
        },
        {arch_flag = true}
    )

    -- Register crafts
    create_fuel_recipe(full_name, adj_full_name, 3/16)
    create_cook_recipe(full_name, data_table.cooked_name, adj_part_name)

    -- (From castle/castle_masonry)
    -- N.B. Tweaked original recipe so it doesn't require a torch
    --[[
    unilib.register_craft({
        output = adj_full_name .. " 5",
        recipe = {
            {"", full_name, full_name},
            {full_name, "group:torch", ""},
            {full_name, "", ""},
        },
    })
    ]]--
    unilib.register_craft({
        output = adj_full_name .. " 5",
        recipe = {
            {"", full_name, full_name},
            {full_name, full_name, ""},
            {full_name, "", ""},
        },
    })

    return adj_full_name

end

---------------------------------------------------------------------------------------------------
-- Shared functions (convert names)
---------------------------------------------------------------------------------------------------

function unilib.convert_stairs_simple(full_name)

    -- Original to unilib
    -- Converts a node name (e.g. "unilib:stone_ordinary") into the name of the corresponding simple
    --      stair node (e.g. "unilib:stone_ordinary_stair_simple")
    -- If the minetest setting is not enabled, returns the unmodified node name
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --
    -- Return values:
    --      The (un)modified node name

    if unilib.add_stairs_any_flag then
        return full_name .. "_stair_simple"
    else
        return full_name
    end

end

function unilib.convert_stairs_inner(full_name)

    -- Original to unilib
    -- Converts a node name (e.g. "unilib:stone_ordinary") into the name of the corresponding inner
    --      stair node (e.g. "unilib:stone_ordinary_stair_inner")
    -- If the minetest setting is not enabled, returns the unmodified node name
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --
    -- Return values:
    --      The (un)modified node name

    if unilib.add_stairs_any_flag then
        return full_name .. "_stair_inner"
    else
        return full_name
    end

end

function unilib.convert_stairs_outer(full_name)

    -- Original to unilib
    -- Converts a node name (e.g. "unilib:stone_ordinary") into the name of the corresponding outer
    --      stair node (e.g. "unilib:stone_ordinary_stair_outer")
    -- If the minetest setting is not enabled, returns the unmodified node name
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --
    -- Return values:
    --      The (un)modified node name

    if unilib.add_stairs_any_flag then
        return full_name .. "_stair_outer"
    else
        return full_name
    end

end

function unilib.convert_stairs_slab(full_name)

    -- Original to unilib
    -- Converts a node name (e.g. "unilib:stone_ordinary") into the name of the corresponding slab
    --      stair node (e.g. "unilib:stone_ordinary_stair_slab")
    -- If the minetest setting is not enabled, returns the unmodified node name
    --
    -- Args:
    --      full_name (str): e.g. "unilib:stone_ordinary"
    --
    -- Return values:
    --      The (un)modified node name

    if unilib.add_stairs_any_flag then
        return full_name .. "_stair_slab"
    else
        return full_name
    end

end
