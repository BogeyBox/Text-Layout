module(...,package.seeall)

local DisplayObjectPrototype = require "DisplayObjectPrototype"
DisplayObjectPrototype:generalize(TextLayout)

local fonte = native.systemFont --native.newFont( "Adobe Garamond Pro", 20 )

local fonteBold = native.systemFontBold--native.newFont( "Adobe Garamond Pro Bold", 20 )



 



--@Override
function TextLayout:init(properties)
	self.view = display.newGroup()
	
	self.xRight = properties.xRight
	self.currentSize = properties.currentSize
	
	self:newTextLayout(properties.textList)
end


function TextLayout:explode(div,str) 	

  if (div=='') then return false end

  local pos,arr = 0,{}

  -- for each divider found

  for st,sp in function() return string.find(str,div,pos,true) end do

    -- Attach chars left of current divider

    -- table.insert(arr,string.sub(str,pos,st-1)) 

        arr[#arr+1] = string.sub(str,pos,st-1)

    pos = sp + 1 -- Jump past current divider

  end

  -- Attach chars right of last divider

  -- table.insert(arr,string.sub(str,pos)) 

  arr[#arr+1] = string.sub(str,pos)

  

  return arr

end
 

-- --------------------------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------------------------

-- Generate a text group that contains several other text groups formatted as per the instructions

-- in the display list...

 

function TextLayout:newTextLayout(list)
	local currentFont = fonte

	local currentSize = self.currentSize or 20

	local currentColR = 0

	local currentColG = 0

	local currentColB = 0

	local currentColA = 255

	local currentAlign = 0

	local leading = 0

	local spaceWidth = 2           

	local xLeft = 0

	local xRight = self.xRight or 320
	
	local lastX = nil 
	local lastY = nil 
	local lastHeight = nil
	function self:makeLines(strings) 

		local group = self.view

		strings = self:explode(" ",strings)

		local num = #strings

		local tlx,w,word



		for i=1,num do



				word = display.newRetinaText(strings[i],0,0,currentFont,currentSize)

				word:setReferencePoint(display.TopLeftReferencePoint)

				word:setTextColor(currentColR,currentColG,currentColB,currentColA)

				--w = word.width

				--lastHeight = word.height
				lastHeight = word.contentBounds.yMax - word.y 
				
				word.x = lastX
				--tlx = lastX + w

				tlx = word.contentBounds.xMax
				

				if tlx > xRight then
					lastY = lastY + lastHeight
					lastX = xLeft 
				end

				

				word.x = lastX; word.y = lastY; --[[lastX = lastX + (w + spaceWidth)]] lastX =  word.contentBounds.xMax + spaceWidth

				

				group:insert(word)

		end

	end

	local index,data,t

	local listLen = #list

	local g = display.newGroup()

	

	lastX, lastY = 0,0

	

	-- print("Listlength = " .. listLen)



	index = 1

	

	while index <= listLen do



			data = list[index] index = index + 1



					-- Check data to see if it's a valid command (add your own as required)         

					if data == "#br"  then lastX = xLeft; lastY = lastY + lastHeight

					elseif data == "#brn" then t = tonumber(list[index]) lastX = xLeft; lastY = lastY + t; index = index + 1

					elseif data == "#lm"  then xLeft = tonumber(list[index]); index = index + 1 

					elseif data == "#rm"  then xRight = tonumber(list[index]); index = index + 1 

					

					elseif data == "#bl"  then currentFont = fonteBold; currentSize = self.currentSize; 

					elseif data == "#nm"  then currentFont = fonte;  currentSize = self.currentSize;

											

					elseif data == "#cl"  then currentColR = tonumber(list[index]); currentColG = tonumber(list[index+1]); currentColB = tonumber(list[index+2]); currentColA = 255; index = index + 3

					elseif data == "#cla" then currentColR = tonumber(list[index]); currentColG = tonumber(list[index+1]); currentColB = tonumber(list[index+2]); currentColA = tonumber(list[index+3]); index = index + 4

			else            

					-- Else it's a string to render into a block of text groups             

					self:makeLines(data,g)

			end

			

	end

	

	return g

end
