import 'package:BrossScrum/resources/color/custom_color.dart';
import 'package:BrossScrum/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:BrossScrum/providers/intro/intro_provider.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColor.bg_color,
        body: _body(context));
  }

  Widget _body(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;

    return Consumer<IntroProvider>(
      builder: (context, provider, _) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: topPadding + 24,
                      bottom: 12,
                      left: 24,
                      right: 24,
                    ),

                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 400),
                        child: Container(
                          padding: const EdgeInsets.all(28),
                          decoration: BoxDecoration(
                            color: CustomColor.bg_color,
                            borderRadius: BorderRadius.circular(28),
                          ),

                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 300,
                                height: 30,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      "assets/images/brslogo.png",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 380,
                    child: PageView.builder(
                      controller: provider.pageController,
                      onPageChanged: provider.updatePage,
                      itemCount: provider.introData.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        provider.introData[index]["image"]!,
                                      ),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 32),
                              Center(
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxWidth: 320,
                                  ),
                                  child: Text(
                                    provider.introData[index]["text"]!,
                                    textAlign: TextAlign.center,
                                    style:  TextStyle(
                                      color: CustomColor.bross_scrum,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 32,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 400),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                provider.introData.length,
                                (index) => AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  height: 8,
                                  width: index == provider.currentPage ? 24 : 8,
                                  decoration: BoxDecoration(
                                    color: index == provider.currentPage
                                        ? Colors.blueGrey
                                        : Colors.blue,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 48),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, AppRoute.login);
                              },
                              child: Container(
                                width: 200,
                                height: 32,
                                color: Colors.blue.shade50,
                                child: Center(
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
