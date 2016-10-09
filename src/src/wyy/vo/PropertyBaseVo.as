package src.wyy.vo
{
	
	/**
	 * 组件vo<br>
	 * 记录组件的属性
	 * @author weiyanyu
	 * 创建时间：2016-9-22 下午4:33:29
	 */
	public class PropertyBaseVo
	{
		/**
		 * 只用来记录顺序
		 */		
		public var deProperty:Array = new Array();
		
		public var type:String = "";
		
		public var uiName:String = "";
		
		public function PropertyBaseVo()
		{
			
		}
		
		public function getProperty(key:String):KeyValueVo
		{
			var kv:KeyValueVo;
			for(var i:int = 0; i < deProperty.length; i++)
			{
				kv = deProperty[i];
				if(kv.key == key)
					return kv;
			}
			return null;
		}
		
		public function setProperty(key:String,value:String):void
		{
			var kv:KeyValueVo = getProperty(key);
			kv.value = value;
		}
		
		public function fromXML(xml:XML):void
		{
			type = xml.@type;
			for each(var child:XML in xml.prop)
			{
				var obj:KeyValueVo = new KeyValueVo;
				obj.fromXML(child);
				deProperty.push(obj);
			}
		}
		
		public function get clone():PropertyBaseVo
		{
			var vo:PropertyBaseVo = new PropertyBaseVo();
			vo.type = type;
			for(var i:int = 0; i < deProperty.length; i++)
			{
				var kv:KeyValueVo = deProperty[i];
				vo.deProperty.push(kv.clone);
			}
			return vo;
		}
		
	}
}