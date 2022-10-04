import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Utilities/app_images.dart';
import '../../../providers/seed_phrase_provider.dart';
import '../../../widget/custom_widgets/custom_elevated_button.dart';
import '../create_wallet_screen/create_wallet_screen.dart';
import '../import_seed_screen/import_seed_screen.dart';

class WalletSetupScreen extends StatelessWidget {
  const WalletSetupScreen({Key? key}) : super(key: key);
  static const String routeName = '/WalletSetupScreen';

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(24),
                child: Image.asset(AppImages.wallet),
              ),
              const SizedBox(height: 20),
              const Text(
                'Wallet Setup',
                style: TextStyle(fontSize: 32),
              ),
              const Spacer(),
              CustomElevatedButton(
                applyGradient: false,
                title: 'Import Using Seed Phrase',
                onTap: () {                           
                  Navigator.of(context).pushNamed(ImportSeedScreen.routeName);
                },
              ),
              CustomElevatedButton(
                title: 'Create a New Wallet',
                onTap: () async {
                  await Provider.of<SeedPhraseProvider>(context, listen: false)
                      .init();
                  Navigator.of(context).pushNamed(CreateWalletScreen.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
