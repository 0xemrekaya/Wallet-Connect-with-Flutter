import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_modal_flutter/walletconnect_modal_flutter.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late WalletConnectModalService service;
  bool isConnected = false;

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
      setState(() {
        isConnected = true;
      });
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 100),
              isConnected == true
                  ? ElevatedButton(
                      onPressed: () async{
                       await service.disconnect();
                       service.close();
                        setState(() {
                          isConnected = false;
                        });
                      },
                      child: Text("Disconnect Wallet", style: Theme.of(context).textTheme.labelLarge ))
                  :
              ElevatedButton(
                  onPressed: () async {
                    await _connect();
                  },
                  child: Text("Connect Wallet", style: Theme.of(context).textTheme.labelLarge )),
                  const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("Connected: ${service.address}"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
