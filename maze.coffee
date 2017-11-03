###This a maze library containing all maze related functions###
rest = require 'restler'
maze = {}
baseUrl = 'https://ponychallenge.trustpilot.com/pony-challenge/maze'
#generateMaze will simply call the api endpoint generating a maze
maze.generateMaze = (height, width, name, difficulty, cb)->
	data={
		"maze-width": width,
		"maze-height": height,
		"maze-player-name": name,
		"difficulty": 0
	}
	options = {}
	options.headers = {
		'Content-Type': 'application/json'
	}
	options.data = JSON.stringify(data)
	rest.post baseUrl, options
	.on 'complete', (result, response)->
		console.log response.error
		cb null, result.maze_id

#fetches the generated maze data from the maze-id, a simple api call using restler
maze.getMaze = (maze_id, cb)->
	options = {}
	rest.get baseUrl+'/'+maze_id, options
	.on 'complete', (result,response)->
		#console.log result
		cb null, result

#given the mazedata, dimensions, position and monster position, this function calulates the possible positions the pony can move to
maze.checkPossibleMoves = (maze,width,height,position, enemy)->
	moves =[]
	if maze[position] and position%width isnt 0
		if maze[position].indexOf('west') is -1 and (position-1 isnt enemy)
			moves.push(position-1)
	if maze[position+1] and position%width isnt width-1
		if maze[position+1].indexOf('west') is -1 and (position+1 isnt enemy)
			moves.push(position+1)
	if maze[position-width] and (position/width)>1 
		if maze[position].indexOf('north') is -1 and (position-width isnt enemy)
			moves.push(position-width)
	if maze[position+width] and (position/width) < height
		if maze[position+width].indexOf('north') is -1 and (position+width isnt enemy)
			moves.push(position+width)
	moves

#Recursively calculates a route that fits the criteria of not running Domokun, yest reaching the endpoint
maze.solve = (mazeData, dimension, ep, sp, mo, currentRoute, cb)->
	if currentRoute is null
		currentRoute=[sp]
	else
		currentRoute.push sp
	if sp is ep
		cb null, currentRoute
		return true
	pMoves = maze.checkPossibleMoves mazeData,dimension[0],dimension[1], sp, mo
	pMoves.forEach (integer)->
		if currentRoute.indexOf(integer) is -1 
			maze.solve mazeData, dimension, ep,integer, mo, currentRoute.slice(), cb

#Recursively calls all the move actions to the api. Wait's for one call to finish before calling the next to ensure not overloading the server.
maze.move = (mazeId, directions, cb)->
	if directions.length>0
		data={
			"direction": directions[0]
		}
		options = {}
		options.headers = {
			'Content-Type': 'application/json'
		}
		options.data = JSON.stringify(data)
		rest.post baseUrl + '/' + mazeId, options
		.on 'complete', (result, response)->
			directions.splice 0,1
			if directions.length is 0
				cb null,result
			else
				maze.move mazeId, directions, cb
maze.getDirections = (currentRoute, width)->
	directions = []
	for value, index in currentRoute
		directionValue = value - currentRoute[index+1]
		if directionValue is width
			directions.push("north")
		if directionValue is -width
			directions.push("south")
		if directionValue is 1
			directions.push("west")
		if directionValue is -1
			directions.push("east")
	directions
module.exports = maze
