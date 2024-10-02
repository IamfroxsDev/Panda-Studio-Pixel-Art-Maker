extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GlobalInformation.selected_color == color:
		modulate = Color("#ffffff")
	else:
		modulate = Color("#eeeeee")


func _on_gui_input(event):
	if event is InputEventScreenTouch:
		GlobalInformation.selected_color = color
		get_tree().get_root().get_child(1).get_child(1).color_picker.color = color
