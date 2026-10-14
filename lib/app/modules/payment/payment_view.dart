import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:aerova_app/app/core/core.dart';
import 'package:aerova_app/app/data/data.dart';
import 'package:aerova_app/app/widgets/widgets.dart';

import 'payment_controller.dart';

class PaymentView extends GetView<PaymentController> {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    final BookingDraft d = controller.draft;
    return GradientPageScaffold(
      headerHeight: 76,
      overlap: 60,
      header: const ScreenHeaderBar(title: AppStrings.payment, subtitle: AppStrings.securePayment),
      bottomBar: BottomActionBar(
        child: Obx(
          () => GradientButton(
            label: '${AppStrings.pay} ${Formatters.rupee(d.total)}',
            leadingIcon: Icons.lock_outline_rounded,
            loading: controller.paying.value,
            onTap: controller.pay,
          ),
        ),
      ),
      children: <Widget>[
        const GroupLabel(AppStrings.fareSummary),
        const SizedBox(height: 10),
        AppCard(
          shadows: AppShadows.raised,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  AirlineLogo(code: d.flight.airlineCode),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('${d.flight.fromCode} → ${d.flight.toCode}', style: AppTextStyles.cardTitle),
                        Text('${d.flight.flightNo} · ${d.flight.departTime}', style: AppTextStyles.caption),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 28, color: AppColors.divider),
              FareRow(label: AppStrings.baseFare, value: Formatters.rupee(d.flight.baseFare)),
              FareRow(label: AppStrings.taxesAndFees, value: Formatters.rupee(d.flight.taxesAndFees)),
              if (d.seatId.isNotEmpty)
                FareRow(label: '${AppStrings.seat} ${d.seatId}', value: Formatters.rupee(d.seatFee)),
              const Divider(height: 24, color: AppColors.divider),
              FareRow(label: AppStrings.total, value: Formatters.rupee(d.total), isTotal: true),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const GroupLabel(AppStrings.payUsing),
        const SizedBox(height: 10),
        Obx(
          () => Column(
            children: <Widget>[
              _MethodCard(
                icon: Icons.account_balance_wallet_outlined,
                title: AppStrings.upi,
                subtitle: AppStrings.upiSubtitle,
                selected: controller.method.value == PaymentMethod.upi,
                onTap: () => controller.selectMethod(PaymentMethod.upi),
                body: AppInputField(
                  controller: controller.upiId,
                  hint: AppStrings.upiHint,
                  prefixIcon: Icons.alternate_email_rounded,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(height: 12),
              _MethodCard(
                icon: Icons.credit_card_rounded,
                title: AppStrings.cards,
                subtitle: AppStrings.cardsSubtitle,
                selected: controller.method.value == PaymentMethod.card,
                onTap: () => controller.selectMethod(PaymentMethod.card),
                body: Column(
                  children: <Widget>[
                    AppInputField(
                      controller: controller.cardNumber,
                      hint: AppStrings.cardNumber,
                      prefixIcon: Icons.credit_card_rounded,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: AppInputField(
                            controller: controller.cardExpiry,
                            hint: AppStrings.cardExpiry,
                            keyboardType: TextInputType.datetime,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: AppInputField(
                            controller: controller.cardCvv,
                            hint: AppStrings.cardCvv,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _MethodCard(
                icon: Icons.account_balance_rounded,
                title: AppStrings.netBanking,
                subtitle: AppStrings.netBankingSubtitle,
                selected: controller.method.value == PaymentMethod.netBanking,
                onTap: () => controller.selectMethod(PaymentMethod.netBanking),
                body: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    for (final String bank in PaymentController.banks)
                      PillChip(
                        label: bank,
                        height: 36,
                        horizontalPadding: 16,
                        selected: controller.selectedBank.value == bank,
                        onTap: () => controller.selectBank(bank),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MethodCard extends StatelessWidget {
  const _MethodCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      borderColor: selected ? AppColors.primary : Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              IconTile(icon: icon),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(title, style: AppTextStyles.cardTitle),
                    Text(subtitle, style: AppTextStyles.caption),
                  ],
                ),
              ),
              RadioDot(selected: selected),
            ],
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            alignment: Alignment.topCenter,
            child: selected
                ? Padding(padding: const EdgeInsets.only(top: 16), child: body)
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}
