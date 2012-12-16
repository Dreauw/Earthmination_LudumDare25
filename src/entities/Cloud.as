package entities {
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import utils.Resource;
	import net.flashpunk.FP;

	public class Cloud extends Entity{
		
		public function Cloud() {
			super(FP.screen.width / 2, FP.rand(8) * 40 + 10);
			var type : int = FP.rand(2);
			graphic = new Image(Resource.CLOUD, new Rectangle(type*55, 0, 55, 18));
			layer = 1;
			setHitbox(55, 18);
		}
		
		public function randomPosition():void {
			this.x = FP.screen.width/2;
			this.y = FP.rand(8) * 20 + 10;
		}
		
		override public function update():void {
			super.update();
			this.x -= 0.5;
			if (this.x + width < 0) {
				world.recycle(this);
			}
		}
		
	}

}