function startTutorial(element)
	fadeCamera(element,false,3)
	local text = "Willkommen auf "..config.name..". Du wirst nun ins Tutorial weitergeleitet."
	triggerClientEvent(element,"dxslowtext",root,text, 196, 118, 1216, 438, 255, 255, 255, 255,"center","bankghotic",1.5,false,50,6000)
	setTimer(tutorial1,6500,1,element)
	setCameraInterior(element,0)
end

function tutorial1 (element)
	setCameraMatrix(element,1379.7781982422,-1589.1779785156,85.031951904297,1453.4000244141,-1643.5999755859,44.799999237061)
	fadeCamera(element,true,5)
	setCameraInterior(element,0)
	local text = "Hier befindet sich das Zentrum der Stadt. Du wirst nun im Rathaus gespawnt.\nAlles gute und einen schönen Tag wünscht dir dein Adminteam."
	triggerClientEvent(element,"dxslowtext",root,text,196,118,1216,438,255,0,0,180,"center","bankghotic",1.5,false,50,8000)
	setTimer(fadeCamera,8500,1,element,false,3)
	setTimer(tutorial2,10000,1,element)
end

function tutorial2 (element)
	local text = "[Angestellter]: Guten Tag, "..getPlayerName(element).."! Hier ist ihr Personalausweis den sie angefordert haben. (Drücke nun mit ALT-GR auf den Ausweis)"
	local ped = createPed(59,363.10000610352,151.89999389648,1025.8000488281)
	setElementFrozen(ped,true)
	setElementDimension(ped,playerGetElementData(element,"ID"))
	setElementInterior(ped,3)
	local ped2 = createPed(147,359.599609375,173.599609375,1008.4000244141,270.001373)
	setElementInterior(ped2,3)
	setElementFrozen(ped2,true)
	setElementDimension(ped2,playerGetElementData(element,"ID"))
	spawnPlayer(element,363.29998779297,155,1025.8000488281,180.005493,playerGetElementData(element,"Skin"),3,playerGetElementData(element,"ID"))
	showPlayerHudComponent(element,"radar",true)
	showPlayerHudComponent(element,"crosshair",true)
	setCameraTarget(element,element)
	fadeCamera(element,true,3)
	setTimer(outputChatBox,3000,1,text,element,255,255,255)
	setTimer(function(element)
		local ausweis = createObject(1581,363.10000610352,153.5,1025.7099511719,0,0,180)
		setElementInterior(ausweis,3)
		setElementDimension(ausweis,playerGetElementData(element,"ID"))
		addEventHandler("onElementClicked",getRootElement(),function(button,state,element)
			if state == "down" then
				if source == ausweis then
					if playerGetElementData(element,"inTutorial") == true then
						destroyElement(source)
						outputChatBox("[Angestellter]: Gehe nun in die unterste Etage zum Empfang. Einen schönen Tag noch!",element,255,255,255)
						local pickup = createPickup(362.70001220703,173.69999694824,1008.3600244141,3,1210)
						setElementInterior(pickup,3)
						setElementDimension(pickup,tonumber(playerGetElementData(element,"ID")))
						addEventHandler("onPickupHit",pickup,tutorial3)
					end
				end
			end
		end)
	end,3000,1,element)
end

function tutorial3 (element)
	if playerGetElementData(element,"inTutorial") == true then
		destroyElement(source)
		triggerClientEvent(element,"openTutorialGui",root)
	end
end

function tutorialEnd ()
	if not isElement(client) then return end
	if playerGetElementData(client,"inTutorial") == true then
		outputChatBox("Gehe nun zum Ausgang um das Tutorial abzuschließen!",client,255,255,255)
		local pickup = createPickup(389.400390625,173.7998046875,1008.4000244141,3,1318,1000)
		setElementInterior(pickup,3)
		setElementDimension(pickup,tonumber(playerGetElementData(client,"ID")))
		addEventHandler("onPickupHit",pickup,function(element)
			if getElementDimension(pickup) == getElementDimension(element) then 
				setElementInterior(element,0,1481.0999755859,-1766.8000488281,18.799999237061)
				setElementDimension(element,0)
				if playerGetElementData(element,"inTutorial",true) then
					playerSetElementData(element,"inTutorial",false)
				end
				destroyElement(pickup)
			end
		end)
	end
end
addEvent("tutorialend",true)
addEventHandler("tutorialend",root,tutorialEnd)