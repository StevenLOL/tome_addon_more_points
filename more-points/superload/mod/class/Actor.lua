print("=== DEBUG: SUPERLOAD LOADED ===")

local _M = loadPrevious(...)

print("=== DEBUG: loadPrevious OK ===")


local base_levelup = _M.levelup

function _M:levelup()
print("=== DEBUG: levelup OK ===")
    local ret = base_levelup(self)
    
    if self == game.player then
        self.unused_stats = (self.unused_stats or 0) + 10
        self.unused_talents = (self.unused_talents or 0) + 10
        self.unused_generics = (self.unused_generics or 0) + 10
		self.unused_talents_types = (self.unused_talents_types or 0) + 10
        self.unused_prodigies=(self.unused_prodigies or 0) +1
        game.logPlayer(self, "#00FF00#Bonus: +100 stats, +100 class, +100 generic!")
    end
    
    return ret
end

local base_onTakeHit = _M.onTakeHit

function _M:onTakeHit(value, src)
	local ret = base_onTakeHit(self,value, src)
    if self == game.player then
		self.max_life = self.max_life + 1
		self.combat_dam= self.combat_dam +1
		
	end
	return ret
end




	

return _M