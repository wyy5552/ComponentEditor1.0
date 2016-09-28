package com.gamehero.sxd2.gui.core.imageCutBox.imageUi
{
	import com.gamehero.sxd2.gui.core.imageCutBox.ImageCutTool;
	
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	import alternativa.gui.base.ActiveObject;
	import alternativa.gui.mouse.CursorManager;

	public class ImageCutBox extends ActiveObject
	{
		/**
		 * 框选最小尺寸
		 * */
		private static const MIN_RECT:int = 50;
		
		/**
		 * 缩略图的偏移
		 */
		private var imageOffestX:int = 0;
		private var imageOffestY:int = 0;
		/**
		 * 缩略图大小
		 * */
		private var imagewith:int = 0;
		private var imageheight:int = 0;
		
		public var left_point:Point;
		public var right_point:Point;
		
		/**
		 * 裁剪框对象边线  
		 * */
		private var rect:Sprite;
		/**
		 * 中心裁剪拖拽对象
		 * */
		private var center:Sprite;
		/**
		 * 拖拽点以后矩形的宽度
		 * */
		private var centerWidth:int = 0;
		
		private var left_top:Sprite;
		private var top:Sprite;
		private var right_top:Sprite;
		private var left:Sprite;
		private var right:Sprite;
		private var left_below:Sprite;
		private var below:Sprite;
		private var right_below:Sprite;
		private var spritecount:Sprite;
		
		/**
		 * 四个点的拖拽对象池
		 * */
		private var _LeftorBelow:LeftorBelow;
		private var _LeftorRight:LeftorRight;
		private var _RightorBelow:RightorBelow;
		private var _ToporBelow:ToporBelow;
		/**
		 * 选区对象池
		 * */
		private var _cutBox:CenterDragCell;
		/**
		 * 裁剪拉伸框可拖拽的区域
		 * */
		public var latticeRetangle:Rectangle;
		
		/**
		 * 鼠标点下的对象
		 * */
		private var downSp:Sprite;
		/**
		 * 拖拽的对象
		 * */
		private var MousePointer:Sprite;
		
		/**
		 * 擦除透明裁剪区域
		 * */
		private var cutArea:Sprite = new Sprite();
		
		/**
		 * 裁剪框是否发生变化
		 * */
		private var isChange:Boolean = false;
		
		public function ImageCutBox(left_point:Point,right_point:Point,offX:int,offY:int,imgwth:int,imghei:int):void
		{
			/*CursorManager.cursorType = CursorManager.SWORD;*/
			this.cursorType = CursorManager.HAND;
			
			this.left_point = left_point;
			this.right_point = right_point;
			this.centerWidth = this.right_point.x - this.left_point.x;
			
			this.imageOffestX = offX;
			this.imageOffestY = offY;
			this.imagewith = imgwth;
			this.imageheight = imghei;
			
			this.init();
		}
		
		private function init():void
		{
			this.rect = new Sprite();
			this.center = new Sprite();
			
			//绘制初始裁剪框
			this.draw();
			//裁剪层容器
			this.spritecount = new Sprite();
			this.addChild(this.spritecount);
			
			//绘制灰色遮罩
			var imageMask:Sprite = new Sprite();
			imageMask.graphics.beginFill(0x000000,0.5);
			imageMask.graphics.drawRect(0,0,ImageCutTool.MASK_WIDTH,ImageCutTool.MASK_HEIGHT);
			imageMask.graphics.endFill();
			imageMask.blendMode = BlendMode.LAYER;
			this.spritecount.addChild(imageMask);
			
			//绘制初始高亮区域
			drawlight(this.left_point.x,this.left_point.y,this.right_point.x - this.left_point.x,this.right_point.y - this.left_point.y);
			//遮罩区域添加高亮区域
			imageMask.addChild(cutArea);
			
			this.spritecount.addChild(this.rect);

			//绘制拖拽点
			this.left_top = drawLattice();
			this.top = drawLattice();
			this.right_top = drawLattice();
			this.left = drawLattice();
			this.right = drawLattice();
			this.left_below = drawLattice();
			this.below = drawLattice();
			this.right_below = drawLattice();

			//定义拖拽点
			this.left_top.name = "left_top";
			this.top.name = "top";
			this.right_top.name = "right_top";
			this.left.name = "left";
			this.right.name = "right";
			this.left_below.name = "left_below";
			this.below.name = "below";
			this.right_below.name = "right_below";
			this.center.name = "center";
			
			this.cutArea.name = "cutArea";

			//添加拖拽点到裁剪容器
			this.spritecount.addChild(this.center);
			this.spritecount.addChild(this.left_top);
			this.spritecount.addChild(this.top);
			this.spritecount.addChild(this.right_top);
			this.spritecount.addChild(this.left);
			this.spritecount.addChild(this.right);
			this.spritecount.addChild(this.left_below);
			this.spritecount.addChild(this.below);
			this.spritecount.addChild(this.right_below);

			//调整拖拽点位置
			adjustPosition();

			this._LeftorBelow = new LeftorBelow();
			this._LeftorRight = new LeftorRight();
			this._RightorBelow = new RightorBelow();
			this._ToporBelow = new ToporBelow();
			this._cutBox = new CenterDragCell();

			this.spritecount.addChild(this._LeftorBelow);
			this.spritecount.addChild(this._LeftorRight);
			this.spritecount.addChild(this._RightorBelow);
			this.spritecount.addChild(this._ToporBelow);
			this.spritecount.addChild(this._cutBox);
			
			this._LeftorBelow.visible = false;
			this._LeftorRight.visible = false;
			this._RightorBelow.visible = false;
			this._ToporBelow.visible = false;
			
			this._LeftorBelow.mouseEnabled = false;
			this._LeftorRight.mouseEnabled = false;
			this._RightorBelow.mouseEnabled = false;
			this._ToporBelow.mouseEnabled = false;
			
			this.latticeRetangle = new Rectangle(0,0,ImageCutTool.MASK_WIDTH,ImageCutTool.MASK_HEIGHT);
			
			eventManager();
		}
		
		/**
		 * 事件管理器
		 * */
		private function eventManager():void
		{
			//拖拽点监听
			this.left_top.addEventListener(MouseEvent.MOUSE_OVER,eventFunction);
			this.top.addEventListener(MouseEvent.MOUSE_OVER,eventFunction);
			this.right_top.addEventListener(MouseEvent.MOUSE_OVER,eventFunction);
			this.left.addEventListener(MouseEvent.MOUSE_OVER,eventFunction);
			this.right.addEventListener(MouseEvent.MOUSE_OVER,eventFunction);
			this.left_below.addEventListener(MouseEvent.MOUSE_OVER,eventFunction);
			this.below.addEventListener(MouseEvent.MOUSE_OVER,eventFunction);
			this.right_below.addEventListener(MouseEvent.MOUSE_OVER,eventFunction);
			this.center.addEventListener(MouseEvent.MOUSE_OVER,eventFunction);
			
			App.ui.stage.addEventListener(MouseEvent.MOUSE_UP,stageUpFunction);
			
			this.addEventListener(Event.ENTER_FRAME,onFrame);
		}
		
		protected function onFrame(event:Event = null):void
		{
			// TODO Auto-generated method stub
			//鼠标超出缩略位图区域
			/*if(this.mouseX < this.imageOffestX)
			{
				stageUpFunction();
			}
			
			if(this.mouseX > (this.imageOffestX + this.imagewith))
			{
				stageUpFunction();
			}
			
			if(this.mouseY < this.imageOffestY)
			{
				stageUpFunction();
			}
			
			if(this.mouseY > (this.imageOffestY + this.imageheight))
			{
				stageUpFunction();
			}*/
			
			//实时重绘的矩形宽高
			var rw:Number;
			var rh:Number;
			
			if(this.center.x < this.imageOffestX)
			{
				isChange = true;
				
//				trace("左边界到了" + this.center.x + " "+ this.imageOffestX);
				//调整相对坐标
				this.left_point.x = this.imageOffestX;
				
				rw = this.right_point.x - this.left_point.x;
				rw = rw > this.imagewith ? this.imagewith : rw;
				
				this.right_point.x = this.left_point.x + rw;
				this.right_point.y = this.left_point.y + rw;
			}
			
			if((this.center.x + this.center.width)  > (imageOffestX + imagewith))
			{
				isChange = true;
				
//				trace("右边界到了"+ (this.center.x + this.center.width) + " "+ (imageOffestX + imagewith));
				//调整相对坐标
				this.right_point.x = imageOffestX + imagewith;
				
				rw = this.right_point.y - this.left_point.y;
				rw = rw > this.imagewith ? this.imagewith : rw;
				
				this.left_point.x = this.right_point.x - rw;
				this.left_point.y = this.right_point.y - rw;
			}
			
			if(this.center.y < this.imageOffestY)
			{
				isChange = true;
				
//				trace("上边界到了" + this.center.y + " "+ this.imageOffestY);
				//调整相对坐标
				this.left_point.y = this.imageOffestY;
				
				rh = this.right_point.x - this.left_point.x;
				rh = rh > this.imageheight ? this.imageheight : rh;
				this.right_point.x = this.left_point.x + rh;
				this.right_point.y = this.left_point.y + rh;
			}
			
			if((this.center.y + this.center.height) > (imageOffestY + imageheight))
			{
				isChange = true;
				
//				trace("下边界到了" + (this.center.y + this.center.height) + " "+ (imageOffestY + imageheight));
				//调整相对坐标
				this.right_point.y = imageOffestY + imageheight;
				
				rh = this.right_point.x - this.left_point.x;
				rh = rh > this.imageheight ? this.imageheight : rh;
				this.left_point.x = this.right_point.x - rh;
				this.left_point.y = this.right_point.y - rh;
			}
			
			redraw();
		}
		
		
		private function eventFunction(evt:MouseEvent):void
		{
			switch (evt.currentTarget.name)
			{
				case "left_top" :
					{
						everythFunction(evt,this._LeftorBelow);
						break;
					}
					
				case "top" :
					{
						everythFunction(evt,this._ToporBelow);
						break;
					}
					
				case "right_top" :
					{
						everythFunction(evt,this._RightorBelow);
						break;
					}
					
				case "left" :
					{
						everythFunction(evt,this._LeftorRight);
						break;
					}
					
				case "right" :
					{
						everythFunction(evt,this._LeftorRight);
						break;
					}
					
				case "left_below" :
					{
						everythFunction(evt,this._RightorBelow);
						break;
					}
					
				case "below" :
					{
						everythFunction(evt,this._ToporBelow);
						break;
					}
					
				case "right_below" :
					{
						everythFunction(evt,this._LeftorBelow);
						break;
					}
					
				case "center" :
					{
						everythFunction(evt,this._cutBox);
						break;
					}
			}
		}
		
		private function stageUpFunction(evt:MouseEvent = null):void
		{
			if(this.downSp != null && this.MousePointer != null)
			{
				if(this.hasEventListener(MouseEvent.MOUSE_MOVE))
				{
					this.downSp.stopDrag();
					this.removeEventListener(MouseEvent.MOUSE_MOVE,stageMoveFunction);
					this.downSp.removeEventListener(MouseEvent.MOUSE_UP,eventFunction);
					
//					trace("mouseMove " + downSp + " " + MousePointer);
				}
				
				if(this.downSp.hasEventListener(MouseEvent.MOUSE_OUT))
				{
					//Mouse.show();
					this.MousePointer.visible = false;
					this.downSp.removeEventListener(MouseEvent.MOUSE_OUT,eventFunction);
					
//					trace("stageup " + MousePointer)
				}
				this.dispatchCut();
				this.downSp = null;
			}
			
			isChange = false;
		}
		
		public function dispatchCut():void
		{
			// TODO Auto Generated method stub
			this.dispatchEvent(new Event(Event.CHANGE,{left:left_point,right:right_point}));
		}
		
		private function everythFunction(evt:MouseEvent,Pointer:Sprite):void
		{
			if (evt.type == "mouseOver" && evt.buttonDown == false)
			{
				this.MousePointer = Pointer;
				//Mouse.hide();
				this.MousePointer.visible = true;
//				this.MousePointer.x = this.mouseX;
//				this.MousePointer.y = this.mouseY;
				evt.currentTarget.addEventListener(MouseEvent.MOUSE_DOWN,eventFunction);
				evt.currentTarget.addEventListener(MouseEvent.MOUSE_UP,eventFunction);
				evt.currentTarget.addEventListener(MouseEvent.MOUSE_OUT,eventFunction);
				
//				trace("over " + MousePointer)
			}
			else if (evt.type == "mouseDown")
			{
				this.downSp = evt.target as Sprite;
				
				if(this.downSp.name != this.center.name)
				{
					this.spritecount.setChildIndex(this.downSp,this.spritecount.numChildren - 1);
				}
				
				evt.target.startDrag(false,this.latticeRetangle);
				this.addEventListener(MouseEvent.MOUSE_MOVE,stageMoveFunction);
//				evt.currentTarget.removeEventListener(MouseEvent.MOUSE_DOWN,eventFunction);
				
//				trace("down " + MousePointer + " " + downSp)
			}
			else if (evt.type == "mouseUp")
			{
				evt.target.stopDrag();
				this.removeEventListener(MouseEvent.MOUSE_MOVE,stageMoveFunction);
				evt.currentTarget.removeEventListener(MouseEvent.MOUSE_UP,eventFunction);
				
//				trace("up " + MousePointer)
			}
			else if (evt.type == "mouseOut" && evt.buttonDown == false)
			{
				//Mouse.show();
				this.MousePointer.visible = false;
				evt.currentTarget.removeEventListener(MouseEvent.MOUSE_OUT,eventFunction);
				
//				trace("out " + MousePointer)
			}
		}
		
		private function stageMoveFunction(evt:MouseEvent):void
		{
			if(this.downSp != null)
			{
				isChange = true;
				
				setMousePointer();
				
//				this.MousePointer.x = this.mouseX;
//				this.MousePointer.y = this.mouseY;
				
				if(this.downSp.name == "left_top")
				{
					//自由
//					this.left_point.x = this.left_top.x;
//					this.left_point.y = this.left_top.y;
					//定比1:1
					this.left_point.x = this.left_top.x;
					this.left_point.y = this.right_point.y - (this.right_point.x - this.left_point.x);
				}
				else if(this.downSp.name == "top")
				{
					//自由
//					this.left_point.y = this.top.y;
					//定比1:1
					this.left_point.y = this.top.y;
					this.left_point.x = this.below.x - (this.below.y - this.left_point.y)/2;
					this.right_point.x = this.below.x + (this.below.y - this.left_point.y)/2
				}
				else if(this.downSp.name == "right_top")
				{
					//自由
//					this.left_point.y = this.right_top.y;
//					this.right_point.x = this.right_top.x;
					//定比1:1
					this.right_point.x = this.right_top.x;
					this.left_point.y = this.right_point.y - (this.right_point.x - this.left_point.x);
				}
				else if(this.downSp.name == "left")
				{
					//自由
//					this.left_point.x = this.left.x;
					//定比1:1
					this.left_point.x = this.left.x;
					this.left_point.y = this.right.y - (this.right.x - this.left_point.x)/2;
					this.right_point.y = this.right.y + (this.right.x - this.left_point.x)/2;
				}
				else if(this.downSp.name == "right")
				{
					//自由
//					this.right_point.x = this.right.x;
					//定比1:1
					this.right_point.x = this.right.x;
					this.right_point.y = this.left.y + (this.right_point.x - this.left_point.x)/2;
					this.left_point.y = this.left.y - (this.right_point.x - this.left_point.x)/2;
				}
				else if(this.downSp.name == "left_below")
				{
					//自由
//					this.left_point.x = this.left_below.x;
//					this.right_point.y = this.left_below.y;
					//定比1:1
					this.left_point.x = this.left_below.x;
					this.right_point.y = this.left_point.y + (this.right_point.x - this.left_point.x);
				}
				else if(this.downSp.name == "below")
				{
					//自由
//					this.right_point.y = this.below.y;
					//定比1:1
					this.right_point.y = this.below.y
					this.left_point.x = this.top.x - (this.right_point.y - this.left_point.y)/2;
					this.right_point.x = this.top.x + (this.right_point.y - this.left_point.y)/2
				}
				else if(this.downSp.name == "right_below")
				{
					//自由
//					this.right_point.x = this.right_below.x;
//					this.right_point.y = this.right_below.y;
					//定比1:1
					this.right_point.x = this.right_below.x;
					this.right_point.y = this.left_point.y + (this.right_point.x - this.left_point.x);
				}
				else if(this.downSp.name == "center")
				{
					//中心拖拽
					if(this.center.x + this.centerWidth > this.imageOffestX + this.imagewith)
					{
					}
					else if(this.center.y + this.centerWidth > this.imageOffestY + this.imageheight)
					{
					}
					
					this.left_point.x = this.center.x;
					this.left_point.y = this.center.y;
					this.right_point.x = this.center.x + this.centerWidth;
					this.right_point.y = this.center.y + this.centerWidth;
					
//					this.right_point.x = this.center.x + this.center.width;
//					this.right_point.y = this.center.y + this.center.height;
				}
				//每一帧去处理，不在拖动的时候处理，会有卡顿
//				redraw();
				
				this.onFrame();
				this.centerWidth = this.right_point.x - this.left_point.x;
			}
		}
		
		/**
		 * 帧听鼠标拖拽对象是否超出边界
		 * */
		private function setMousePointer():void
		{
			//鼠标超出缩略位图区域
			if((this.mouseX < this.imageOffestX)||
				(this.mouseX > (this.imageOffestX + this.imagewith))||
				(this.mouseX > (this.imageOffestX + this.imagewith))||
				(this.mouseY < this.imageOffestY)||
				(this.mouseY > (this.imageOffestY + this.imageheight)))
			{
				return;
			}
			
			this.MousePointer.x = this.mouseX;
			this.MousePointer.y = this.mouseY;
		}
		
		/**
		 * 重绘裁剪区域
		 * */
		private function redraw():void
		{
			//限制反拉
			if(this.left_point.x > this.right_point.x)
			{
				isChange = true;
				this.right_point.x = this.left_point.x;
			}
			else if(this.left_point.y > this.right_point.y)
			{
				isChange = true
				this.right_point.y = this.left_point.y;
			}
			
			//重绘裁剪框
			if(isChange == true)
			{
				isChange = false;
				draw();
				drawlight(this.left_point.x,this.left_point.y,this.right_point.x - this.left_point.x,this.right_point.y - this.left_point.y);
			}
			//调整相对坐标
			adjustPosition();
		}
		
		/**
		 * 校正拖拽点位置
		 * */
		private function adjustPosition():void
		{
			//拖拽点间距
			var numx:Number = (this.right_point.x - this.left_point.x) / 2;
			var numy:Number = (this.right_point.y - this.left_point.y) / 2;
				
			this.left_top.x = this.left_point.x;
			this.left_top.y = this.left_point.y;
			
			this.top.x = this.left_point.x + numx;
			this.top.y = this.left_point.y;
			
			this.right_top.x = this.right_point.x;
			this.right_top.y = this.left_point.y;
			
			this.left.x = this.left_point.x;
			this.left.y = this.left_point.y + numy;
			
			this.right.x = this.right_point.x;
			this.right.y = this.left_point.y + numy;
			
			this.left_below.x = this.left_point.x;
			this.left_below.y = this.right_point.y;
			
			this.below.x = this.left_point.x + numx;
			this.below.y = this.right_point.y;
			
			this.right_below.x = this.right_point.x;
			this.right_below.y = this.right_point.y;
			
			this.center.x = this.left_point.x;
			this.center.y = this.left_point.y;
		}
		
		/**
		 * 绘制边框
		 * */
		private function draw():void
		{
			this.rect.graphics.clear();
			this.rect.graphics.beginFill(0xFFFF33,0);
			this.rect.graphics.lineStyle(1,0xFFFF33);
			this.rect.graphics.moveTo(this.left_point.x,this.left_point.y);
			this.rect.graphics.lineTo(this.right_point.x,this.left_point.y);
			this.rect.graphics.lineTo(this.right_point.x,this.right_point.y);
			this.rect.graphics.lineTo(this.left_point.x,this.right_point.y);
			this.rect.graphics.lineTo(this.left_point.x,this.left_point.y);
			
//			trace(this.left_point.x,this.left_point.y,this.right_point.x,this.left_point.y);
		}
		
		/**
		 * 绘制锚点
		 * */
		private function drawLattice():Sprite
		{
			var sp:Sprite = new Sprite();
			sp.graphics.beginFill(0xFFFF33,1);
			sp.graphics.lineStyle(1,0xFFFF33);
			sp.graphics.drawRect(-5,-5,10,10);
			sp.graphics.endFill();

			return sp;
		}
		
		/**
		 * 绘制选区
		 * */
		private function drawlight(_x:Number,_y:Number,_w:Number,_h:Number):void
		{
			//mask像素处理区域
			this.cutArea.graphics.clear();
			this.cutArea.graphics.beginFill(0x000000);
			this.cutArea.graphics.drawCircle(Math.floor(_w/2),Math.floor(_w/2),Math.floor(_w/2));
			this.cutArea.graphics.endFill()
//			this.cutArea.graphics.beginFill(0x000000);
//			this.cutArea.graphics.drawRect(0,0,W,H);
//			this.cutArea.graphics.endFill();
			
			this.cutArea.x = _x;
			this.cutArea.y = _y;
			
			this.cutArea.blendMode = BlendMode.ERASE;
			
			
			//绘制拖拽对象
			this.center.graphics.clear();
//			this.center.graphics.lineStyle(1,0xFFFF33);
			this.center.graphics.beginFill(0x000000 , 0);
			this.center.graphics.drawCircle(Math.floor(_w/2),Math.floor(_w/2),Math.floor(_w/2));
			this.center.graphics.endFill();
//			this.center.graphics.beginFill(0x000000 , 0.5);
//			this.center.graphics.drawRect(0,0,W,H);
//			this.center.graphics.endFill();
			
//			if(this.downSp)
//			{
//				trace("X " + _x + " Y " + _y + " downSp " + this.downSp.name + "center.wi " + center.width + " center.hi " + center.height);
//			}
		}
		
		public function clear():void
		{
			// TODO Auto Generated method stub
			
			if(left_top)
				this.left_top.removeEventListener(MouseEvent.MOUSE_OVER,eventFunction);
			if(left_top)
				this.top.removeEventListener(MouseEvent.MOUSE_OVER,eventFunction);
			if(left_top)
				this.right_top.removeEventListener(MouseEvent.MOUSE_OVER,eventFunction);
			if(left_top)
				this.left.removeEventListener(MouseEvent.MOUSE_OVER,eventFunction);
			if(left_top)
				this.right.removeEventListener(MouseEvent.MOUSE_OVER,eventFunction);
			if(left_top)
				this.left_below.removeEventListener(MouseEvent.MOUSE_OVER,eventFunction);
			if(left_top)
				this.below.removeEventListener(MouseEvent.MOUSE_OVER,eventFunction);
			if(left_top)
				this.right_below.removeEventListener(MouseEvent.MOUSE_OVER,eventFunction);
			if(_cutBox)
				this._cutBox.removeEventListener(MouseEvent.MOUSE_OVER,eventFunction);
			
			App.ui.stage.removeEventListener(MouseEvent.MOUSE_UP,stageUpFunction);
			
			this.removeEventListener(Event.ENTER_FRAME,onFrame);
			
			while(this.numChildren > 0)
			{
				this.removeChildAt(0);
			}
		}
		
	}
}