package entities {
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import utils.Resource;
	import net.flashpunk.FP;
	import utils.Audio;
	import utils.Particle;

	public class VerticalBullet extends Entity{
		public var speed:int = 2;
		public var dammage:int = 1;
		public function VerticalBullet() {
			super(0, 0);
			setHitbox(4, 4);
			type = "bullet";
			graphic = new Image(Resource.VERTICAL_BULLET);
		}
		
		override public function update():void {
			super.update();
			this.y += speed;
			if (this.y - this.height > FP.screen.height/2) {
				world.recycle(this);
			}
			if (this.y + this.height < 0) {
				world.recycle(this);
			}
			var notVillain:NotVillain = collide("notVillain", x, y) as NotVillain;
			if (notVillain) {
				destroy();
				if (!notVillain.hit(dammage)) {
					Particle.emit("hurt", x, y, 5);
					Audio.playSound("explosion2");
				}
			}
			
			var boss:NotVillain = collide("boss", x, y) as NotVillain;
			if (boss) {
				destroy();
				if (!boss.hit(dammage)) {
					Particle.emit("explosion", x, y, 1);
					Audio.playSound("explosion2");
				}
			}
		}
		
		public function destroy():void {
			world.recycle(this);
		}
		
	}

}