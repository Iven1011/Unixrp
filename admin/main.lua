adminrangnamen = {}
adminrangnamen[1] = "Entwickler"
adminrangnamen[2] = "Probe-Supporter"
adminrangnamen[3] = "Supporter"
adminrangnamen[4] = "Moderator"
adminrangnamen[5] = "Adminstrator"
adminrangnamen[6] = "Projektleiter"

function a_chat (element,cmd,...)
	local text = table.concat({...}," ")
	if playerGetElementData(element,"logged") == true then
		local adminrang = tonumber(playerGetElementData(element,"Adminrang"))
		local pname = getPlayerName(element)
		for i,pi in ipairs(getElementsByType("player")) do
			if playerGetElementData(pi,"logged") == true then
				if adminrang >= 1 then
					outputChatBox("["..adminrangnamen[adminrang].."] "..pname..": "..text,pi,255,128,0)
				end
			end
		end
	end
end
addCommandHandler("a",a_chat)

function setadminrank_func (player,cmd,target,value)
	if target and value then
		local tplayer = getPlayerFromName(target)
		if tplayer then
			if tplayer ~= player then
				if playerGetElementData(player,"Adminrang") == 6 then
					if playerGetElementData(player,"logged") == true and playerGetElementData(tplayer,"logged") == true then
						playerSetElementData(tplayer,"Adminrang",tonumber(value))
						local tadminrank = tonumber(playerGetElementData(tplayer,"Adminrang"))
						outputChatBox("Dir wurde der Adminrang: "..adminrangnamen[tadminrank].." zugewiesen!",tplayer,0,255,0)
						outputChatBox("Du hast "..getPlayerName(tplayer).." den Adminrang: "..adminrangnamen[tadminrank].." gegeben.",player,0,255,0)
					end
				end
			end
		end
	end
end
addCommandHandler("setadminrank",setadminrank_func)

function setfraktion_func (element,cmd,target,fraktion,rang)
	if playerGetElementData(element,"logged") == true then 
		if target and tonumber(fraktion) then
			local tplayer = getPlayerFromName(target)
			if tplayer then
				if tplayer ~= element or tplayer == element then
					if playerGetElementData(element,"Adminrang") >= 4 then
						if playerGetElementData(tplayer,"logged") == true then
							if tonumber(fraktion) <= 5 and tonumber(fraktion) >= 1 and tonumber(rang) <= 5 and tonumber(rang) >= 1 then
								local rank 
								local pname = getPlayerName(element) 
								if tonumber(rang) then
									rank = tonumber(rang)
								else
									rank = 0
								end
								playerSetElementData(tplayer,"Fraktion",fraktion)
								playerSetElementData(tplayer,"Rang",rank)
								outputChatBox("Du wurdest von "..pname.." in die Fraktion "..getFactionName(tplayer).." gesettet!",tplayer,0,255,0)
								if rank >= 0 then outputChatBox("Dir wurde der Rang "..rank.." gegeben!",tplayer,0,255,0) end
							end
						end
					end
				end
			end
		end
	end
end
addCommandHandler("setfraktion",setfraktion_func)