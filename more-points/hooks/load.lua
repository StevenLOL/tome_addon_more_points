require "engine.class"

class:bindHook("Actor:takeHit", function(self, data)
    if self ~= game.player then return end
    
    local attacker = data.src
    if not attacker or not attacker.x or not attacker.y then return end
    if self:reactionToward(attacker) >= 0 then return end
    
    -- 检查是否在近战范围
    local dist = core.fov.distance(self.x, self.y, attacker.x, attacker.y)
    if dist > 1 then return end
    
    -- ★ 防止自己无限反击自己
    if self._counter_attacking then return end
    
    -- ★ 防止被反伤/反击伤害触发
    if data.no_counter then return end
    
    -- 执行反击
    self._counter_attacking = true
    
    self:attackTarget(attacker, {
        no_talents = true,
        no_counter = true,
    })
    
    self._counter_attacking = false
    
    game.logPlayer(self, "#LIGHT_RED#Counter-attack!")
end)