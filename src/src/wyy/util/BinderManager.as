package src.wyy.util
{
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	
	import mx.controls.Alert;
	
	import src.wyy.vo.PropertyBaseVo;

	/**
	 * 组件与属性vo绑定管理
	 * @author weiyanyu
	 * 创建时间：2016-10-9 20:31:52
	 * 
	 */
	public class BinderManager
	{
		private static var _instance:BinderManager;
		public static function get inst():BinderManager
		{
			if(_instance == null)
				_instance = new BinderManager();
			return _instance;
		}
		public function BinderManager()
		{
			if(_instance != null)
				throw "BinderManager.as" + "is a SingleTon Class!!!";
			_instance = this;
		}
		/**
		 * key sp; value binder; 
		 */		
		public var dict:Dictionary = new Dictionary();
		
		public function bind(sp:DisplayObject,vo:PropertyBaseVo):void
		{
			if(dict[sp] != null)
			{
				Alert.show("已经绑定过这个组件了，看下问题吧!");
				return;
			}
			
			dict[sp] = new SpriteVoBinder(sp,vo);
		}
		
		public function getBinder(sp:DisplayObject):SpriteVoBinder
		{
			return dict[sp] as SpriteVoBinder;
		}
		
		public function delSp(sp:DisplayObject):void
		{
			dict[sp] = null;
			delete dict[sp];
		}
		/**
		 * 设置组件单独属性 
		 * @param dis
		 * @param key
		 * @param value
		 * 
		 */		
		public function setSingleProperty(dis:DisplayObject,key:String,value:String):void
		{
			(dict[dis] as SpriteVoBinder).setSingleProperty(key,value);
		}
	}
}