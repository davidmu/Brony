maze = require './maze.coffee'
module.exports= ()->
	maze.generateMaze 15, 15, 'FlutterShy', 10, (err,mazeId)->
		maze.getMaze mazeId, (err, mazeData)->
			directions = []
			currentSolution = null
			console.log "solving ", mazeId
			maze.solve mazeData.data, mazeData.size, mazeData["end-point"][0], mazeData.pony[0], mazeData.domokun[0], null, (err,currentRoute)->
				directions = maze.getDirections(currentRoute, mazeData.size[0])
				maze.move mazeId, directions, (err,result)->
					console.log result
					console.log mazeId
