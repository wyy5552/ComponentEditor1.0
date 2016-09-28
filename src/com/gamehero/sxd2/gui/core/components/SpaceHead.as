package com.gamehero.sxd2.gui.core.components
{
	import com.gamehero.sxd2.core.URI;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.PlayerSkin;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	
	/**
	 * 空间头像，可自定义大小
	 * @author xuwenyi
	 * @create 2016-09-20
	 **/
	public class SpaceHead extends Sprite
	{
		//缩略图参数
		public static const SCALE_1:String = "";//原图256*256
		public static const SCALE_2:String = "!/sq/80";//80*80
		public static const SCALE_3:String = "!/sq/60";//60*60
		public static const SCALE_4:String = "!/sq/54";//54*54
		
		protected var _bitmap:Bitmap;
		private var loader:Loader;
		private var _url:String = "";
		// 头像圆形遮罩
		private var circleMask:Shape;
		// 缩放比例
		private var scale:String = "";
		// 性别
		protected var sex:int;
		// 是否审核中
		protected var isVerify:Boolean;
		// 是否设定默认头像
		protected var needDefaut:Boolean = true;
		
		
		/**
		 * 构造函数
		 * @param isVerify 是否在审核中
		 * */
		public function SpaceHead(scale:String = SCALE_4 , sex:int = 1 , isVerify:Boolean = false)
		{
			this.mouseEnabled = false;
			this.mouseChildren = false;
			this.tabEnabled = false;
			
			_bitmap = new Bitmap();
			this.addChild(_bitmap);
			
			this.scale = scale;
			this.sex = sex;
			this.isVerify = isVerify;
		}
		
		
		
		
		public function set url(value:String):void
		{
			this.clear();
			
			if(value != "")
			{
				_url = isVerify == false ? URI.headCDN : URI.headCDN2;	
				_url += value + scale;
				
				loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE , onLoaded);
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR , onError);
				loader.load(new URLRequest(_url) , new LoaderContext(true));
			}
			else
			{
				// 设置默认头像
				this.setDefautHead();
			}
		}
		
		
		
		
		
		protected function onLoaded(e:Event):void
		{
			var info:LoaderInfo = e.currentTarget as LoaderInfo;
			info.removeEventListener(Event.COMPLETE , onLoaded);
			info.removeEventListener(IOErrorEvent.IO_ERROR , onError);
			
			_bitmap.bitmapData = Bitmap(info.content).bitmapData;
			
			var w:int = _bitmap.width;
			var radius:int = w >> 1;
			
			//根据图片尺寸创建遮罩
			if(circleMask)
			{
				circleMask.graphics.clear();
			}
			else
			{
				circleMask = new Shape();
				this.addChild(circleMask);
			}
			circleMask.graphics.beginFill(0);
			circleMask.graphics.drawCircle(radius , radius , radius);
			circleMask.graphics.endFill();
			this.mask = circleMask;
			
			loader = null;
		}
		
		
		
		
		
		protected function onError(e:Event):void
		{
			var ld:Loader = e.currentTarget as Loader;
			ld.contentLoaderInfo.removeEventListener(Event.COMPLETE , onLoaded);
			ld.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR , onError);
			
			loader = null;
			this.clear();
			
			// 设置默认头像
			this.setDefautHead();
		}
		
		
		
		// 设置默认头像
		protected function setDefautHead():void
		{
			// 默认头像
			var bmd:BitmapData;
			
			if(needDefaut)
			{
				if(sex == 1)
				{
					switch(scale)
					{
						case SCALE_2:
							bmd = PlayerSkin.HEAD_80_M;
							break;
						case SCALE_3:
							bmd = PlayerSkin.HEAD_60_M;
							break;
						case SCALE_4:
							bmd = PlayerSkin.HEAD_54_M;
							break;
						default:
							bmd = PlayerSkin.HEAD_54_M;
							break;
					}
				}
				else
				{
					switch(scale)
					{
						case SCALE_2:
							bmd = PlayerSkin.HEAD_80_W;
							break;
						case SCALE_3:
							bmd = PlayerSkin.HEAD_60_W;
							break;
						case SCALE_4:
							bmd = PlayerSkin.HEAD_54_W;
							break;
						default:
							bmd = PlayerSkin.HEAD_54_W;
							break;
					}
				}
			}
			
			_bitmap.bitmapData = bmd;
		}
		
		
		
		
		public function clear():void
		{
			_bitmap.bitmapData = null;
			
			if(loader)
			{
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE , onLoaded);
				loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR , onError);
			}
			loader = null;
			
			if(circleMask && this.contains(circleMask) == true)
			{
				this.removeChild(circleMask);
				circleMask = null;
			}
			this.mask = null;
		}
	}
}