--PP 20
--Power --
--Accuracy --
--Type NORMAL
--Category Status
--GEN 1: If Whirlwind is used in a wild Pokémon battle by a Pokémon on either side, the battle will automatically end. 
--In a Trainer battle, Whirlwind has no effect. Whirlwind has 85% accuracy and normal priority.
--GEN 5: Whirlwind no longer works if the target is a wild Pokémon with a higher level than the user's.
--When in a Trainer battle, Whirlwind will now force the target to switch with a randomly chosen Pokémon from its Trainer's party. 
--If there is no Pokémon for the target to switch with, Whirlwind will fail.
--For now, we will ignore trainer battles.
function Whirlwind( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local pokemon = target.pokemon

	if pokemon ~= nil then
		if pokemon:IsWild() then
			target:AddNoDraw()
			target:ForceKill( false )
		elseif caster.pokemon:IsWild() then
			caster:AddNoDraw()
			caster:ForceKill( false )
			PokeHelper:Withdraw( target.trainer )
		end
	end
end