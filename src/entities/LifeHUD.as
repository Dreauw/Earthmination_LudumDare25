package entities {
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.FP;
	import worlds.WorldGame;
	import net.flashpunk.graphics.Image;

	public class LifeHUD extends Entity{
		private var life:int = 0;
		public var bar:Image = Image.createRoundRect(70, 8, 0xFF0000, 7);
		public var background:Image = Image.createRoundRect(72, 10, 0, 7);
		public var text:Text;
		public var scoret:Text;
		public var score:int = 78;
		public function LifeHUD(life:int) {
			super(2, FP.screen.height / 2 - 12, background)
			background.alpha = bar.alpha = 0.6;
			bar.x = bar.y = 1;
			text = new Text("Life " + life.toString() + "/5", 0, 0, { size : 8 } )
			text.x = (bar.width - text.width) / 2;
			scoret = new Text("Score : 0", 260, 0, { size : 8 } );
			addGraphic(bar);
			addGraphic(text);
			addGraphic(scoret);
			this.life = life;
		}
		
		override public function update():void {
			super.update();
			var delta:Number = life - (FP.world as WorldGame).villain.life
			if (delta != 0) {
				life = (FP.world as WorldGame).villain.life;
				if (delta > 0) bar.clipRect.width = FP.approach(bar.clipRect.width, 0, Math.abs(delta)/5*70);
				if (delta < 0) bar.clipRect.width = FP.approach(bar.clipRect.width, bar.width, Math.abs(delta)/5*70);
                bar.clear();
                bar.updateBuffer();
				text.text = "Life " + life.toString() + "/5";
			}
			if (score != (FP.world as WorldGame).score) {
				score = (FP.world as WorldGame).score;
				scoret.text = "Score : " + (score-78).toString();
			}
		}
		
	}

}