fraktionid = {}
fraktionid[1] = "Police"
fraktionid[2] = "Agents"
fraktionid[3] = "Army"
fraktionid[4] = "Reporter"
fraktionid[5] = "Notdienst"
fraktionid[6] = "Groves" 
fraktionid[7] = "Ballas"
fraktionid[8] = "Triaden"
fraktionid[9] = "Vagos"
fraktionid[10] = "Truth"

factiontypes = {}
factiontypes[1] = "Staat" 
factiontypes[2] = "Staat"
factiontypes[3] = "Staat"
factiontypes[4] = "Neutral"
factiontypes[5] = "Neutral"
factiontypes[6] = "Evil"
factiontypes[7] = "Evil"
factiontypes[8] = "Evil"
factiontypes[9] = "Evil"
factiontypes[10] = "Unknown"

factionskins = {}
factionskins[1] = {284, 283, 282, 281, 280, 267, 266, 265, 288}
factionskins[2] = {163, 164, 165, 166, 286}
factionskins[3] = {73, 179, 191, 287, 312}
factionskins[4] = {59, 60, 147, 170, 185, 267, 188, 186, 288, 219, 141}
factionskins[5] = {274, 275, 276, 70, 71, 176, 177}
factionskins[6] = {300, 269, 270, 105, 106, 107, 195}
factionskins[7] = {102, 104, 296, 303, 304}
factionskins[8] = {272, 49, 57, 169, 117, 118}
factionskins[9] = {108, 109, 110, 114, 115, 116, 293}
factionskins[10] = {1}



function getFaction (element)
	local search = playerGetElementData(element,"Fraktion")
	return tonumber(search)
end

function getFactionRank (element)
	local search = playerGetElementData(element,"Rang")
	return tonumber(search)
end

function getFactionType (element)
	local faction = playerGetElementData(element,"Fraktion")
	return tostring(factiontypes[faction])
end

function getFactionName (element)
	local faction = playerGetElementData(element,"Fraktion")
	return tostring(fraktionid[tonumber(faction)])
end

function cskin_func (element)
	if playerGetElementData(element,"logged") == true then
		if playerGetElementData(element,"Fraktion") >= 1 then
			if not getPedOccupiedVehicle(element) then
				if isPlayerInBase(element) then
					local counter = nil
					local curmodel = getElementModel(element)
					for i,skin in pairs(factionskins[playerGetElementData(element,"Fraktion")]) do 
						if skin == getElementModel(element) then
							counter = i  
							if #factionskins[playerGetElementData(element,"Fraktion")] == counter then 
								counter = nil
							else
								counter = counter + 1
								setElementModel(element,factionskins[playerGetElementData(element,"Fraktion")][counter])
								playerSetElementData(element,"Skin",getElementModel(element)) 
							end
							break
						end
					end
					if counter == nil then
						setElementModel(element,factionskins[playerGetElementData(element,"Fraktion")][1])
						playerSetElementData(element,"Skin",getElementModel(element))
					end
				end
			end
		end
	end	
end
addCommandHandler("cskin",cskin_func)

function invite_func (element,cmd,target)
	if playerGetElementData(element,"logged") == true then
		if target then
			if getFaction(element) >= 1 then
				if getFactionRank(element) >= 4 then
					local tplayer = getPlayerFromName(target)
					if tplayer then
						if playerGetElementData(tplayer,"logged") == true then
							if getFaction(tplayer) >= 1 then 
								playerSetElementData(tplayer,"tempfaction",playerGetElementData(element,"Fraktion"))
								local faction = getFactionName(element)
								local pname = getPlayerName(element)
								triggerClientEvent(tplayer,"showInvitingWindow",root,pname,faction)
								outputChatBox("[Fraktion]: Du hast "..getPlayerName(tplayer).." in deine Fraktion eingeladen!",element,255,0,0)
							else
								triggerClientEvent(element,"infobox",root,"Ungueltiger\nSpieler.",238,238,0,150,0,2000)
							end
						else
							triggerClientEvent(element,"infobox",root,"Der Spieler\nmuss eingeloggt\nsein.",238,238,0,150,100,2000)
						end
					else
						triggerClientEvent(element,"infobox",root,"Dieser Name\nist nicht\nvorhanden.",238,238,0,150,100,2000)
					end
				else
					triggerClientEvent(element,"infobox",root,"Keine\nBerechtigung.",238,238,0,150,0,2000)
				end
			else
				triggerClientEvent(element,"infobox",root,"Keine\nBerechtigung.",238,238,0,150,0,2000)
			end
		else
			outputChatBox("Syntax: invite [NAME]",element,255,0,0)
		end
	end
end

function factionmessage (faction,message,r,g,b)
	if not r then r,g,b = 255,0,0 end
	for i,pi in ipairs(getElementsByType("player")) do 
		if playerGetElementData(pi,"Fraktion") == faction then
			outputChatBox(message,pi,r,g,b)
		end
	end
end

function uninvite_func (element,cmd,target)
	if playerGetElementData(element,"logged") == true then
		if target then
			local tplayer = getPlayerFromName(target)
			if tplayer then
				if tplayer ~= element then
					if playerGetElementData(tplayer,"logged") == true then
						if getFaction(tplayer) == getFaction(element) then
							if getFactionRank(tplayer) < getFactionRank(element) then
								playerSetElementData(tplayer,"Fraktion",0)
								playerSetElementData(tplayer,"Rang",0)
								outputChatBox("[Fraktion]: Du wurdest aus deiner Fraktion entlassen!",tplayer,255,0,0)
								factionmessage(getFaction(element),"[Fraktion]: "..getPlayerName(element).." hat "..getPlayerName(tplayer).." aus der Fraktion entlassen!")
							else
								triggerClientEvent(element,"infobox",root,"Keine\nBerechtigung.",238,238,0,150,0,2000)
							end
						else
							triggerClientEvent(element,"infobox",root,"Ungueltiger\nSpieler.",238,238,0,150,0,2000)
						end
					end
				end
			else
				triggerClientEvent(element,"infobox",root,"Dieser Name\nist nicht\nvorhanden.",238,238,0,150,100,2000)
			end		
		else
			outputChatBox("Syntax: uninvite [NAME]",element,255,0,0)
		end
	end
end

function acceptinvite_func (element,name)
	if playerGetElementData(element,"logged") == true then
		if playerGetElementData(element,"tempfaction") >= 1 then
			local faction = playerGetElementData(element,"tempfaction")
			playerSetElementData(element,"Fraktion",faction)
			playerSetElementData(element,"Rang",1)
			factionmessage(playerGetElementData(element,"Fraktion"),"[Fraktion]: "..getPlayerName.." hat die Einladung von "..name.." angenommen!",255,0,0)
			playerSetElementData(element,"tempfaction",0)
		end
	end
end
addEvent("acceptinvite_trigger",true)
addEventHandler("acceptinvite_trigger",root,acceptinvite_func)

function deleteinvite_func (element,name)
	if playerGetElementData(element,"logged") == true then
		if playerGetElementData(element,"tempfaction") >= 1 then
			factionmessage(playerGetElementData(element,"tempfaction"),"[Fraktion]: "..getPlayerName(element).." hat die Einladung von "..name.." in die Fraktion abgelehnt!",255,0,0)
			playerSetElementData(element,"tempfaction",0)
		end
	end
end
addEvent("deleteinvite_trigger",true)
addEventHandler("deleteinvite_trigger",root,deleteinvite_func)
