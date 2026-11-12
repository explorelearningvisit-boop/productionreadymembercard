import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bad_gym/core/models/member_intelligence_data.dart';
import 'package:bad_gym/core/theme/bad_gym_theme.dart';
import 'package:bad_gym/presentation/widgets/renewal_sheet.dart';

class PaymentIntelligenceCard extends StatelessWidget {
  final MemberIntelligenceData data;
  final VoidCallback? onRenewPressed;

  const PaymentIntelligenceCard({
    super.key,
    required this.data,
    this.onRenewPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: BadGymColors.borderSubtle,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: BadGymColors.purpleRail.withValues(alpha: 0.08),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Header: Icon Badge | Title | Status Pill
          Row(
            children: [
              Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      BadGymColors.gold,
                      BadGymColors.goldDark,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.account_balance_wallet_rounded,
                  color: Colors.white,
                  size: 14,
                ),
              ),
              const SizedBox(width: 5),
              const Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Payment Intelligence',
                    style: TextStyle(
                      fontFamily: BadGymTypography.fontHeading,
                      fontWeight: FontWeight.w800,
                      fontSize: 12.5,
                      color: Color(0xFF1E0E38),
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 3),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6.5, vertical: 2.5),
                decoration: BoxDecoration(
                  color: BadGymColors.emerald.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: BadGymColors.emerald.withValues(alpha: 0.35),
                    width: 1,
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle_rounded, size: 9, color: BadGymColors.emerald),
                    SizedBox(width: 2.5),
                    Text(
                      'Paid',
                      style: TextStyle(
                        fontFamily: BadGymTypography.fontHeading,
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        color: BadGymColors.emerald,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // 2. Billing Summary Row
          Row(
            children: [
              Expanded(
                child: _buildMetricPill(
                  label: 'Current Plan',
                  value: data.planName,
                  icon: Icons.workspace_premium,
                  color: BadGymColors.goldDark,
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: _buildMetricPill(
                  label: 'Monthly Fee',
                  value: data.paymentAmount,
                  icon: Icons.currency_rupee,
                  color: const Color(0xFF6D28D9),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: _buildMetricPill(
                  label: 'Next Due',
                  value: '${data.daysLeft}d left',
                  icon: Icons.alarm,
                  color: BadGymColors.redAbsent,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // 3. Invoices History
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFFAF7FE),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xFFEDE9FE),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Billing History',
                      style: TextStyle(
                        fontFamily: BadGymTypography.fontHeading,
                        fontWeight: FontWeight.w800,
                        fontSize: 10.5,
                        color: Color(0xFF1E0E38),
                      ),
                    ),
                    Text(
                      'AutoPay: Active',
                      style: TextStyle(
                        fontFamily: BadGymTypography.fontBody,
                        fontWeight: FontWeight.w600,
                        fontSize: 8.5,
                        color: BadGymColors.emerald,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                _buildInvoiceRow(
                  date: '24 Sep 2026',
                  txnId: 'TXN#BG-9921',
                  amount: '₹1,200',
                  status: 'Success',
                ),
                const SizedBox(height: 4),
                _buildInvoiceRow(
                  date: '24 Aug 2026',
                  txnId: 'TXN#BG-8419',
                  amount: '₹1,200',
                  status: 'Success',
                ),
                const SizedBox(height: 4),
                _buildInvoiceRow(
                  date: '24 Jul 2026',
                  txnId: 'TXN#BG-7023',
                  amount: '₹1,200',
                  status: 'Success',
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // 4. Action Row: Renew Plan / Download Receipt
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    if (onRenewPressed != null) {
                      onRenewPressed!();
                    } else {
                      RenewalSheet.show(context, data);
                    }
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 6.5),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          BadGymColors.goldDark,
                          BadGymColors.gold,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: BadGymColors.gold.withValues(alpha: 0.35),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.autorenew_rounded, size: 12, color: Colors.white),
                        SizedBox(width: 4),
                        Text(
                          'Renew Plan Now',
                          style: TextStyle(
                            fontFamily: BadGymTypography.fontHeading,
                            fontWeight: FontWeight.w800,
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              InkWell(
                onTap: () {
                  HapticFeedback.selectionClick();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('GST Invoice #BG-9921 downloaded to Downloads/BadGym/'),
                      backgroundColor: BadGymColors.purpleCardStart,
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6.5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAF7FE),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFEDE9FE),
                      width: 1,
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.download_rounded, size: 12, color: Color(0xFF6D28D9)),
                      SizedBox(width: 3),
                      Text(
                        'PDF',
                        style: TextStyle(
                          fontFamily: BadGymTypography.fontHeading,
                          fontWeight: FontWeight.w700,
                          fontSize: 9.5,
                          color: Color(0xFF6D28D9),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricPill({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF7FE),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFEDE9FE),
          width: 0.8,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 11, color: color),
              const SizedBox(width: 2.5),
              Flexible(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontFamily: BadGymTypography.fontBody,
                    fontWeight: FontWeight.w500,
                    fontSize: 8,
                    color: Color(0xFF6B7280),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontFamily: BadGymTypography.fontHeading,
              fontWeight: FontWeight.w800,
              fontSize: 10.5,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceRow({
    required String date,
    required String txnId,
    required String amount,
    required String status,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(2.5),
              decoration: BoxDecoration(
                color: BadGymColors.emerald.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, size: 9, color: BadGymColors.emerald),
            ),
            const SizedBox(width: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: const TextStyle(
                    fontFamily: BadGymTypography.fontHeading,
                    fontWeight: FontWeight.w700,
                    fontSize: 9.5,
                    color: Color(0xFF1E0E38),
                  ),
                ),
                Text(
                  txnId,
                  style: const TextStyle(
                    fontFamily: BadGymTypography.fontBody,
                    fontSize: 8,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ],
        ),
        Text(
          amount,
          style: const TextStyle(
            fontFamily: BadGymTypography.fontHeading,
            fontWeight: FontWeight.w800,
            fontSize: 10.5,
            color: Color(0xFF1E0E38),
          ),
        ),
      ],
    );
  }
}
