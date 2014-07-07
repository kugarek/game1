package events
{
	import starling.events.Event;
	
	public class NavigationEvent extends Event
	{
		
		public static const START_GAME:String = "startGame";
		public static const RETURN_TO_MENU:String = "returnToMenu";		
		public static const REVERT:String = "revert";
		public static const SETTINGS:String = "settings";
		//public static const MENU:String = "menu";
		
		public function NavigationEvent(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
		
		/*override public function clone():Event
		{
			return new NavigationEvent(type, bubles, cancelable)
		}*/
	}
}