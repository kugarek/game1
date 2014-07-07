package actors
{
	import starling.display.Image;
	import starling.events.Event;
	
	public class Six extends Digit
	{
			
		
		public function Six()
		{
			create();
		}
		
		private function create():void
		{
			digitColor = new Image(Root.assets.getTexture( "06_color@2x.png" ));
			digitMono = new Image(Root.assets.getTexture( "06_mono@2x.png" ));
			
			digitColor.name = Constants.SIX;
			digitMono.name = Constants.SIX;
			
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		private function onRemovedFromStage():void
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			this.removeEventListeners();
			digitColor = null;
			digitMono = null;
		}

	}
}