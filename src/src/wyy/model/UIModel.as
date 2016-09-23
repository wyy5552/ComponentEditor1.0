package src.wyy.model
{
	import flash.display.DisplayObject;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * @author weiyanyu
	 * 创建时间：2016-9-23 下午4:23:54
	 */
	public class UIModel
	{
		
		private static var _inst:UIModel;
		
		public static function get inst():UIModel
		{
			return new UIModel();
		}
		public function UIModel()
		{
			if(_inst == null)
				_inst = this;
			else
			{
				trace("UIModel不能实例化了！");
			}
		}
		
		private var pre:String = "public var ";
		
		private var end:String = ";\n";
		
		private var impt:String = "import ";
		
		
		
		
		public function sava(value:Vector.<DisplayObject>):void
		{
			var file:File;
			var stream:FileStream;
			file = File.applicationStorageDirectory.resolvePath("shenmeatext.as");
			stream = new FileStream();
			var dis:DisplayObject;
			var impt:String = "";
			var varStr:String = "";
			var initStr:String = "";
			
			var type:String;
			var typeArr:Array;
			for each(dis in value)
			{
				typeArr = getQualifiedClassName(dis).split("::");
				
				type = typeArr[1];
				impt += impt + typeArr[0] + "." + type + end;
				varStr += pre + dis.name + ":" + type + end;
				initStr += "    " + dis.name + " = new " + type + "()" + end;
				initStr += "	" + dis.name + ".x = " + dis.x + end;
				initStr += "	" + dis.name + ".y = " + dis.y + end;
				initStr += "	" + dis.name + ".height = " + dis.height + end;
				initStr += "	" + dis.name + ".width = " + dis.width + end + "\n";
			}
			initStr = "private function initUI():void" +
				"\n{\n" +
				initStr +
				"\n}";
			
			stream.openAsync(file, FileMode.WRITE);
			stream.writeUTFBytes(impt + "\n" + varStr + "\n" + initStr);
			stream.close();
		}
		
		public function analyse(value:String):Vector.<DisplayObject>
		{
			var lines:Array = value.split("\n");
			trace(lines[0]);
			//完全路径
			var path:Dictionary = new Dictionary();
			//
			
			
			var dict:Dictionary = new Dictionary();
			var str:String = "";
			for(var i:int = 0; i < lines.length; i++)
			{
				str = lines[i];
				if(str.indexOf(pre) > -1)
				{
					
				}
			}
			
			var addVec:Vector.<DisplayObject>;
			
			
			
			return addVec;
		}
		
	}
}