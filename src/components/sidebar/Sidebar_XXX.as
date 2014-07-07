package components.sidebar
{
	import feathers.events.DragDropEvent;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	import utils.DragDropSource;
	
	public class Sidebar_XXX extends Sprite
	{
		
		private var sidebarBgd:Image;
		private var layout:VerticalLayout;
		private var container:DragDropSource;
		private var menu:SidebarMenu;
				
		public function Sidebar_XXX()
		{		
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			sidebarBgd = new Image(Root.assets.getTexture("sidebar_background@2x"));
			sidebarBgd.y = 0;
			sidebarBgd.x = 0;
			this.addChild(sidebarBgd);
			
			layout = new VerticalLayout();
			layout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
			layout.padding = 15;
			layout.gap = 50;
			
			menu = new SidebarMenu();			
			addChild(menu);
			
			var calculatedY:int = menu.y + menu.height + 10;
			
			container = new DragDropSource();
			container.width = sidebarBgd.width;
			container.height = Root.stageHeight - calculatedY;
			container.layout = layout;				
			container.y = calculatedY;
			container.verticalScrollPolicy = "on";
			container.horizontalScrollPolicy = "off";
			container.addEventListener(DragDropEvent.DRAG_START, onDragStartHandler);
			container.addEventListener(DragDropEvent.DRAG_COMPLETE, onDragCompleteHandler);
						
			addChild(container);
			
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage );
		}
		
		private function onDragStartHandler(event:DragDropEvent):void
		{
			trace("drag start event>>>");
		}
		
		private function onDragCompleteHandler(event:DragDropEvent):void
		{
			trace("Drag complete event: isDropped >>> " + event.isDropped);
			
			if(!event.isDropped) {
				
				var undroppedImageSource:DragDropSource = event.currentTarget as DragDropSource;
				var draggedImage:Image = event.dragData.getDataForFormat(undroppedImageSource.name);
				var touchX:int = draggedImage.x;
				var touchY:int = draggedImage.y;
				
				snapBackToSidebar(draggedImage, touchX, touchY);
			}
		}
		
		
		
		private function onRemovedFromStage(event:Event):void
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage );			
			this.removeChild(sidebarBgd);
			sidebarBgd = null;
			
			this.removeChild( container);
			container = null;
			
			this.removeChild( menu); 			
			menu = null;
			
			layout = null;
		}
		
		public function addPuzzle(d:Image):void
		{
			d.scaleX = 0.8;
			d.scaleY = 0.8;
//			/d.addEventListener(Event.TRIGGERED, onCoulourDigitClick);
			container.addChild(d);
		}
		
		private function snapBackToSidebar(draggedImage:Image, touchX:int, touchY:int):void
		{			
			//trace("name>> " + undroppedImageSource.name + " X>> " + touchX + " Y>> " + touchY);
			draggedImage.x = touchX;
			draggedImage.y = touchY;
			draggedImage.pivotX = 0;
			draggedImage.pivotY = 0;
			//container.addChild(draggedImage);
			
			//tween.onComplete = onMoveCloudRighComplete();
						
			Starling.juggler.tween(draggedImage, 0.1, {
				transition: Transitions.EASE_IN_OUT_BACK,
				delay: 0,
				repeatCount: 0,
				reverse: false,
				onComplete: onTweenComplete(draggedImage),
				x: 0,
				y: 0
			});
		}
		
		private function onTweenComplete(draggedImage:Image):void
		{
			trace("tween complete");
			container.addChild(draggedImage);
		}
		
	}
}