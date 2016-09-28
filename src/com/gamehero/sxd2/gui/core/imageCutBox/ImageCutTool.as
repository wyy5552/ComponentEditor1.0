package com.gamehero.sxd2.gui.core.imageCutBox
{
	import com.gamehero.sxd2.gui.core.imageCutBox.imageUi.ImageAdjustSize;
	import com.gamehero.sxd2.gui.core.imageCutBox.imageUi.ImageCutBox;
	import com.gamehero.sxd2.manager.DialogManager;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	/**
	 * @author Wbin
	 */
	public class ImageCutTool extends Sprite
	{
		private static const IMAGE_MAX_SIZE:int = 256;
		
		/**
		 * 裁剪框最小尺寸
		 * */
		private static const IMAGE_MIN_SIZE:int = 50;
		/**
		 * 画布尺寸
		 * */
		public static var MASK_WIDTH:int;
		public static var MASK_HEIGHT:int;
		/**
		 * 裁剪框最大尺寸 取短边
		 * */
		public static var CUT_BOX_MAX:int;
		
		/**
		 * 加载本地资源类库
		 * */
		private var file:FileReference;
		/**
		 * 加载进来的图片
		 * */
		private var loadBitmap:Bitmap;
		
		/**
		 * 拉伸框相对于遮罩区域的位置
		 * */
		private var leftP:Point;
		private var rightP:Point;
		
		/**
		 * 裁剪框 
		 */
		private var box:ImageCutBox;
		/**
		 * 加载下来的位图数据
		 * */
		private var loadFileBitmapData:BitmapData;
		
		private var rect:Rectangle;
		
		/**
		 * 裁剪的源数据
		 * */
		private var bytes:ByteArray;
		/**
		 * 填充的数据 非最终保存数据
		 * </br> 待压缩
		 * */
		private var cutByte:ByteArray;
		
		
		/**
		 * 缩放比例
		 * */
		private var scale:Number = 1.0;
		/**
		 * 图形缩放全部显示以后偏移量
		 * */
		private var offestX:int = 0;
		private var offestY:int = 0;
		/**
		 * 预览用的bitmapdata
		 * */
		private var scanBd:BitmapData;
		/**
		 * 预览图片的rect
		 * */
		private var scanRet:Rectangle;
		/**
		 * 预览图片256*256
		 * */
		private var scanBp:Bitmap;
		
		/**
		 * 预览画布
		 * */
		private var canvs:Sprite;
		/**
		 * 要上传的位图数据
		 * */
		private var uploadBmd:BitmapData;
		
		public function ImageCutTool(w:int , h:int):void
		{
			MASK_WIDTH = w;
			
			MASK_HEIGHT = h;
			
			this.init();
		}
		
		private function init():void
		{
			//马赛克底图
			/*var maskBg:Sprite = ImageBackGrundMasks.drawLattice(0,0,MASK_WIDTH,MASK_HEIGHT);
			this.addChild(maskBg);*/
			
			//初始化加载图片
			loadBitmap = new Bitmap();
			this.addChild(loadBitmap);
			
			//初始化预览图片
			scanBp = new Bitmap();
			
			file = new FileReference();
			
			canvs = new Sprite();
			
			uploadBmd = new BitmapData(IMAGE_MAX_SIZE,IMAGE_MAX_SIZE,true,0);
			
			this.addEventListener(Event.CHANGE,onCutChange);
		}
		
		/**
		 * 裁剪区域变化
		 * */
		protected function onCutChange(event:Event):void
		{
			// TODO Auto-generated method stub
			leftP = box.left_point;
			rightP = box.right_point;
			
			this.cut();
		}
		
		/**
		 * 错误加载
		 * */
		private function IoErrorHalder(evt:IOErrorEvent):void
		{
			evt.target.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,IoErrorHalder);
			evt.target.contentLoaderInfo.removeEventListener(Event.COMPLETE,ImageComHalder);
			
			loadBitmap.bitmapData.dispose();
			loadBitmap = null;
		}
		
		
		/**
		 * 完成加载
		 * */
		private function ImageComHalder(evt:Event):void
		{
			//加载完成移出事件
			file.removeEventListener(Event.SELECT,selected);
			
			loadFileBitmapData = (evt.target.content as Bitmap).bitmapData;
			
			var imageBytes:ByteArray = loadFileBitmapData.getPixels(new Rectangle(0,0,loadFileBitmapData.height,loadFileBitmapData.width));
			if(imageBytes.length > 12000000 || loadFileBitmapData.width > 1920 || loadFileBitmapData.height > 1080)
			{
				DialogManager.inst.showPrompt("图片尺寸过大！");
				return;
			}
			
			loadBitmap.bitmapData = loadFileBitmapData;
			
			//按比例缩放
			/**===================此处很关键，加载进来对象的宽高要用 loadFileBitmapData的宽高============================**/		
			ImageAdjustSize.setImageSize(loadBitmap,MASK_WIDTH,MASK_HEIGHT,loadFileBitmapData.width,loadFileBitmapData.height);
			
			CUT_BOX_MAX = Math.min(loadBitmap.width,loadBitmap.height);
//			trace("CUT_BOX_MAX = " + CUT_BOX_MAX);
			
			this.scale = ImageAdjustSize.scale;
			//显示原始尺寸
			/*ImageSize.setImageSize(loadBitmap,loadBitmap.width,loadBitmap.height,loadBitmap.width,loadBitmap.height);*/
			
			//居中显示
			offestX = loadBitmap.x = (MASK_WIDTH - loadBitmap.width)/2;
			offestY = loadBitmap.y = (MASK_HEIGHT - loadBitmap.height)/2;
			
			//裁剪框居中点
			var dis:Number = CUT_BOX_MAX/2;
			var lp:Point = new Point(loadBitmap.x + (loadBitmap.width - dis >> 1),loadBitmap.y + (loadBitmap.height -  dis >> 1));
			var rp:Point = new Point(lp.x + dis,lp.y + dis);
			//绘制初始裁剪框
			box = new ImageCutBox(lp,rp,offestX,offestY,loadBitmap.width,loadBitmap.height);
			this.addChild(box);
			
			//裁剪拉伸框 
			var _W:Number = MASK_WIDTH;
			var _H:Number = MASK_HEIGHT;
			var _X:Number = (_W - loadBitmap.width) / 2;
			var _Y:Number = (_H - loadBitmap.height) / 2;
			
			if (loadBitmap.width >= _W && loadBitmap.height >= _H)
			{
				box.latticeRetangle = new Rectangle(0, 0, _W, _H);
			}
			else if (loadBitmap.width >= _W || loadBitmap.height >= _H)
			{
				if (loadBitmap.width >= _W)
				{
					box.latticeRetangle = new Rectangle(0, _Y, _W, loadBitmap.height);
				}
				else if (loadBitmap.height >= _H)
				{
					box.latticeRetangle = new Rectangle(_X, 0, loadBitmap.width, _H);
				}
			}
			else
			{
				box.latticeRetangle = new Rectangle(_X, _Y, loadBitmap.width, loadBitmap.height);
			}
			
			box.dispatchCut();
		}
		
		
		/**
		 * 确认裁剪 
		 * */
		public function cut():void
		{
			// TODO Auto Generated method stub
			if(null == loadBitmap || null == loadBitmap.bitmapData)return;
			
			//相对坐标
			leftP = box.left_point;
			rightP = box.right_point;
			if(rightP.x - leftP.x < IMAGE_MIN_SIZE)
			{
				this.dispatchEvent(new ImageCutEvent(ImageCutEvent.CUT_SMALL));
				return;
			}
			//矩形区域 绝对坐标 
			var _x:int = (leftP.x - offestX)*scale;
			var _y:int = (leftP.y - offestY)*scale;
			var _w:int = (rightP.x - leftP.x)*scale;
			var _h:int = (rightP.y - leftP.y)*scale;
			rect = new Rectangle(_x , _y , _w ,_h);
			
			//创建二进制存储
//			bytes = new ByteArray();
//			bytes.writeUnsignedInt(rect.width);//写入宽
//			bytes.writeUnsignedInt(rect.height);//写入高
//			bytes.writeBytes(loadBitmap.bitmapData.getPixels(rect));//写入像素数据
			bytes = loadBitmap.bitmapData.getPixels(rect);
			bytes.position = 0;
			
			cutByte = new ByteArray();
			bytes.readBytes(cutByte);
			cutByte.position = 0;
			
			
			//读取二进制存储的宽高
//			var byteRect:Rectangle = new Rectangle(0,0,cutByte.readUnsignedInt(),cutByte.readUnsignedInt());
//			scanBd = new BitmapData(byteRect.width,byteRect.height,true,0);
			
			scanBd = new BitmapData(rect.width,rect.height,true,0);
			var newRect:Rectangle = new Rectangle(0,0,rect.width,rect.height);
			try
			{
				//填充二进制数据
				scanBd.setPixels(newRect,cutByte);
			}
			catch(e:Error)
			{
				
			}
			
			//填充预览图片
			scanBp.bitmapData = scanBd;
			scanBp.smoothing = true;
			scanBp.width = IMAGE_MAX_SIZE;
			scanBp.height = IMAGE_MAX_SIZE;
			
			//先清理画布
			if(canvs && canvs.numChildren > 0)
			{
				canvs.removeChildAt(0);
			}
			canvs.addChild(scanBp);
			
			//要上传的图像
			uploadBmd = new BitmapData(IMAGE_MAX_SIZE,IMAGE_MAX_SIZE,true,0);
			try
			{
				uploadBmd.draw(canvs);
				this.dispatchEvent(new ImageCutEvent(ImageCutEvent.SCAN_BITMAPDATA,uploadBmd));
			}
			catch(e:Error)
			{
			}
		}
		
		/**
		 * 保存图片
		 * */
		public function save():void
		{
			
		}
		
		/**
		 * load外部文件
		 * */
		public function loadFile():void
		{
			// TODO Auto Generated method stub
			file.browse();//浏览
			file.addEventListener(Event.SELECT,selected);//添加“选择文件”事件
		}
		
		private function selected(e:Event):void
		{
			//文件名后缀转义成小写
			var picName:String = file.type.toLowerCase();
			if(picName ==".jpg" || picName ==".png")
			{
				file.load();//加载
				file.addEventListener(Event.COMPLETE,onCompleteLoaded);//添加加载完成事件
			} 
		}
		
		private function onCompleteLoaded(e:Event):void
		{
			var byteArray:ByteArray = ByteArray(e.target.data); //处理数据 
			
			var loader:Loader = new Loader();
			loader.loadBytes(byteArray);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,ImageComHalder);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,IoErrorHalder)
		}
		
		public function clear():void
		{
			if(box)
			{  
				box.clear();
				this.removeChild(box);
				box = null;
			}
			
			if(scanBd)
			{
				scanBd.dispose();
			}
			
			if(loadBitmap)
			{
				loadBitmap.bitmapData = null;
			}
			
			if(loadFileBitmapData)
			{
				loadFileBitmapData.dispose();
			}
		}
	}
}