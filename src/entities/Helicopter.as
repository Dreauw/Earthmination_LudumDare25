package entities {
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import utils.Resource;

	public class Helicopter extends NotVillain{
		
		public function Helicopter() {
			super(0);
			var sprite:Spritemap = new Spritemap(Resource.HELICO, 47, 19);
			sprite.add("fly", [0, 1, 0, 2], 30, true);
			sprite.play("fly");
			graphic = sprite;
			setHitbox(39, 19, -7);
		}
		
	}

}