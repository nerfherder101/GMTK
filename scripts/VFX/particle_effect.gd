class_name Particles
extends Node2D

func _enter_tree() -> void:
	$CPUParticles2D.emitting = true

func _on_cpu_particles_2d_finished() -> void:
	queue_free()
