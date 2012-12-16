package entities {
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import utils.Resource;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import worlds.WorldGame;

	public class Boss2 extends NotVillain{
		public var moveUp:Boolean = true;
		public var moveDown:Boolean = false;
		private var waitTimer:Number = 0;
		public function Boss2() {
			super((FP.screen.height-21)/2);
			graphic = new Image(Resource.BOSS2);
			setHitbox(24, 19);
			type = "boss";
			bullet = AdvancedEnBullet;
		}
		
		override public function initialize():void {
			super.initialize();
			life = 500;
			reloadTime = 2;
		}
		
		override public function update():void {
			super.update();
			// AI
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
				
			if (this.x + width > FP.screen.width / 2) {
				this.x -= 1;
			}
			waitTimer -= FP.elapsed;
			if (moveUp && waitTimer <= 0) {
				this.y -= 1;
				if (this.y - FP.rand(40) <= 10) {
					waitTimer = 3;
					moveDown = !moveDown;
					moveUp = !moveUp;
				}
			}
			
			if (moveDown && waitTimer <= 0) {
				this.y += 1;
				if (this.y + FP.rand(40) >= FP.screen.height/2-(height+10) ) {
					waitTimer = 3;
					moveDown = !moveDown;
					moveUp = !moveUp;
				}
			}
			
		}
		override public function destroy():void {
			super.destroy();
			(world as WorldGame).goToShop();
		}
		
	}

}