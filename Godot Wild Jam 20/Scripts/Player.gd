extends KinematicBody2D

signal player_changed

const MAX_SPEED := 400
const ACCEL := 0.05
const FRICTION := 0.05
const ROTATION_FACTOR := 2
const GRAVITY := 9.7

export(int, -100, 0) var jump_height := -1
export var active := false

var motion := Vector2(0,0)
var can_jump := true
var jump_ready := true
var is_jumping := false


onready var sprite: AnimatedSprite = $AnimatedSprite as AnimatedSprite
onready var Cam: Camera2D = $Camera2D as Camera2D
onready var Downcast: RayCast2D = $Downcast as RayCast2D
onready var ResetTimer: Timer = $Timers/ResetTimer as Timer
onready var IdleTimer: Timer = $Timers/IdleTimer as Timer
onready var CoyoteTimer: Timer = $Timers/CoyoteTimer as Timer
onready var JumpTimer: Timer = $Timers/JumpTimer as Timer

func _ready() -> void:
	if active:
		Cam.current = true

func _physics_process(delta) -> void:
	gravity()
	get_input()
	stick_to_surface()
#	motion = move_and_slide_with_snap(motion, Vector2(0,20), Vector2.UP, false, 4, deg2rad(46.0))
#	Cam.smoothing_speed = abs(motion.x/30)
	motion = move_and_slide(motion, Vector2.UP)
	_coyote_check()



func get_input() -> void:
	var velocity := Vector2.ZERO
	if active:
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
		if Input.is_action_pressed("ui_select") or Input.is_action_pressed("ui_up"):
			jump()
		if Input.is_action_just_released("ui_select") or Input.is_action_just_released("ui_up"):
			jump_ready = true
	
	velocity = velocity.normalized() * MAX_SPEED
	if velocity.length() > 0 and is_on_floor():
		motion.x = lerp(motion.x, velocity.x, ACCEL)
	elif velocity.length() > 0 and is_on_ceiling():
		motion.x = lerp(motion.x, -velocity.x, ACCEL)
	elif velocity.length() > 0 and Downcast.rotation == 0:
		motion.x = lerp(motion.x, velocity.x/2, ACCEL)
	else:
		if !is_on_floor():
			motion.x = lerp(motion.x, 0, 0.01)
		else:
			motion.x = lerp(motion.x, 0, FRICTION)
			slope_roll()
			reset_animation()
	if is_on_floor():
		if sprite.animation == "Roll" or sprite.animation =="RollR":
			sprite.speed_scale = abs(motion.x/50)
		else:
			sprite.speed_scale = 1.0


func jump():
	if can_jump and jump_ready:
		can_jump = false
		is_jumping = true
		jump_ready = false
		$JumpTimer.start()
		motion.y = -50
	if is_jumping:
		motion.y += jump_height


func _coyote_check():
	if !is_on_floor():
		if CoyoteTimer.is_stopped():
			CoyoteTimer.start()
	else:
		can_jump = true


func gravity() -> void:
	motion.y += GRAVITY


func reset_animation() -> void:
	if sprite.animation == "Roll" or sprite.animation == "RollR":
		if motion.x < 1.5 and motion.x > -1.5:
			if ResetTimer.is_stopped():
				ResetTimer.start()


func slope_roll() -> void:
	if Downcast.is_colliding():
		var normal : Vector2 = Downcast.get_collision_normal()
		var slope_angle : float = rad2deg(acos(normal.dot(Vector2(0, -1))))
		if slope_angle > 0:
			if normal.x < 0:
				motion.x = lerp(motion.x, -100000, 0.0001)
				if !sprite.flip_h and sprite.animation != "RollR":
					var last_frame := sprite.frame
					sprite.play("RollR")
					sprite.frame = last_frame - 5
			elif normal.x > 0:
				motion.x = lerp(motion.x, 100000, 0.0001)
				if sprite.flip_h and sprite.animation != "RollR":
					var last_frame := sprite.frame
					sprite.play("RollR")
					sprite.frame = last_frame - 5


func stick_to_surface() -> void:
	if get_slide_count() > 0:
		var normal = get_slide_collision(0).normal
		var angle = rad2deg(normal.angle_to(Vector2(0, -1)))
		Downcast.rotation_degrees = -angle
	else:
		Downcast.rotation_degrees = 0


func change_player() -> void:
	active = true
	Cam.current = true
	emit_signal("player_changed")


func camera_lock() -> void:
	Cam.camera_lock()


func _on_ResetTimer_timeout() -> void:
	if motion.x < 1.5 and motion.x > -1.5:
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
		IdleTimer.start(4)


func _on_CoyoteTimer_timeout() -> void:
	can_jump = false


func _on_JumpTimer_timeout() -> void:
	is_jumping = false


func _on_Area2D_area_entered(area: Area2D) -> void:
	if !active:
		var last_player: KinematicBody2D = area.get_parent()
		Cam.position = last_player.position - position
		change_player()
		Cam.move_to_new_player()
		motion.x = last_player.motion.x
		sprite.play("Roll")
	else:
		active = false
		Cam.current = false
		sprite.play("Hit")
		motion.x = motion.x/2
