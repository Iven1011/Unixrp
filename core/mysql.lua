handler = dbConnect("mysql","dbname="..serverconfig.dbname..";host="..serverconfig.dbhost.."",serverconfig.dbuser,serverconfig.dbpass,"share=1")

function dbConnectorCheck ()
	if handler then
		outputDebugString("Verbindung zur Datenbank hergestellt!")
	else
		outputDebugString("Verbindung zur Datenbank fehlgeschlagen!")
	end
end
dbConnectorCheck()

function playerSetMysqlData (element,tablename,data,value)
	local sql = dbExec(handler,"UPDATE `??` SET `??`=? WHERE Benutzername = ?",tablename,data,value,getPlayerName(element))
	if sql then
		return true 
	else
		local result,rows,errormsg = dbPoll(sql, -1)
		outputDebugString(errormsg) 
		return nil
	end
end


function playerGetMysqlData(element,tablename,data)
	local sql = dbQuery(handler,"SELECT ?? FROM `??` WHERE Benutzername = ?",data,tablename,getPlayerName(element))
	local result,rows,errormsg = dbPoll(sql,-1)
	if sql then
		return result[1][data]
	else
		outputDebugString(errormsg)
		return nil
	end
end
