package utils
{
	import feathers.controls.ScrollContainer;
	import feathers.dragDrop.IDragSource;
	
	import starling.events.Event;
	
	public class DragDropSource extends ScrollContainer implements IDragSource
	{
		
		private var _startDragX:int;
		private var _startDragY:int; 
		private var _startDragIndexPos:int;
		
		public function DragDropSource()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		private function onRemovedFromStage(event:Event):void
		{
			this.removeEventListeners();
			this.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			this.removeChildren();
			dispose();
		}

		
		public function get startDragX():int
		{
			return _startDragX;
		}

		public function set startDragX(value:int):void
		{
			_startDragX = value;
		}

		public function get startDragY():int
		{
			return _startDragY;
		}

		public function set startDragY(value:int):void
		{
			_startDragY = value;
		}

		public function get startDragIndexPos():int
		{
			return _startDragIndexPos;
		}

		public function set startDragIndexPos(value:int):void
		{
			_startDragIndexPos = value;
		}


	}
}