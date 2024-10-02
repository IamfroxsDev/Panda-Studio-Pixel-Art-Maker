extends Control

@onready var project_name = $Panel/HBoxContainer3/TextEditName
@onready var width = $Panel/HBoxContainer2/TextWidth
@onready var height = $Panel/HBoxContainer2/TextHeight

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Este método filtra el texto para permitir solo números.
func filter_text(input_text: String) -> String:
	var result := ""
	for char in input_text:
		if char.is_valid_int():
			result = result + char
	
	return result

func _on_text_width_text_changed():
	#$Panel/HBoxContainer2/TextWidth.text = filter_text($Panel/HBoxContainer2/TextWidth.text)
	pass


func _on_text_height_text_changed():
	pass # Replace with function body.


func _on_btn_accept_pressed():
	
	if project_name.text == "":
		print("no name")
		return
	elif (width.text == "") or (height.text == ""):
		print("rellene w or h")
		return
	
	GlobalInformation.project_name = project_name.text
	GlobalInformation.dimensions = Vector2i(int($Panel/HBoxContainer2/TextWidth.text), int($Panel/HBoxContainer2/TextHeight.text))
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_btn_cancel_pressed():
	pass # Replace with function body.
