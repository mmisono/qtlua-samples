require "qt"
require "qtwidget"
require "qtuiloader"

-- print painter information
function print_painter_info(painter)
	local inspect = require "inspect"
	print(inspect(painter:rect():totable()))
	print(inspect(painter.point:totable()))
	print(inspect(painter.pen:totable()))
	print(painter.width)
end

function draw_line(painter)
	painter:setcolor("red")
	painter:setlinewidth(5)
	painter:newpath()
	painter:moveto(0,0)
	painter:lineto(100,100)
	-- don't forget stroke!
	painter:stroke(false)
end

function draw_text(painter)
	painter:moveto(100,200)
	painter:setcolor("black")
	painter:setfont(qt.QFont{serif=true,italic=true,size=16})
	painter:show("hello world!")
end

function draw_rect(painter)
	painter:setcolor("blue")
	painter:rectangle(150,100,30,40)
	painter:fill(false)
end

function main()
	local w = qtuiloader.load("drawing.ui")
	local painter = qt.QtLuaPainter(w.frame)

	draw_line(painter)
	draw_text(painter)
	draw_rect(painter)
	print_painter_info(painter)

	w:show()
end

main()
