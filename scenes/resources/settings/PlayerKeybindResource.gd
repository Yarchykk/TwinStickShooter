class_name PlayerKeybindResource
extends Resource

#Reference used for this setup: https://youtu.be/z-vU475Rixk?si=F3CNsN6uD60TXckl

## Movement Controls
#region Movement Controls Keybinds
#Naming Convention / Specific Action Names
const MOVE_UP : String = "move_up"
const MOVE_DOWN : String = "move_down"
const MOVE_RIGHT : String = "move_right"
const MOVE_LEFT : String = "move_left"
#Export Veriables to set up DEFAULT keybinds
@export var DEFAULT_MOVE_UP_KEY = InputEventKey.new()
@export var DEFAULT_MOVE_DOWN_KEY = InputEventKey.new()
@export var DEFAULT_MOVE_RIGHT_KEY = InputEventKey.new()
@export var DEFAULT_MOVE_LEFT_KEY = InputEventKey.new()
#Location where custom keybinds are to be stored
var move_up_key = InputEventKey.new()
var move_down_key = InputEventKey.new()
var move_right_key = InputEventKey.new()
var move_left_key = InputEventKey.new()
#endregion


## Rotation Controls
#region Rotation Controls Keybinds
#Naming Convention / Specific Action Names
const ROTATE_COUNTER_CLOCKWISE : String = "rotate_counter_clockwise"
const ROTATE_CLOCKWISE : String = "rotate_clockwise"
const ROTATE_RESET : String = "rotate_reset"
#Export Veriables to set up DEFAULT keybinds
@export var DEFAULT_ROTATE_COUNTER_CLOCKWISE_KEY = InputEventKey.new()
@export var DEFAULT_ROTATE_CLOCKWISE_KEY = InputEventKey.new()
@export var DEFAULT_ROTATE_RESET_KEY = InputEventKey.new()
#Location where custom keybinds are to be stored
var rotate_counter_clockwise_key = InputEventKey.new()
var rotate_clockwise_key = InputEventKey.new()
var rotate_reset_key = InputEventKey.new()
#endregion


## Shooting Controls
#region Shooting Controls Keybinds
#Naming Convention / Specific Action Names
const SHOOT : String = "shoot"
const RELOAD : String = "reload"
#Export Veriables to set up DEFAULT keybinds
@export var DEFAULT_SHOOT_KEY = InputEventKey.new()
@export var DEFAULT_RELOAD_KEY = InputEventKey.new()
#Location where custom keybinds are to be stored
var shoot_key = InputEventKey.new()
var reload_key = InputEventKey.new()
#endregion


## Controls to be deprecated 
const EXIT = "KILL"
const RESET_SCENE = "KILL" 
