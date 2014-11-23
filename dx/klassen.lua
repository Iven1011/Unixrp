local gx,gy = guiGetScreenSize()
local gpx,gpy = 1366,768

dxButton = {} 

function dxButton:createButton(x,y,w,h,r,g,b,a,hr,hg,hb,ha,text,tr,tg,tb,size,shadow,callfunc)
	local self = setmetatable({},{__index = self})
	self.activ = true
	self.x = x 
	self.y = y 
	self.w = w 
	self.h = h
	self.tx = x
	self.ty = y
	self.tw = w
	self.th = h
	self.r = r 
	self.g = g 
	self.b = b 
	self.a = a
	self.hr = hr 
	self.hg = hg 
	self.hb = hb
	self.ha = ha
	self.text = text 
	self.tr = tr 
	self.tg = tg 
	self.tb = tb
	self.size = size
	self.shadow = shadow
	self.callfunc = callfunc
	self.visible = true
	self.render = function() self:onButtonRender() end
	self.click = function(button,state) self:onButtonClick(button,state) end
	addEventHandler("onClientClick",getRootElement(),self.click)
	addEventHandler("onClientRender",getRootElement(),self.render)
	return self
end

function dxButton:onButtonRender()
	if self.activ then
		if self.visible then
			local mr,mg,mb,ma
			if getCursorArea(gx*(self.x/gpx),gy*(self.y/gpy),gx*(self.w/gpx),gy*(self.h/gpy)) then
				mr,mg,mb,ma = self.hr,self.hg,self.hb,self.ha
			else
				mr,mg,mb,ma = self.r,self.g,self.b,self.a
			end
			if shadow then
				dxDrawRectangle(gx*((self.x+1)/gpx),gy*((self.y+1)/gpy),gx*((self.w+1)/gpx),gy*((self.h+1)/gpy),tocolor(0,0,0))
			end 
			dxDrawRectangle(gx*(self.x/gpx),gy*(self.y/gpy),gx*(self.w/gpx),gy*(self.h/gpy),tocolor(mr,mg,mb,ma))
			dxDrawText(self.text,gx*((self.tx+(self.tw/2)-dxGetTextWidth(self.text, self.size, "default-bold")/2)/gpx),gy*((self.ty+(self.th/2)-dxGetFontHeight(self.size, "default-bold")/2)/gpy),gx*(self.tw/gpx),gy*(self.th/gpy),tocolor(self.tr,self.tg,self.tb,255),self.size,"default-bold")
		end
	end
end

function dxButton:onButtonClick(button,state)
	if self.activ then
		if button == "left" and state == "up" then
			if getCursorArea(gx*(self.x/gpx),gy*(self.y/gpy),gx*(self.w/gpx),gy*(self.h/gpy)) then
				triggerEvent(self.callfunc,root)
			end
		end
	end
end

function dxButton:buttonSetVisible (boolean)
	if self.activ then
		self.visible = boolean
	end
end

function dxButton:buttonDestroy()
	self.activ = false
	removeEventHandler("onClientRender",getRootElement(),self.render)
	removeEventHandler("onClientRender",getRootElement(),self.click)
	self = nil 
end

dxKeyNot = { 
	'mouse1',
	'mouse2',
	'mouse3',
	'mouse4',
	'mouse5',
	'mouse_wheel_up',
	'mouse_wheel_down',
	'arrow_l',
	'arrow_u',
	'arrow_r',
	'arrow_d',
	'num_0',
	'num_1',
	'num_2',
	'num_3',
	'num_4',
	'num_5',
	'num_6',
	'num_7',
	'num_8',
	'num_9',
	'num_mul',
	'num_add',
	'num_sep',
	'num_sub',
	'num_div',
	'num_dec',
	'num_enter',
	'F1',
	'F2',
	'F3',
	'F4',
	'F5',
	'F6',
	'F7',
	'F8',
	'F9',
	'F10',
	'F11',
	'F12',
	'escape',
	'tab',
	'lalt',
	'ralt',
	'enter',
	'pgup',
	'pgdn',
	'end',
	'home',
	'insert',
	'delete',
	'lshift',
	'rshift',
	'lctrl',
	'rctrl',
	'pause',
	'capslock',
	'scroll',
	';',
	',',
	'-',
	'.',
	'/',
	'#',
	'=',
	'#',
	'<',
	'^',
	'´'
	--''\''
}

function isAbleKey(key)
	local able = true
	for i,character in ipairs(dxKeyNot) do
		if key == character then
			able = false
		end
	end
	return able 
end

function isAbleToWrite ()
	if not isChatBoxInputActive() and not isConsoleActive() and not isMTAWindowActive() and not isMainMenuActive() then
		return true
	end
end

dxEditbox = {}

