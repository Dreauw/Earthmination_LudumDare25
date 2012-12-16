package entities {
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import utils.Resource;

	public class Helicopter2 extends NotVillain{
		
		public function Helicopter2() {
			super(0);
			var sprite:Spritemap = new Spritemap(Resource.HELICO2, 47, 18);
			sprite.add("fly", [0, 1, 0, 2], 30, true);
			sprite.play("fly");
			graphic = sprite;
			setHitbox(39, 18, -8);
			
		}
		
		override public function initialize():void {
			super.initialize();
			reloadTime = 2;
		}
		
	}

}