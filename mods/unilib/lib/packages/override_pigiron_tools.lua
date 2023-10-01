---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pigiron
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.override_pigiron_tools = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pigiron.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.override_pigiron_tools.init()

    return {
        description = "Switches bronze and steel tool capabilities (for realism)",
        notes = "This package does not require any iron-related packages",
        at_least_one = {
            "tool_axe_bronze",
            "tool_axe_steel",
            "tool_pick_bronze",
            "tool_pick_steel",
            "tool_shovel_bronze",
            "tool_shovel_steel",
            "tool_sword_bronze",
            "tool_sword_steel",
        },
    }

end

function unilib.pkg.override_pigiron_tools.exec()

    if unilib.pkg_executed_table["tool_axe_bronze"] ~= nil and
            unilib.pkg_executed_table["tool_axe_steel"] ~= nil then

        unilib.override_item("unilib:tool_axe_bronze", {
            tool_capabilities = {
                damage_groups = {fleshy = 4},
                full_punch_interval = 1.0,
                groupcaps = {
                    choppy = {
                        times = {[1] = 2.50, [2] = 1.40, [3] = 1.00},
                        uses = 20, maxlevel = 2
                    },
                },
                max_drop_level = 1,
            },
        })

        unilib.override_item("unilib:tool_axe_steel", {
            tool_capabilities = {
                damage_groups = {fleshy = 4},
                full_punch_interval = 1.0,
                groupcaps = {
                    choppy = {
                        times = {[1] = 2.75, [2] = 1.70, [3] = 1.15},
                        uses = 20, maxlevel = 2
                    },
                },
                max_drop_level = 1,
            },
        })

    end

    if unilib.pkg_executed_table["tool_pick_bronze"] ~= nil and
            unilib.pkg_executed_table["tool_pick_steel"] ~= nil then

        unilib.override_item("unilib:tool_pick_bronze", {
            tool_capabilities = {
                damage_groups = {fleshy = 4},
                full_punch_interval = 1.0,
                groupcaps = {
                    cracky = {
                        times = {[1] = 4.00, [2] = 1.60, [3] = 0.80},
                        uses = 20, maxlevel = 2
                    },
                },
                max_drop_level = 1,
            },
        })

        unilib.override_item("unilib:tool_pick_steel", {
            tool_capabilities = {
                damage_groups = {fleshy = 4},
                full_punch_interval = 1.0,
                groupcaps = {
                    cracky = {
                        times = {[1] = 4.50, [2] = 1.80, [3] = 0.90},
                        uses = 20, maxlevel = 2
                    },
                },
                max_drop_level = 1,
            },
        })

    end

    if unilib.pkg_executed_table["tool_shovel_bronze"] ~= nil and
            unilib.pkg_executed_table["tool_shovel_steel"] ~= nil then

        unilib.override_item("unilib:tool_shovel_bronze", {
            tool_capabilities = {
                damage_groups = {fleshy = 3},
                full_punch_interval = 1.1,
                groupcaps = {
                    crumbly = {
                        times = {[1] = 1.50, [2] = 0.90, [3] = 0.40},
                        uses = 30, maxlevel = 2
                    },
                },
                max_drop_level = 1,
            },
        })

        unilib.override_item("unilib:tool_shovel_steel", {
            tool_capabilities = {
                damage_groups = {fleshy = 3},
                full_punch_interval = 1.1,
                groupcaps = {
                    crumbly = {
                        times = {[1] = 1.65, [2] = 1.05, [3] = 0.45},
                        uses = 25, maxlevel = 2
                    },
                },
                max_drop_level = 1,
            },
        })

    end

    if unilib.pkg_executed_table["tool_sword_bronze"] ~= nil and
            unilib.pkg_executed_table["tool_sword_steel"] ~= nil then

        unilib.override_item("unilib:tool_sword_bronze", {
            tool_capabilities = {
                damage_groups = {fleshy = 6},
                full_punch_interval = 0.8,
                groupcaps = {
                    snappy = {
                        times = {[1] = 2.5, [2] = 1.20, [3] = 0.35},
                        uses = 30, maxlevel = 2
                    },
                },
                max_drop_level = 1,
            },
        })

        unilib.override_item("unilib:tool_sword_steel", {
            tool_capabilities = {
                damage_groups = {fleshy = 6},
                full_punch_interval = 0.8,
                groupcaps = {
                    snappy = {
                        times = {[1] = 2.75, [2] = 1.30, [3] = 0.375},
                        uses = 25, maxlevel = 2
                    },
                },
                max_drop_level = 1,
            },
        })

    end

end
