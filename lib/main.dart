import 'dart:async';

import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_modal_flutter/walletconnect_modal_flutter.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return WalletConnectModalTheme(
      data: WalletConnectModalThemeData.darkMode,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late WalletConnectModalService service;

  @override
  void initState() {
    super.initState();
    serviceInit();
  }

  Future<void> serviceInit() async {
    service = WalletConnectModalService(
      projectId: "932bfa5375a38d53adda143fbb6486f0",
      metadata: const PairingMetadata(
        name: 'wCon',
        description: 'Flutter WalletConnectModal Sign Example',
        url: 'https://walletconnect.com/',
        icons: ['https://walletconnect.com/walletconnect-logo.png'],
        redirect: Redirect(
          native: 'flutterdapp://',
          universal: 'https://www.walletconnect.com',
        ),
      ),
    );
    await service.init();
  }

  Future<void> _connect() async {
    if (!service.isInitialized) {
      // Service must be initialized before calling this method.
      return;
    }

    try {
      await service.open(context: context);
      print(service.address);

      print(service.connectResponse);
    } on TimeoutException {
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () async {
                  await _connect();
                },
                child: Text("connect")),
            Text(service.address.toString()),
            ElevatedButton(
                onPressed: () {
                  setState(() {});
                },
                child: Text("set steate")),
            WalletConnectModalConnect(service: service),
          ],
        ),
      ),
    );
  }
}
