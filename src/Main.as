package
{
	import flash.display.NativeWindow;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import game.ui.shell.GameWindowUI;
	import game.ui.shell.Main2UI;
	import game.ui.shell.MainUI;
	
	import moreui.view.TestPage;
	
	import morn.core.handlers.Handler;
	
	public class Main extends Sprite
	{
		public function Main()
		{
			App.init(this);
			App.loader.loadAssets(["assets/comp.swf"],new Handler(loadComplete));
		}
		private var nativeWindow:NativeWindow;
		
		private var sp:Sprite;
		private function loadComplete():void
		{
			// TODO Auto Generated method stub
			addChild(new TestPage());
			sp = new GameWindowUI();
//			addChild(sp);
			
			nativeWindow  = this.stage.nativeWindow;
			
			addEventListener(MouseEvent.MOUSE_DOWN,onMove);
			
//			addEventListener(Event.CLOSE,onC
			stage.addEventListener(Event.RESIZE, onStageResize);
			onStageResize(null);
		}
		
		private function onStageResize(e:Event):void {
			sp.width = stage.stageWidth;
			sp.height = stage.stageHeight;
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
			
//			this.nativeWindow.close();
		}
	}
}