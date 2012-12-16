package worlds {
	import entities.NotVillain;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import flash.display.BitmapData;
	import utils.Audio;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import mochi.as3.MochiScores;

	public class WorldBase extends World {
		private var _classToGo:Class;
		private var inTransition:Boolean = false;
		private var transitionTypeIn:Boolean = false;
		private var transitionX:Number = 0;
		protected var blackScreen:Boolean = false;
		
		public function showLeaderBoard(score:Number = 0):void {
			FP.engine.paused = true
			Input.clear();
			score != 0 ? MochiScores.showLeaderboard({score: score, onClose:onLBClose}) : MochiScores.showLeaderboard({onClose:onLBClose})
		}
		
		public function onLBClose():void {
			MochiScores.closeLeaderboard();
			FP.engine.paused = false;
		}
		
		public function switchWorld(classToGo:Class):void {
			_classToGo = classToGo;
			transitionOut();
		}
		
		public function transitionOut():void {
			inTransition = true;
			transitionTypeIn = true;
			transitionX = -(FP.screen.width / FP.screen.scale);
			transitionX -= (FP.screen.width / FP.screen.scale)/2;
		}
		
		public function transitionIn():void {
			transitionTypeIn = !(inTransition = true);
			transitionX = -(FP.screen.width / FP.screen.scale)/2;
		}
		
		
		override public function update():void {
			super.update();
			if (Input.released(Key.M)) Audio.mute();
			if (inTransition) {
				transitionX += FP.elapsed * 230;
				if (transitionTypeIn && transitionX >= 0) {
					if (_classToGo) {
						var worldTo:WorldBase = new _classToGo();
						FP.world = worldTo;
						worldTo.transitionIn();
					} else {
						transitionIn();
					}
				}
			}
		}
		
		override public function focusGained():void {
			if (FP.engine.paused) {
				FP.engine.paused = false;
				Audio.resume();
				super.focusGained();
			}
		}
		
		override public function focusLost():void {
			FP.engine.paused = true;
			Audio.stop();
			FP.engine.render();
			super.focusGained();
		}
		
		override public function recycle(e:Entity):Entity {
			if (e is NotVillain) (e as NotVillain).initialize(); 
			return super.recycle(e);
		}
		
		override public function render():void {
			super.render();
			if (inTransition) {
				var bd:BitmapData = new BitmapData((FP.screen.width/FP.screen.scale)+(FP.screen.width/FP.screen.scale)/2, (FP.screen.height/FP.screen.scale), true, 0);
				var transitionNbr:uint = 10;
				var tWidth:uint = Math.round((FP.screen.width / FP.screen.scale) / 2 / transitionNbr);
				var i:uint = 1;
				var col:uint;
				if (transitionTypeIn) {
					bd.fillRect(new Rectangle(0, 0, (FP.screen.width/FP.screen.scale), (FP.screen.height/FP.screen.scale)), 0xFF000000);
					for (i = 1; i < transitionNbr; i += 1) {
						col = ( (255 - (255/transitionNbr)*i) << 24) | ( 0 << 16 ) | ( 0 << 8 ) | 0;
						bd.fillRect(new Rectangle((FP.screen.width/FP.screen.scale)+tWidth*(i-1), 0, tWidth, (FP.screen.height/FP.screen.scale)), col);
					}
				} else {
					bd.fillRect(new Rectangle((FP.screen.width/FP.screen.scale)/2, 0, (FP.screen.width/FP.screen.scale), (FP.screen.height/FP.screen.scale)), 0xFF000000);
					for (i = 1; i <= transitionNbr; i += 1) {
						col = ( ((255 / transitionNbr) * i) << 24) | ( 0 << 16 ) | ( 0 << 8 ) | 0;
						bd.fillRect(new Rectangle(tWidth*(i-1), 0, tWidth, (FP.screen.height/FP.screen.scale)), col);
					}
				}
				FP.buffer.copyPixels(bd, bd.rect, new Point(transitionX, 0));
			}
			
			if (!FP.focused || blackScreen) {
				var bdf:BitmapData = new BitmapData((FP.screen.width / FP.screen.scale) + (FP.screen.width / FP.screen.scale) / 2, (FP.screen.height / FP.screen.scale), true, 0xAA000000);
				FP.buffer.copyPixels(bdf, bdf.rect, new Point(0, 0));
			}
			
		}
	}

}