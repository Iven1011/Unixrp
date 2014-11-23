rathausped = createPed(147,359.599609375,173.599609375,1008.4000244141,270.001373)
setElementInterior(rathausped,3)
setElementFrozen(rathausped,true)
setPedAnimation(rathausped,"ped","factalk")

function onRathausPedWasted ()
	destroyElement(rathausped)
	rathausped = createPed(147,359.599609375,173.599609375,1008.4000244141,270.001373)
	setElementInterior(rathausped,3)
	setPedAnimation(rathausped,"ped","factalk")
	setElementFrozen(rathausped,true)
	addEventHandler("onPedWasted",rathausped,onRathausPedWasted)
end
addEventHandler("onPedWasted",rathausped,onRathausPedWasted)

local inPickup = createPickup(1481.0999755859,-1770.4000244141,18.799999237061,3,1318,1000)
local outPickup = createPickup(389.400390625,173.7998046875,1008.4000244141,3,1318,1000)
setElementInterior(outPickup,3)
createBlipAttachedTo(inPickup,56,1)

addEventHandler("onPickupHit",inPickup,function(element)
	if getElementDimension(element) == getElementDimension(inPickup) then
		if getPedOccupiedVehicle(element) then return end
		setElementInterior(element,3,386.79998779297,173.80000305176,1008.4000244141)
		setElementRotation(element,0,0,90)
	end
end)

addEventHandler("onPickupHit",outPickup,function(element)
	if getElementDimension(element) == getElementDimension(outPickup) then
		setElementInterior(element,0,1481.0999755859,-1766.8000488281,18.799999237061)
	end
end)

local bribepickup = createPickup(363.10000610352,173.60000610352,1008.3600244141,3,1210,1000)
setElementInterior(bribepickup,3)
function bribepickup_hit (element)
	if playerGetElementData(element,"logged") then
		triggerClientEvent(element,"openinfowindow",root)
	end
end
addEventHandler("onPickupHit",bribepickup,bribepickup_hit)