function dxEditbox:createEditbox(x,y,w,h,r,g,b,a,password)
	local self = setmetatable({},{__index = self})
	self.activ = true
	self.textactiv = false
	self.shiftactiv = false
	self.x = x
	self.y = y
	self.w = w 
	self.h = h
	self.r = r 
	self.g = g 
	self.b = b 
	self.a = a
	self.password = password
	self.text = ""
	self.ptext = ""
	self.click = function(button,state) self:onEditClick(button,state) end
	self.render = function() self:onEditRender() end
	self.key = function(key,state) self:onEditKey(key,state) end
	self.shift = function(key,state) self:onEditShift(key,state) end
	bindKey("lshift","both",self.shift)
	addEventHandler("onClientKey",getRootElement(),self.key)
	addEventHandler("onClientRender",getRootElement(),self.render)
	addEventHandler("onClientClick",getRootElement(),self.click)
	return self
end

function dxEditbox:onEditShift(key,state)
	if self.activ then
		if state == "down" then
			self.shiftactiv = true
		else
			self.shiftactiv = false
		end
	end
end

function dxEditbox:onEditClick(button,state)
	if self.activ then
		if getCursorArea(gx*(self.x/gpx),gy*(self.y/gpy),gx*(self.w/gpx),gy*(self.h/gpy)) then
			self.textactiv = true
		else
			self.textactiv = false
		end
	end
end

local alpha = 0
function dxEditbox:onEditRender()
	if self.activ then
		dxDrawRectangle(gx*(self.x/gpx),gy*(self.y/gpy),gx*(self.w/gpx),gy*(self.h/gpy),tocolor(self.r,self.g,self.b,self.a))
		alpha = alpha + 10
		if self.textactiv then
			if dxGetTextWidth(self.text,1) <= self.w then
				dxDrawRectangle(self.x+1+self.w/2+dxGetTextWidth(self.text, 1, "default-bold")/2, self.y+1, 1, self.h-2, tocolor(255, 255, 255, alpha), true)
			end
		end
		if #self.text > 0 then
			dxDrawText(self.text,gx*((self.x+(self.w/2)-dxGetTextWidth(self.text, 1, "default-bold")/2)/gpx),gy*((self.y+(self.h/2)-dxGetFontHeight(1, "default-bold")/2)/gpy),gx*(self.w/gpx),gy*(self.h/gpy),tocolor(255,255,255,255),1,"default-bold")
		end
	end
end

