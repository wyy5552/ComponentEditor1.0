package test
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	public class ByteMapArray extends Sprite
	{
		public var url:String=new String("D:/github/ComponentEditor1.0/src/test/bg.png");
		public var loader:Loader=new Loader();
		public var bitmapdata:BitmapData
		public var bytearr:ByteArray=new ByteArray();
		public var bytemap:Bitmap=new Bitmap();
		public var newmap:Bitmap=new Bitmap();
		public function ByteMapArray()
		{
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,completeHandle);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,errorHandle);
			loader.load(new URLRequest(url));
			//this.addChild(loader);
			
			
		}
		public function completeHandle(evt:Event):void
		{
			trace("sucess");
			bitmapdata=new BitmapData(4500,800);
			bitmapdata.draw(loader);
			var temp:ByteArray=bitmapdata.getPixels(bitmapdata.rect);
			bytearr.writeBytes(temp);
			
			var bitmapdata2:BitmapData=new BitmapData(loader.width,loader.height);
			bytearr.position=0;
			bitmapdata2.setPixels(bitmapdata.rect,bytearr);
			bytemap.bitmapData=bitmapdata2;
			this.addChild(bytemap);
			
			var picRect:Rectangle=new Rectangle(35,50,20,20);//从哪里开始扣，扣多少？
			var point:Point=new Point(20,20);//将抠图放在newBitmapdata的那个位置
			var newBitmapdata:BitmapData=new BitmapData(100,100);
			newBitmapdata.copyPixels(bitmapdata2,picRect,point);
			newmap.bitmapData=newBitmapdata;
			newmap.x=200;
			newmap.y=200;
			this.addChild(newmap);
		}
		public function errorHandle(evt:IOErrorEvent):void
		{
			trace("error");
		}
		
	}
}