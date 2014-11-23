function cursor (element,key,keystate)
	if isCursorShowing(element) then
		showCursor(element,false)
	else
		showCursor(element,true)
	end
end


