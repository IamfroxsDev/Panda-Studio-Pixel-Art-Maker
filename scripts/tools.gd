extends Control

@onready var palette_selector = $ColorPalettes/ContainerPalette/PaletteOptions/PaletteSelector
@onready var palette = $ColorPalettes/ContainerPalette/ScrollContainer/Palette
@onready var color_picker = $ColorPalettes/ContainerPalette/PaletteOptions/ColorPickerButton

@onready var btn_save: TextureButton = $BottomTool/BtnSave
@onready var btn_bucket: TextureButton = $BottomTool/BtnBucket
@onready var btn_symmetry: TextureButton = $BottomTool/BtnSymmetry
@onready var btn_erase: TextureButton = $BottomTool/BtnErase
@onready var btn_pencil: TextureButton = $BottomTool/BtnPencil
@onready var btn_erase_bucket: TextureButton = $BottomTool/BtnEraseBucket


var color_btn = preload("res://scenes/color.tscn")



# Called when the node enters the scene tree for the first time.
func _ready():
	add_colors(palette_selector.selected)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GlobalInformation.tool == "pencil":
		btn_pencil.modulate = Color("#9b9b9b")
		btn_erase.modulate = Color("#ffffff")
		btn_symmetry.modulate = Color("#ffffff")
		btn_bucket.modulate = Color("#ffffff")
		btn_erase_bucket.modulate = Color("#ffffff")
	elif GlobalInformation.tool == "fill":
		btn_pencil.modulate = Color("#ffffff")
		btn_erase.modulate = Color("#ffffff")
		btn_symmetry.modulate = Color("#ffffff")
		btn_bucket.modulate = Color("#9b9b9b")
		btn_erase_bucket.modulate = Color("#ffffff")
	elif GlobalInformation.tool == "symmetry":
		btn_pencil.modulate = Color("#ffffff")
		btn_erase.modulate = Color("#ffffff")
		btn_symmetry.modulate = Color("#9b9b9b")
		btn_bucket.modulate = Color("#ffffff")
		btn_erase_bucket.modulate = Color("#ffffff")
	elif GlobalInformation.tool == "erase":
		btn_pencil.modulate = Color("#ffffff")
		btn_erase.modulate = Color("#9b9b9b")
		btn_symmetry.modulate = Color("#ffffff")
		btn_bucket.modulate = Color("#ffffff")
		btn_erase_bucket.modulate = Color("#ffffff")
	elif GlobalInformation.tool == "erase_bucket":
		btn_pencil.modulate = Color("#ffffff")
		btn_erase.modulate = Color("#ffffff")
		btn_symmetry.modulate = Color("#ffffff")
		btn_bucket.modulate = Color("#ffffff")
		btn_erase_bucket.modulate = Color("#9b9b9b")

func add_colors(index):
	
	var key : String
	
	match index:
		0:
			key = "default"
		1:
			key = "gray"
		2:
			key = "purple"
		3:
			key = "green"
		4:
			key = "red"
		5:
			key = "blue"
	
	while palette.get_child_count() > 0:
		var child = palette.get_child(0)
		palette.remove_child(child)
		child.queue_free()
	
	for color in GlobalInformation.colorPalettes.get(key):
		var color_rect = color_btn.instantiate()
		color_rect.size_flags_horizontal = SIZE_EXPAND_FILL
		color_rect.size_flags_vertical = SIZE_EXPAND_FILL
		color_rect.color = color
		palette.add_child(color_rect)


func _on_palette_selector_item_selected(index):
	add_colors(index)


func _on_color_picker_button_color_changed(color):
	GlobalInformation.selected_color = color


func _on_color_picker_button_button_up():
	GlobalInformation.selected_color = color_picker.color


func _on_btn_pencil_button_up():
	GlobalInformation.tool = "pencil"


func _on_btn_bucket_button_up():
	GlobalInformation.tool = "fill"


func _on_btn_symmetry_button_up():
	GlobalInformation.tool = "symmetry"


func _on_btn_erase_button_up():
	GlobalInformation.tool = "erase"


func _on_btn_erase_bucket_button_up() -> void:
	GlobalInformation.tool = "erase_bucket"
