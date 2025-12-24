---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mtb_restore_head = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

-- Localise math functions (for speed)
local rad = math.rad

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_restore_head.do_action(self)

    -- Was petz.return_head_to_origin()
    -- After an earlier call to the "mtb_move_head" behaviour, rotates the mob's head back to its
    --      original (forward) position

    if not unimobs.mobkit_api.is_behaviour_safe(self) then
        return
    end

    self.object:set_bone_override("head", {
        position = {vec = self.head_prop_table.position, absolute = true},
        rotation = {vec = self.head_prop_table.rotation_origin:apply(rad), absolute = true}
    })

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mtb_restore_head.init()

    return {
        description = "Standard mob meta-behaviour: restore the mob's head to its original" ..
                " (forward) position",
    }

end
