package entities {
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import utils.Resource;
	import net.flashpunk.FP;
	import worlds.WorldGame;

	public class MiniMirage extends NotVillain{
		
		public function MiniMirage() {
			super(0);
			graphic = new Image(Resource.MINI_MIRAGE);
			setHitbox(65, 13, -4, -6);
			bullet = AdvancedEnBullet;
		}
		
		override public function update():void {
			super.update();
			if (speed > 0 && reloadTimer < 0) {
				reloadTimer = reloadTime;
				var vx:Number = (FP.world as WorldGame).villain.x;
				if ((x - vx) <= 0) return;
				var bullet:AdvancedEnBullet = world.create(AdvancedEnBullet) as AdvancedEnBullet;
				bullet.x = x;
				bullet.y = y + height;
				bullet.setTarget(x, y + height, vx, (FP.world as WorldGame).villain.y);
				bullet.speed = 2;
				world.add(bullet);
			}
		}
		
		override public function initialize():void {
			super.initialize();
			life = 8;
			reloadTimer = 0;
			reloadTime = 3;
		}
		
	}

}