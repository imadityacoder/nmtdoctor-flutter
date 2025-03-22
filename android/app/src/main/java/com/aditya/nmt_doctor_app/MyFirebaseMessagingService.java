package com.aditya.nmt_doctor_app;

import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;
import android.util.Log;

public class MyFirebaseMessagingService extends FirebaseMessagingService {
    private static final String TAG = "MyFirebaseMsgService";

    @Override
    public void onMessageReceived(RemoteMessage remoteMessage) {
        // Log the message for debugging
        Log.d(TAG, "Message received: " + remoteMessage.getNotification().getBody());
    }

    @Override
    public void onNewToken(String token) {
        // Log the new token
        Log.d(TAG, "New token: " + token);
    }
}
