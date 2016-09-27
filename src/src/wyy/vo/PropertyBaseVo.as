package src.wyy.vo
{
	
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
		 * 属性对应的默认值 
		 */		
		public var deValue:Array = new Array();
		
		
		public var type:String = "";
		
		public function PropertyBaseVo()
		{
		}
		
		public function fromXML(xml:XML):void
		{
			type = xml.@type;
			var property:String = xml.@property;
			var arr:Array = property.split(",");
			for(var i:int = 0; i < arr.length; i++)
			{
				var arr1:Array = String(arr[i]).split("=");
				deProperty.push(arr1[0]);
				deValue.push(arr1[1]);
			}
		}
	}
}