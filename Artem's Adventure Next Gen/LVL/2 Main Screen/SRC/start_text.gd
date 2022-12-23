tool
extends RichTextEffect

class_name Red_alert

var bbcode = "RA"

func _process_custom_fx(char_fx):
	char_fx.color.a = 1+sin(char_fx.elapsed_time*2)
	return true
