package src.wyy.model
{
	import flash.display.DisplayObject;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	import src.wyy.vo.PropertyBaseVo;
	
	
	/**
	 * @author weiyanyu
	 * 创建时间：2016-9-23 下午4:23:54
	 */
	public class UIModel
	{
		
		private static var _instance:UIModel;
		
		public static function get inst():UIModel
		{
			if(_instance == null)
				_instance = new  UIModel();
			return _instance;
		}
		public function UIModel()
		{
			if(_instance != null)
				throw "UIModel.as" + "is a SingleTon Class!!!";
		}
		/**
		 * 舞台上所有的组件 
		 */		
		public var addVec:Vector.<DisplayObject> = new Vector.<DisplayObject>();
		/**
		 * 组件对应的属性 
		 */		
		public var voDict:Dictionary = new Dictionary();
		
		private var pre:String = "public var ";
		
		private var end:String = ";\n";
		
		private var imptPre:String = "import ";
		
		
		public function sava():void
		{
			var file:File;
			var stream:FileStream;
			file = new File("D:\\abc" + ".as");
			stream = new FileStream();
			var dis:DisplayObject;
			var impt:String = "";//导入的包
			var varStr:String = "";//变量声明
			var initStr:String = "";//初始化函数体
			
			var type:String;
			var typeArr:Array;
			
			var propertyVo:PropertyBaseVo;
			for each(dis in addVec)
			{
				
				propertyVo = voDict[dis];
				typeArr = getQualifiedClassName(dis).split("::");
				
				type = typeArr[1];
				if(impt.search(imptPre + typeArr[0] + "." + type + end) == -1)
					impt += imptPre + typeArr[0] + "." + type + end;
				varStr += pre + propertyVo.uiName + ":" + type + end;
				initStr += "    " + propertyVo.uiName + " = new " + type + "()" + end;
				initStr += "	" + "addChild(" + propertyVo.uiName + ")" + end;
				
				for(var i:int = 0; i < propertyVo.deProperty.length; i++)
				{
					initStr += "	" + propertyVo.uiName + "." + CompModel.getProperty(propertyVo.deProperty[i]) + end;
				}
				initStr += "\n";
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
			value = value.substr(value.indexOf("{"),value.indexOf("}"))
			var lines:Array = value.split("\n");
			
			var addVec:Vector.<DisplayObject> = new Vector.<DisplayObject>();
			//变量字典
			var vDict:Dictionary = new Dictionary();
			var str:String = "";
			for(var i:int = 0; i < lines.length; i++)
			{
				str = lines[i];
				if(str.indexOf("new ") > -1)
				{
					var arr:Array = str.split("=");
					var key:String = trim(arr[0]);//key 组件名字
					var spType:String = String(arr[1]).substring(4,String(arr[1]).length - 3);//去掉new，()
					spType = trim(spType);
					vDict[key] = CompModel.getUIbyName(spType);// 获取对应的组件
					addVec.push(DisplayObject(vDict[key]));//保存组件
				}
				else if(str.indexOf(".") > -1)
				{
					//例子  btn.x = 165;
//					str = StringUtil.trim(str);//去除首尾空格
					str =  trim(str);// 去除空格 btn.x=165;
					str = str.slice(0,str.length - 1);//去除分号btn.x=165
					
					var arr1:Array = str.split(".");//名字与属性分开,[btn,x=165]
					var arr2:Array = arr1[1].split("=");//属性与值分开 [x,165]
					var obj:Object = vDict[arr1[0]];
					obj[arr2[0]] = arr2[1];
					trace(arr2[0],"= " + arr2[1]);
				}
				
			}
			
			return addVec;
		}
		//http://www.runoob.com/regexp/regexp-syntax.html
		//正则表达式语法
		/**
		 * 去除空格 
		 * @param str
		 * @return 
		 * 
		 */		
		public function trim(str:String):String 
		{
			return str.replace(/\s+/g,"");
		}

		
		
	}
}