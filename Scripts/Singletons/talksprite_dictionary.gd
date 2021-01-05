extends Node

var talksprites := {
	"":null,
	"player_human":preload("res://Assets/Sprites/DialogTalksprites/WWDetecHumanProfile.png"),
	"player_dog":preload("res://Assets/Sprites/DialogTalksprites/WWDetecDogProfile.png"),
}

func get_talksprite(var name):
	return talksprites[name]