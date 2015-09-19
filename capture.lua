require "camera"
require "qt"
require "qtgui"
require "qtwidget"
require "qtuiloader"
require "qttorch"
require "xlua"

function capture_image(camera)
	local frame = camera:forward()
	input = image.toDisplayTensor{input=frame}
	qtimg = qt.QImage.fromTensor(input)

	return qtimg
end

function main()
	local w = qtuiloader.load("capture.ui")
	local painter = qt.QtLuaPainter(w.frame)
	local camera = image.Camera{idx=0,width=320,height=240}
	local status = 1
	local timer = qt.QTimer()
	timer.singleShot = true

	qt.connect(w.captureButton, 'clicked()',
		function()
			if status == 1 then
				w.captureButton.text = "Restart"
				w.saveButton:setEnabled(true)
				status = 0
			else
				w.captureButton.text = "Capture"
				w.saveButton:setEnabled(false)
				status = 1
			end
		end)

	qt.connect(w.saveButton, 'clicked()',
		function()
			local filepath = qt.QFileDialog.getSaveFileName(w):tostring()
			if filepath ~= "" then
				-- save image
				painter:write(filepath)
				print("save image at: ",filepath)
			end
		end)

	qt.connect(timer, 'timeout()',
		function ()
			if status == 1 then
				local img = capture_image(camera)
				painter:gbegin()
				painter:image(0,0,img)
				painter:gend()
			end
			timer:start(1000/100)
		end)
	timer:start(1000/100)

	w:show()
end

main()
