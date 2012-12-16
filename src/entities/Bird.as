package entities {
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import utils.Resource;

	public class Bird extends NotVillain{
		
		public function Bird() {
			super(0);
			var sprite:Spritemap = new Spritemap(Resource.BIRD, 21, 22);
			sprite.add("fly", [0, 1], 10, true);
			sprite.play("fly");
			graphic = sprite;
			setHitbox(21, 22);
			particle = "blood"
		}
		
		override public function initialize():void {
			super.initialize();
			speed = 2
			reloadTimer = 99999;
		}
	}

}