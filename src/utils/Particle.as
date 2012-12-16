package utils {
	import net.flashpunk.graphics.Emitter;
	/**
	* ...
	* @author Dreauw
	*/
	public class Particle extends Emitter{
		static public var instance : Particle;

		public function Particle() {
			super(Resource.PARTICLES, 7, 7);
			registerParticle();
		}

		private function registerParticle() : void {
			// Explosion
			newType("explosion", [0]);
			setAlpha("explosion", 1, 0);
			setMotion("explosion", 0, 20, 0.7, 360, 0, 0.4);
			// VillainHurt
			newType("hurt", [1]);
			setAlpha("hurt", 1, 0);
			setMotion("hurt", 0, 50, 0.7, 360, 0, 0.4);
			// Blood
			newType("blood", [2]);
			setAlpha("blood", 1, 0);
			setMotion("blood", 0, 50, 0.7, 360, 0, 0.4);
			setGravity("blood", 5, 10);
			// Purple
			newType("purple", [3]);
			setAlpha("purple", 1, 0);
			setMotion("purple", 0, 200, 0.7, 360, 0, 0);
		}

		static public function emit(name:String, x:Number, y:Number, nbr:Number = 1) : void {
			for (var i : Number = 0; i < nbr ; i++) {instance.emit(name, x, y);}
		}

	}

}