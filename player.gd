extends CharacterBody2D


const SPEED = 50
const MAX_THRUST = -50
@onready var player = $"."
var thrust = -5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var fallingtimer
func exp_decay(a,b,decay,dt):
	return (b+(a-b)*exp(-decay*dt))

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor() and fallingtimer:
		velocity.y += gravity * delta
	
	# Handle jump.
	if Input.is_action_pressed("thrust"):
		thrust += thrust * (1-thrust/MAX_THRUST)
		thrust = exp_decay(thrust, MAX_THRUST ,1, delta)
		print(thrust)
		velocity.y = thrust
	exp_decay(thrust,0,1,delta)
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		player.rotate(-0.1)
	else:
		player.rotate(0.1)

	


func _on_ready():
	pass # Replace with function body.

func _landing_mode():
	fallingtimer = true
