package 
{
	import fl.controls.Button;
	import fl.controls.TextArea;
	import flash.display.BlendMode;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.setTimeout;
	import skyboy.serialization.JSON;
	
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Main extends Sprite 
	{
		private var t:TextField;
		private var label:TextField;
		private var button:Button;
		private var output:TextArea;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			
			t = new TextField();
			t.defaultTextFormat = new TextFormat("Arial", 24, 0x999999, true);
			t.border = true;
			t.borderColor = 0x999999;
			t.text = "Username Here";
			t.type = "input";
			t.width = 300;
			t.height = 35;
			t.x = 15;
			t.y = 15
			addChild(t);
			
			label = new TextField();
			label.defaultTextFormat = new TextFormat("Arial", 14, 0x666666, true);
			label.width = 300;
			label.height = 40;
			label.x = 15
			label.y = 55;
			label.text = "Username";
			addChild(label);
			
			button = new Button();
			button.x = t.x + t.width + 15;
			button.y = t.y;
			button.height = t.height;
			button.width = 100;
			button.label = "Get User ID";
			button.addEventListener(MouseEvent.CLICK, getPlayerInfo);
			addChild(button);
			
			output = new TextArea();
			output.setStyle('textFormat', new TextFormat("Arial", 14, 0x999999, true));
			output.textField.opaqueBackground = 0x444444;
			//output.border = true;
			//output.borderColor = 0x999999;
			output.width = stage.stageWidth - 30;
			output.height = stage.stageHeight - label.y - 35 - 30;
			output.x = 15;
			output.y = label.y + 35;
			output.text = "Output:"
			//output.defaultTextFormat = new TextFormat("Arial", 14, 0x999999, true);
			addChild(output);
		}
		
		/**
		 * getPlayerInfo
		 * @description		gets information about the player
		 */
		public function getPlayerInfo(e:MouseEvent):void
		{
			var request:URLRequest = new URLRequest("http://api.kongregate.com/api/user_info.json?username=" + t.text);
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(IOErrorEvent.IO_ERROR, catchIOError); //catch if username does not exist
			loader.addEventListener(Event.COMPLETE, loadedPlayerInfo);
			loader.load(request); 
		}
		private function catchIOError(e:Error):void
		{
			output.text += "\n" + "Error: Username " + t.text + " does not exist. -> Player Info not retrieved.";
		}
		private function loadedPlayerInfo(event:Event):void
		{
			var load:URLLoader = URLLoader(event.target);
			var playerData:Object = JSON.decode(load.data);
			output.text += "\n" + "Username " + t.text + " has user ID " + playerData.user_id + ".";
			output.verticalScrollPosition = output.maxVerticalScrollPosition;
		}
	}
	
}