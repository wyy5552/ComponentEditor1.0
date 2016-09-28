package src.wyy.model
{
	import flash.utils.Dictionary;
	
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
				vo.type = node.@type;
				for each(var child:XML in node.prop)
				{
					var obj:Object = new Object;
					obj.type = String(child.@type);
					
					obj.value = String(child.@value);
					trace(obj.type,obj.value);
					vo.deProperty.push(obj);
					vo.dict[obj.type] = obj.value;
				}
				dict[vo.type] = vo;
				compArr.push(vo);
			}
		}
		

		
		
	}
}