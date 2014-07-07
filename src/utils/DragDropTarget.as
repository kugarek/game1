package utils
{
	import feathers.controls.LayoutGroup;
	import feathers.dragDrop.IDropTarget;
	import feathers.layout.HorizontalLayout;
	
	import starling.display.Image;
	import starling.events.Event;
	
	
	
	public class DragDropTarget extends LayoutGroup implements IDropTarget
	{
		private var layout:HorizontalLayout ;
		
		
		public function DragDropTarget()
		{
			super();			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			layout = new HorizontalLayout();
			layout.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
			layout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
			
			this.layout = layout;
			
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		private function onRemovedFromStage(event:Event):void
		{
			this.removeEventListeners();
			this.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			this.removeChildren();
			this.dispose();
		}
		
		public function handleValidDrop(data:Image):void
		{
			var image:Image = data;
			image.pivotX = 0;
			image.pivotY = 0;
			image.scaleX = 1;
			image.scaleY = 1;
			image.x = 0;
			image.y = 0;
			
			this.addChild(image);
			trace("Accepted drop>>>" + image.name);
			
			SoundPlayer.playDigitName(image.name + Root.defaultLanguage);
			Animations.jump(this, 0, 1);
		}
	}
}