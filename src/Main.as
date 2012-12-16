package {
	import net.flashpunk.FP;
	import net.flashpunk.Engine;
	import worlds.WorldBase;
	import worlds.WorldTitle;
	import worlds.WorldGame;
	import net.flashpunk.utils.Key;
	import mochi.as3.MochiServices;
	import mochi.as3.MochiScores;
	
	/**
	 * ...
	 * @author Dreauw
	 */
	[Frame(factoryClass="Preloader")]
	dynamic public class Main extends Engine {
		public function Main() {
			super(640, 480, 60, false);
			FP.world = new WorldTitle;
			//FP.console.enable();
			FP.console.toggleKey = Key.F1;
			FP.screen.scale = 2;
		}
		
		override public function init():void {
			super.init();
			MochiServices.connect("xxxx", this);
			MochiScores.setBoardID("xxxx");
		}
	}
}