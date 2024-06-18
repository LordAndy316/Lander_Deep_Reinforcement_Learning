extends CharacterBody2D



const MAX_THRUST = -10
@onready var player = $"."
var thrust = -1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var fallingtimer
func exp_decay(a,b,decay,dt):
	return (b+(a-b)*exp(-decay*dt))

func _on_ready():
	pass # Replace with function body.

func _physics_process(delta):
	# Add the gravity.
	velocity.y += gravity * delta
	if not is_on_floor() and fallingtimer:
		gravity = 200
	
	# Handle thrust.
	if Input.is_action_pressed("thrust"):
		thrust += thrust * (1-thrust/MAX_THRUST)
		thrust = exp_decay(thrust, MAX_THRUST ,1, delta)
		print("thrust")
	
	velocity += Vector2(0, 0.5).rotated(rotation) * thrust
	thrust = exp_decay(thrust,0,5,delta)
	
	
	
	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("left", "right")
	if direction >0.9:
		player.rotate(-0.05)
	elif direction < -0.9 :
		player.rotate(0.05)
	move_and_slide()

func _landing_mode():
	fallingtimer = true
	print("time to fall")
