import 'package:BrossScrum/resources/color/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/account_screen_provider/feedback/feedback_page_provider.dart';


class SendFeedbackPage extends StatelessWidget {
  const SendFeedbackPage({super.key});

  void _showFeedbackTypeDialog(BuildContext context, SendFeedbackProvider provider) {
    String tempSelected = provider.feedbackType;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: CustomColor.card_bg(context),
              title: Text(
                'Feedback Type',
                style: TextStyle(
                  color: CustomColor.textPrimary(context),
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: ['Bug', 'Improvement', 'How do I?'].map((type) {
                  return RadioListTile<String>(
                    title: Text(
                      type,
                      style: TextStyle(color: CustomColor.textPrimary(context)),
                    ),
                    value: type,
                    groupValue: tempSelected,
                    activeColor: const Color(0xFF0052CC),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => tempSelected = value);
                      }
                    },
                  );
                }).toList(),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('CANCEL', style: TextStyle(color: Color(0xFF0052CC))),
                ),
                TextButton(
                  onPressed: () {
                    provider.setFeedbackType(tempSelected);
                    Navigator.pop(context);
                  },
                  child: const Text('OK', style: TextStyle(color: Color(0xFF0052CC))),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = CustomColor.isDark(context);

    return ChangeNotifierProvider(
      create: (_) => SendFeedbackProvider(),
      child: Consumer<SendFeedbackProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            backgroundColor: CustomColor.card_bg(context),
            appBar: AppBar(
              backgroundColor: CustomColor.card_bg(context),
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.close, size: 28),
                color: isDark ? Colors.white : const Color(0xFF0052CC),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                'Send Feedback',
                style: TextStyle(
                  color: isDark ? Colors.white : const Color(0xFF172B4D),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
              actions: [
                TextButton(
                  onPressed: provider.isLoading
                      ? null
                      : () async {
                    bool success = await provider.sendFeedback();
                    if (success && context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'Send',
                    style: TextStyle(
                      color: provider.isLoading ? Colors.grey : const Color(0xFF0052CC),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: provider.feedbackController,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(
                          color: CustomColor.textPrimary(context),
                          fontSize: 18,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Type some feedback...',
                          hintStyle: TextStyle(
                            color: CustomColor.inputHintDefault(context),
                            fontSize: 18,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add, color: const Color(0xFF0052CC), size: 24),
                            const SizedBox(width: 8),
                            Text(
                              'Add attachment',
                              style: TextStyle(
                                color: const Color(0xFF0052CC),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      GestureDetector(
                        onTap: () => _showFeedbackTypeDialog(context, provider),
                        behavior: HitTestBehavior.opaque,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Feedback type',
                              style: TextStyle(
                                color: CustomColor.textMutedLabel(context),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              provider.feedbackType,
                              style: TextStyle(
                                color: CustomColor.textPrimary(context),
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Atlassian can contact me about this',
                                  style: TextStyle(
                                    color: CustomColor.textMutedLabel(context),
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                RichText(
                                  text: TextSpan(
                                    text: 'See our ',
                                    style: TextStyle(
                                      color: CustomColor.textPrimary(context),
                                      fontSize: 18,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'privacy policy',
                                        style: const TextStyle(
                                          color: Color(0xFF0052CC),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: provider.canContact,
                            activeTrackColor: CustomColor.switchActiveTrack(context),
                            activeColor: Colors.white,
                            inactiveTrackColor: CustomColor.switchInactiveTrack(context),
                            onChanged: (value) => provider.setCanContact(value),
                          ),
                        ],
                      ),
                      if (provider.canContact) ...[
                        const SizedBox(height: 24),
                        TextField(
                          controller: provider.emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                            color: CustomColor.textPrimary(context),
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              color: CustomColor.textMutedLabel(context),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: CustomColor.inputBorderDefault(context),
                              ),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF0052CC)),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (provider.isLoading)
                  Container(
                    color: Colors.black.withOpacity(0.15),
                    child: const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0052CC)),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}