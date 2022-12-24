extends Control


func _ready():
	self.hide()


func _on_Apply_pressed():
	print("Apply")


func _on_Cancel_pressed():
	print("Cancel")
	self.hide()