function dxEditbox:onEditKey(key,state)
	if self.activ then
		if self.textactiv then
			if state then
				if isAbleKey(key) then
					if self.password then
						if key == "space" and dxGetTextWidth(self.text, 1, "default-bold" ) <= 7 then
							if dxGetTextWidth(self.text,1,"default-bold") >= self.w - 10 then return end
							if #self.text > 0 then
								return 
							end
						elseif key == "backspace" then
							if #self.text > 0 then
								ssub = string.sub(self.text,1,#self.text - 1)
								self.text = ssub
								self.ptext = ssub
							end
						else
							if key == "space" then return end
							if dxGetTextWidth(self.text,1,"default-bold") >= self.w - 10 then return end
							if self.shiftactiv then
								key = string.upper(key)
							end
							self.ptext = self.ptext..key
							self.text = self.text.."*"
						end
					else
						if key == "space" and dxGetTextWidth(self.text, 1, "default-bold" ) <= 7 then
							if dxGetTextWidth(self.text,1,"default-bold") >= self.w - 10 then return end
							if #self.text > 0 then
								--self.text = self.text.." "
								--self.ptext = self.ptext.." "
								return
							end
						elseif key == "backspace" then
							if #self.text > 0 then
								ssub = string.sub(self.text,1,#self.text - 1)
								self.text = ssub
								self.ptext = ssub
							end
						else
							if key == "space" then return end
							if dxGetTextWidth(self.text,1,"default-bold") >= self.w - 10 then return end
							if self.shiftactiv then
								key = string.upper(key)
							end
							self.text = self.text..key
							self.ptext = self.ptext..key
						end
					end
				end
			end
		end
	end
end

function dxEditbox:getEditText()
	return self.ptext
end

function dxEditbox:setEditboxVisible(state)
	self.activ = state 
end

function dxEditbox:destroyEditbox()
	self.activ = false
	self.shiftactiv = false
	self.textactiv = false
	unbindKey("lshift","both",self.shift)
	removeEventHandler("onClientKey",getRootElement(),self.key)
	removeEventHandler("onClientClick",getRootElement(),self.click)
	removeEventHandler("onClientRender",getRootElement(),self.render)
	self = nil
end

infoboxactive = false 

dxInfobox = {}

function dxInfobox:createNew(text,r,g,b,a,add,time) 
	if infoboxactive == false then
		local self = setmetatable({},{__index = self})
		infoboxactive = true
		self.text = text
		self.r = r 
		self.g = g
		self.b = b
		self.a = a
		self.time = time
		self.addition = add
		self.render = function() self:onInfoboxRender() end
		self.delay = function() self:onTimerDelay() end
		showChat(false)
		addEventHandler("onClientRender",getRootElement(),self.render)
		setTimer(self.delay,self.time,1)
		return self
	end
end

function dxInfobox:onInfoboxRender()
	dxDrawRectangle(5,5,450  - dxGetTextWidth(self.text,1,"bankghotic"),(dxGetTextWidth(self.text,1,"bankghotic") + (dxGetFontHeight(1,"default")+self.addition) ),tocolor(0,0,0,200))
	dxDrawText(self.text,10,10,dxGetTextWidth(self.text,1,"bankgothic") + 5,dxGetFontHeight(1,"bankgothic"),tocolor(self.r,self.g,self.b,self.a),1,"bankgothic")
end

function dxInfobox:onTimerDelay()
	removeEventHandler("onClientRender",getRootElement(),self.render)
	self = nil 
	infoboxactive = false
	showChat(true)
end

function dxInfoboxTrigger (text,r,g,b,a,add,time)
	dxInfobox:createNew(text,r,g,b,a,add,time)
end
addEvent("infobox",true)
addEventHandler("infobox",getRootElement(),dxInfoboxTrigger)

dxSlowText = {}

function dxSlowText:createSlowText (text,x,y,w,h,r,g,b,a,position,font,size,shadow,tempo,delay)
	local self = setmetatable({},{__index = self})
	self.text = text
	self.curtext = ""
	self.x = x 
	self.y = y
	self.w = w 
	self.h = h 
	self.r = r 
	self.g = g
	self.b = b 
	self.a = a 
	self.position = position
	self.font = font 
	self.fontsize = size
	self.shadow = shadow
	self.tempo = tempo
	self.delay = delay
	self.render = function() self:onSlowTextRender() end
	self.nextletter = function(index) self:nextLetter(index) end
	self.destroyletter = function() self:destroyLetter() end
	addEventHandler("onClientRender",getRootElement(),self.render)
	for index = 1, #self.text do 
		setTimer(self.nextletter,index*tempo,1,index)
	end
	setTimer(self.destroyletter,self.delay,1)
	return self
end

function dxSlowText:nextLetter (index)
	self.curtext = string.sub(self.text,1,index)
end

function dxSlowText:onSlowTextRender() 
	dxDrawText(self.curtext,gx*(self.x/gpx),gy*(self.y/gpy),gx*(self.w/gpx),gy*(self.h/gpy), tocolor(self.r,self.g,self.b,self.a),self.fontsize,self.font,self.position,"center")
end

function dxSlowText:destroyLetter() 
	removeEventHandler("onClientRender",getRootElement(),self.render)
	self = nil 
end

function createSlowText (text,x,y,w,h,r,g,b,a,position,font,size,shadow,tempo,delay)
	dxSlowText:createSlowText (text,x,y,w,h,r,g,b,a,position,font,size,shadow,tempo,delay)
end
addEvent("dxslowtext",true)
addEventHandler("dxslowtext",getRootElement(),createSlowText)

dxWindow = {}

function dxWindow:createDxWindow (x,y,w,h,r,g,b,a,title,enable)
	local self = setmetatable({},{__index = self})
	self.activ = true 
	self.x = gx*(x/gpx) 
	self.y = gy*(y/gpy)
	self.w = gx*(w/gpx)
	self.h = gy*(h/gpy)
	self.r = r 
	self.g = g 
	self.b = b 
	self.a = a 
	self.enable = enable
	self.title = title
	self.visible = true 
	self.render = function() self:onDxWindowRender() end
	self.click = function(key,state) self:onDxWindowExit(key,state) end
	addEventHandler("onClientRender",root,self.render)
	addEventHandler("onClientClick",root,self.click)
	return self
end

function dxWindow:onDxWindowExit(key,state)

end

function dxWindow:onDxWindowRender() 
	if self.activ then
		if self.visible then 
			dxDrawRectangle(self.x,self.y,self.w,self.h,tocolor(self.r,self.g,self.b,self.a))
			dxDrawText(self.title,self.x+(self.w/2)-(dxGetTextWidth(self.title, 1, "default-bold")/2)+1,self.y,self.w,self.h,tocolor(255,255,255,255),1,"default-bold")
			dxDrawLine(self.x,self.y,self.x+self.w,self.y,tocolor(255,255,255,255))
			dxDrawLine(self.x,self.y+15,self.x+self.w,self.y+15,tocolor(255,255,255,255))
			dxDrawLine(self.x,self.y,self.x,self.y+15,tocolor(255,255,255,255))
			dxDrawLine(self.x+self.w-1,self.y,self.x+self.w-1,self.y+15,tocolor(255,255,255,255))
		end
	end
end


function dxWindow:setWindowVisible(boolean)
	self.visible = boolean
end

function dxWindow:destroyWindow()
	removeEventHandler("onClientRender",root,self.render)
	removeEventHandler("onClientClick",root,self.click)
	self = nil 
end





