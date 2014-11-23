
gtutorial = {
    button = {},
    window = {},
    label = {}
}
gtutorial.window[1] = guiCreateWindow(0.27, 0.35, 0.47, 0.16, "Tutorial", true)
guiWindowSetMovable(gtutorial.window[1], false)
guiWindowSetSizable(gtutorial.window[1], false)

gtutorial.label[1] = guiCreateLabel(0.00, 0.22, 0.98, 0.29, "Herzlich Willkommen auf "..config.name..".\nDies ist ein GUI(Graphical User Interface). Drücke auf den Button um zum nächsten Schritt zu gelangen.", true, gtutorial.window[1])
guiSetFont(gtutorial.label[1], "default-bold-small")
guiLabelSetHorizontalAlign(gtutorial.label[1], "center", false)
guiLabelSetVerticalAlign(gtutorial.label[1], "center")
gtutorial.button[1] = guiCreateButton(0.28, 0.58, 0.42, 0.34, "Schließen", true, gtutorial.window[1])
guiSetProperty(gtutorial.button[1], "NormalTextColour", "FFAAAAAA")    
guiSetVisible(gtutorial.window[1],false)


function opengtutorialWindow()
	guiSetVisible(gtutorial.window[1],true)
end
addEvent("openTutorialGui",true)
addEventHandler("openTutorialGui",getRootElement(),opengtutorialWindow)

addEventHandler("onClientGUIClick",gtutorial.button[1],function(button,state) 
	guiSetVisible(gtutorial.window[1],false)
	for i,o in ipairs(gtutorial) do 
		destroyElement(i)
	end
	triggerServerEvent("tutorialend",root)
end)
