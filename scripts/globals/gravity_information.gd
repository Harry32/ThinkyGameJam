extends Node
## Main control for gravity change.
##
## Every time something change the up direction it's stored in [member upDirection].

signal up_direction_change(targetName: String)


var upDirection : Vector2 = Vector2.UP
var specificsUpDirections = {}


## Updates the current up direction
##
## Updates the current up direction for a given target. If [param targetName] is empty every possible
## element will be affected as long as the new up direction is different from the current one. The new
## up position will be stored in [member upDirection].
## In case of [param targetName] not being empty the new up direction is stored inside [member specificsUpDirections].
## If [param remove] is true and [param targetName] is not empty the target will be removed from [member specificsUpDirections].
##
## [param newUpDirection]: The new up direction
## [param targetName]: The name of the target of the change
## [param remove]: Define if the change must be removed from [member specificsUpDirections]. It just
## work if [param targetName] is not empty
func update_up_direction(newUpDirection: Vector2, targetName: String = String(), remove: bool = false) -> bool:
	if targetName == "":
		return general_update(newUpDirection)
	
	return specific_update(newUpDirection, targetName, remove)


## Updates the up direction for everyone
##
## [param newUpDirection]: The new up direction
func general_update(newUpDirection: Vector2) -> bool:
	if newUpDirection != Vector2.ZERO and newUpDirection != upDirection:
		if abs(newUpDirection.x) != abs(newUpDirection.y):
			upDirection = newUpDirection
			up_direction_change.emit(String())
			return true

	return false


## Updates the up direction for a specific target
##
## If [param remove] is true and [param targetName] is not empty the target will be removed from [member specificsUpDirections].
##
## [param newUpDirection]: The new up direction
## [param targetName]: The name of the target of the change
## [param remove]: Define if the change must be removed from [member specificsUpDirections]
func specific_update(newUpDirection: Vector2, targetName: String, remove: bool) -> bool:
	if remove:
		specificsUpDirections.erase(targetName)
	else:
		specificsUpDirections[targetName] = newUpDirection

	up_direction_change.emit(targetName)

	return true


## Get the current up direction
##
## If the target is found inside [member specificsUpDirections] then the stored vector will be returned,
## otherwise it'll return [member upDirection].
##
## [param targetName]: The name of the target of the information
func get_up_direction(targetName: String) -> Vector2:
	if specificsUpDirections.has(targetName):
		return specificsUpDirections[targetName]

	return upDirection
