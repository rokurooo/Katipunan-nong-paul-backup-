extends CharacterBody2D

@export var max_health: int = 100
@export var speed: float = 150.0
@export var attack_range: float = 100.0
@export var attack_damage: int = 20
@export var attack_cooldown: float = 1.2

@onready var timer: Timer = Timer.new()
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var sfx_hit: AudioStreamPlayer2D = $sfx_hit
@onready var sfx_death: AudioStreamPlayer2D = $sfx_death

var health: int = max_health
var is_dead := false
var current_target: Node2D = null

func _ready():
	add_to_group("enemies")
	add_child(timer)
	timer.one_shot = true
	timer.timeout.connect(func(): pass) 
	
	pick_random_target()

func pick_random_target():
	var targets = get_tree().get_nodes_in_group("aggro_target")
	if targets.is_empty():
		return
	
	current_target = targets[randi() % targets.size()]
	print(name, " randomly targeted: ", current_target.name)

func _physics_process(_delta):
	if is_dead:
		velocity = Vector2.ZERO
		return
	
	if not current_target or not is_instance_valid(current_target):
		pick_random_target()
		return
	
	var dist = global_position.distance_to(current_target.global_position)
	
	if dist > attack_range:
		# CHASE
		var dir = global_position.direction_to(current_target.global_position)
		velocity = dir * speed
		sprite.play("Walk")
		sprite.flip_h = dir.x < 0
	else:
		velocity = Vector2.ZERO
		sprite.flip_h = global_position.x > current_target.global_position.x
		
		if timer.is_stopped():
			sprite.play("Attack")
			sfx_hit.play()
			if current_target.has_method("take_damage"):
				current_target.take_damage(attack_damage)
			timer.start(attack_cooldown)
		else:
			if sprite.animation != "Attack" or sprite.frame == 0:
				sprite.play("Attack")
				sprite.frame = 2 

	move_and_slide()

func take_damage(amount: int):
	if is_dead: return
	
	health -= amount
	modulate = Color.RED
	get_tree().create_timer(0.2).timeout.connect(func(): modulate = Color.WHITE)
	print("Enemy HP: ", health)
	
	if health <= 0:
		die()

func die():
	is_dead = true
	sprite.play("Death")
	sfx_death.play()
	await sprite.animation_finished
	queue_free()
