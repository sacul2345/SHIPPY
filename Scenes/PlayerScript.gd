extends RigidBody3D

@export var camera : Camera3D
@export var groundCast : RayCast3D

const SENS_MULTI = .005

var inputDirection : Vector2
var moveVector : Vector3

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		camera.rotation.y -= event.relative.x * SENS_MULTI
		camera.rotation.x -= event.relative.y * SENS_MULTI
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))

func _physics_process(delta):
	inputDirection = Input.get_vector("foward","backward","strafeLeft","strafeRight")
	moveVector = (camera.transform.basis * Vector3(inputDirection.y,0,inputDirection.x)).normalized()
	
	if isOnGround():
		apply_impulse(Vector3(moveVector.x,0,moveVector.z)) 

func isOnGround():
	if groundCast.is_colliding():
		return true
	else:
		return false
