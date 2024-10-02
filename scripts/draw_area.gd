extends Control


@onready var bg_layer = $bg_layer
@onready var canvas = $layer

func _input(event):
	if event is InputEventScreenTouch and event.is_pressed():
		var local_pos = canvas.get_local_mouse_position()
		draw_pixel(local_pos)
	elif event is InputEventScreenDrag:
		var local_pos = canvas.get_local_mouse_position()
		draw_pixel(local_pos)
	elif event is InputEventGesture:
		hancle_pinch_gesture(event)
	
	# Zoom con la rueda del mouse
	if event is InputEventMouseButton:
		if event.is_action_pressed("zoom_in") or event.is_action_pressed("zoom_out"):
			handle_mouse_wheel(event)
	
	if Input.is_action_just_pressed("ui_accept"):
		export_image("res:/images.png")


func hancle_pinch_gesture(event):
	# event.magnitude indica el cambio de distancia entre los dos dedos
	# Puedes ajustar la sensibilidad del zoom según sea necesario
	canvas.scale *= event.factor
	bg_layer.scale *= event.factor

func handle_mouse_wheel(event):
	var zoom_factor = 1.1  # Puedes ajustar este valor según la sensibilidad que desees
	if event.button_index == MOUSE_BUTTON_WHEEL_UP:
		print("Zoom_in")
		# Si se mueve la rueda hacia arriba, hacer zoom in
		zoom_at_position(event.position, zoom_factor)
		#bg_layer.scale *= zoom_factor
	elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
		print("Zoom_out")
		# Si se mueve la rueda hacia abajo, hacer zoom out
		zoom_at_position(event.position, 1/ zoom_factor)
		#canvas.scale /= zoom_factor
		#bg_layer.scale /= zoom_factor

func zoom_at_position(mouse_position: Vector2, zoom_factor: float):
	# Convertir la posición del mouse al sistema de coordenadas global del canvas
	var canvas_mouse_pos = (mouse_position - canvas.position) / canvas.scale
	
	# Aplicar el zoom
	canvas.scale *= zoom_factor
	bg_layer.scale *= zoom_factor
	
	# Nueva posición del mouse después del zoom
	var new_canvas_mouse_pos = (mouse_position - canvas.position) / canvas.scale
	
	# Ajustar la posición del canvas para mantener el mouse en el mismo lugar visualmente
	var offset = new_canvas_mouse_pos - canvas_mouse_pos
	canvas.position -= -offset * canvas.scale
	bg_layer.position -= -offset * bg_layer.scale


# Called when the node enters the scene tree for the first time.
func _ready():
	var img = Image.create(GlobalInformation.dimensions.x,GlobalInformation.dimensions.y,false,Image.FORMAT_RGBA8) # Crear una imagen con las dimensiones.
	img.fill(Color.WHITE) # Rellenar de blanco
	
	var bg_img = Image.create(GlobalInformation.dimensions.x,GlobalInformation.dimensions.y,false,Image.FORMAT_RGBA8)
	bg_img.fill(Color("#0000007c"))
	
	var texture = ImageTexture.create_from_image(img)
	canvas.texture = texture
	
	var bg_texture = ImageTexture.create_from_image(bg_img)
	bg_layer.texture = bg_texture
	await 100
	
	# Canvas Pivot
	canvas.pivot_offset.x = GlobalInformation.dimensions.x / 2
	canvas.pivot_offset.y = GlobalInformation.dimensions.y / 2
	
	# Background Pivot
	bg_layer.pivot_offset.x = GlobalInformation.dimensions.x / 2
	bg_layer.pivot_offset.y = GlobalInformation.dimensions.y / 2
	
	await 100
	
	if GlobalInformation.dimensions.x <= 32 and GlobalInformation.dimensions.y <= 32:
		canvas.scale = Vector2(20,20)
	elif GlobalInformation.dimensions.x <= 64 and GlobalInformation.dimensions.y <= 64:
		canvas.scale = Vector2(10,10)
	elif GlobalInformation.dimensions.x <= 125 and GlobalInformation.dimensions.y <= 125:
		canvas.scale = Vector2(5,5)
	
	bg_layer.scale = canvas.scale
	

func draw_pixel(position: Vector2):
	var img = canvas.texture.get_image()
	
	var x = int(position.x)
	var y = int(position.y)
	

	# Asegurarse de que las coordenadas estén dentro del rango de la imagen
	if x >= 0 and y >= 0 and x < img.get_width() and y < img.get_height():
		#img.set_pixel(x, y, GlobalInformation.selected_color)  # Establecer el color del píxel.
		
		
		#match  GlobalInformation.tool:
			#"symmetry":
				#print("Simetria")
			#"fill":
				#print("Rellenar")
			#_:
				#print("Lapiz")
		
		if GlobalInformation.tool == "symmetry":
			img.set_pixel(x, y, GlobalInformation.selected_color)  # Establecer el color del píxel.
			img.set_pixel((GlobalInformation.dimensions.x - x - 1), y, GlobalInformation.selected_color)  # Establecer el color del píxel.
		elif GlobalInformation.tool == "fill":
			flood_fill(Vector2(x,y), GlobalInformation.selected_color, img)
		elif GlobalInformation.tool == "erase":
			img.set_pixel(x, y, Color.TRANSPARENT)  # Remover Pixel (Volverlo Transparente)
		elif GlobalInformation.tool == "erase_bucket":
			flood_fill(Vector2(x,y), Color.TRANSPARENT, img)  # Remover Pixel usando Fill (Volverlo Transparente)
		else:
			img.set_pixel(x, y, GlobalInformation.selected_color)  # Establecer el color del píxel.
	
	var texture = ImageTexture.create_from_image(img)
	canvas.texture = texture
	canvas.queue_redraw()


# Flood Fill
func flood_fill(start_position, fill_color, _canvas):
	var stack = []
	stack.append(start_position)
	
	var start_color = _canvas.get_pixelv(start_position)
	
	if start_color == fill_color:
		return
	
	while stack.size() > 0:
		var pos = stack.pop_back()
		var current_color = _canvas.get_pixelv(pos)
		
		if current_color == start_color:
			_canvas.set_pixelv(pos, fill_color)
			
			if pos.x > 0:
				stack.append(Vector2(pos.x - 1, pos.y))
			if pos.x < GlobalInformation.dimensions.x - 1:
				stack.append(Vector2(pos.x + 1, pos.y))
			if pos.y > 0:
				stack.append(Vector2(pos.x, pos.y - 1))
			if pos.y < GlobalInformation.dimensions.y - 1:
				stack.append(Vector2(pos.x, pos.y + 1))


func export_image(path: String):
	if canvas.texture:
		var img = canvas.texture.get_image()
		var file = FileAccess.open(path, FileAccess.WRITE)
		if file:
			img.save_png(file.get_path())
			file.close()
			print("imagen en: " + path)
		else:
			print("Error al guardar")
	else:
		print("No textura")


func _on_btn_save_pressed():
	export_image(OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS) + "/" + GlobalInformation.project_name + ".png")
