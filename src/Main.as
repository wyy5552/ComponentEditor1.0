package
{
	import flash.display.NativeWindow;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import game.ui.shell.MainUI;
	
	import morn.core.handlers.Handler;
	
	public class Main extends Sprite
	{
		public function Main()
		{
			App.init(this);
			App.loader.loadAssets(["assets/comp.swf"],new Handler(loadComplete));
		}
		private var nativeWindow:NativeWindow;
		private function loadComplete():void
		{
			// TODO Auto Generated method stub
			addChild(new MainUI());
			nativeWindow  = this.stage.nativeWindow;
			
			addEventListener(MouseEvent.MOUSE_DOWN,onMove);
			
//			addEventListener(Event.CLOSE,onC
		}
		
		protected function onMove(event:MouseEvent):void
		{
//			nativeWindow.startResize("L"); 
//			nativeWindow.startResize("R"); 
//			nativeWindow.startResize("T"); 
//			nativeWindow.startResize("B"); 
//			nativeWindow.startResize("TL"); 
//			nativeWindow.startResize("RB");
//			this.nativeWindow.startMove();
			
			this.nativeWindow.close();
		}
	}
}