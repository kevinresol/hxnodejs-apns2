package apns2;

import js.node.events.EventEmitter;
import js.Promise;
import haxe.DynamicAccess;
import haxe.extern.EitherType;

@:jsRequire('apns2')
extern class Apns extends EventEmitter<Apns> {
	public function new(options:ApnsOptions):Void;
	public function send(notification:Notification):Promise<Dynamic>;
}

@:jsRequire('apns2', 'Notification')
extern class Notification {
	public function new(deviceToken:String, options:NotificationOptions);
}

@:jsRequire('apns2', 'BasicNotification')
extern class BasicNotification extends Notification {
	public function new(deviceToken:String, message:String, ?options:BasicNotificationOptions);
}

@:jsRequire('apns2', 'SilentNotification')
extern class SilentNotification extends Notification {
	public function new(deviceToken:String);
}

typedef ApnsOptions = {
	cert:String,
	key:String,
}

typedef BasicNotificationOptions = {
	?badge:Int,
	?data:Dynamic,
}

typedef NotificationOptions = {
	aps: {
		?badge:Int, // The number to display as the badge of the app icon.
		alert:Alert,
		?sound:String, // The name of a sound file in the app bundle or in the Library/Sounds folder of the app’s data container.
		//?content-available:Int, // Provide this key with a value of 1 to indicate that new content is available. Including this key and value means that when your app is launched in the background or resumed, application:didReceiveRemoteNotification:fetchCompletionHandler: is called.
		?category:String, // Provide this key with a string value that represents the identifier property of the UIMutableUserNotificationCategory object you created to define custom actions
	},
	?data:Dynamic,
}

typedef Alert = EitherType<String, {
	title:String, 
	body:String,
	//?title-loc-key:String, // The key to a title string in the Localizable.strings file for the current localization. The key string can be formatted with %@ and %n$@ specifiers to take the variables specified in the title-loc-args array.
	//?title-loc-args:String, // Variable string values to appear in place of the format specifiers in title-loc-key. 
	//?action-loc-key:String, // If a string is specified, the system displays an alert that includes the Close and View buttons. The string is used as a key to get a localized string in the current localization to use for the right button’s title instead of “View”.
	//?loc-key:String, // A key to an alert-message string in a Localizable.strings file for the current localization (which is set by the user’s language preference). The key string can be formatted with %@ and %n$@ specifiers to take the variables specified in the loc-args array.
	//?loc-args:Array<String>, // Variable string values to appear in place of the format specifiers in loc-key.
	//?launch-image:String, // The filename of an image file in the app bundle, with or without the filename extension. The image is used as the launch image when users tap the action button or move the action slider.
}>;

abstract NotificationOptionsBuilder(DynamicAccess<Dynamic>) from DynamicAccess<Dynamic> {
	
	var apns(get, never):DynamicAccess<Dynamic>;
	
	public inline function new()
		this = cast {apns: {}};
		
	inline function get_apns():DynamicAccess<Dynamic>
		return untyped this.apns;
		
	@:to
	public inline function toOptions():NotificationOptions
		return cast this;
	
	public inline function alert(v:EitherType<String, Alert>):NotificationOptionsBuilder {
		apns.set('alert', v);
		return this;
	}
	
	public inline function badge(v:Int):NotificationOptionsBuilder {
		apns.set('badge', v);
		return this;
	}
	
	public inline function sound(filename:String):NotificationOptionsBuilder {
		apns.set('sound', filename);
		return this;
	}
	
	public inline function contentAvailable(value:Bool):NotificationOptionsBuilder {
		if(value) apns.set('content-available', 1);
		return this;
	}
	
	public inline function category(identifier:String):NotificationOptionsBuilder {
		apns.set('category', identifier);
		return this;
	}
	
	public inline function threadId(id:String):NotificationOptionsBuilder {
		apns.set('thread-id', id);
		return this;
	}
	
	public inline function data(v:Dynamic):NotificationOptionsBuilder {
		this.set('data', v);
		return this;
	}
}


abstract AlertBuilder(DynamicAccess<Dynamic>) from DynamicAccess<Dynamic> {
	
	public inline function new()
		this = new DynamicAccess();
		
	@:to
	public inline function toAlert():Alert
		return cast this;
	
	public inline function title(v:String):AlertBuilder {
		this.set('title', v);
		return this;
	}
	
	public inline function body(v:String):AlertBuilder {
		this.set('body', v);
		return this;
	}
	
	public inline function titleLocKey(v:String):AlertBuilder {
		this.set('title-loc-key', v);
		return this;
	}
	
	public inline function titleLocArgs(v:Array<String>):AlertBuilder {
		this.set('title-loc-args', v);
		return this;
	}
	
	public inline function actionLocKey(v:String):AlertBuilder {
		this.set('action-loc-key', v);
		return this;
	}
	
	public inline function locKey(v:String):AlertBuilder {
		this.set('loc-key', v);
		return this;
	}
	
	public inline function locArgs(v:Array<String>):AlertBuilder {
		this.set('loc-args', v);
		return this;
	}
	
	public inline function launchImage(v:String):AlertBuilder {
		this.set('launch-image', v);
		return this;
	}
}