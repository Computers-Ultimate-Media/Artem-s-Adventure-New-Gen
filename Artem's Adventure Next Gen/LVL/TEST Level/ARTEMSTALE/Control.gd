extends Control

export var dialogPath = ""
export(float) var textSpeed = 0.05

var dialog

var phraseNum = 0
var finished = false

var once_upon_a_time = load("res://RES/music/undertale_001. Once Upon a Time.mp3")

func _ready():
	
	MusicController.play_music(once_upon_a_time)
	
	$Timer.wait_time = textSpeed
	dialog = getDialog()
	assert (dialog, "Dialog not found")
	nextPhrase()
	#$TextureRect/AnimationPlayer.play_backwards("boner")  # !!!

func _process(_delta):
	#if Input.is_action_just_pressed("ui_accept"):
	if finished:
		#$TextureRect/AnimationPlayer.play("boner") # !!!
		#yield(get_tree().create_timer(2), "timeout")
		nextPhrase()

func getDialog() -> Array:
	var f = File.new()
	assert(f.file_exists(dialogPath), "File path does not exist")
	
	f.open(dialogPath, File.READ)
	var json = f.get_as_text()
	
	var output = parse_json(json)
	
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return[]

func nextPhrase() -> void:
	
	$TextureRect/AnimationPlayer.play_backwards("boner")
	
	if phraseNum >= len(dialog):
		yield(get_tree().create_timer(0.5), "timeout")
		queue_free()
		return
	
	finished = false
	
	$RichTextLabel2.bbcode_text = dialog[phraseNum]["Name"]
	$RichTextLabel.bbcode_text = dialog[phraseNum]["Text"]
	
	var f = File.new()
	var img = "res://LVL/TEST Level/ARTEMSTALE/" + dialog[phraseNum]["Name"] + dialog[phraseNum]["Emotion"] + ".png"
	if f.file_exists(img):
		$TextureRect.texture = load(img)
	else: $TextureRect.texture = null
	
	$RichTextLabel.visible_characters = 1 
	
	while $RichTextLabel.visible_characters < len($RichTextLabel.text):
		$RichTextLabel.visible_characters += 1
		
		$Timer.start()
		yield($Timer, "timeout")
	
	
	yield(get_tree().create_timer(2), "timeout")
	$TextureRect/AnimationPlayer.play("boner")
	yield(get_tree().create_timer(1), "timeout")
	finished = true
	phraseNum += 1
	return
