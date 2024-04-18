extends KinematicBody
# local export variables
export var speed = 14
export var jump_impulse = 20.0
export var gravity = 0.1
export var camera_sensitivity_horizontal = 0.01
export var camera_sensitivity_vertical = 0.01

var velocity = Vector3.ZERO
var acceleration_due_to_gravity = 1

func _physics_process(delta):
	# Walking
	var direction = Vector3.ZERO
	if Input.is_action_pressed("move_right"):
		direction += transform.basis.x.normalized()
	if Input.is_action_pressed("move_left"):
		direction += -transform.basis.x.normalized()
	if Input.is_action_pressed("move_forward"):
		direction += -transform.basis.z.normalized()
	if Input.is_action_pressed("move_backward"):
		direction += transform.basis.z.normalized()
	transform = transform.orthonormalized()
	direction = direction.normalized() * speed
	velocity.x = direction.x
	velocity.z = direction.z
	
	# Jumping
	if is_on_floor():
		acceleration_due_to_gravity = 1
		if Input.is_action_pressed("jump"):
			velocity.y = jump_impulse
	else:
		velocity.y -= gravity * acceleration_due_to_gravity
		acceleration_due_to_gravity += 0.3
		#print("gravity is ", acceleration_due_to_gravity)
	
	velocity = move_and_slide(velocity, Vector3.UP)


func _input(event):
	# Camera movement
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x * camera_sensitivity_horizontal
		rotation.x -= event.relative.y * camera_sensitivity_vertical
		rotation.x = clamp(rotation.x, deg2rad(-80), deg2rad(90))
		#transform = transform.orthonormalized()
		
