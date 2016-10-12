package src.wyy.vo
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import src.wyy.util.UICreater;
	
	/**
	 * 组件与vo绑定<br>
	 * 方便两者统一管理
	 * @author weiyanyu
	 * 创建时间：2016-10-9 下午8:18:32
	 */
	public class SpriteVoBinder
	{
		
		public var dis:Sprite;
		
		public var vo:PropertyBaseVo;
		
		public function SpriteVoBinder(sp:Sprite,vo:PropertyBaseVo)
		{
			this.dis = sp;
			this.vo = vo;
			setProperty(vo);
		}
		/**
		 * 设置组件显示的属性 
		 * @param dis
		 * @param vo
		 * 
		 */		
		public function setProperty(vo:PropertyBaseVo):void
		{
			var kv:KeyValueVo;
			for(var i:int = 0; i < vo.deProperty.length; i++)
			{
				kv = vo.deProperty[i];
				setSingleProperty(kv.key,kv.value);
			}
		}
		
		public function setSingleProperty(key:String,value:String):void
		{
			var kv:KeyValueVo = vo.getProperty(key);
			kv.value = value;
			UICreater.setSingleProperty(dis,kv);
		}
		
	}
}