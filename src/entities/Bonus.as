package entities {
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import utils.Resource;
	import utils.Audio;
	import worlds.WorldGame;
	import utils.Particle;
	
	public class Bonus extends Entity{
		private var id:int = 0;
		public function Bonus() {
			super(0, 0)
			setHitbox(8, 8);
		}
		
		public function setId(id:int):void {
			this.id = id;
			graphic = new Image(Resource.BONUS, new Rectangle(8 * id, 0, 8, 8));
		}
		
		
		override public function update():void {
			super.update();
			this.x -= 0.5;
			if (x + 8 < 0) {
				world.recycle(this);
			}
			// Collide with the villain
			var villain:Villain = collide("villain", x, y) as Villain;
			if (villain) {
				switch(id) {
					case 0:
						if (villain.nbBullet < 3) villain.nbBullet += 1;
						(world as WorldGame).dialog.richText = "The <green>green orb</green> increment the number of laser";
						break;
					case 1:
						villain.bulletType = 1;
						(world as WorldGame).dialog.richText = "The <blue>blue orb</blue> upgrade your laser";
						break;
					case 2:
						villain.reloadTime -= 0.1;
						if (villain.reloadTime < 0.1) villain.reloadTime = 0.1;
						(world as WorldGame).dialog.richText = "The <red>red orb</red> increase the firing rate";
						break;
					case 3:
						Particle.emit("purple", x + width / 2, y + height / 2, 10);
						var notVillains:Array = new Array();
						world.getType("notVillain", notVillains);
						for each(var notVillain:NotVillain in notVillains) {
							notVillain.destroy();
						}
						(world as WorldGame).dialog.richText = "The <purple>purple orb</purple> destroy all the entities on the screen";
						break;
					case 4:
						var notVillains2:Array = new Array();
						world.getType("notVillain", notVillains);
						for each(var notVillain2:NotVillain in notVillains2) {
							notVillain2.speed -= 0.5;
						}
						(world as WorldGame).shop.addGold(1);
						(world as WorldGame).dialog.richText = "The <yellow>yellow orb</yellow> slow the entities on the screen and give 1 gold";
						break;
				}
				Audio.playSound("bonus");
				world.recycle(this);
			}
		}
		
	}

}