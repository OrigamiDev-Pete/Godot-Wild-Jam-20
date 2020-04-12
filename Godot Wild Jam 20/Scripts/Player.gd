extends KinematicBody2D

const MAX_SPEED := 400
const ACCEL := 10
const DECEL := 5
const ROTATION_FACTOR := 5

var motion := Vector2()

onready var sprite: AnimatedSprite = $AnimatedSprite as AnimatedSprite


func _physics_process(delta):
	get_input()
	move_and_slide_with_snap(motion, Vector2(0,0))

func get_input():
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + ACCEL, MAX_SPEED)
		sprite.flip_h = false
		sprite.play("Roll")
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x - ACCEL, -MAX_SPEED)
		sprite.flip_h = true
		sprite.play("Roll")
#		if motion.x < 0:
#			sprite.play("Roll", true)
#		sprite.frames.set_animation_speed("Roll", -motion.x/ROTATION_FACTOR+5)
	else:
		if motion.x < 0:
			motion.x = min(motion.x + DECEL, 0)
			sprite.frames.set_animation_speed("Roll", -motion.x/ROTATION_FACTOR)
		elif motion.x > 0:
			motion.x = max(motion.x + -DECEL, 0)
			sprite.frames.set_animation_speed("Roll", motion.x/ROTATION_FACTOR)
		if motion.x == 0:
			sprite.stop()
	sprite.frames.set_animation_speed("Roll", abs(motion.x/ROTATION_FACTOR+10))
#		motion.x = lerp(motion.x, 0, 0.05)
	
#	motion = motion.normalized() * speed
