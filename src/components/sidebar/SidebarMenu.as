package components.sidebar
{
	import flash.system.System;
	
	import events.NavigationEvent;
	
	import feathers.controls.LayoutGroup;
	import feathers.layout.HorizontalLayout;
	
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class SidebarMenu extends Sprite
	{
				
		private var container:LayoutGroup;
		private var homeBtn:Button;
		private var revertBtn:Button;
		
		public function SidebarMenu()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);		
		}
		
		private function onAddedToStage(e:Event):void
		{
			var layout:HorizontalLayout = new HorizontalLayout();
			layout.padding = 15;
			layout.gap = 10;
			
			container = new LayoutGroup();
			container.layout = layout;
			
			homeBtn = new Button(Root.assets.getTexture("home_icon"));
			homeBtn.addEventListener(Event.TRIGGERED, onHomeButtonClick);
			revertBtn = new Button(Root.assets.getTexture("revert_icon"));
			revertBtn.addEventListener(Event.TRIGGERED, onRevertButtonClick);
			
			container.addChild(homeBtn);	
			container.addChild(revertBtn);	
			container.height = homeBtn.height + 30;
			addChild(container);
			
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);			
			this.addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
		}
				
		
		private function onRemovedFromStage(e:Event):void
		{
			this.removeEventListeners();
			this.removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );	
			homeBtn.removeEventListener(Event.TRIGGERED, onHomeButtonClick);
			revertBtn.removeEventListener(Event.TRIGGERED, onRevertButtonClick);
			
			revertBtn = null;
			homeBtn = null;
			container = null; 
			
			dispose();
		}
		
		private function onHomeButtonClick(event:Event):void
		{
			dispatchEventWith(NavigationEvent.RETURN_TO_MENU, true, "sidebarHomeBtn");
		}
		
		private function onRevertButtonClick(event:Event):void
		{
			//dispatchEventWith(NavigationEvent.REVERT, true, "sidebarRevertBtn");
			// now would be a good time for a clean-up 
			System.pauseForGCIfCollectionImminent(0);
			dispatchEventWith(NavigationEvent.REVERT, true, "sidebarHomeBtn");
		}
	}
}