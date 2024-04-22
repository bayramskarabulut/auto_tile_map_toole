extends Node2D

var coords_background =  [
	
]


var background_array: Array
var background_array_x: Array

var background_canvas_size = 32
var background_box_size = 20
var bbs = background_box_size

var back_color_grie : Color = Color("999999")
var back_color_white : Color = Color("e5e5e5")

var red : Color = Color(1, 0, 0)

var coords_background_color : Color

func _ready():
	for x in range(background_canvas_size):
		background_array_x = []
		for y in range(background_canvas_size):
			coords_background = []
			for cord in [Vector2(bbs*x, bbs*y), Vector2(bbs+bbs*x, bbs*y), Vector2(bbs+bbs*x, bbs+bbs*y), Vector2(bbs*x, bbs+bbs*y)]:
				coords_background.append(cord)
			if (x+y)%2 == 0:
				coords_background_color = back_color_grie
			else:
				coords_background_color = back_color_white
			background_array_x.append([coords_background, coords_background_color])
		background_array.append(background_array_x)


func _draw():
	
	for x in range(background_array.size()):
		for y in range(background_array[x].size()):
			if (x+y)%2 == 0:
				draw_polygon(background_array[x][y][0], [ background_array[x][y][1] ])
			else:
				draw_polygon(background_array[x][y][0], [ background_array[x][y][1] ])

var mouse_pos

func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		mouse_pos = get_global_mouse_position()
		var x = int(mouse_pos.x/background_box_size)
		var y = int(mouse_pos.y/background_box_size)
		if x < background_canvas_size and 0 < x and y < background_canvas_size and 0 < y:
			background_array[x][y][1] = red
			queue_redraw()
		
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		mouse_pos = get_global_mouse_position()
		var x = int(mouse_pos.x/background_box_size)%background_canvas_size
		var y = int(mouse_pos.y/background_box_size)%background_canvas_size
		if (x+y)%2 == 0:
			background_array[x][y][1] = back_color_grie
		else:
			background_array[x][y][1] = back_color_white
		queue_redraw()
