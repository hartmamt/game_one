extends Area2D
class_name NPCBase

@export var npc_name: String = "NPC"
@export var npc_type: String = "generic"  # blacksmith, archivist, merchant, warden_spirit
@export var dialogue_lines: Array[String] = []

var player_nearby: bool = false
var is_interacting: bool = false

@onready var sprite = $AnimatedSprite2D
@onready var interaction_prompt = $InteractionPrompt

signal interaction_started(npc: NPCBase)
signal interaction_ended()

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	interaction_prompt.visible = false

func _process(delta):
	if player_nearby and Input.is_action_just_pressed("interact") and not is_interacting:
		start_interaction()

func _on_body_entered(body):
	if body is Player:
		player_nearby = true
		interaction_prompt.visible = true

func _on_body_exited(body):
	if body is Player:
		player_nearby = false
		interaction_prompt.visible = false

func start_interaction():
	is_interacting = true
	emit_signal("interaction_started", self)
	EventBus.emit_signal("npc_interaction_started", self)

	# Open appropriate UI based on NPC type
	match npc_type:
		"blacksmith":
			_open_blacksmith_menu()
		"archivist":
			_open_archivist_menu()
		"merchant":
			_open_merchant_menu()
		"warden_spirit":
			_open_warden_dialogue()

func end_interaction():
	is_interacting = false
	emit_signal("interaction_ended")
	EventBus.emit_signal("npc_interaction_ended")

func _open_blacksmith_menu():
	print("Opening Blacksmith menu...")
	# TODO: Implement upgrade/reforge UI

func _open_archivist_menu():
	print("Opening Archivist grimoire...")
	# TODO: Implement lore/grimoire UI

func _open_merchant_menu():
	print("Opening Merchant shop...")
	# TODO: Implement shop UI

func _open_warden_dialogue():
	print("Speaking with Warden's Spirit...")
	# TODO: Implement dialogue system
