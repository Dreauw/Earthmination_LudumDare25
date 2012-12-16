package entities {
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import utils.Resource;
	import net.flashpunk.FP;
	import utils.Audio;
	import utils.Particle;

	public class AdvancedEnBullet extends Entity{
		public var speed:int = 2;
		public var dammage:int = 1;
		private var dir:Point;
		public function AdvancedEnBullet() {
			super(0, 0);
			setHitbox(6, 4);
			type = "bullet";
			graphic = new Image(Resource.FIRE_BULLET);
		}
		
		public function setTarget(startX:Number, startY:Number, targetX:Number, targetY:Number):void {
			dir = new Point(targetX - startX, targetY - startY);
		}
		
		override public function update():void {
			super.update();
			dir.normalize(speed);
			moveBy(dir.x, dir.y);
			
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