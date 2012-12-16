package entities {
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import utils.Resource;
	import net.flashpunk.FP;
	import utils.Audio;
	import utils.Particle;

	public class SimpleBullet extends Entity{
		public var speed:int = 2;
		public var dammage:int = 1;
		public var bullet2:SimpleBullet;
		public var bullet3:SimpleBullet;
		public function SimpleBullet() {
			super(0, 0);
			setHitbox(8, 2);
			type = "bullet";
		}
		
		public function setType(id:int):void {
			graphic = new Image(Resource.LASER_BULLET, new Rectangle(8 * id, 0, 8, 2));
			speed = dammage = id + 2;
		}
		
		override public function update():void {
			super.update();
			this.x += speed;
			if (this.x - this.width > FP.screen.width/2) {
				world.recycle(this);
			}
			var notVillain:NotVillain = collide("notVillain", x, y) as NotVillain;
			if (notVillain) {
				destroy();
				if (bullet2) bullet2.destroy();
				if (bullet3) bullet3.destroy();
				if (!notVillain.hit(dammage)) {
					Particle.emit("hurt", x, y, 5);
					Audio.playSound("explosion2");
				}
			}
			
			var boss:NotVillain = collide("boss", x, y) as NotVillain;
			if (boss) {
				destroy();
				if (bullet2) bullet2.destroy();
				if (bullet3) bullet3.destroy();
				if (!boss.hit(dammage)) {
					Particle.emit("explosion", x, y, 1);
					Audio.playSound("explosion2");
				}
			}
		}
		
		public function destroy():void {
			(FP.world).recycle(this);
		}
		
	}

}