extends Label

var time = 0
var running = true

func _process(delta):
	if running:
		time += delta
	text = "%0.3f" % time

func stop_stopwatch():
	running = false
