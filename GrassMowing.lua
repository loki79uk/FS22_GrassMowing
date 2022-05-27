-- ============================================================= --
-- GRASS MOWING MOD
-- ============================================================= --
GrassMowing = {};

addModEventListener(GrassMowing);

function GrassMowing:loadMap(name)
	--print("Load Mod: 'Grass Mowing'")
	self.initialised = false
end

function GrassMowing:deleteMap()
end

function GrassMowing:mouseEvent(posX, posY, isDown, isUp, button)
end

function GrassMowing:keyEvent(unicode, sym, modifier, isDown)
end

function GrassMowing:draw()
end

function GrassMowing:update(dt)
	if not self.initialised then
		for name, fruitType in pairs(g_fruitTypeManager.nameToFruitType) do
			if name == "GRASS" or name == "MEADOW" then
				-- Set minimum growth state 2
				fruitType.minHarvestingGrowthState = 2
				fruitType.minForageGrowthState = 2
			end
		end
		
		for name, effectType in pairs(g_motionPathEffectManager.effectsByType) do
			if name == "MOWER" or name == "CUTTER" then
				-- Add a motionPathEffect for growth state 2
				for i=1, #effectType do
					if effectType[i].growthStates ~= nil then
						if #effectType[i].growthStates == 1 then
							if effectType[i].growthStates[1] == 3 then
								table.insert(effectType[i].growthStates, 2)
							end
						end
					end
				end
				
			end
		end
		
		if g_currentMission.foliageSystem ~= nil then
			local decoFoliages = g_currentMission.foliageSystem:getDecoFoliages()

			for _, decoFoliage in pairs(decoFoliages) do
				if decoFoliage.layerName=="decoFoliage" or decoFoliage.layerName=="decoBush" then
					decoFoliage.mowable = true
					print("MOWABLE: " .. decoFoliage.layerName )
				end
			end
		end
		
		self.initialised = true
	end
end
