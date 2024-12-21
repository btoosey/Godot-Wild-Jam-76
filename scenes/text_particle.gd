class_name TextParticle
extends Node2D

@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D
@onready var particle_label: Label = $SubViewport/ParticleLabel

var particle_text: String
var particle_text_colour: String


func _ready() -> void:
	play_particle()


func play_particle() -> void:
	particle_label.text = particle_text
	particle_label.add_theme_color_override("font_color", Color(particle_text_colour))
	gpu_particles_2d.emitting = true


func _on_timer_timeout() -> void:
	queue_free()
