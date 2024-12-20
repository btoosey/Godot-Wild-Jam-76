extends Control

@onready var money_label: Label = $MoneyLabel


func _process(delta: float) -> void:
	money_label.text = str(PlayerData.player_money)
