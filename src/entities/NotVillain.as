package entities {
	import net.flashpunk.Entity;
	import utils.Particle;
	import utils.Audio;
	import net.flashpunk.FP;
	import worlds.WorldGame;

	public class NotVillain extends Entity{
		public var life:int;
		public var speed:int;
		public var reloadTimer:Number;
		public var reloadTime:Number;
		public var particle:String = "explosion";
		public var score:int = 10;
		public var bullet:Class = SimpleEnBullet;
		public function NotVillain(y:Number) {
			super(FP.screen.width/2, y);
			type = "notVillain";
			initialize();
		}
		
		public function initialize():void {
			life = 1;
			speed = 1;
			reloadTimer = 0;
			reloadTime = 3;
		}
		
		override public function update():void {
			super.update();
			if (type != "boss") this.x -= speed;
			reloadTimer -= FP.elapsed;
			if (bullet == SimpleEnBullet && speed > 0 && reloadTimer < 0) {
				reloadTimer = reloadTime;
				var bullet:SimpleEnBullet = world.create(SimpleEnBullet) as SimpleEnBullet;
				bullet.x = x;
				bullet.y = y + height - 5;
				world.add(bullet);
			}
			if (this.x + width < 0) {
				x = FP.screen.width/2;
				world.recycle(this);
			}
		}
		
		public function destroy():void {
			Particle.emit(particle, x + width / 2, y + height / 2, 10);
			Audio.playSound(particle);
			world.recycle(this);
			if (FP.rand(3) == 0) {
				var bonus:Bonus = world.create(Bonus) as Bonus
				bonus.x = x + width / 2;
				bonus.y = y + height / 2;
				if (FP.rand(6) == 1) {
					bonus.setId(4)
				} else {
					bonus.setId(FP.rand(4));
				}
				world.add(bonus);
			}
			initialize();
			(world as WorldGame).score += life*10;
			x = FP.screen.width / 2;
			speed = 1;
		}
		
		public function hit(dammage:int):Boolean {
			life -= dammage;
			if (life <= 0) {
				destroy();
				return true;
			}
			return false;
		}
	}
}