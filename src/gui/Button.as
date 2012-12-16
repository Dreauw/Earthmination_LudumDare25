package gui {
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	
	public class Button extends Entity {
		public var buttonUp:Image;
		public var buttonOver:Image;
		public var text:Text;
		public var func:Function;
		public function Button(x:Number, y:Number, text:String, func:Function) {
			this.text = new Text(text, 0, 0, { size:8, color:0 } )
			buttonUp = Image.createButtonUp(this.text.width, this.text.height-2, 0, 0);
		    buttonOver = Image.createButtonDown(this.text.width, this.text.height-2, 0, 0);
			super (x, y, buttonUp);
			addGraphic(this.text);
			setHitbox(buttonUp.width - 9, buttonUp.height - 9);
			this.func = func;
		}
		
		override public function update():void {
			super.update();
			if (collidePoint(x, y, Input.mouseX, Input.mouseY)) {
				if (Input.mouseReleased) {
					func(this);
				}
				if (graphic != buttonOver) {
					graphic = buttonOver;
					addGraphic(this.text);
				}
			} else if (graphic != buttonUp) {
				graphic = buttonUp;
				addGraphic(this.text);
			}
			
		}
		
	}

}