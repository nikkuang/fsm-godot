extends Object

var states = []
var object = null 
var elapsed_time = 0 
 
func _init(obj):   
	object = obj
	
#Pass the name of the function
func push_state(_state, _timeout = -1):  
	reset()
	states.append({ 
		'state' : _state, 
		'timeout' : _timeout 
	})

func pop_state():
	reset()
	states.pop_back()

func update(delta): 
	if not states.empty(): 
		var cs = states.back() 
		elapsed_time += delta   
		if cs.timeout >= 0 and elapsed_time >= cs.timeout:
			pop_state()
		else:
			funcref(object, cs.state).call_func(delta)

func get_elapsed_time():
	return elapsed_time
  
func size():
	return states.size() 

func reset() :
	elapsed_time = 0 
