import 'dart:convert';
import 'package:betapp/View/BPro_App_Wallet/bpro_app_wallet_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart' as inapp;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreWebView extends StatefulWidget {
  final String url;
  final bool done;
  final String username;
  final String password;

  StoreWebView({
    required this.url,
    required this.done,
    required this.username,
    required this.password,
  });

  @override
  StoreWebViewState createState() => StoreWebViewState();
}

class StoreWebViewState extends State<StoreWebView> {
  final GlobalKey webViewKey = GlobalKey();
  late inapp.InAppWebViewController _webViewController;
  inapp.CookieManager cookieManager = inapp.CookieManager();
  double progress = 0;
  bool isLoggedIn = false;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _loadSavedCookies();
  }

  /// **Save Cookies in SharedPreferences**
  void _saveCookies() async {
    List<inapp.Cookie> cookies = await cookieManager.getCookies(url: inapp.WebUri(widget.url));
    Map<String, String> cookieMap = {};
    for (var cookie in cookies) {
      cookieMap[cookie.name] = cookie.value;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_cookies', jsonEncode(cookieMap));
    print("✅ Cookies saved successfully.");
  }

  /// **Load Cookies from SharedPreferences**
  void _loadSavedCookies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedCookies = prefs.getString('saved_cookies');

    if (savedCookies != null) {
      Map<String, String> cookieMap = Map<String, String>.from(jsonDecode(savedCookies));

      for (var entry in cookieMap.entries) {
        await cookieManager.setCookie(
          url: inapp.WebUri(widget.url),
          name: entry.key,
          value: entry.value,
          domain: ".bpexch.com",
          path: "/",
        );
      }
      print("✅ Cookies loaded successfully.");
    } else {
      print("⚠ No saved cookies found.");
    }
  }

  /// **Clear Cookies, Cache & Local Storage on Logout**
  void _clearCookies() async {
    await cookieManager.deleteAllCookies(); // Delete all cookies
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('saved_cookies'); // Remove from SharedPreferences
    print("🗑️ Cookies cleared on logout.");

    // Clear WebView cache
    await _webViewController.clearCache();
    print("🗑️ Cache cleared.");

    // Inject JavaScript to clear local storage & session storage
    await _webViewController.evaluateJavascript(source: """
      localStorage.clear();
      sessionStorage.clear();
      document.cookie.split(";").forEach((c) => {
        document.cookie = c.replace(/^ +/, "").replace(/=.*/, "=;expires=Thu, 01 Jan 1970 00:00:00 GMT;path=/");
      });
    """);
    print("🗑️ Local Storage cleared.");

    // Force reload login page
    _webViewController.loadUrl(
      urlRequest: inapp.URLRequest(url: inapp.WebUri("https://www.bpexch.com/Users/Login")),
    );
  }

  /// **Detect Logout and Clear Cookies**
  void _handleUrlChange(String url) {
    if (url.contains("/Common/Logout")) {
      print("🚨 Logout detected! Clearing cookies...");
      _clearCookies();
    }
  }

  /// **Track Page Load & Save Cookies on Dashboard**
  void _onPageLoad(inapp.InAppWebViewController controller, inapp.WebUri? url) async {
    if (url == null) return;

    String urlString = url.toString();

    if (urlString.contains("/Common/Dashboard") && !urlString.contains("?r=/users/login")) {
      print("✅ Logged in! Saving cookies...");
      isLoggedIn = true;
      _saveCookies();
    } else if (urlString.contains("/Common/Dashboard?r=/users/login")) {
      print("🚨 Redirect detected! Checking session before clearing cookies...");

      bool isSessionValid = await _checkSession(); // ✅ Verify session before clearing cookies

      if (!isSessionValid) {
        print("🔴 Session invalid! Clearing cookies and reloading login page...");
        _clearCookies();
        controller.loadUrl(
          urlRequest: inapp.URLRequest(url: inapp.WebUri("https://www.bpexch.com/Users/Login")),
        );
      } else {
        print("🟢 Session is still valid, avoiding unnecessary login.");
      }
    }

    setState(() {
      isLoading = false; // 🛑 Stop loading once page is fully loaded
    });
  }

// ✅ Function to check if session is still active
  Future<bool> _checkSession() async {
    // Implement a proper session check, e.g., checking cookies or API validation
    String? cookie = await _getCookie("session_id");
    return cookie != null && cookie.isNotEmpty;
  }
  double _scale = 1.0;

  void _animateBackButton(BuildContext context) {
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: widget.done
          ? AppBar(
        backgroundColor: Colors.black,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => BProWalletMain(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              ),
            );
          },
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text("Batproexch App", style: TextStyle(color: Colors.white)),
      )
          : null,
      body: Stack(
        children: [
          // 🌍 WebView
          Positioned.fill(
            child: inapp.InAppWebView(
              key: webViewKey,
              initialUrlRequest: inapp.URLRequest(url: inapp.WebUri(widget.url)),
              initialOptions: inapp.InAppWebViewGroupOptions(
                android: inapp.AndroidInAppWebViewOptions(useHybridComposition: true),
                ios: inapp.IOSInAppWebViewOptions(sharedCookiesEnabled: true),
              ),
              onWebViewCreated: (controller) {
                _webViewController = controller;
                _loadSavedCookies();
              },
              onLoadStart: (controller, url) {
                setState(() {
                  isLoading = true; // 🔄 Show loader when loading starts
                });
              },
              onLoadStop: _onPageLoad, // Handles login/logout & hides loader
              onProgressChanged: (controller, progress) {
                setState(() => this.progress = progress / 100);
              },
            ),
          ),

          // 🔄 Fullscreen Loader
          if (isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.8),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
  Future<String?> _getCookie(String name) async {
    CookieManager cookieManager = CookieManager.instance();
    List<Cookie> cookies = await cookieManager.getCookies(
      url: WebUri("https://www.bpexch.net"), // 🔹 Apni website ka domain yahan dein
    );

    for (var cookie in cookies) {
      if (cookie.name == name) {
        return cookie.value;
      }
    }
    return null;
  }
}
