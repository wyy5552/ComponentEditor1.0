package src.wyy.vo
{
	import flash.utils.Dictionary;
	
	/**
	 * @author weiyanyu
	 * 创建时间：2016-9-22 下午4:33:29
	 */
	public class PropertyBaseVo
	{
		/**
		 * 属性列表 
		 */		
		public var deProperty:Array = new Array();
		/**
		 * 属性字典，方便查找 
		 */		
		public var dict:Dictionary = new Dictionary();
		
		public var type:String = "";
		
		public function PropertyBaseVo()
		{
		}
		
		public function getProperty(value:String):Object
		{
			for(var i:int = 0; i < deProperty.length; i++)
			{
				if(deProperty[i].type == value)
				{
					return deProperty[i].value;
				}
			}
			return null;
		}
		
		public function setProperty(key:String,value:String):void
		{
			if(dict[key] != null)
			{
				dict[key] = value;
			}
		}
		
		public function get clone():PropertyBaseVo
		{
			var vo:PropertyBaseVo = new PropertyBaseVo();
			vo.type = type;
			for(var i:int = 0; i < deProperty.length; i++)
			{
				var obj:Object = new Object();
				obj.type = deProperty[i].type;
				obj.value = deProperty[i].value;
				vo.deProperty.push(obj);
				vo.dict[obj.type] = obj.value;
			}
			
			return vo;
		}
		
	}
}