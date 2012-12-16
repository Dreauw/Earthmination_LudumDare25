package gui {
	import entities.Villain;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import utils.Resource;
	import worlds.WorldGame;
	import net.flashpunk.FP;
	
	public class Shop extends Entity{
		public var background:Image = Image.createRoundRect(312, 132, 0, 7);
		public var title:Text;
		public var arrayPt:Array = new Array();
		public var buttons:Array = new Array();
		public var villain:Villain;
		public var gold:int = 0;
		public var continueButton:Button;
		public function Shop(villain:Villain) {
			super(4, 20, background)
			this.villain = villain;
			background.alpha = 0.5
			title = new Text("Shop : 1 gold(s)", 0, 2);
			title.x = (background.width - title.width) / 2;
			addGraphic(title);
			var arr:Array = ["Number of laser", "Laser type", "Fire rate", "Vertical laser", "Shield", "Ship speed"];
			var img:Image = new Image(Resource.BONUS2);
			img.x = 2;
			img.y = 26;
			addGraphic(img);
			for (var i:int = 0; i < arr.length; i++) {
				addGraphic(new Text(arr[i],  12, i * 12 + 24, { size : 8 } ));
				var pt:Text = new Text(": "+getValue(i).toString(), 83, i * 12 + 24, { size : 8 } );
				arrayPt.push(pt);
				addGraphic(pt);
				var buy:Button = new Button(102, i * 12 + 44, "Buy", buyButton);
				var sell:Button = new Button(124, i * 12 + 44, "Sell", sellButton);
				buttons.push(buy);
				buttons.push(sell);
			}
			continueButton = new Button(140, 137, "Continue", continueFunc);
		}
		
		public function continueFunc(button:Button):void {
			(world as WorldGame).closeShop();
		}
		
		public function addGold(n:Number):void {
			gold += n;
			title.text = "Shop : " + gold.toString() + " gold(s)";
		}
		
		public function updateText() : void {
			(arrayPt[0] as Text).text = ": " + getValue(0).toString();
			(arrayPt[1] as Text).text = ": " + getValue(1).toString();
			(arrayPt[2] as Text).text = ": " + getValue(2).toString();
			(arrayPt[3] as Text).text = ": " + villain.verticalLaser.toString();
			(arrayPt[4] as Text).text = ": " + villain.shieldLife.toString();
			(arrayPt[5] as Text).text = ": " + villain.speed.toString();
		}
		
		public function buyButton(button:Button):void {
			if (gold <= 0) return;
			
			if (button == buttons[0]) {
				if (getValue(0) < 3) {
					addGold(-1);
					villain.nbBullet += 1;
					(arrayPt[0] as Text).text = ": " + getValue(0).toString();
				}
			} else if (button == buttons[2]) {
				if (getValue(1) < 3) {
					addGold(-1);
					villain.bulletType += 1;
					(arrayPt[1] as Text).text = ": " + getValue(1).toString();
				}
			} else if (button == buttons[4]) {
				if (getValue(2) < 9) {
					addGold(-1);
					villain.reloadTime -= 0.1;
					(arrayPt[2] as Text).text = ": " + getValue(2).toString();
				}
			} else if (button == buttons[6]) {
				if (villain.verticalLaser < 2) {
					addGold(-1);
					villain.verticalLaser += 1;
					(arrayPt[3] as Text).text = ": " + villain.verticalLaser.toString();
				}
			} else if (button == buttons[8]) {
				if (villain.shieldLife < 5) {
					addGold(-1);
					villain.addShieldLife(1);
					(arrayPt[4] as Text).text = ": " + villain.shieldLife.toString();
				}
			} else if (button == buttons[10]) {
				if (villain.speed < 4) {
					addGold(-1);
					villain.speed += 1
					updateText();
				}
			}
			
			
		}
		
		public function sellButton(button:Button):void {
			if (button == buttons[1]) {
				if (getValue(0) > 1) {
					addGold(1);
					villain.nbBullet -= 1;
					(arrayPt[0] as Text).text = ": " + getValue(0).toString();
				}
			} else if (button == buttons[3]) {
				if (getValue(1) > 1) {
					addGold(1);
					villain.bulletType -= 1;
					(arrayPt[1] as Text).text = ": " + getValue(1).toString();
				}
			} else if (button == buttons[5]) {
				if (getValue(2) > 4) {
					addGold(1);
					villain.reloadTime += 0.1;
					(arrayPt[2] as Text).text = ": " + getValue(2).toString();
				}
			} else if (button == buttons[7]) {
				if (villain.verticalLaser > 0) {
					addGold(1);
					villain.verticalLaser -= 1;
					(arrayPt[3] as Text).text = ": " + villain.verticalLaser.toString();
				}
			} else if (button == buttons[9]) {
				if (villain.shieldLife > 0) {
					addGold(1);
					villain.addShieldLife(-1);
					(arrayPt[4] as Text).text = ": " + villain.shieldLife.toString();
				}
			} else if (button == buttons[11]) {
				if (villain.speed > 1) {
					addGold(1);
					villain.speed -= 1
					updateText();
				}
			}
		}
		
		
		override public function added():void {
			super.added();
			for each(var button:Button in buttons) {
				world.add(button);
			}
			world.add(continueButton);
		}
		override public function removed():void {
			super.removed();
			for each(var button:Button in buttons) {
				world.remove(button);
			}
			world.remove(continueButton);
		}
		
		public function getValue(id:int):Number {
			switch(id) {
				case 0:
					return villain.nbBullet;
					break;
				case 1:
					return villain.bulletType + 1;
					break;
				case 2:
					return Math.round((1 - villain.reloadTime)*10);
					break;
					
			}
			return 0;
		}
		
	}

}