package test
{
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	/**
	 * 列举swf中所有资源映射名字
	 * @author weiyanyu
	 * 创建时间：2016-9-21 下午4:02:08
	 */
	public class SwfAnalyse extends Sprite
	{
		private var load:Loader;
		
		public function SwfAnalyse()
		{
			super();
			load = new Loader();
//			D:\sxd2git\sxd2game\SXD2-Game\resource\gui
			load.load(new URLRequest("\BlackMarketWindow.swf"));
			load.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
		}
		
		protected function onComplete(event:Event):void
		{
			var info:LoaderInfo = event.target as LoaderInfo;
			analyseSWF(info.bytes);
			
		}
		private function analyseSWF(bytes:ByteArray):void
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
						name = bytes.readUTFBytes(len).toString();
						trace("连接名："+name);
						
					}
				}
			}
		}
	}
}