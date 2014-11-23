local window = nil
local gx,gy = guiGetScreenSize()
local gpx,gpy = 1366,768
local gxx,gyy = gx/2,gy/2-40
local y1 = 0
local y2 = gy
local selfstate = false
local isOnMove = false


function logoin ()
	if getElementData(getLocalPlayer(),"logged") == true then
		if isOnMove then return end
		if not selfstate then
			selfstate = true
			addEventHandler("onClientRender",root,logodraw)
			isOnMove = true
		else
			isOnMove = true 
			selfstate = false
		end
	end
end
addCommandHandler("self",logoin)


function logodraw()
	if selfstate then
		if y1 >= gyy then
			dxDrawCircle( gxx, gyy, 150 )
		else
			dxDrawCircle( gxx, y1, 150 )
			y1 = y1 + 20
		end
		if y2 <= gy*(250/gpy) then
			dxDrawImage(gx*(587/gpx), gy*(250/gpy), gx*(196/gpx), gy*(211/gpy),":reallife/images/logo.png")
			isOnMove = false
			y1 = gyy
			y2 = gy*(250/gpy)
		else
			dxDrawImage(gx*(587/gpx), gy*(y2/gpy), gx*(196/gpx), gy*(211/gpy),":reallife/images/logo.png")
			y2 = y2 - 25 
		end
	else
		y1 = y1 - 20 
		y2 = y2 + 20 
		dxDrawCircle( gxx, y1, 150 )
		dxDrawImage(gx*(587/gpx), gy*(y2/gpy), gx*(196/gpx), gy*(211/gpy),":reallife/images/logo.png")
		if y1 <= 0 then

		end
		setTimer(logoremove,700,1)

	end
end

function logoremove ()
	removeEventHandler("onClientRender",root,logodraw)
	selfstate = false
	isOnMove = false
	y1 = 0
	y2 = gy
end


 
