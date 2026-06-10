# Google & Facebook Authentication Setup Guide

## Overview
This guide covers the setup and configuration needed for Google and Facebook authentication integration in your Flutter app.

## Dependencies Added
- `google_sign_in: ^7.0.0` - Already in your pubspec.yaml
- `flutter_facebook_auth: ^7.0.0` - Added to pubspec.yaml

## Implementation Files
- `lib/services/user_service.dart` - Updated with `registerWithGoogle()` and `registerWithFacebook()` methods
- `lib/widgets/auth/social_login_buttons.dart` - New reusable social login buttons widget
- `lib/screens/auth/login_screen.dart` - Updated with social login buttons UI

---

## Setup Instructions

### 1. Android Configuration

#### Google Sign-In (Android)
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project "movegui-253e0"
3. Navigate to **Authentication** > **Sign-in method**
4. Enable **Google**
5. In your Android project (`android/app/build.gradle`), ensure you have:
```gradle
dependencies {
    // Your existing dependencies
}
```

6. Add SHA-1 fingerprint:
```bash
# Navigate to your project root
cd android
./gradlew signingReport
```
Copy the SHA-1 from the debug or release variant and add it to Firebase Console:
- Go to **Project Settings** > **Your App** > **SHA certificate fingerprints**
- Add the SHA-1 fingerprint

#### Facebook Sign-In (Android)
1. Go to [Facebook Developers](https://developers.facebook.com/)
2. Create a new app or select existing app
3. Add Android platform:
   - Package Name: `com.example.movegui` (check your app's package name in `android/app/build.gradle`)
   - Main Activity class name: `com.example.movegui.MainActivity`
4. Get your App ID and App Secret from Dashboard
5. In `android/app/build.gradle`, add:
```gradle
dependencies {
    implementation 'com.facebook.android:facebook-android-sdk:17.0.0'
}
```

6. Update `android/app/src/main/AndroidManifest.xml`:
```xml
<manifest ...>
    <!-- ... existing code ... -->
    
    <!-- Facebook permissions -->
    <uses-permission android:name="android.permission.INTERNET" />
    
    <application ...>
        <!-- ... existing code ... -->
        
        <!-- Facebook configuration -->
        <meta-data
            android:name="com.facebook.sdk.ApplicationId"
            android:value="@string/facebook_app_id" />
        
        <activity
            android:name="com.facebook.FacebookActivity"
            android:configChanges="keyboard|keyboardHidden|screenLayout|screenSize|orientation"
            android:label="@string/app_name" />
        <activity
            android:name="com.facebook.CustomTabActivity"
            android:exported="true">
            <intent-filter>
                <action android:name="android.intent.action.VIEW" />
                <category android:name="android.intent.category.DEFAULT" />
                <category android:name="android.intent.category.BROWSABLE" />
                <data android:scheme="fb" />
            </intent-filter>
        </activity>
    </application>
</manifest>
```

7. Add to `android/app/src/main/res/values/strings.xml`:
```xml
<resources>
    <string name="app_name">Movegui</string>
    <string name="facebook_app_id">YOUR_FACEBOOK_APP_ID</string>
    <string name="facebook_client_token">YOUR_FACEBOOK_CLIENT_TOKEN</string>
</resources>
```

### 2. iOS Configuration

#### Google Sign-In (iOS)
1. In Xcode, open `ios/Runner.xcworkspace`
2. Select **Runner** project, then **Runner** target
3. Go to **Build Settings** > search for "URL Schemes"
4. Add your Google OAuth redirect scheme:
   - Value: `com.googleusercontent.apps.<YOUR_GOOGLE_CLIENT_ID>`
   - Find your Client ID in [Firebase Console](https://console.firebase.google.com/) > Project Settings

#### Facebook Sign-In (iOS)
1. Open `ios/Runner.xcworkspace`
2. Select **Runner** project, then **Runner** target
3. In `Info.plist`, add:
```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>fb<YOUR_FACEBOOK_APP_ID></string>
        </array>
    </dict>
</array>
<key>FacebookAppID</key>
<string>YOUR_FACEBOOK_APP_ID</string>
<key>FacebookClientToken</key>
<string>YOUR_FACEBOOK_CLIENT_TOKEN</string>
<key>FacebookDisplayName</key>
<string>Movegui</string>
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>fbapi</string>
    <string>fb-messenger-share-api</string>
    <string>fbauth2</string>
    <string>fbshareextension</string>
</array>
```

### 3. Web Configuration

#### Google Sign-In (Web)
In `web/index.html`, add:
```html
<script src="https://accounts.google.com/gsi/client" async defer></script>
```

#### Facebook Sign-In (Web)
In `web/index.html`, add:
```html
<div id="fb-root"></div>
<script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v18.0&appId=YOUR_FACEBOOK_APP_ID" ></script>
```

### 4. Update Asset Icons

Add Google and Facebook icons to your assets:
1. Download icon images and place in `assets/icons/`
   - `google_icon.png` 
   - `facebook_icon.png`

Or update the `SocialLoginButtons` widget to use icon fonts instead:
```dart
Icon(Icons.g_mobiledata, size: 24)  // for Google
Icon(Icons.facebook, size: 24)      // for Facebook
```

### 5. Firebase Authentication Configuration

1. Ensure Google Sign-In provider is enabled in Firebase:
   - Go to [Firebase Console](https://console.firebase.google.com/)
   - Navigate to **Authentication** > **Sign-in method**
   - Enable **Google** and **Facebook**

2. Facebook setup in Firebase:
   - In Firebase Console, go to **Authentication** > **Sign-in method**
   - Enable **Facebook**
   - Add your Facebook App ID and App Secret

---

## Usage

The social login buttons are now integrated into the login screen. Users can:

1. **Phone/Email Login** - Use the existing phone or email authentication
2. **Google Sign-In** - Click the Google button
3. **Facebook Sign-In** - Click the Facebook button

When a user successfully authenticates via Google or Facebook:
- A new user account is created automatically (if it doesn't exist)
- The user is navigated to `/home`
- Their profile information is populated from their social media account

---

## Troubleshooting

### Common Issues

**Google Sign-In: SHA-1 Mismatch**
- Solution: Ensure your SHA-1 fingerprint in Firebase matches your app's signing certificate

**Facebook Sign-In: Invalid app ID**
- Solution: Verify your Facebook App ID is correctly added to all configuration files

**Social Login Buttons Not Showing**
- Solution: Verify icon files exist in `assets/icons/` or update to use Flutter icons

**Error: "User not found after sign-in"**
- Solution: Check Firebase Firestore rules allow writing new users

---

## Next Steps

1. Download or create Google and Facebook icon PNG files (24x24 recommended)
2. Place them in `assets/icons/` folder
3. Run `flutter pub get` to download dependencies
4. Configure Android and iOS as per instructions above
5. Test on Android emulator/device and iOS simulator
6. Monitor Firebase Console for authentication logs

---

## Files Modified/Created

✅ `pubspec.yaml` - Added `flutter_facebook_auth` dependency
✅ `lib/services/user_service.dart` - Implemented Google and Facebook authentication methods
✅ `lib/widgets/auth/social_login_buttons.dart` - New reusable social login buttons
✅ `lib/screens/auth/login_screen.dart` - Integrated social login buttons into UI

---

## Security Notes

- Never commit API keys or secrets to version control
- Use Firebase secret manager for production credentials
- Test authentication flow thoroughly before release
- Ensure proper CORS and redirect URI configurations for web

