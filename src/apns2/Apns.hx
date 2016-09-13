package apns2;

import js.node.events.EventEmitter;
import js.Promise;

@:jsRequire('apns2') extern class Apns extends EventEmitter<Apns> {
	public function new(option:ApnsOption):Void;
	@:overload(function(notification:BasicNotification):Promise<Dynamic> { })
	@:overload(function(notification:SilentNotification):Promise<Dynamic> { })
	public function send(notification:Notification):Promise<Dynamic>;
}

@:jsRequire('apns2', 'Notification') extern class Notification {
	public function new(deviceToken:String, obj:ApnsNotificationContent);
}

@:jsRequire('apns2', 'BasicNotification') extern class BasicNotification {
	public function new(deviceToken:String, content:String, ?option:ApnsBasicNotificationContent);
}

@:jsRequire('apns2', 'SilentNotification') extern class SilentNotification {
	public function new(deviceToken:String);
}

typedef ApnsOption = {
	cert:String,
	key:String,
}

typedef ApnsBasicNotificationContent = {
	?badge:Int,
	?data:Dynamic,
}

typedef ApnsNotificationContent = {
	aps: {
		?badge:Int, // The number to display as the badge of the app icon.
		alert: {
			title:String, 
			body:String,
			//?title-loc-key:String, // The key to a title string in the Localizable.strings file for the current localization. The key string can be formatted with %@ and %n$@ specifiers to take the variables specified in the title-loc-args array.
			//?title-loc-args:String, // Variable string values to appear in place of the format specifiers in title-loc-key. 
			//?action-loc-key:String, // If a string is specified, the system displays an alert that includes the Close and View buttons. The string is used as a key to get a localized string in the current localization to use for the right button’s title instead of “View”.
			//?loc-key:String, // A key to an alert-message string in a Localizable.strings file for the current localization (which is set by the user’s language preference). The key string can be formatted with %@ and %n$@ specifiers to take the variables specified in the loc-args array.
			//?loc-args:Array<String>, // Variable string values to appear in place of the format specifiers in loc-key.
			//?launch-image:String, // The filename of an image file in the app bundle, with or without the filename extension. The image is used as the launch image when users tap the action button or move the action slider. 
		},
		?sound:String, // The name of a sound file in the app bundle or in the Library/Sounds folder of the app’s data container.
		//?content-available:Int, // Provide this key with a value of 1 to indicate that new content is available. Including this key and value means that when your app is launched in the background or resumed, application:didReceiveRemoteNotification:fetchCompletionHandler: is called.
		?category:String, // Provide this key with a string value that represents the identifier property of the UIMutableUserNotificationCategory object you created to define custom actions
	},
	?data:Dynamic,
}