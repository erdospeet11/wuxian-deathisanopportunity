extends CharacterBody3D
class_name Player

const SPEED = 7.0
const JUMP_VELOCITY = 4.5

const MOUSE_SENSITIVITY = 0.001
const CAMERA_X_ROT_MIN = -60
const CAMERA_X_ROT_MAX = 60
const CAMERA_SMOOTHING = 8.0

@onready var spring_arm = $SpringArm3D
@onready var camera = $SpringArm3D/Camera3D
@onready var mesh = $"Sekiro_ 2_8"

@onready var debug_console: CanvasLayer = $DebugConsole

var target_rotation_y = 0.0
var target_camera_x_rotation = 0.0

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		target_rotation_y -= event.relative.x * MOUSE_SENSITIVITY
		
		target_camera_x_rotation -= event.relative.y * MOUSE_SENSITIVITY
		target_camera_x_rotation = clamp(target_camera_x_rotation, deg_to_rad(CAMERA_X_ROT_MIN), deg_to_rad(CAMERA_X_ROT_MAX))

func _process(_delta: float) -> void:
	if debug_console.visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if Input.is_action_just_pressed("debug"):
		debug_console.visible = !debug_console.visible

func _physics_process(delta: float) -> void:
	# Apply camera rotation to SpringArm only (not the whole character body)
	spring_arm.rotation.y = lerp_angle(spring_arm.rotation.y, target_rotation_y, CAMERA_SMOOTHING * delta)
	spring_arm.rotation.x = lerp_angle(spring_arm.rotation.x, target_camera_x_rotation, CAMERA_SMOOTHING * delta)
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("right", "left", "backward", "forward")
	# Get camera's forward direction for movement relative to camera
	var cam_forward = -spring_arm.global_transform.basis.z
	var cam_right = spring_arm.global_transform.basis.x
	cam_forward.y = 0
	cam_right.y = 0
	cam_forward = cam_forward.normalized()
	cam_right = cam_right.normalized()
	
	var direction: Vector3 = (cam_right * input_dir.x + cam_forward * input_dir.y).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		# Rotate mesh to face movement direction
		mesh.rotation.y = lerp_angle(mesh.rotation.y, atan2(-direction.x, -direction.z), 10.0 * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
