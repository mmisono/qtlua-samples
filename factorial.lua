require "qt"
require "qtwidget"
require "qtuiloader"

function factorial(n)
	if n < 1 then
		return 1
	end
	return n * factorial(n-1)
end

function main()
	local w = qtuiloader.load("factorial.ui")
	local function calc()
		local n = w.inputEdit.text:tonumber()
		local r = factorial(n)
		-- both are ok
		w.resultEdit.text = r
		-- w.resultEdit:setText(r)
	end

	qt.connect(w.pushButton,"clicked()", calc)

	w:show()
end

main()
