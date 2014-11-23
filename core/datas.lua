elementdatatable = {}

function playerSetElementData ( element, datastring, value )
	if not elementdatatable[element] then
		elementdatatable[element] = {}
	end

	elementdatatable[element][datastring] = value
	setElementData ( element, datastring, value )
end

function playerGetElementData ( element, datastring )
	if elementdatatable[element][datastring] then 
		return elementdatatable[element][datastring]
	else
		return nil
	end
end

addEventHandler("onPlayerJoin",getRootElement(),function()
	playerSetElementData(source,"logged",false)
end)

function saveDatas (element)
	if not isElement(client) then return end
	if playerGetElementData(client,"logged") == true then
		playerSetMysqlData(client,"userdata","PosX",playerGetElementData(client,"PosX"))
		playerSetMysqlData(client,"userdata","PosY",playerGetElementData(client,"PosY"))
		playerSetMysqlData(client,"userdata","PosZ",playerGetElementData(client,"PosZ"))
		playerSetMysqlData(client,"userdata","Rotation",playerGetElementData(client,"Rotation"))
		playerSetMysqlData(client,"userdata","Dimension",playerGetElementData(client,"Dimension"))
		playerSetMysqlData(client,"userdata","Interior",playerGetElementData(client,"Interior"))
		playerSetMysqlData(client,"userdata","Skin",playerGetElementData(client,"Skin"))
		playerSetMysqlData(client,"userdata","Adminrang",playerGetElementData(client,"Adminrang"))
		playerSetMysqlData(client,"userdata","Fraktion",playerGetElementData(client,"Fraktion"))
		playerSetMysqlData(client,"userdata","Rang",playerGetElementData(client,"Rang"))
	end
end
addEventHandler("onPlayerQuit",getRootElement(),saveDatas)