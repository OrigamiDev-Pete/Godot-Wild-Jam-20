extends KinematicBody2D

const MAX_SPEED := 200
const ACCEL := 0.1
const FRICTION := 0.05
const ROTATION_FACTOR := 2
const GRAVITY := 9.7

var motion := Vector2(0,0)

onready var sprite: AnimatedSprite = $AnimatedSprite as AnimatedSprite
onready var ray: RayCast2D = $RayCast2D as RayCast2D
onready var ResetTimer: Timer = $ResetTimer as Timer
onready var IdleTimer: Timer = $IdleTimer as Timer


func _physics_process(delta) -> void:
	gravity()
	get_input()
	motion.y = move_and_slide_with_snap(motion, Vector2(0,50), Vector2.UP, false, 4, deg2rad(46.0)).y


func get_input() -> void:
	var velocity := Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		sprite.flip_h = false
		if sprite.animation != "Roll":
			sprite.play("Roll")
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		sprite.flip_h = true
		if sprite.animation != "Roll":
			sprite.play("Roll")
	
	velocity = velocity.normalized() * MAX_SPEED
	if velocity.length() > 0:
		motion.x = lerp(motion.x, velocity.x, ACCEL)
	else:
		motion.x = lerp(motion.x, 0, FRICTION)
		slope_roll()
		reset_animation()
	if is_on_floor():
#		sprite.frames.set_animation_speed("Roll", int(abs(motion.x/ROTATION_FACTOR)))
		sprite.speed_scale = abs(motion.x/50)


func gravity() -> void:
	if not is_on_floor():
		motion.y += GRAVITY
	else:
		motion.y = 0


func reset_animation() -> void:
	if sprite.get_animation() == "Roll" or sprite.get_animation() == "RollR" and sprite.frame != 1 and ResetTimer.is_stopped():
		if motion.x < 1 and motion.x > -1:
			ResetTimer.start()


func slope_roll() -> void:
	if ray.is_colliding():
		var normal : Vector2 = ray.get_collision_normal()
		var slope_angle : float = rad2deg(acos(normal.dot(Vector2(0, -1))))
		if slope_angle > 0:
			if normal.x < 0:
				motion.x = lerp(motion.x, -10000, 0.001)
				if !sprite.flip_h and sprite.animation != "RollR":
					var last_frame := sprite.frame
					sprite.play("RollR")
					sprite.frame = last_frame - 11
			elif normal.x > 0:
				motion.x = lerp(motion.x, 10000, 0.001)
				if sprite.flip_h and sprite.animation != "RollR":
					sprite.play("RollR")
					sprite.frames.set_animation_speed("RollR", int(abs(motion.x/ROTATION_FACTOR)))
		if slope_angle == 0:
			pass
#			sprite.play("Roll")


func _on_ResetTimer_timeout() -> void:
	if motion.x < 1 and motion.x > -1:
		sprite.speed_scale = 1.0
		sprite.play("Reset", false)
		IdleTimer.start(1)


func _on_IdleTimer_timeout() -> void:
	if motion.x < 1 and motion.x > -1:
		match randi() % 10:
			0, 1, 2, 3, 4, 5:
				sprite.play("Idle0")
			6, 7, 8:
				sprite.play("Idle1")
			9:
				sprite.play("Idle2")
			_:
				continue
		IdleTimer.start(3)
