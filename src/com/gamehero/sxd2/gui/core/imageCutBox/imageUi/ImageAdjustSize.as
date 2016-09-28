package com.gamehero.sxd2.gui.core.imageCutBox.imageUi
{
	/**
	 * 设置图片大小类
	 * @author Wbin</br>
	 * 按照图片的宽高比例压缩
	 */
	public class ImageAdjustSize 
	{
		/**
		 * 位图按比例缩放的比例
		 * */
		public static var scale:Number = 1.0;
		
		public function ImageAdjustSize() 
		{
			
		}
		
		/**
		 * 参数说明
		 * @param	Image：需要设置大小的显示对象
		 * @param	FrameWidth:框架宽度
		 * @param	FrameHeight:框架高度
		 * @param	ImageWidth:图片加载进来时宽度
		 * @param	ImageHeight:图片加载进来时高度
		 * 
		 * 
		 * </br>    宽高按原始比例缩放布满画布
		 */
		public static function setImageSize(Image:*,FrameWidth:Number,FrameHeight:Number,ImageWidth:Number, ImageHeight:Number):void
		{
			if ((ImageWidth / ImageHeight) > (FrameWidth / FrameHeight))
			{
				//宽比 > 高比  先处理宽
				Image.width = FrameWidth;
				Image.height = FrameWidth / (ImageWidth / ImageHeight);
				
				//缩放系数为 宽比
				scale = ImageWidth / FrameWidth;
				//trace("宽比 ：" + scale);
			}
			else if ((ImageWidth / ImageHeight) < (FrameWidth / FrameHeight))
			{
				//宽比 < 高比  先处理高
				Image.height = FrameHeight;
				Image.width =  ImageWidth * (FrameHeight / ImageHeight);
				
				//缩放系数为 高比
				scale = ImageHeight / FrameHeight;
				//trace("高比 ：" + scale);
			}
			else if ((ImageWidth / ImageHeight) == (FrameWidth / FrameHeight))
			{
				//宽比 = 高比 
				Image.width = FrameWidth;
				Image.height = FrameHeight;
				
				//缩放系数为 高比/宽比
				scale = ImageWidth / FrameWidth;
				//trace("等比 ：" + scale);
			}
		}
	}
}