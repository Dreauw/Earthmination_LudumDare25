package entities {
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import utils.Resource;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	import utils.Audio;
	import utils.Particle;
	import worlds.WorldGame;

	public class Villain extends Entity {
		public var speed:int = 2;
		public var reloadTime:Number = 0.5;
		private var reloadTimer:Number = 0;
		public var nbBullet:int = 1;
		public var bulletType:int = 0;
		public var life:int = 5;
		public var attractor:Entity;
		private var attract:Boolean;
		public var verticalLaser:int = 0;
		public var shieldLife:int = 0;
		public var shield:Entity;
		public function Villain() {
			super(50, 50);
			graphic = new Image(Resource.VILLAIN);
			type = "villain";
			setHitbox(24, 19);
			attractor = new Entity();
			attractor.graphic = new Image(Resource.ATTRACTOR);
			attractor.type = "attractor";
			attractor.setHitbox(24, 37);
			shield = new Entity(50, 50);
			shield.graphic = new Image(Resource.SHIELD);
			Input.define("Left", Key.LEFT, Key.A);
			Input.define("Right", Key.RIGHT, Key.D);
			Input.define("Up", Key.UP, Key.W);
			Input.define("Down", Key.DOWN, Key.S);
			Input.define("Shoot", Key.SHIFT, Key.Q);
			Input.define("Absorb", Key.ENTER, Key.SPACE, Key.E, Key.Z, Key.X, Key.C);
		}
		
		public function addShieldLife(n:Number):void {
			if (shieldLife <= 0 && n > 0) {
				FP.world.add(shield);
			} else if (shieldLife > 0 && shieldLife + n <= 0) {
				shieldLife += n;
				FP.world.remove(shield);
				return;
			}
			shieldLife += n;
		}
		
		override public function update():void {
			super.update();
			reloadTimer -= FP.elapsed;
			if (Input.check("Up") && y > 0) {
				this.y -= speed;
			} else if (Input.check("Down") && (y+height)*FP.screen.scale < FP.screen.height) {
				this.y += speed;
			}
			
			if (Input.check("Left") && x > 0) {
				this.x -= speed;
			} else if (Input.check("Right") && (x+width)*FP.screen.scale < FP.screen.width) {
				this.x += speed;
			}
			
			// Collide with not villain
			var notVillain:NotVillain = collide("notVillain", x, y) as NotVillain;
			if (notVillain) {
				notVillain.destroy();
				hit(1);
			}
			
			if (shieldLife > 0) {
				shield.x = x-2;
				shield.y = y-2;
			}
			
			// Absorb things on the ground
			if (Input.check("Absorb")) {
				if (!attract) {
					attract = true;
					world.add(attractor);
				}
				attractor.x = x;
				attractor.y = y + 18;
			} else if (attract) {
				attract = false;
				world.remove(attractor);
			}
			
			// Shoot
			if (Input.check("Shoot") && reloadTimer <= 0) {
				if (verticalLaser > 0) {
					var vBullet:VerticalBullet = world.create(VerticalBullet) as VerticalBullet;
					vBullet.x = x + width / 2 - 2;
					vBullet.y = y + height;
					vBullet.speed = 2
					world.add(vBullet);
				}
				if (verticalLaser > 1) {
					var vBullet2:VerticalBullet = world.create(VerticalBullet) as VerticalBullet;
					vBullet2.x = x + width / 2 - 2;
					vBullet2.y = y-2;
					vBullet2.speed = -2
					world.add(vBullet2);
				}
				var bullet:SimpleBullet = getBullet();
				world.add(bullet);
				if (nbBullet > 1) {
					var bullet2:SimpleBullet = getBullet();
					bullet2.y = bullet.y - 3;
					bullet.bullet2 = bullet2;
					bullet2.bullet2 = bullet;
					world.add(bullet2);
				}
				if (nbBullet > 2) {
					var bullet3:SimpleBullet = getBullet();
					bullet3.y = bullet.y + 3;
					bullet.bullet3 = bullet3;
					bullet2.bullet3 = bullet3;
					bullet3.bullet2 = bullet;
					bullet3.bullet3 = bullet2;
					world.add(bullet3);
				}
				reloadTimer = reloadTime;
				Audio.playSound("laser");
			}
		}
		
		private function getBullet():SimpleBullet {
			var bullet:SimpleBullet = world.create(SimpleBullet) as SimpleBullet;
			bullet.setType(bulletType);
			bullet.x = x + 24;
			bullet.y = y + 14;
			return bullet;
		}
		
		public function hit(dammage:int):void {
			Audio.playSound("explosion2");
			if (shieldLife > 0) {
				addShieldLife(-dammage);
				if (shieldLife < 0) {
					dammage = Math.abs(shieldLife);
				} else {
					return;
				}
			}
			
			life -= dammage;
			if (life < 0) {
				life = 0;
			}
			if (life == 0) {
				(world as WorldGame).gameOver();
				Particle.emit("explosion", x + width / 2, y + height / 2, 10);
				Audio.playSound("explosion");
				world.remove(this);
			}
		}
		
	}

}