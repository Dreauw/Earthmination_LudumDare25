package worlds {
	import gui.Button;
	import  gui.TextLetter;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import utils.Audio;
	import utils.Particle;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.FP;
	import utils.Resource;
	
	public class WorldTitle extends WorldBase {
		private var text:Text = new Text("Earthmination", 0, 50, {size:16});
		public function WorldTitle() {
			super();
			addGraphic(new Image(Resource.TITLE_SCREEN));
			text.x = (FP.screen.width / 2 - text.width) / 2;
			addGraphic(text);
			Audio.registerSound("select", "0,,0.0938,0.4136,0.1159,0.7633,,,,,,0.3416,0.5774,,,,,,1,,,,,0.5", true);
			var button:Button = new Button(0, 100, "  Play  ", play);
			button.x = (FP.screen.width/2 - button.width) / 2;
			var button2:Button = new Button(0, 120, " Score ", score);
			button2.x = (FP.screen.width/2 - button2.width) / 2;
			add(button);
			add(button2);
			Audio.playMusic(Resource.TITLE, true);
			
		}
		
		public function play(button:Button):void {
			Audio.playSound("select");
			switchWorld(WorldGame);
		}
		
		public function score(button:Button):void {
			Audio.playSound("select");
			showLeaderBoard();
		}
		
	}

}