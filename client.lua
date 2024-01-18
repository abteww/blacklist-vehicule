--- @author Abtew
--- Create at [18/01/2024] 23:42
--- Current project [naytozzdev]

carblacklist = {
	"tornado6",
	'zr380',
    'zr3802',
    'zr3803',
    'kuruma2',
    'wastelander',
    'pbus2',
    'brickade',
    'squaddie',
    'graintrailer',
    'proptrailer',
    'raketrailer',
    'titan',
    'technical',
    'technical2',
    'technical3',
    'zhaba',
    'menacer',
    'monster5',
    'monster4',
    'monster3',
    'nightshark',
    'insurgent3',
    'insurgent2',
    'insurgent',
    'dune4',
    'dune5',
    'brutus2',
    'brutus3',
    'bruiser',
    'khanjali',
    'minitank',
    'rhino',
    'scarab',
    'scarab2',
    'scarab3',
    'thruster',
    'trailersmall2',
    'halftrack',
    'chernobog',
    'apc',
    'hunter',
    'akula',
    'cargobob',
    'cargobob2',
    'cargobob3',
    'cargobob4',
}

-------------CODE----------------

Citizen.CreateThread(function()
    local playerPed, playerCoords, closestVehicle
    local sleepTime = 500 -- Période d'attente en ms (augmentez cette valeur pour réduire la charge du processeur)

    while true do
        Citizen.Wait(sleepTime)

        playerPed = PlayerPedId()
        if playerPed then
            playerCoords = GetEntityCoords(playerPed)
            checkCar(GetVehiclePedIsIn(playerPed, false))

            for _, blacklistedCar in ipairs(carblacklist) do
                closestVehicle = GetClosestVehicle(playerCoords, 100.0, GetHashKey(blacklistedCar), 70)
                if closestVehicle and closestVehicle ~= 0 then
                    checkCar(closestVehicle)
                end
            end
        end
    end
end)

function checkCar(car)
	if car then
		carModel = GetEntityModel(car)
		carName = GetDisplayNameFromVehicleModel(carModel)

		if isCarBlacklisted(carModel) then
			_DeleteEntity(car)
			sendForbiddenMessage("Le véhicule est interdit! (Allez sur le discord si vous avez un soucis ou ma mp Abteww)")
		end
	end
end

function isCarBlacklisted(model)
	for _, blacklistedCar in pairs(carblacklist) do
		if model == GetHashKey(blacklistedCar) then
			return true
		end
	end

	return false
end

function sendForbiddenMessage(message)
	TriggerEvent("chatMessage", "Exelity", {0, 0, 0}, "^1" .. message)
end

function _DeleteEntity(entity)
	Citizen.InvokeNative(0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized(entity))
end


print("[^1Auteur^0] : ^4Abteww")