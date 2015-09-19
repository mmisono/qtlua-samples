require "qt"
require "qtwidget"

-- qtwidget.newwindow() sample

function print_field(field)
	for i=1,3 do
			print(field[i][1], field[i][2], field[i][3])
	end
end

function main()
	local width = 300
	local height = 300
	local BW = width/3
	local BH = height/3
	local w = qtwidget.newwindow(width,height,"Tic-Tac-Toe")
	local painter = w.port
	local field = {{-1,-1,-1},{-1,-1,-1},{-1,-1,-1}}
	local turn = 0

	local function reset()
		for i=1,3 do
			for j=1,3 do
				field[i][j] = -1
			end
		end
	end

	local function draw()
		painter:gbegin()
		painter:showpage()
		painter:gsave()
	
		-- draw frame
		painter:setcolor("black")
		painter:newpath()
		painter:moveto(0,100)
		painter:lineto(300,100)
		painter:moveto(0,200)
		painter:lineto(300,200)
		painter:moveto(100,0)
		painter:lineto(100,300)
		painter:moveto(200,0)
		painter:lineto(200,300)
		painter:closepath()
		painter:stroke()

		-- draw x & circle
		for i=1,3 do
			for j=1,3 do
				if field[i][j] == 0 then
					-- draw circle
					painter:newpath()
					painter:setcolor("red")
					-- arc(x,y,r,angle1,angle2)
					painter:arc(BW*(j-1)+BW/2,BW*(i-1)+BW/2,BW/3,0,360)
					painter:stroke()
				elseif field[i][j] == 1 then
					-- draw x
					painter:newpath()
					painter:setcolor("blue")
					painter:moveto(BW*(j-1)+BW/4,BW*(i-1)+BW/4)
					painter:lineto(BW*(j-1)+BW/4*3,BW*(i-1)+BW/4*3)
					painter:moveto(BW*(j-1)+BW/4,BW*(i-1)+BW/4*3)
					painter:lineto(BW*(j-1)+BW/4*3,BW*(i-1)+BW/4)
					painter:stroke()
				end
			end
		end
	
		painter:grestore()
		painter:gend()
	end

	local function click(x,y)
		print("clicked:",x,y)
		local fx = math.floor(x / BW) + 1
		local fy = math.floor(y / BH) + 1

		if field[fy][fx] == -1  then
			field[fy][fx] = turn
			turn = 1 - turn
			print_field(field)
			draw()
		end
	end

	local function key(k,n)
		if k:tostring() == "r" then
			reset()
			draw()
		end
	end

	-- mouse event
	qt.connect(w.listener,
		"sigMousePress(int,int,QByteArray,QByteArray,QByteArray)",
		function(x,y) click(x,y) end)

	-- keyboard event
	qt.connect(w.listener,
		"sigKeyPress(QString,QByteArray,QByteArray)",
		function(k,n) key(k,n) end)

	print_field(field)
	reset()
	draw()
end

main()
