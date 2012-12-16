package entities 
{
	import net.flashpunk.Entity;
	/**
	 * ...
	 * @author Dreauw
	 */
	public class EntityBase extends Entity {
		public function EntityBase(x:Number, y:Number) {
			super(x, y);
			layer = 1;
		}
	}
}