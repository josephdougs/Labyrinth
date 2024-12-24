extends RigidBody3D

var reset = false
var starting_pos

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	starting_pos = self.global_position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

# moving the ball manually needs to happen here
func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	if reset:
		self.global_position = starting_pos
		self.linear_velocity = Vector3(0,0,0)
		self.angular_velocity = Vector3(0,0,0)
		reset = false
		return
	
	if $"../../playarea/OverlapTestArea".overlaps_body(self):
		print("jump")
		# "jump" the ball up a bit if it sinks below
		self.global_position.y += 1


func reset_pos() -> void:
	reset = true
