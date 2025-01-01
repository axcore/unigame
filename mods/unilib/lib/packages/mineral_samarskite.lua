---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    AATO
-- Code:    GPL 3.0
-- Media:   GPL 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mineral_samarskite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aato.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mineral_samarskite.init()

    return {
        description = "Samarskite (as mineral)",
        optional = {"metal_ytterbium", "metal_yttrium"},
    }

end

function unilib.pkg.mineral_samarskite.exec()

    -- N.B. AATO notes specify that samarskite should produce either yttrium or ytterbium
    -- In unilib, this is implemented as two different samarskite lumps.
    --      "unilib:mineral_samarskite_rock" drops the (normal) yttrium-producing lump about four
    --      times as often as the ytterbium-producing lump

    local c_lump = "unilib:mineral_samarskite_lump"
    local c_rare_lump = "unilib:mineral_samarskite_rare_lump"

    unilib.register_mineral({
        -- Original to unilib
        part_name = "samarskite",
        description = S("Samarskite"),

        hardness = 3,
        metal_list = {"yttrium"},
    })

    unilib.register_craftitem(c_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, samarskite_y.png). Original code
        description = S("Samarskite Lump"),
        inventory_image = "unilib_mineral_samarskite_lump.png",
    })
    if unilib.global.pkg_executed_table["metal_yttrium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_yttrium_chunk",
            recipe = c_lump,
        })

    end

    unilib.register_craftitem(c_rare_lump, nil, mode, {
        -- Original texture (adapted from an AATO texture, samarskite_y.png). Original code
        description = S("Rare Samarskite Lump"),
        inventory_image = "unilib_mineral_samarskite_rare_lump.png",
    })
    if unilib.global.pkg_executed_table["metal_ytterbium"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:metal_ytterbium_chunk",
            recipe = c_rare_lump,
        })

    end

end
