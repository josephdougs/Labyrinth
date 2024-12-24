extends Node3D

var xangle = 0
var zangle = 0
var in_control = false
var showing_welcome = true
var showing_dead = false
var showing_won = false
var starting_global_position: Vector3

# let's just put the main logic here because why not, right?
func _ready() -> void:
	$"../Control/WelcomeLabel".set_visible(true)
	starting_global_position = $"../ball".global_position
	pass # Replace with function body.

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pressR"):
		print('reset')
		# here we reset the game
		showing_dead = false
		showing_won = false
		showing_welcome = true
		in_control = false
		self.global_rotation_degrees = Vector3(0,0,0)
		print(starting_global_position)
		$"../ball".reset_pos()
		return

	if showing_won:
		$"../Control/YouWon".set_visible(true)
		# prevent other actions or dying while also having won
		return
	else:
		$"../Control/YouWon".set_visible(false)
	
	if showing_dead:
		$"../Control/YouLose".set_visible(true)
	else:
		$"../Control/YouLose".set_visible(false)
		
	# turn off welcome screen when done
	if in_control:
		showing_welcome = false
		
	if showing_welcome:
		$"../Control/WelcomeLabel".set_visible(true)
	else:
		$"../Control/WelcomeLabel".set_visible(false)
	
	if in_control:
		self.global_rotation_degrees = Vector3(xangle, 0, zangle)
		
func set_won() -> void:
	showing_won = true

func set_dead() -> void:
	showing_dead = true

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1:
			if event.is_pressed():
				in_control = !in_control
		
	if event is InputEventMouseMotion:
		# Print the size of the viewport.
		# print("Viewport Resolution is: ", get_viewport().get_visible_rect().size)
		
		var size = get_viewport().get_visible_rect().size
		var x_size = size.x
		var y_size = size.y
		
		var x_pos = event.position.x
		var y_pos = event.position.y
		
		xangle = get_angle(y_pos, y_size)
		zangle = -1 * get_angle(x_pos, x_size)
		
		
	
	
func get_angle(position: int, max_possible_position: int) -> float:
	# use 15 percent as max angle
	var min_position = 0.2 * max_possible_position
	var max_position = 0.8 * max_possible_position
	var difference = max_position - min_position
	
	if position <= min_position:
		return -15.0
	if position >= max_position:
		return 15.0
	
	var adjusted_pos = position - min_position
	var ratio = adjusted_pos / difference
	return (ratio * 30) - 15
	
