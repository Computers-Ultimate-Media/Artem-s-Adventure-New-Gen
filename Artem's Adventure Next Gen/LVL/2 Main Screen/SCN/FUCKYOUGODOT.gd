extends TextureButton


var newline = "\n"

export var text : = ""
export var text_with_effects : = ""

func _ready():
	$RichTextLabel.bbcode_text = newline + text
	pass
	

func _on_TextureButton_mouse_entered():
	$RichTextLabel.bbcode_text = newline + text_with_effects


func _on_TextureButton_mouse_exited():
	$RichTextLabel.bbcode_text = newline + text
