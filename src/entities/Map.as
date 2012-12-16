package entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import worlds.WorldGame;
	import utils.Resource;
	import flash.utils.ByteArray;
	import net.flashpunk.FP;
	import flash.utils.getDefinitionByName;
	import utils.Particle;
	/**
	 * ...
	 * @author Dreauw
	 */
	public class Map {
		private var world:WorldGame;
		public var cursor:Cursor;
		public var width:uint;
		public var height:uint;
		public var tileWidth:uint;
		public var tileHeight:uint;
		public var crystal:Crystal;
		public function Map(_world:WorldGame) {
			world = _world;
			Particle.instance = new Particle();
			cursor = new Cursor();
		}
		
		public function load(mapClass:Class):void {
			world.removeAll();
			FP.camera.x = FP.camera.y = 0;
			var b:ByteArray = new mapClass();
			var s:Array = b.readUTFBytes(b.length).split("\n")
			var entit:Array = new Array();
			width = 30;
			height = 25;
			tileWidth = 16;
			tileHeight = 16;
			for each(var line:String in s) {
				var val:Array = line.split("=");
				if (val[0].indexOf("tile_width") >= 0) tileWidth = uint(val[1]);
				if (val[0].indexOf("tile_height") >= 0) tileHeight = uint(val[1]);
				if (val[0].indexOf("width") >= 0) width = uint(val[1]);
				if (val[0].indexOf("height") >= 0) height = uint(val[1]);
				if (val[0].indexOf("tile_layer") >= 0) {
					var tilemap:Tilemap = new Tilemap(Resource.TILESET, width * tileWidth, height * tileHeight, tileWidth, tileHeight);
					tilemap.loadFromString(val[1], ",", "|");
					var ent:Entity = new Entity(0, 0, tilemap)
					ent.layer = 3;
					if (val[0].indexOf("tile_layer_1") >= 0) ent.layer = 1;
					ent.type = "solid";
					ent.mask = tilemap.createGrid([16, 17, 18, 19, 20, 21, 22, 23, 24, 31, 32, 33, 34, 35, 36]);
					entit.push(ent);
				}
				if (val[0].indexOf("event_layer") >= 0) {
					for each(var ev:String in val[1].split(",")) {
						var subVal:Array = ev.split("|");
						if (subVal.length <= 2) continue;
						var eventClass:Class = getDefinitionByName("entities." + subVal[0]) as Class;
						entit.push(new eventClass(uint(subVal[1]) * tileWidth, uint(subVal[2]) * tileHeight));
					}
					
				}
			}
			world.addList(entit);
		}
		
		public function screenWidth():uint {
			return width * tileWidth;
		}
		
		public function screenHeight():uint {
			return height * tileHeight;
		}
		
	}

}