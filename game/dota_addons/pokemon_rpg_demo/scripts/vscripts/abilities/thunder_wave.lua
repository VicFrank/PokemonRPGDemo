--PP 20
--Power --
--Accuracy 100
--Type ELECTRIC
--Category Status
--Paralyzes the target
function ThunderWave( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local pokemon = target.pokemon
	
	local targetPosition = target:GetAbsOrigin()
	
	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_lightning_bolt.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, Vector(targetPosition.x,targetPosition.y,2000))
	ParticleManager:SetParticleControl(particle, 1, targetPosition) -- point landing
	ParticleManager:SetParticleControl(particle, 2, targetPosition) -- point origin

	if pokemon ~= nil then
		if pokemon:GetType1() ~= "GROUND" and pokemon:GetType2() ~= "GROUND" then
			PokeHelper:InflictStatus( target, "PARALYZED" )
		end
	end	
end