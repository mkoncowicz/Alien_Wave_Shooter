extends Node

var score: int = 0
var player_is_dead : bool
var player_health : int

const machinegun_ammo_max : int = 24
const shotgun_ammo_max : int = 12
const railgun_ammo_max : int = 1

var machinegun_ammo_mag : int = 0 #max 24
var shotgun_ammo_mag : int = 0    #max 12
var railgun_ammo_mag : int = 0  #max 1

var machinegun_ammo_stash : int = 144 #max 144
var shotgun_ammo_stash : int = 36   #max 36
var railgun_ammo_stash : int = 5    #max 5
