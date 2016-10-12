package src.wyy.vo
{
	
	/**
	 * 属性设置
	 * @author weiyanyu
	 * 创建时间：2016-9-28 下午8:09:51
	 */
	public class KeyValueVo
	{
		public static var int_type:String = "0";
		public static var str_type:String = "1";
		public static var bd_type:String = "2";
		public static var mc_type:String = "3";
		
		public var key:String;
		
		public var value:String;
		/**
		 * 0,表示整形； 1，表示字符串 
		 */		
		public var type:String;
		
		
		public function KeyValueVo()
		{
		}
		
		public function fromXML(xml:XML):void
		{
			key = xml.@key;
			value = xml.@value;
			type = xml.@type;
		}
		
		public function get clone():KeyValueVo
		{
			var vo:KeyValueVo = new KeyValueVo();
			vo.key = key;
			vo.value = value;
			vo.type = type;
			return vo;
		}
	}
}