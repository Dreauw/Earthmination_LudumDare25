package worlds {
	import entities.Boss1;
	import entities.Cloud;
	import entities.Ground;
	import entities.Helicopter;
	import entities.LifeHUD;
	import entities.NotVillain;
	import entities.SimpleBullet;
	import entities.SimpleEnBullet;
	import entities.Villain;
	import gui.Shop;
	import gui.TextLetter;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import utils.Audio;
	import utils.Particle;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import entities.Bird;
	import entities.Bird2;
	import entities.Helicopter2;
	import entities.Helicopter3;
	import utils.Resource;
	import entities.MiniMirage;
	import entities.Boss2;
	import entities.Boss3;
	
	public class WorldGame extends WorldBase{
		private var newEnTimer:Number = 0;
		private var newEnTime:Number = 2;
		private var cloudTimer:Number = 0;
		private var groundTimer:Number = 9;
		private var shopTimer:Number = -1;
		private var enTypes:Array = new Array();
		public var dialog:TextLetter;
		private var elapsedTime:Number = 0;
		public var dialogIndex:int = 0;
		public var villain:Villain;
		public var score:int = 78;
		public var shop:Shop;
		private var danger:Entity;
		public var inShop:Boolean = false;
		public function WorldGame() {
			super();
			FP.screen.color = 0x85CCF1;
			Particle.instance = new Particle();
			addGraphic(Particle.instance, 0);
			Audio.registerSound("explosion", "3,,0.3302,0.5361,0.1464,0.0536,,-0.0837,,,,,,,,,0.0514,-0.0258,1,,,,,0.5", true);
			Audio.registerSound("explosion2", "3,,0.1086,0.5599,0.4169,0.2112,,-0.0648,,,,,,,,,0.4541,-0.2278,1,,,,,0.5", true);
			Audio.registerSound("bonus", "0,,0.0717,0.3835,0.199,0.75,,,,,,0.4126,0.5284,,,,,,1,,,,,0.5", true);
			Audio.registerSound("blood", "3,,0.0811,,0.2424,0.641,,-0.4015,,,,,,,,,,,1,,,0.0838,,0.5", true);
			Audio.registerSound("laser", "0,,0.2511,0.238,0.1648,0.8709,0.3763,-0.2967,,,,,,0.3073,0.0853,,,,1,,,,,0.4", true);
			Audio.playMusic(Resource.SPACE, true);
			villain = new Villain()
			add(villain);
			dialog = new TextLetter("This planet must be destroyed");
			dialog.setStyle("red", { color: 0xFF0000 } );
			dialog.setStyle("green", { color: 0x2d7a16 } );
			dialog.setStyle("blue", { color: 0x0000FF } );
			dialog.setStyle("purple", { color: 0x703a8f } );
			dialog.setStyle("yellow", { color: 0x9c690a } );
			dialog.color = 0;
			dialog.size = 8;
			addGraphic(dialog);
			add(new LifeHUD(villain.life));
			shop = new Shop(villain);
			danger = new Entity();
			danger.graphic = new Text("Danger", 0, 0, {size : 16});
			(danger.graphic as Text).color = 0xFF0000;
			danger.x = (FP.screen.width / 2 - (danger.graphic as Text).width) / 2;
			danger.y = (FP.screen.height / 2 - (danger.graphic as Text).height) / 2;
		}
		
		public function gameOver():void {
			blackScreen = true;
			var gameOver:Text = new Text("Game Over\n  (Click)", 0, 0, { size : 16 } );
			gameOver.x = (FP.screen.width / 2 - gameOver.width) / 2;
			gameOver.y = (FP.screen.height / 2 - gameOver.height) / 2;
			addGraphic(gameOver);
			enTypes = [];
			elapsedTime = -9999;
			showLeaderBoard(score-78);
		}
		
		public function goToShop():void {
			shopTimer = 2;
			shop.addGold(1);
			dialogIndex += 1;
			inShop = true;
			Audio.playMusic(Resource.SPACE, true);
		}
		
		public function closeShop():void {
			transitionOut();
			remove(shop);
			elapsedTime = 0;
			dialogIndex += 1;
			inShop = false;
		}
		
		override public function update():void {
			super.update();
			elapsedTime += FP.elapsed;
			newEnTimer -= FP.elapsed;
			cloudTimer -= FP.elapsed;
			groundTimer -= FP.elapsed;
			shopTimer -= FP.elapsed;
			
			if (Input.mouseReleased && blackScreen) {
				switchWorld(WorldTitle);
			}
			
			if (elapsedTime > 2 && dialogIndex == 0) {
				dialogIndex += 1;
				dialog.text = "We need the place to build a city for the Villains";
			} else if (elapsedTime > 5 && dialogIndex == 1) {
				dialogIndex += 1;
				dialog.text = "Use the arrow keys to move and SHIFT to shoot";
			}  else if (elapsedTime > 9 && dialogIndex == 2) {
				dialogIndex += 1;
				dialog.richText = "<red>Tips : </red>Absorb goats on the ground for restores life by pressing ENTER";
			} else if (elapsedTime > 15 && dialogIndex == 3) {
				dialogIndex += 1;
				dialog.text = "Destroy all the obstacles that you will find"
				enTypes.push(Bird);
			} else if (elapsedTime > 20 && dialogIndex == 4) {
				dialogIndex += 1;
				enTypes.push(Helicopter);
			} else if (elapsedTime > 25 && dialogIndex == 5) {
				dialogIndex += 1;
				enTypes.push(Helicopter2);
			} else if (elapsedTime > 35 && dialogIndex == 6) {
				dialogIndex += 1;
				newEnTime = 2;
				enTypes.push(Bird2);
			} else if (elapsedTime > 45 && dialogIndex == 7) {
				dialogIndex += 1;
			} else if (elapsedTime > 55 && dialogIndex == 8) {
				dialogIndex += 1;
				enTypes.push(Helicopter3);
			} else if (elapsedTime > 80 && dialogIndex == 9) {
				add(danger);
				dialogIndex += 1;
				enTypes = [];
				dialog.text = "Boss Fight";
				Audio.playMusic(Resource.BOSS1_ZIC, true);
			} else if (elapsedTime > 83 && dialogIndex == 10) {
				remove(danger);
				add(new Boss1());
				dialogIndex += 1;
				// LVL 2
			} else if (elapsedTime > 0 && dialogIndex == 13) {
				dialogIndex += 1;
				dialog.text = "Humans are more resistant than I thought...";
			} else if (elapsedTime > 6 && dialogIndex == 14) {
				dialogIndex += 1;
				enTypes = [Bird, Bird, Helicopter, Helicopter, Helicopter2, Bird2, Helicopter3];
				newEnTime = 2;
			} else if (elapsedTime > 20 && dialogIndex == 15) {
				dialogIndex += 1;
				newEnTime = 1;
			} else if (elapsedTime > 35 && dialogIndex == 16) {
				enTypes.push(MiniMirage);
				dialogIndex += 1;
				newEnTime = 1;
			} else if (elapsedTime > 120 && dialogIndex == 17) {
				add(danger);
				dialogIndex += 1;
				enTypes = [];
				dialog.text = "Boss Fight";
				Audio.playMusic(Resource.BOSS2_ZIC, true);
			} else if (elapsedTime > 123 && dialogIndex == 18) {
				dialog.text = "Wow ... He looks familiar";
				remove(danger);
				add(new Boss2());
				dialogIndex += 1;
				// LVL 3
			} else if (elapsedTime > 0 && dialogIndex == 21) {
				dialog.text = "No time to lose, we have a planet to destroy";
				dialogIndex += 1;
			} else if (elapsedTime > 6 && dialogIndex == 22) {
				dialogIndex += 1;
				enTypes = [Helicopter, Helicopter, Helicopter2, Bird2, Helicopter3, MiniMirage, MiniMirage];
				newEnTime = 1;
			} else if (elapsedTime > 60 && dialogIndex == 23) {
				newEnTime = 0.5;
				dialogIndex += 1;
			} else if (elapsedTime > 145 && dialogIndex == 24) {
				add(danger);
				dialogIndex += 1;
				enTypes = [];
				dialog.text = "Boss Fight";
				Audio.playMusic(Resource.BOSS3_ZIC, true);
			} else if (elapsedTime > 148 && dialogIndex == 25) {
				dialog.text = "Uhg !?";
				remove(danger);
				add(new Boss3());
				dialogIndex += 1;
				// Loop -> Infinite lvl
			}
			
			if (newEnTimer <= 0 && enTypes.length > 0) {
				var notVillain:NotVillain = create(enTypes[FP.rand(enTypes.length)]) as NotVillain;
				notVillain.y = FP.rand(10) * 20 + 30;
				add(notVillain);
				newEnTimer = newEnTime;
			}
			
			if (cloudTimer <= 0) {
				cloudTimer = 3;
				var cloud:Cloud = create(Cloud) as Cloud;
				cloud.randomPosition();
				add(cloud);
			}
			
			if (groundTimer <= 0) {
				var ground:Ground = create(Ground) as Ground;
				ground.position();
				add(ground);
				groundTimer = 20 + FP.rand(5);
			}
			
			if (shopTimer <= 0 && dialogIndex == 12 || dialogIndex == 20) {
				shop.updateText();
				add(shop);
			}
			
		}
		
	}

}