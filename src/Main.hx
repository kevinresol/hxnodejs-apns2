import apns2.*;
import apns2.Apns.Notification;
import apns2.Apns.BasicNotification;
import sys.io.File;
class Main {
	public static function main() {
		var test = new Apns({
			cert: File.getContent('secret/cert.pem'), 
			key: File.getContent('secret/key.pem')
		});
		var notification = new BasicNotification('someToken', 'hihi');
		var a = test.send(notification);
	}
}