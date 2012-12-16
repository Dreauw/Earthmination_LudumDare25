package entities {
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import utils.Resource;

	public class Bird2 extends NotVillain{
		
		public function Bird2() {
			super(0);
			var sprite:Spritemap = new Spritemap(Resource.BIRD2, 21, 22);
			sprite.add("fly", [0, 1], 10, true);
			sprite.play("fly");
			graphic = sprite;
			setHitbox(21, 22);
			particle = "blood"
		}
		
		override public function update():void {
			super.update();
			if (speed > 0 && reloadTimer < 0) {
				reloadTimer = reloadTime;
				var bullet:VerticalEnBullet = world.create(VerticalEnBullet) as VerticalEnBullet;
				bullet.x = x + width - 4;
				bullet.y = y + height;
				bullet.speed = 2;
				world.add(bullet);
			}
		}
		
		override public function initialize():void {
			super.initialize();
			speed = 2
			life = 2;
			reloadTimer = 1;
			bullet = VerticalEnBullet;
		}
	}

}