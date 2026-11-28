import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../theme/member_theme.dart';

class GlassChartFrame extends StatelessWidget {
  const GlassChartFrame({
    required this.title,
    required this.child,
    this.subtitle,
    this.trailing,
    this.height,
    super.key,
  });

  final String title;
  final String? subtitle;
  final Widget child;
  final Widget? trailing;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.fromLTRB(9, 7, 9, 7),
      decoration: BoxDecoration(
        color: const Color(0xDFFFFFFF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: MemberTheme.glassEdge.withOpacity(0.82)),
        boxShadow: const [
          BoxShadow(color: Color(0x180F0630), blurRadius: 8, offset: Offset(0, 3)),
          BoxShadow(color: Color(0xBFFFFFFF), blurRadius: 1, offset: Offset(0, -1)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, maxLines: 1, overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: MemberTheme.ink, fontSize: 12, fontWeight: FontWeight.w800)),
                    if (subtitle != null)
                      Text(subtitle!, maxLines: 1, overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: MemberTheme.muted, fontSize: 9, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          const SizedBox(height: 4),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class GlassMetricCard extends StatelessWidget {
  const GlassMetricCard({
    required this.label,
    required this.value,
    required this.icon,
    this.tint = MemberTheme.purple,
    this.caption,
    this.compact = false,
    super.key,
  });

  final String label;
  final String value;
  final String? caption;
  final IconData icon;
  final Color tint;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(compact ? 4 : 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.white, tint.withOpacity(0.065)],
          begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tint.withOpacity(0.18)),
        boxShadow: const [BoxShadow(color: Color(0x120E0630), blurRadius: 5, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(children: [
            Icon(icon, size: compact ? 13 : 16, color: tint),
            const SizedBox(width: 4),
            Expanded(child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis,
              style: TextStyle(color: MemberTheme.muted, fontSize: compact ? 8 : 9, fontWeight: FontWeight.w700))),
          ]),
          const SizedBox(height: 3),
          FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.centerLeft,
            child: Text(value, style: TextStyle(color: MemberTheme.ink,
              fontSize: compact ? 16 : 19, height: 1, fontWeight: FontWeight.w900))),
          if (caption != null && !compact)
            Text(caption!, maxLines: 1, overflow: TextOverflow.ellipsis,
              style: TextStyle(color: MemberTheme.muted, fontSize: compact ? 7 : 8, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class GlassLineChart extends StatelessWidget {
  const GlassLineChart({
    required this.series,
    required this.colors,
    this.minY = 0,
    this.maxY = 100,
    this.showGrid = true,
    super.key,
  });

  final List<List<double>> series;
  final List<Color> colors;
  final double minY;
  final double maxY;
  final bool showGrid;

  @override
  Widget build(BuildContext context) {
    final lines = <LineChartBarData>[
      for (var i = 0; i < series.length; i++)
        LineChartBarData(
          spots: [for (var x = 0; x < series[i].length; x++) FlSpot(x.toDouble(), series[i][x])],
          isCurved: true,
          curveSmoothness: 0.22,
          color: colors[i % colors.length],
          barWidth: 2.5,
          isStrokeCapRound: true,
          dotData: FlDotData(show: true,
            getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
              radius: 2.5, color: Colors.white, strokeWidth: 1.8,
              strokeColor: colors[i % colors.length],
            )),
          belowBarData: BarAreaData(show: i == 0, color: colors[i % colors.length].withOpacity(0.10)),
        ),
    ];
    return LineChart(
      LineChartData(
        minY: minY,
        maxY: maxY,
        lineBarsData: lines,
        gridData: FlGridData(show: showGrid, drawVerticalLine: false,
          getDrawingHorizontalLine: (value) => FlLine(color: MemberTheme.glassEdge.withOpacity(0.6), strokeWidth: 0.7)),
        borderData: FlBorderData(show: false),
        titlesData: const FlTitlesData(show: false),
        lineTouchData: LineTouchData(enabled: true,
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (spots) => spots.map((spot) => LineTooltipItem(
              spot.y.toStringAsFixed(0),
              const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800),
            )).toList(),
          )),
      ),
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
    );
  }
}

class GlassBarChart extends StatelessWidget {
  const GlassBarChart({
    required this.values,
    required this.color,
    this.highlightIndex,
    this.maxY,
    super.key,
  });

  final List<double> values;
  final Color color;
  final int? highlightIndex;
  final double? maxY;

  @override
  Widget build(BuildContext context) {
    final maximum = maxY ?? (values.isEmpty ? 1 : values.reduce((a, b) => a > b ? a : b) * 1.2);
    return BarChart(
      BarChartData(
        minY: 0,
        maxY: maximum,
        barGroups: [
          for (var i = 0; i < values.length; i++)
            BarChartGroupData(x: i, barRods: [
              BarChartRodData(
                toY: values[i],
                width: 13,
                color: i == highlightIndex ? MemberTheme.green : color,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
                backDrawRodData: BackgroundBarChartRodData(
                  show: true, toY: maximum, color: MemberTheme.glassEdge.withOpacity(0.22)),
              ),
            ]),
        ],
        gridData: FlGridData(show: true, drawVerticalLine: false,
          getDrawingHorizontalLine: (value) => FlLine(color: MemberTheme.glassEdge.withOpacity(0.45), strokeWidth: 0.6)),
        borderData: FlBorderData(show: false),
        titlesData: const FlTitlesData(show: false),
        barTouchData: BarTouchData(enabled: true),
      ),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
    );
  }
}

class GlassDonutChart extends StatelessWidget {
  const GlassDonutChart({
    required this.values,
    required this.colors,
    required this.centerLabel,
    required this.centerValue,
    super.key,
  });

  final List<double> values;
  final List<Color> colors;
  final String centerLabel;
  final String centerValue;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        PieChart(
          PieChartData(
            sections: [
              for (var i = 0; i < values.length; i++)
                PieChartSectionData(value: values[i], color: colors[i % colors.length], radius: 12, showTitle: false),
            ],
            sectionsSpace: 2,
            centerSpaceRadius: 24,
            startDegreeOffset: -90,
          ),
          duration: const Duration(milliseconds: 340),
          curve: Curves.easeOutCubic,
        ),
        Column(mainAxisSize: MainAxisSize.min, children: [
          Text(centerValue, style: const TextStyle(color: MemberTheme.ink, fontSize: 14, fontWeight: FontWeight.w900, height: 1)),
          Text(centerLabel, style: const TextStyle(color: MemberTheme.muted, fontSize: 7, fontWeight: FontWeight.w700)),
        ]),
      ],
    );
  }
}
