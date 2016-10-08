package test
{
	import com.gamehero.sxd2.gui.core.util.SpAddUtil;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import mx.core.FlexGlobals;
	
	/**
	 * @author weiyanyu
	 * 创建时间：2016-9-29 下午4:05:24
	 */
	public class ResourceByteLoadTest
	{
		private static var _instance: ResourceByteLoadTest;
		public static function get inst(): ResourceByteLoadTest
		{
			if(_instance == null)
				_instance = new  ResourceByteLoadTest();
			return _instance;
		}
		
		public function ResourceByteLoadTest()
		{
			if(_instance != null)
				throw "ResourceModel.as" + "is a SingleTon Class!!!";
		}
		private var _loadFile:File;
//		public function init():void
//		{
////			_loadFile = new File();
////			_loadFile.url = "file:///D:/sxd2git/sxd2game/SXD2-Game/resource/gui/MainUI.swf";
////			var stream: FileStream = new FileStream();
////			stream.open(_loadFile, FileMode.READ);
////			_loadFile.addEventListener(Event.COMPLETE, loadFileCompleteHandler);
////			_loadFile.load();
//			onOpenCode(null);
//		}
		
		protected function onOpenCode(event:MouseEvent):void
		{
			_loadFile = new File();
			_loadFile.addEventListener(Event.SELECT, selectFileHandler);
			var fileFilter:FileFilter = new FileFilter("游戏界面UI: (*.swf)", "*.swf");
			_loadFile.browseForOpen("游戏界面UI", [fileFilter]);
		}
		
		/**
		 * @param event
		 */
		private function selectFileHandler(event:Event):void {
			_loadFile.removeEventListener(Event.SELECT, selectFileHandler);
			_loadFile.addEventListener(Event.COMPLETE, loadFileCompleteHandler);
			_loadFile.load();
		}
		
		protected function loadFileCompleteHandler(event:Event):void
		{
			// TODO Auto-generated method stub
			var loader:Loader = new Loader();
			var context:LoaderContext = new LoaderContext();
			context.allowCodeImport = true;
			loader.loadBytes(_loadFile.data,context);
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoaded);
			function onLoaded():void
			{
				var swfTarget:LoaderInfo=loader.contentLoaderInfo; 
				//swfTarget的只读属性applicationDomain返回一个ApplicationDomain 
				//CuPlayer.com创建被加载swf的应用程序域 
				var appDomain:ApplicationDomain=swfTarget.applicationDomain as ApplicationDomain; 
				
				//			var swf:MovieClip = loader.loaderInfo.parameters as MovieClip;
				//创建MCClass实例，并返回影片剪辑对象 
				var myMCA:Bitmap= new Bitmap(SpAddUtil.getBD(appDomain,"m_54"));
				
				(FlexGlobals.topLevelApplication as MyUI).ui.addChild(myMCA);
			}
			
			
		}
	}
}