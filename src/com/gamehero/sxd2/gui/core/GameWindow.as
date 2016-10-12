package com.gamehero.sxd2.gui.core {
	
	
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.GText;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.HintLabel;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.geom.Rectangle;
	import flash.system.ApplicationDomain;
	import flash.text.TextFormatAlign;
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;
	
	import bowser.loader.BulkLoaderSingleton;
	import bowser.utils.GameTools;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	
	import org.bytearray.display.ScaleBitmap;
	
	
	[Event(name="complete", type="flash.events.Event")]
	
	
	/**
	 * Game Window
	 * @author Trey
	 * @create-date: 2013-8-8
	 */
	// Modify by Trey, 2014-2-25, 优化getSwfBD()方法，使用Dictionary保存已经new的BitmapData（避免重复new）
	public class GameWindow extends BaseWindow {
		
		private var bitmapDataDict:Dictionary = new Dictionary(); 

		protected var resourceURL:String;
		protected var loader:BulkLoaderSingleton;
		protected var isLoading:Boolean = false;
		
		protected var windowResource:MovieClip;
		private var _uiResDomain:ApplicationDomain;

		// 是否正在播放打开关闭窗口缓动
		protected var isTweening:Boolean = false;
		// 是否onShow时同时播放打开窗口的缓动
		protected var isTweenWithOnshow:Boolean = false;
		
		///////////////////////////////////////////////////////////////////////////////
		//	CONSTRUCTOR
		///////////////////////////////////////////////////////////////////////////////


		public function GameWindow(position:int, resourceURL:String = null, width:Number = 0, height:Number = 0)
		{	
			super(position);
			
		}
		
		
		/**
		 * Init Window<br/>
		 * Run Only Once
		 */
		protected function initWindow():void 
		{
				
		}
		
		
		override protected function onShow():void
		{
			//还原缓动标志
			isTweening = false;
			
			super.onShow();
		}
		
		
		
		
		/**
		 * Swf Resource Complete Handler 
		 * @param event 
		 */
		protected function onWindowResourceLoaded(e:Event = null):void
		{
			_loaded = true;
			isLoading = false;
			
			if(resourceURL)
			{
				var imageItem:ImageItem = e.currentTarget as ImageItem;
				imageItem.removeEventListener(ProgressEvent.PROGRESS, onWindowResourceProgress);
				imageItem.removeEventListener(Event.COMPLETE, onWindowResourceLoaded);
				
				windowResource = imageItem.content;
				
				_uiResDomain = windowResource.loaderInfo.applicationDomain;
			}
			
			initWindow();
			// 增加100ms延迟，防止窗口打开时有卡顿的感觉
			setTimeout(show, 100);
		}
		
		
		/**
		 * Window Resource Progress Handler
		 * @param event
		 * 
		 */
		protected function onWindowResourceProgress(event:ProgressEvent):void {
			
			var progressEvent:ProgressEvent = new ProgressEvent(ProgressEvent.PROGRESS);
			progressEvent.bytesLoaded = event.bytesLoaded;
			progressEvent.bytesTotal = event.bytesTotal;
			
			this.dispatchEvent(progressEvent);
		}		
		
		
		
		/**
		 * 更新窗口参数
		 * */
		public function updateParam(param:Object):void
		{
			
		}
		
		
		
		
		
		/**
		 * Close Button Click Handler 
		 * @param event
		 * 
		 */
		override public function close():void
		{	
			//还原缓动标志
			isTweening = false;
			
			
			/** 暂停加载并移除未加载项 */
			if(loader) {
				
				loader.pauseAndRemoveAllPaused();
			}
			
			super.close();
			
			GameTools.forceGC();
		}
		
		
		
		
	}
}