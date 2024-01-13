extends Resource
class_name AudioManager

enum SoundType {HIT_BRICK = 0, HIT_WALL = 1, HIT_PLAYER = 2}

var hit_brick_audio 
var hit_wall_audio 
var hit_player_audio

# contains audio mappings
# key: SoundType
# value: Array ->
#	[0] AudioStreamPlayer
# 	[1] File path to the audio file
var audio_dict = {}

func initialize():
	hit_brick_audio = AudioStreamPlayer.new()
	hit_wall_audio = AudioStreamPlayer.new()
	hit_player_audio = AudioStreamPlayer.new()

	audio_dict[SoundType.HIT_BRICK] = [hit_brick_audio, "res://Assets/Audio/andrew_hit_brick.wav"]
	audio_dict[SoundType.HIT_WALL] = [hit_wall_audio, "res://Assets/Audio/andrew_hit_wall.wav"]
	audio_dict[SoundType.HIT_PLAYER] = [hit_player_audio, "res://Assets/Audio/andrew_hit_player.wav"]

func _ready():
	pass
	
	
func attach_sound(node, type):
	if audio_dict[type] != null:
		var current_audio = audio_dict[type][0]
		var file_path = audio_dict[type][1]
		node.add_child(current_audio)
		var audio_file = load(file_path)
		current_audio.set_stream(audio_file)
		
	#match type:
		#SoundType.HIT_BRICK:
			#node.add_child(hit_brick_audio)
			#var hit_brick_file = load("res://Assets/Audio/andrew_hit_brick.wav")
			#hit_brick_audio.set_stream(hit_brick_file)
			#pass
		#SoundType.HIT_WALL:
			#node.add_child(hit_wall_audio)
			#var hit_wall_file = load("res://Assets/Audio/andrew_hit_wall.wav")
			#hit_wall_audio.set_stream(hit_wall_file)
			#pass
		#SoundType.HIT_PLAYER:
			#node.add_child(hit_player_audio)
			#var hit_player_file = load("res://Assets/Audio/andrew_hit_player.wav")
			#hit_player_audio.set_stream(hit_player_file)
			#pass

	
func play_sound(type, offset):
	if audio_dict[type] != null:
		var current_audio = audio_dict[type][0]
		current_audio.play(offset)
		
	#match type:
		#SoundType.HIT_BRICK:
			#hit_brick_audio.play(offset)
			#pass
		#SoundType.HIT_WALL:
			#hit_wall_audio.play(offset)
			#pass
		#SoundType.HIT_PLAYER:
			#hit_player_audio.play(offset)
			#pass

	pass




