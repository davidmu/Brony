assert = require 'assert'
maze = require './../maze.coffee'
describe 'Maze', ()->
	it 'Possible moves', (done)->
		maze.getMaze "9c068dcf-ab0a-4352-8d59-2593b3a75011", (err, mazeData)->
			moves = maze.checkPossibleMoves mazeData.data,mazeData.size[0],mazeData.size[1],0
			assert(moves.indexOf(15)>-1)
			done()

	it 'Vertical', (done)->
		maze.getMaze "9c068dcf-ab0a-4352-8d59-2593b3a75011", (err, mazeData)->
			moves1 = maze.checkPossibleMoves mazeData.data,mazeData.size[0],mazeData.size[1],17
			assert(moves1.indexOf(2)>-1)
			assert(moves1.indexOf(32)>-1)
			done()

	it 'Horizontal', (done)->
		maze.getMaze "9c068dcf-ab0a-4352-8d59-2593b3a75011", (err, mazeData)->
			moves2 = maze.checkPossibleMoves mazeData.data,mazeData.size[0],mazeData.size[1],76
			assert(moves2.indexOf(75)>-1)
			assert(moves2.indexOf(77)>-1)
			done()

	it 'Right Vertice', (done)->
		maze.getMaze "9c068dcf-ab0a-4352-8d59-2593b3a75011", (err, mazeData)->
			moves2 = maze.checkPossibleMoves mazeData.data,mazeData.size[0],mazeData.size[1],149
			assert(moves2.indexOf(134)>-1)
			assert(moves2.indexOf(164)>-1)
			done()

	it 'Right Vertice1', (done)->
		maze.getMaze "9c068dcf-ab0a-4352-8d59-2593b3a75011", (err, mazeData)->
			moves2 = maze.checkPossibleMoves mazeData.data,mazeData.size[0],mazeData.size[1],134
			assert(moves2.indexOf(133)>-1)
			console.log moves2
			done()