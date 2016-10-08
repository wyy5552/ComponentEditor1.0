package src.wyy.model
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	/**
	 * @author weiyanyu
	 * 创建时间：2016-9-30 上午10:10:13
	 */
	public class ResourceModel
	{
		private static var _instance: ResourceModel;
		public static function get inst(): ResourceModel
		{
			if(_instance == null)
				_instance = new  ResourceModel();
			return _instance;
		}
		
		public function ResourceModel()
		{
			if(_instance != null)
				throw "ResourceModel.as" + "is a SingleTon Class!!!";
		}
		/**
		 * mainUI域 
		 */		
		public var mainUI:ApplicationDomain;
		
		public var source:ApplicationDomain;
		
		public static var MAIN:String = "main";
		public static var UI:String = "ui";
		
		public var sourceArr:Array;
		
		private var loader:Loader;
		public function init():void
		{
			loader = new Loader();
			loader.load(new URLRequest("file:///D:/sxd2git/sxd2game/SXD2-Game/resource/gui/MainUI.swf"));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadFileCompleteHandler);
		}
		
		public function getDomain(value:String):ApplicationDomain
		{
			switch(value)
			{
				case UI:
				{
					return source;
					break;
				}
					
				default:
				{
					return mainUI;
					break;
				}
			}
		}
		
		protected function loadFileCompleteHandler(event:Event):void
		{
			var swfTarget:LoaderInfo=loader.contentLoaderInfo; 
			mainUI=swfTarget.applicationDomain as ApplicationDomain; 
			analyseSWF(swfTarget.bytes);
		}
		
		private var _loadFile:File;
		public function addSource():void
		{
			_loadFile = new File();
			_loadFile.addEventListener(Event.SELECT, selectFileHandler);
			var fileFilter:FileFilter = new FileFilter("游戏界面swf: (*.swf)", "*.swf");
			_loadFile.browseForOpen("游戏界面swf", [fileFilter]);
		}
		/**
		 * @param event
		 */
		private function selectFileHandler(event:Event):void {
			_loadFile.removeEventListener(Event.SELECT, selectFileHandler);
			_loadFile.addEventListener(Event.COMPLETE, loadFileCompleteHandler1);
			_loadFile.load();
		}
		/**
		 * @param event
		 */
		private function loadFileCompleteHandler1(event:Event):void 
		{
			_loadFile.removeEventListener(Event.COMPLETE, loadFileCompleteHandler1);
			var loader:Loader = new Loader();
			var context:LoaderContext = new LoaderContext();
			context.allowCodeImport = true;
			loader.loadBytes(_loadFile.data,context);
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoaded);
			function onLoaded():void
			{
				var swfTarget:LoaderInfo=loader.contentLoaderInfo; 
				source = swfTarget.applicationDomain as ApplicationDomain; 
				var str:String = analyseSWF(swfTarget.bytes);
				sourceArr = str.split("~");
			}
			
		}	
		
		private function analyseSWF(bytes:ByteArray):String
		{
			var id:int;
			var head:int;
			var size:int;
			var i:int;
			var name:String;
			var len:int;
			var lastPosition:int;
			var num:int;
			var type:int;
			bytes.endian = Endian.LITTLE_ENDIAN;
			bytes.position = Math.ceil(((bytes[8]>>1)+5)/8)+12;
			while(bytes.bytesAvailable>0)//字节数组剩余可读数据长度大于2个字节
			{
				head = bytes.readUnsignedShort();//读取tag类型
				size = head&63;//判断低6位的值是否是63，如果是，这个tag的长度就是下面的32位整数，否则就是head的低6位
				if (size == 63)size=bytes.readInt();
				type = head>>6;
				if(type != 76)
				{
					bytes.position += size;
				}
				else
				{
					num = bytes.readShort();
					for(i=0; i<num; i++)
					{
						id = bytes.readShort();//读取tag ID
						lastPosition = bytes.position;
						while(bytes.readByte() != 0);//读到字符串的结束标志
						len = bytes.position - lastPosition;
						bytes.position = lastPosition;
						name += "~" + bytes.readUTFBytes(len).toString();
					}
				}
			}
			return name;
		}
		
	}
}