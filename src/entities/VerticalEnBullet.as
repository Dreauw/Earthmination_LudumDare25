package entities {
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import utils.Resource;
	import net.flashpunk.FP;
	import utils.Audio;
	import utils.Particle;

	public class VerticalEnBullet extends Entity{
		public var speed:int = 2;
		public var dammage:int = 1;
		public function VerticalEnBullet() {
			super(0, 0);
			setHitbox(4, 4);
			type = "bullet";
			graphic = new Image(Resource.VERTICAL_BULLET);
			(graphic as Image).color = 0;
		}
		
		override public function update():void {
			super.update();
			this.y += speed;
			this.x -= 0.5;
			if (this.y - this.height > FP.screen.height/2) {
				world.recycle(this);
			}
			if (this.y + this.height < 0) {
				world.recycle(this);
			}
			
			var villain:Villain = collide("villain", x, y) as Villain;
			if (villain) {
				world.recycle(this);
				Particle.emit("hurt", x, y, 5);
				villain.hit(dammage);
			}
		}
		
		public function destroy():void {
			world.recycle(this);
		}
		
	}

}