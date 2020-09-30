# Time_Manager

a simple todo list, just for my flutter study

## data storage
using SharedPreferences to store all the data currently, but will change to use database maybe

## currently features
cause it's just a simple todo list, so only for todo list
  * add a todo
  * change the todo status for pending or done
  * delete a todo by slide the item

## update plans of future version
  * currently the main task is to implement the todo features
  * also will add the calendar
  * maybe will add daily attendance

## Getting Started
This project is a starting point for a Flutter application.
- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## publish apk
 * generate key file: keytool -genkey -v -keystore ~/sign.jks -keyalg RSA -keysize 2048 -validity 10000 -alias sign
 * you can use command to see the details: keytool -list -v -keystore (filepath)' -alias (keyalias) -storepass (storepassword) -keypass (keypassword)
 * add the key file to directory: /android/app/key/  ( you need to build the directory manually )
 * generate file /android/key.properties and add key info in it ( including: storePassword, keyPassword, keyAlias, storeFile )
 * run the command to generate apk: flutter build apk

## About me
if you hava any questions, please email me @ gvousiu@gmail.com
I will reply as soon as I see the email.
