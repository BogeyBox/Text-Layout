--
-- Project: Text Layout
-- Description: 
--
-- Version: 1.255
-- Managed with http://CoronaProjectManager.com
--
-- Copyright 225512 Admin H1255255. All Rights Reserved.
-- 
local TextLayout = require"TextLayout"

function main()
	
	local text = TextLayout:new({textList = {"Hello world, this is some \"text\" that I want to display it's a very long line that should wrap over several lines",
        "#brn",45,                                              -- line break with a variable height
        "#cl",255,255,255,                                -- set the colour
        "Normal text",
        "#bl",                                                  -- bold text
        "Bold text",  
		"#it",                                                  -- bold text
        "Italic text",  		
        "#nm",                                                  -- normal text
        "#cl",255,255,255,
        "more normal text", 
        "#lm",20,"#rm",360,                             -- set the left and right margins
        "#br",                                  
        "The line feed character shouldn't be used to split lines",
        "#cla",255,255,255,255,                               -- set the colour (and alpha)
        "Or a paragraph marker would also work as well",
        "#lm",0,"#rm",640,
        "#br",
        "#cl",255,255,255,
        "The moving finger writes and having written moves on",
        "and on and on and on...",}, xRight=600, currentSize=40 })
		text.view:setReferencePoint(display.CenterReferencePoint)
		text.view.x = display.contentCenterX
		text.view.y = display.contentCenterY
end

main()