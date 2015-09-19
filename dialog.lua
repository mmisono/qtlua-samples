require "qt"
require "qtgui"
require "qtwidget"
require "qtuiloader"

function main()
	local w = qtuiloader.load("dummy.ui")
	qt.connect(w.pushButton, "clicked()",
		function()
			local dialog = qtuiloader.load("dialog.ui",w)	
			dialog:exec()
			res = dialog:result()
			print("result:",res)
			if res == 1 then
				qt.qApp:quit()
			end
		end)
	w:show()
end


main()
