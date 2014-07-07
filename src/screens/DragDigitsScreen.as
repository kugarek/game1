package screens
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import actors.Digit;
	import actors.Eight;
	import actors.Five;
	import actors.Four;
	import actors.Nine;
	import actors.One;
	import actors.Seven;
	import actors.Six;
	import actors.Three;
	import actors.Two;
	import actors.Zero;
	
	import components.sidebar.SidebarMenu;
	
	import events.NavigationEvent;
	
	import feathers.dragDrop.DragData;
	import feathers.dragDrop.DragDropManager;
	import feathers.events.DragDropEvent;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	import utils.Animations;
	import utils.DragDropSource;
	import utils.DragDropTarget;
	import utils.SoundPlayer;
	
	
	public class DragDigitsScreen extends Sprite
	{				
		private var sidebarBgd:Image;
		private var menu:SidebarMenu;
		private var dragSourceContainer:DragDropSource;
		private var colorDigits:Array /* collection of coloured digits */;
		private var monoDigits:Array /* collection of monohromatical digits */;
		private var cords:Array = [Constants.ZERO_CORDS, Constants.ONE_CORDS, Constants.TWO_CORDS, 
			Constants.THREE_CORDS, Constants.FOUR_CORDS, Constants.FIVE_CORDS, Constants.SIX_CORDS, Constants.SEVEN_CORDS, 
			Constants.EIGHT_CORDS, Constants.NINE_CORDS] /* of Points which are cords for the digits */;
		private var draggedImageIndex:int;
		
		private var dragDropTargets:Vector.<DragDropTarget> /* of DragDropTarget's */;
		private var timer:Timer;
		
		public function DragDigitsScreen()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		
				
		private function onAddedToStage(e:Event):void
		{	
			this.addChild(Root.defaultBackground);	
			
			sidebarBgd = new Image(Root.assets.getTexture("sidebar_background"));
			sidebarBgd.y = 0;
			sidebarBgd.x = Root.stageWidth - sidebarBgd.width;
			this.addChild(sidebarBgd);
			
			menu = new SidebarMenu();	
			menu.y = 0;
			menu.x = sidebarBgd.x;
			this.addChild(menu);
			
			
			var layout:VerticalLayout = new VerticalLayout();
			layout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
			layout.padding = 15;
			layout.gap = 50;
			
			var calculatedY:int = menu.y + menu.height + 10;
			
			dragSourceContainer = new DragDropSource();
			dragSourceContainer.width = sidebarBgd.width;
			dragSourceContainer.height = Root.stageHeight - calculatedY;
			dragSourceContainer.layout = layout;				
			dragSourceContainer.y = calculatedY;
			dragSourceContainer.x = sidebarBgd.x;
			dragSourceContainer.verticalScrollPolicy = "off";
			dragSourceContainer.horizontalScrollPolicy = "off";
			dragSourceContainer.addEventListener(DragDropEvent.DRAG_START, onDragStartHandler);
			dragSourceContainer.addEventListener(DragDropEvent.DRAG_COMPLETE, onDragCompleteHandler);
			
			addChild(dragSourceContainer);
			
			createDigits();
			
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			this.addEventListener(TouchEvent.TOUCH, onClick);			
			addEventListener(NavigationEvent.REVERT,  revertToInitialState);
		}
		
		
		private function revertToInitialState(event:Event, eventName:String):void
		{
			onRemovedFromStage(null);
			onAddedToStage(null);
			
		}
		
		private function createDigits():void
		{
			colorDigits = [new Zero(), new One(), new Two(), new Three(), new Four(), new Five(), new Six(), new Seven(), new Eight(), new Nine()];			
			populateScreen();
		}
		
		
		/**
		 * Populate the drop container with the digits 
		 * for each digit create layoutGroup container 
		 * give the layout container cords from cords collection 
		 * add to stage
		 */
		private function populateScreen():void
		{
			var length:int = colorDigits.length;	
			var dropTarget:DragDropTarget;
			var dragSource:DragDropTarget;
			var backupCords:Array = [];
			var randomCords:Array = [];
			
			for(var c:int = 0; c < cords.length; c++)
			{
				backupCords.push( cords[c] );
			}
			
			while (backupCords.length > 0) {
				randomCords.push(backupCords.splice(Math.round(Math.random() * (backupCords.length - 1)), 1)[0]);
			}
			
			
			dragDropTargets = new Vector.<DragDropTarget>;
			
			for(var i:int = 0; i < length; i++) {				
				var d:Digit = colorDigits[i];	
				var img:Image = d.digitMono;
				
				dropTarget = new DragDropTarget();				
				dropTarget.width = img.width;
				dropTarget.height = img.height;
				dropTarget.pivotX = dropTarget.width /2;
				dropTarget.pivotY = dropTarget.height /2;
				dropTarget.addChild(img);
				dropTarget.x = randomCords[i].x;
				dropTarget.y = randomCords[i].y;
				dropTarget.name = img.name;
				dropTarget.addEventListener(DragDropEvent.DRAG_ENTER, dropEnterListener);
				
				dragDropTargets.push(dropTarget);//so they could be easily manipulated later
				this.addChild(dropTarget);
				
				var dragData:DragData = new DragData();
				dragData.setDataForFormat(d.name, d.digitColor);
				
				addPuzzlePiecesToSidebar(d.digitColor);
			}
		}
		
		
		
		public function initialize():void
		{
			this.visible = true;
			
		}
		
		
		
		/**
		 * Scales the puzzle pieces down to the constant value 
		 * and adds it to the drag source 
		 * @param value:Image
		 */
		public function addPuzzlePiecesToSidebar(value:Image):void
		{
			value.scaleX = Constants.SCALE_SIDEBAR_VALUE;
			value.scaleY = Constants.SCALE_SIDEBAR_VALUE;
			dragSourceContainer.addChild(value);
		}
		
				
		
		/**
		 * Main touch event listener which listens to any touch in the scene and then filters the event out
		 * to the images in the sidebar which are in the drag source contaner, starts drag 
		 */
		private function onClick(e:TouchEvent):void
		{
			var touches:Vector.<Touch> = e.getTouches(this);
			var clicked:DisplayObject = e.currentTarget as DisplayObject;
			if ( touches.length == 1 )
			{
				var touch:Touch = touches[0];   
				if ( touch.phase == TouchPhase.MOVED )
				{
					var image:Image = e.target as Image;
					
					if(image && image.parent.parent is DragDropSource) {
						
						draggedImageIndex = image.parent.parent.getChildIndex( image );
						
						image.pivotX = image.width  / 2.0;
						image.pivotY = image.height - 20;
						
						var dragData:DragData = new DragData();
						dragData.setDataForFormat(image.name, image);
						
						if(dragSourceContainer) {
							
							dragSourceContainer.name = image.name;
							dragSourceContainer.startDragX = touch.globalX;
							dragSourceContainer.startDragY = touch.globalY;
						}						
					}
					
					if(image && dragData && dragSourceContainer) {
						
						image.scaleX = Constants.SCALE_NORMAL_VALUE;
						image.scaleY = Constants.SCALE_NORMAL_VALUE;
						
						trace ("TouchEvent.TOUCH initiate drag >>> " + e.currentTarget, image.name );						
						DragDropManager.startDrag(dragSourceContainer, touch, dragData, image);
					}
					
				}				
			}
		}
		
		
		
		
		//-------------------------------------------------------------------------------------
		//
		//	DRAG AND DROP 
		//
		//--------------------------------------------------------------------------------------
		
		
		/**
		 * Handles drag start event 
		 */
		private function onDragStartHandler(event:DragDropEvent):void
		{
			trace("DragDropEvent.DRAG_START >>>");			
			startTimer();
		}
		
		
		/**
		 * Starts the timer wich tickes every 4 seconds 
		 */
		private function startTimer():void
		{
			trace("timer started");			
			timer = new Timer(4000, 1); 
			timer.addEventListener(TimerEvent.TIMER, onTimerEvent);			
			timer.start();
		}		
		
		
		
		/**
		 * Finds the drop target on the screen with the same name as dragged object
		 * and plays the jump animation on the found drag drop target to indicate the digit which expects the drop 
		 */
		protected function onTimerEvent(event:TimerEvent):void
		{
			for each (var target:DragDropTarget in dragDropTargets)
			{										
				//playJump(target);
				if(target.name == dragSourceContainer.name) {
					
					setChildIndex(target, this.numChildren - 1);
					Animations.jump(target, 0, 1 );
				}				
			}
			trace("timer event");
		}
		
		
		
		/**
		 * Listens for the DragDropEvent.DRAG_ENTER event and checks if the targer object should accept the drop 
		 * if so it attaches the event listener to the dragDropTarget which listens for the drag_drop event 
		 */
		private function dropEnterListener(event:DragDropEvent, dragData:DragData):void
		{
			var dropTarget:DragDropTarget;
			
			if(dragData.hasDataForFormat(DragDropTarget(event.currentTarget).name)) {
				
				dropTarget = event.currentTarget as DragDropTarget;				
				dropTarget.addEventListener(DragDropEvent.DRAG_DROP, dragDropListener);
				DragDropManager.acceptDrag(dropTarget);			
				
				trace(" DragDropEvent.DRAG_ENTER + accept drop >>>>" + dropTarget.name);
			}
		}
		
		
		
		/**
		 * Listens for a succesfull drop above the drop target 
		 */		
		private function dragDropListener(event:DragDropEvent):void
		{
			if(event.type == DragDropEvent.DRAG_DROP) {
				
				var dropTarget:DragDropTarget = event.currentTarget as DragDropTarget;	
				
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER, onTimerEvent);
								
				setChildIndex(dropTarget, this.numChildren - 1); //so when the digit jumps it is always above any other digit in displayObject list 				
				dropTarget.handleValidDrop(event.dragData.getDataForFormat(dropTarget.name));		
				
				dropTarget.removeEventListener(DragDropEvent.DRAG_ENTER, dropEnterListener);
				dropTarget.removeEventListener(DragDropEvent.DRAG_DROP, dragDropListener);
				
				isComplete();
				trace(" DragDropEvent.DRAG_DROP >>>>" + dropTarget.name);
			}
		}
		
		
		/**
		 * Each time the digit is dropped this function checks if the puzzles are complete
		 * if complete it invokes the animation for each one of the digits 
		 */
		private function isComplete():void
		{						
			if(dragSourceContainer.numChildren == 0) {
				
				for each (var target:DragDropTarget in dragDropTargets)
				{										
					//playJump(target);
					Animations.jump(target, Math.random(), 1 );
					SoundPlayer.playCrownCheeringSound();
				}
				
				trace("All pieces added, puzzle complete ");
			}
		}		
		
		
	
		
		/**
		 * Listens for the event when the touch is released
		 */
		private function onDragCompleteHandler(event:DragDropEvent):void
		{
			trace("DragDropEvent.DRAG_COMPLETE: isDropped >>> " + event.isDropped);
			
			if(!event.isDropped) {
				
				var undroppedImageSource:DragDropSource = event.currentTarget as DragDropSource;
				var draggedImage:Image = event.dragData.getDataForFormat(undroppedImageSource.name);
				this.addChild(draggedImage);
				
				var touchStartX:int = undroppedImageSource.startDragX;
				var touchStartY:int = undroppedImageSource.startDragY;
				var touchDropX:int = draggedImage.x;
				var touchDropY:int = draggedImage.y;
				
				SoundPlayer.playFailedDropSound();
				
				snapBackToSidebar(draggedImage, touchStartX, touchStartY, touchDropX, touchDropY);
				
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER, onTimerEvent);
			}
		}
		
		
		/**
		 * Animates the current object back to the sidebar on canceled drag 
		 */
		private function snapBackToSidebar(draggedImage:Image, touchStartX:int, touchStartY:int, touchDropX:int, touchDropY:int):void
		{			
			draggedImage.x = touchDropX;
			draggedImage.y = touchDropY;
			draggedImage.pivotX = 0;
			draggedImage.pivotY = 0;
					
			Starling.juggler.tween(draggedImage, 0.5, {
				transition: Transitions.EASE_IN_OUT,
				delay: 0,
				repeatCount: 1,
				reverse: true,
				onComplete: function():void  { removeChild(draggedImage); 
					draggedImage.scaleX = Constants.SCALE_SIDEBAR_VALUE; 
					draggedImage.scaleY = Constants.SCALE_SIDEBAR_VALUE; 
					dragSourceContainer.addChildAt(draggedImage, draggedImageIndex) },
				x: Root.defaultBackground.width - (sidebarBgd.width - 20),
				y: touchStartY - 200
			});
			
			
		}
		
				
		
			
		
		
		/**
		 * Clearing properties 
		 */
		private function onRemovedFromStage(event:Event):void
		{
			this.removeEventListeners();
			this.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			
			dragSourceContainer.removeEventListener(DragDropEvent.DRAG_START, onDragStartHandler);
			dragSourceContainer.removeEventListener(DragDropEvent.DRAG_COMPLETE, onDragCompleteHandler);
			dragSourceContainer.removeChildren();
			dragSourceContainer.dispose();
			
			this.removeEventListener(TouchEvent.TOUCH, onClick);
			this.removeChild( Root.defaultBackground );
			this.removeChild(menu);
			this.removeChild(sidebarBgd);
			
			for each (var targed:DragDropTarget in dragDropTargets)
			{
				targed.removeEventListener(DragDropEvent.DRAG_ENTER, dropEnterListener);
				targed.removeEventListener(DragDropEvent.DRAG_DROP, dragDropListener);
				targed.dispose();
			}
			
			timer = null;
			dragDropTargets = null;			
			colorDigits = null;
			sidebarBgd = null;
			menu = null;
						
			this.removeChildren();
			this.dispose();
			
		}
	}
}