package src.wyy.model
{
	import flash.utils.Dictionary;
	
	import src.wyy.vo.KeyValueVo;
	import src.wyy.vo.PropertyBaseVo;
	
	/**
	 * @author weiyanyu
	 * 创建时间：2016-9-27 下午6:25:13
	 */
	public class CompModel
	{
		private static var _instance: CompModel;
		public static function get inst(): CompModel
		{
			if(_instance == null)
				_instance = new  CompModel();
			return _instance;
		}
		
		[Embed(source="/assets/component.xml",mimeType = "application/octet-stream")]
		public var xmlClass:Class;
		
		/**
		 * 组件数组 ,只是用来初始化组件列表用
		 */		
		public var compArr:Array = new Array();
		/**
		 * key 元件类型  value 属性组 
		 */		
		public var dict:Dictionary = new Dictionary();
		
		public function CompModel()
		{
			if(_instance != null)
				throw "CompModel.as" + "is a SingleTon Class!!!";
			
			var xml:XML = XML(new xmlClass());
			var vo:PropertyBaseVo;
			var i:int;
			for each(var node:XML in xml.comp)
			{
				vo = new PropertyBaseVo();
				vo.fromXML(node);
				dict[vo.type] = vo;
				compArr.push(vo);
			}
		}
		
		
		public static function getProperty(kv:KeyValueVo):String
		{
			var str:String = kv.key;
			switch(kv.type)
			{
				case KeyValueVo.int_type:
				{
					str = kv.key + " = " + kv.value;
					break;
				}
				case KeyValueVo.bd_type:
					var arr:Array = kv.value.split("~");
					str = kv.key + " = " + "SpAddUtil.getBD('"+ arr[0] + "','" + arr[1] + "')";
					break;
				default:
				{
					str = kv.key + " = " + "\"" + kv.value + "\"";
					break;
				}
			}
			return str;
		}
		
		
	}
}