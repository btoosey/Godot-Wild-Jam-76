class_name WorldTimer
extends Node

signal money_tick

#TODO Make timer not autostart and turn it on when game state changes to run
func _on_timer_timeout() -> void:
	money_tick.emit()
