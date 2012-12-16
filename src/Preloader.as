package  
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getDefinitionByName;
	import flash.utils.setTimeout;
	import net.flashpunk.Engine;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author Dreauw
	 */
	public class Preloader extends MovieClip {
		private var label : TextField = new TextField();
		private var progressBar : Shape = new Shape();
		private var paused : Boolean = false;
		public function Preloader() {
			if (stage) {
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
			}
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			progressBar.x = 100;
			progressBar.y = (stage.stageHeight - 50) / 2;
			addChild(progressBar);
			label.x = progressBar.x;
			label.y = progressBar.y - 40;
			var format:TextFormat = new TextFormat();
			
			label.autoSize = TextFieldAutoSize.LEFT;  
			label.text = "Loading 0%";
			label.selectable = false;
			format.color = 0xFFFFFF
			format.size = 26;
			format.bold = true
			label.defaultTextFormat = format;
			addChild(label);
		}
		
		private function ioError(e:IOErrorEvent):void {
			trace(e.text);
		}
		
		private function progress(e:ProgressEvent):void {
			var percent:Number = e.bytesLoaded / e.bytesTotal;
			label.text = "Loading " + (percent*100).toFixed().toString() + "%";
			progressBar.graphics.clear();
			progressBar.graphics.lineStyle(2, 0xFFFFFF, 1.0, true);
			progressBar.graphics.drawRoundRect(0, 0, stage.stageWidth - 200, 50, 9);
			progressBar.graphics.beginFill(0xFFFFFF);
			progressBar.graphics.drawRoundRect(5, 5, percent*(stage.stageWidth-210), 40, 9);
			progressBar.graphics.endFill();
		}
		
		private function checkFrame(e:Event):void {
			if (currentFrame == totalFrames) {
				stop();
				loadingFinished();
			}
		}
		
		private function loadingFinished():void {
			removeEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
			removeChild(progressBar);
			removeChild(label);
			progressBar = null;
			label = null;
			startup();
		}
		
		private function startup():void {
			var mainClass:Class = getDefinitionByName("Main") as Class;
			addChild(new mainClass() as Engine);
		}
		
	}
}