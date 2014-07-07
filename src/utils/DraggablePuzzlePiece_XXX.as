package utils
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class DraggablePuzzlePiece_XXX extends Sprite
	{
		private var _draggedPuzzleImage:Image;
		private var _startDragX:int;
		private var _startDragY:int; 
		private var _dragDropX:int;
		private var _dragDropY:int; 
		private var _startDragIndexPos:int;
		
		public function DraggablePuzzlePiece_XXX(puzzle:Image)
		{
			super();
			
			draggedPuzzleImage = puzzle;	
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		private function onRemovedFromStage(event:Event):void
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			
			this.removeChildren();
		}
		
		
		public function get draggedPuzzleImage():Image
		{
			return _draggedPuzzleImage;
		}
		
		public function set draggedPuzzleImage(value:Image):void
		{
			_draggedPuzzleImage = value;			
			this.addChild(value);
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

		public function get dragDropX():int
		{
			return _dragDropX;
		}

		public function set dragDropX(value:int):void
		{
			_dragDropX = value;
		}

		public function get dragDropY():int
		{
			return _dragDropY;
		}

		public function set dragDropY(value:int):void
		{
			_dragDropY = value;
		}

				
	}
}