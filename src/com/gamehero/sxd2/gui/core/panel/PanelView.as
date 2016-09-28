package com.gamehero.sxd2.gui.core.panel
{
	
	import com.gamehero.sxd2.core.GameConfig;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;
	
	import bowser.loader.BulkLoaderSingleton;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	import br.com.stimuli.loading.loadingtypes.LoadingItem;
	
	/**
	 * 包括资源加载的view面板<br>
	 * 比如说有些功能面板有很多页签，页签内部又有很多资源，没必要一开始的时候就把资源全部加载，而是要面板打开后才加载
	 * @author weiyanyu
	 * 创建时间：2016-8-18 下午10:53:05
	 */
	public class PanelView extends Sprite
	{
		
		private var bitmapDataDict:Dictionary = new Dictionary(); 
		protected var loader:BulkLoaderSingleton;
		protected var _uiResDomain:ApplicationDomain;
		protected var windowResource:MovieClip;
		public function PanelView(resourceURL:String)
		{
			super();
			resourceURL =  GameConfig.GUI_URL + resourceURL;
			if(loader == null) 
			{	
				loader = BulkLoaderSingleton.createUniqueNamedLoader();
			}
			var loadingItem:LoadingItem = loader.add(resourceURL, {priority: GameConfig.HIGHEST_LOAD_PRIORITY});
			if(loadingItem.isLoaded == false) 
			{	
				loadingItem.addEventListener(Event.COMPLETE, onWindowResourceLoaded);
				loader.start();
			}
		}
		
		/**
		 * Swf Resource Complete Handler 
		 * @param event 
		 */
		protected function onWindowResourceLoaded(e:Event = null):void
		{
			
			var imageItem:ImageItem = e.currentTarget as ImageItem;
			imageItem.removeEventListener(Event.COMPLETE, onWindowResourceLoaded);
			
			windowResource = imageItem.content;
			
			_uiResDomain = windowResource.loaderInfo.applicationDomain;
			
			initWindow();
		}
		
		protected function initWindow():void
		{
			
		}
		/**
		 * 加载的swf的导出类得到BitmapData 
		 * @param className
		 * @return 
		 * 
		 */
		protected function getSwfBD(className:String):BitmapData {
			
			try {
				
				if(bitmapDataDict[className] == undefined) {
					
					bitmapDataDict[className] = new (_uiResDomain.getDefinition(className) as Class)() as BitmapData;
				}
				
				return bitmapDataDict[className];
			}
			catch(e:Error) {
				
				return null;
			}
		}

		public function get uiResDomain():ApplicationDomain
		{
			return _uiResDomain;
		}

		
	}
}