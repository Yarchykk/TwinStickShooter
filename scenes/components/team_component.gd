extends Node2D
class_name Team_Component

enum TeamName{
	NEUTRAL,
	PLAYER,
	ENEMY
}


@export var entity_team : TeamName = TeamName.NEUTRAL
