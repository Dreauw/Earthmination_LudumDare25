package entities {
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import utils.Resource;
	import utils.Particle;
	import utils.Audio;
	import worlds.WorldGame;
	import net.flashpunk.FP;

	public class Goats extends Entity{
		private var attracted:Boolean = false;
		public function Goats() {
			super(0, 0);
			graphic = new Image(Resource.GOATS);
			setHitbox((graphic as Image).width, (graphic as Image).height);
			layer = 1;
		}
		
		override public function update():void {
			super.update();
			this.x -= 0.5;
			if (x + (graphic as Image).width < 0) {
				destroy();
			}
			if (collide("attractor", x, y)) {
				attracted = true;
			}
			if (attracted) {
				var dx:Number = x - (world as WorldGame).villain.x
				var dy:Number = y - (world as WorldGame).villain.y
				if (dx > 0) this.x -= 2;
				if (dx < 0) this.x += 2;
				if (dy > 0) this.y -= 2;
				if (dy < 0) this.y += 2;
				if (collideWith((world as WorldGame).villain, x, y)) {
					destroy();
					Particle.emit("blood", x + width / 2, y + height / 2, 5);
					Audio.playSound("blood");
					if ((world as WorldGame).villain.life < 5) (world as WorldGame).villain.life += 1;
				}
			}
		}
		
		public function destroy():void {
			world.recycle(this);
			if (FP.rand(2) == 0) {
				graphic = new Image(Resource.GOATS);
			} else {
				graphic = new Image(Resource.COW);
			}
			
			attracted = false;
		}
	}

}