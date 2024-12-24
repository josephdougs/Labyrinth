extends Node3D

@export var playarea: Node3D

var starting_pos
var reset = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var winbox = get_node("../playarea/Winbox")
	winbox.connect("body_entered", win)
	starting_pos = self.global_position

	
func reset_pos() -> void:
	self.get_child(0).reset_pos()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_killbox_body_entered(body: Node3D) -> void:
	print('killing now')
	playarea.set_dead()
	
func win(body: Node3D) -> void:
	# kind of a hacky way to do this, but it should work here
	if body == self.get_child(0):
		print('you win!!')
		playarea.set_won()
