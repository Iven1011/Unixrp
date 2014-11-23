local window 
local button1 
local button2 
local state 
local gx,gy = guiGetScreenSize()
local gpx,gpy = 1366,768
local itable = {} 

function drawInvitedWindow (name,faction)
	itable.name = name 
	itable.faction = faction
	window = dxWindow:createDxWindow(407, 204, 557, 319,255,0,0,100,"Fraktionseinladung",true)
	button1 = dxButton:createButton(490, 454, 140, 36,0,255,0,150,0,255,0,200,"Annehmen",255,255,255,1,false,"accept_invite_func")
	button2 = dxButton:createButton(736, 454, 140, 36,0,255,0,150,0,255,0,200,"Ablehnen",255,255,255,1,false,"delete_invite_func")
	state = true 
	if state then
		addEventHandler("onClientRender",root,inviting_text)
	end
end
addEvent("showInvitingWindow",true)
addEventHandler("showInvitingWindow",root,drawInvitedWindow)

function inviting_text()
	dxDrawText("Du wurdest von "..tostring(itable.name).." zur Fraktion "..tostring(itable.faction).." eingeladen. ", gx*(408/gpx), gy*(231/gpy), gx*(963/gpx), gy*(315/gpy), tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "top", false, false, true, false, false)
end

function acceptinvite_client ()
	triggerServerEvent("acceptinvite_trigger",root,root,itable.name)
	destroyInvitingWindow()
end
addEvent("accept_invite_func",true)
addEventHandler("accept_invite_func",root,acceptinvite_client)

function deleteinvite_client()
	triggerServerEvent("deleteinvite_trigger",root,root,itable.name)
	destroyInvitingWindow()
end
addEvent("delete_invite_func",true)
addEventHandler("delete_invite_func",root,deleteinvite_client)

function destroyInvitingWindow ()
	removeEventHandler("onClientRender",root,inviting_text)
	state = false 
	itable = nil 
	button1:buttonDestroy()
	button2:buttonDestroy()
	window:destroyWindow()
end