package entities {
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import utils.Resource;
	import net.flashpunk.FP;
	import utils.Particle;

	public class SimpleEnBullet extends Entity{
		public var speed:int = 2;
		public var dammage:int = 1;
		public function SimpleEnBullet() {
			super(0, 0);
			graphic = new Image(Resource.FIRE_BULLET);
			setHitbox(6, 4);
			type = "enBullet";
		}
		
		override public function update():void {
			super.update();
			this.x -= speed;
			if (this.x + width < 0) {
				world.recycle(this);
			}
			var villain:Villain = collide("villain", x, y) as Villain;
			if (villain) {
				world.recycle(this);
				Particle.emit("hurt", x, y, 5);
				villain.hit(dammage);
			}
		}
		
	}

}