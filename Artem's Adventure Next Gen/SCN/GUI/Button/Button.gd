extends TextureButton


var newline = "\n"
var space = " "

export var text : = ""
export var text_with_effects : = ""

func _ready():
	$RichTextLabel.bbcode_text = space + text + space
	pass
	

func _on_TextureButton_mouse_entered():
	$RichTextLabel.bbcode_text = text_with_effects


func _on_TextureButton_mouse_exited():
	$RichTextLabel.bbcode_text = space + text + space
