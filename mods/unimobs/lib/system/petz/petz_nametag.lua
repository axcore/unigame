---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- petz_nametag.lua
--      Shared API functions from the petz/petz mod
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/petz/api/api_nametag.lua)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.update_mob_nametag(self)

    -- From petz.update_nametag()
    -- Updates the nametag that's visible in the world for the specified mob
    -- If the mob's .nametag property is set (and if nametags are enabled globally), makes it
    --      visible in the game; otherwise sets an empty nametag (that is not visible)

    if self.show_nametag_flag and self.nametag and self.nametag ~= "" then

        local nametag = self.nametag

        local colour_spec
        if not unimobs.petz_setting.enable_nametag_backgrounds_flag then

            colour_spec = "#FFFFFF00"

        else

            -- Set background colour automatically, based on user settings
            colour_spec = false

        end

        local for_sale = ""
        if self.for_sale_flag then
            for_sale = "$ "
        end

        local generations = ""
        if self.generation_count > 0 then
            generations = " ♦ " .. tostring(self.generation_count + 1)
        end

        self.object:set_nametag_attributes({
            text = for_sale .. nametag .. generations .. " ♥ " .. tostring(self.hp) .. "/"
                    .. tostring(self.max_hp),
            bgcolor = colour_spec,
        })

    else

        self.object:set_nametag_attributes({
            text = "",
        })

    end

end

function unimobs.petz_api.remove_mob_nametag(self)

    -- From petz.delete_nametag()
    -- Without changing any of the mob's properties, removes the entity's nametag

    self.object:set_nametag_attributes({text = nil})

end
