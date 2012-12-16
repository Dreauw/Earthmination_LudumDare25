package entities {
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import utils.Resource;
	import net.flashpunk.FP;
	import entities.Goats;
	import worlds.WorldGame;

	public class Ground extends Entity{
		private var goats:Entity;
		public function Ground() {
			super(FP.screen.width/2, 0);
			graphic = new Image(Resource.GROUND);
			this.y = FP.screen.height / 2 - (graphic as Image).height;
			layer = 1;
			position();
		}
		
		override public function update():void {
			super.update();
			this.x -= 0.5;
			if (x + (graphic as Image).width < 0) {
				world.recycle(this);
			}
		}
		
		public function position():void {
			this.x = FP.screen.width / 2;
			this.y = FP.screen.height / 2 - (graphic as Image).height; 
			if (!(FP.world as WorldGame).inShop && (FP.world as WorldGame).dialogIndex >= 12 && FP.rand(2) == 0) {
				goats = FP.world.create(Tank) as Tank;
				goats.x = x + 15;
				goats.y = y - (goats.graphic as Image).height;
				FP.world.add(goats);
			} else {
				goats = FP.world.create(Goats) as Goats;
				goats.x = x + 15;
				goats.y = y - (goats.graphic as Image).height;
				FP.world.add(goats);
			}
			
		}
		
	}

}