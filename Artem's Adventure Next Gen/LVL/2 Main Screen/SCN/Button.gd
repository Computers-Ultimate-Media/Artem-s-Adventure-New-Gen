extends TextureButton

var newline = "\n"

export var text : = ""
export var text_with_effects : = ""

func _ready():
	$RichTextLabel.bbcode_text = newline + text
	pass

