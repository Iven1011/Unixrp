function register_function (benutzername,passwort)
	if not isElement(client) then return end
	local sql = dbQuery(handler,"SELECT * FROM userdata WHERE Benutzername = '"..benutzername.."'")
	local result, row = dbPoll(sql,-1)
	if row == 0 then
		registerPlayer(client,benutzername,passwort)
	else
		triggerClientEvent(client,"infobox",root,"Dieser Name ist\nbereits vergeben.",238,238,0,150,0,3000)
	end
end
addEvent("register_func",true)
addEventHandler("register_func",root,register_function)

function login_function (benutzername,passwort)
	if not isElement(client) then return end
	local sql = dbQuery(handler,"SELECT * FROM userdata WHERE Benutzername = '"..benutzername.."' AND Passwort = '"..md5(passwort).."'")
	local result,row = dbPoll(sql,-1)
	if row == 1 then
		setPlayerName(client,benutzername)
		loginPlayer(client)
	else
		triggerClientEvent(client,"infobox",root,"Falsches\nPasswort.",238,238,0,150,0,3000)
	end
end
addEvent("login_func",true)
addEventHandler("login_func",root,login_function)

function registerPlayer (element,benutzername,passwort)
	local pw = md5(passwort)
	local result = dbExec(handler,"INSERT INTO `userdata` (`Benutzername`,`Passwort`,`Serial`) VALUES (?,?,?)",benutzername,pw,getPlayerSerial(element))
	if result then
		showCursor(element,false)
		setPlayerName(element,benutzername)
		local x = 1481.0999755859
		local y = -1766.8000488281
		local z = 18.799999237061
		local rotation = 0 
		local dimension = 0 
		local interior = 0 
		local skin = math.random(78,79)
		local adminrang = 0 
		local faction = 0 
		local rank = 0
		playerSetElementData(element,"PosX",x)
		playerSetElementData(element,"PosY",y)
		playerSetElementData(element,"PosZ",z)
		playerSetElementData(element,"Rotation",rotation)
		playerSetElementData(element,"Dimension",dimension)
		playerSetElementData(element,"Interior",interior)
		playerSetElementData(element,"Skin",skin)
		playerSetElementData(element,"Adminrang",adminrang)
		playerSetElementData(element,"Fraktion",faction)
		playerSetElementData(element,"Rang",rank)
		playerSetElementData(element,"logged",true)
		playerSetElementData(element,"inTutorial",true)
		saveDatas(element)
		playerSetElementData(element,"ID",playerGetMysqlData(element,"userdata","ID"))
		triggerClientEvent(element,"disablewindow",root)
		triggerClientEvent(element,"infobox",root,"Du hast dich\nerfolgreich\nregistriert.",0,250,0,150,50,2000)
		startTutorial(element)
		bindKey(element,"ralt","down",cursor)
	end
end

function loginPlayer (element)
	playerSetElementData(element,"ID",playerGetMysqlData(element,"userdata","ID"))
	playerSetElementData(element,"PosX",playerGetMysqlData(element,"userdata","PosX"))
	playerSetElementData(element,"PosY",playerGetMysqlData(element,"userdata","PosY"))
	playerSetElementData(element,"PosZ",playerGetMysqlData(element,"userdata","PosZ"))
	playerSetElementData(element,"Rotation",playerGetMysqlData(element,"userdata","Rotation"))
	playerSetElementData(element,"Dimension",playerGetMysqlData(element,"userdata","Dimension"))
	playerSetElementData(element,"Interior",playerGetMysqlData(element,"userdata","Interior"))
	playerSetElementData(element,"Skin",playerGetMysqlData(element,"userdata","Skin"))
	playerSetElementData(element,"Adminrang",playerGetMysqlData(element,"userdata","Adminrang"))
	playerSetElementData(element,"Fraktion",playerGetMysqlData(element,"userdata","Fraktion"))
	playerSetElementData(element,"Rang",playerGetMysqlData(element,"userdata","Rang"))
	playerSetElementData(element,"logged",true)
	playerSetElementData(element,"inTutorial",false)
	spawnThePlayer(element)
	triggerClientEvent(element,"infobox",root,"Du hast dich\nerfolgreich\neingeloggt.",0,250,0,150,50,2000)
	triggerClientEvent(element,"disablewindow",root)
	bindKey(element,"ralt","down",cursor)
end

