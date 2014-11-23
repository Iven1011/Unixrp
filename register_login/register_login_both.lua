local edittable = {}
local buttontable = {} 

addEventHandler("onClientResourceStart",resourceRoot,function()
	addEventHandler("onClientRender",getRootElement(),register_login_render)
	showCursor(true)
	edittable[1] = dxEditbox:createEditbox(509, 269, 356, 27, 0,0,0,150,false)
    edittable[2] = dxEditbox:createEditbox(509, 372, 356, 27, 0,0,0,150,true )
	buttontable[1] = dxButton:createButton(509, 427, 166, 48, 200, 0, 0, 100,255,0,0,150,"Login",255,255,255,1,true,"login_client")
    buttontable[2] = dxButton:createButton(699, 427, 166, 48, 200, 0, 0, 100,255,0,0,150,"Register",255,255,255,1,true,"register_client")
	showChat(false)
	fadeCamera(true)
	showPlayerHudComponent("all",false)
	setCameraMatrix(0,0,20,0,0,20)
end)

local gx,gy = guiGetScreenSize()
local gpx,gpy = 1366,768

function register_login_render()
	dxDrawText(config.name, gx*(307/gpx), gy*(40/gpy), gx*(1076/gpx), gy*(155/gpy), tocolor(255, 0, 0, 180), 2.00, "bankgothic", "center", "center", false, false, true, false, false)
	dxDrawText("Willkommen auf unseren Server. Bitte fülle das Formular aus\num dich zu registrieren.", gx*(509/gpx), gy*(185/gpy), gx*(865/gpx), gy*(183/gpy), tocolor(255, 0, 0, 150), 1.00, "default-bold", "center", "top", false, false, true, false, false)
	dxDrawText("Benutzername", gx*(644/gpx), gy*(246/gpy), gx*(731/gpx), gy*(229/gpy), tocolor(255, 0, 0, 150), 1.00, "default-bold", "center", "center", false, false, true, false, false)
    dxDrawText("Passwort", gx*(644/gpx), gy*(349/gpy), gx*(731/gpx), gy*(332/gpy), tocolor(255,0,0, 150), 1.00, "default-bold", "center", "center", false, false, true, false, false)
end

function disable_window()
	removeEventHandler("onClientRender",getRootElement(),register_login_render)
	edittable[1]:destroyEditbox()
	edittable[2]:destroyEditbox()
	buttontable[1]:buttonDestroy()
	buttontable[2]:buttonDestroy()
end
addEvent("disablewindow",true)
addEventHandler("disablewindow",root,disable_window)

function register_client_func ()
	local benutzername = edittable[1]:getEditText()
	local passwort = edittable[2]:getEditText()
	if #passwort >= 5 then 
		if #benutzername >= 4 then
			triggerServerEvent("register_func",root,benutzername,passwort)
		else
			dxInfobox:createNew("Dein Benutzername\nmuss mindestens\n4 Zeichen lang\nsein.",238,238,0,150,50,3000)
		end
	else
		dxInfobox:createNew("Dein Passwort\nmuss mindestens\n5 Zeichen lang\nsein.",238,238,0,150,50,3000)
	end
end
addEvent("register_client",true)
addEventHandler("register_client",root,register_client_func)

function login_client_func () 
	local benutzername = edittable[1]:getEditText()
	local passwort = edittable[2]:getEditText()
	if #passwort >= 5 then 
		if #benutzername >= 4 then
			triggerServerEvent("login_func",root,benutzername,passwort)
		else
			dxInfobox:createNew("Falsches Passwort.\nFalls du dein\nPasswort vergessen\nhast benachrichtige\neinen Adminstrator.",238,238,0,150,50,3000)
		end
	else
		dxInfobox:createNew("Falsches Passwort.\nFalls du dein\nPasswort vergessen\nhast benachrichtige\neinen Adminstrator.",238,238,0,150,50,3000)
	end
end
addEvent("login_client",true)
addEventHandler("login_client",root,login_client_func)



